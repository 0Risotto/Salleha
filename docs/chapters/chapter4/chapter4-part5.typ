#set par(justify: false)
== ERD analysis and Database Design
=== Database Design (ERD)
#figure(image("../../assets/chapter4/dbdesign.svg"),caption: [Entity Relation Diagram])

=== Object to ER Mapping
#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*User*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [User], [users],
    [
      user_id → user_id (PK) \
      fullName → full_name \
      email → email (UNIQUE) \
      passwordHash → password_hash \
      nationalID → national_id (UNIQUE) \
      isEmailVerified → is_email_verified \
      role → role \
      registrationDate → registration_date \
      accountStatus → account_status \
      lastLoginAt → last_login_at \
      accountExpirationDate → account_expiration_date \
      failedLoginAttempts → failed_login_attempts \
      profilePicture → profile_picture_url \
      phoneNumber → phone_number \
      createdAt → created_at \
      updatedAt → updated_at
    ],
    [
      One-to-Many with MaintenanceRequest \
      One-to-Many with Notification \
      One-to-Many with Comment \
      One-to-One with Technician
    ]
  ),
  caption: [Object to ER Mapping – User]
)



#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*Technician*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [Technician], [technicians],
    [
      technician_id → technician_id (PK) \
      userID → user_id (FK) \
      skills → skills \
      availabilityStatus → availability_status \
      skillLevel → skill_level \
      certifications → certifications \
      specialization → specialization \
      workZone → work_zone \
      workSchedules → work_schedules \
      teamLeadFlag → team_lead_flag \
      averageResolutionTime → average_resolution_time_minutes \
      customerSatisfactionRating → customer_satisfaction_rating \
      createdAt → created_at \
      updatedAt → updated_at
    ],
    [
      One-to-One with User \
      One-to-Many with MaintenanceRequest \
      One-to-Many with MaintenanceSchedule \
      One-to-Many with MaintenanceEvidence
    ]
  ),
  caption: [Object to ER Mapping – Technician]
)



#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*Maintenance Request*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [MaintenanceRequest], [maintenance_requests],
    [
      ticketID → ticket_id (PK) \
      title → title \
      description → description \
      category → category \
      requesterID → requester_id (FK) \
      technicianID → technician_id (FK) \
      locationID → location_id (FK) \
      reportedAt → reported_at \
      assignedAt → assigned_at \
      resolvedAt → resolved_at \
      priority → priority \
      status → status \
      estimatedCompletionTime → estimated_completion_time \
      isUrgentFlag → is_urgent_flag \
      similarityFlag → similarity_flag \
      escalationLevel → escalation_level \
      onHoldReason → on_hold_reason \
      residentEditable → resident_editable \
      createdAt → created_at \
      updatedAt → updated_at
    ],
    [
      Many-to-One with User \
      Many-to-One with Technician \
      Many-to-One with Location \
      One-to-Many with TicketImages \
      One-to-Many with TicketComments \
      One-to-Many with MaintenanceEvidence \
      One-to-Many with Notifications \
      One-to-Many with MaintenanceSchedule
    ]
  ),
  caption: [Object to ER Mapping – Maintenance Request]
)



#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*Location*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [Location], [locations],
    [
      locationID → location_id (PK) \
      zone → zone \
      buildingName → building_name \
      locationCriticality → location_criticality \
      geoCoordinates → geo_coordinates \
      roomNumber → room_number \
      floorNumber → floor_number \
      details → details \
      createdAt → created_at \
      updatedAt → updated_at
    ],
    [
      One-to-Many with MaintenanceRequest
    ]
  ),
  caption: [Object to ER Mapping – Location]
)



#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*Maintenance Schedule*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [MaintenanceSchedule], [maintenance_schedules],
    [
      scheduleID → schedule_id (PK) \
      technicianID → technician_id (FK) \
      linkedRequestID → linked_request_id (FK) \
      expectedDuration → expected_duration_minutes \
      scheduledStartTime → scheduled_start_time \
      recurrencePattern → recurrence_pattern \
      scheduleStatus → schedule_status \
      notes → notes \
      createdAt → created_at \
      updatedAt → updated_at
    ],
    [
      Many-to-One with Technician \
      Many-to-One with MaintenanceRequest
    ]
  ),
  caption: [Object to ER Mapping – Maintenance Schedule]
)








#figure(
  table(columns: 4,
    table.cell(colspan: 4, fill: rgb("#7EA6E0"))[*Notification*],

    [*Class (Object) Name*], [*Table Name*], [*Attributes (Fields → Columns)*], [*Relationships*],

    [Notification], [notifications],
    [
      notificationID → notification_id (PK) \
      userID → user_id (FK) \
      relatedTicketID → related_ticket_id (FK) \
      notificationType → notification_type \
      message → message \
      isRead → is_read \
      deliveryMethod → delivery_method \
      priorityLevel → priority_level \
      expirationDate → expiration_date \
      createdAt → created_at
    ],
    [
      Many-to-One with User \
      Many-to-One with MaintenanceRequest
    ]
  ),
  caption: [Object to ER Mapping – Notification]
)

