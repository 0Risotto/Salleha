// Shaima

== Data Requirements

 #show figure : set block(breakable:true)
 #show figure : set par(justify:false)
Data requirements is the specification for the information the system will depend on, store in the database, and process to achieve the business goals. These requirements are important for effective system design and implementation. For our smart maintenance request system, the core data entities, including their attributes, constraints, and the key relationships between them, are:
 
  #figure(
  table(
   
  columns: 5,align:left,
[*Entity*],[*Description*],[*Attributes*],[*Constraints*], [*Key relationships*],
[*Users*], [The Users entity represents any system user, including technicians, staff, admins, and requestors.
], [UserID (PK), full name, password hash, NationalID to initiate password recovery, IsEmailVerified, role (which can be User, Technician, Admin, or other staff), registration date, account status (Active, Suspended, Locked), LastLoginAt for security, account expiration date, failed login attempts, and profile picture. Email address will also be stored for communication, and a Phone number (is an optional field).], [UserID is the Primary Key, Email and NationalID have a uniqueness constraint, role can be User, Technician, Admin, or other staff.], [- One user can submit many requests (one to many).
 - One user receives multiple notifications (one to many). 
 - A user can be linked to zero or one technician record depending on their role (one to one or one to zero).
],

[*Technician*], [The Technician entity represents technicians or teams responsible for carrying out maintenance tasks.], [This entity tracks their skills, an availability status to indicate whether they are available, busy, or on break. Other fields are for skill level, certifications, specialization, work zone, work schedules, TeamLeadFlag to identify technicians with team lead permissions, average resolution time (analytics), customer satisfaction rating. It also tracks their performance, such as the number of tasks they have completed. Each technician has a unique TechnicianID (PK) and a UserID, which is a FK referring to the User table.
], [TechnicianID is the Primary Key, UserID is a Foreign Key referring to the User table, specialization is required.], [- One technician may handle many requests. 
- One technician can have many scheduled tasks.],

[*Maintenance Request*
], [The Maintenance Request entity documents the actual problem submitted by users or a need for service.
], [A request captures details such as the issue description, TicketID, title, category, the requester’s ID (a FK referring to the User table), TechnicianID (FK), LocationID (FK), ReportedAt, AssignedAt, and ResolvedAt. It also includes priority (Low, Medium, High, Critical), current status (new, in progress, completed, rejected), estimated completion time, IsUrgentFlag, SimilarityFlag to prevent duplicate tickets, escalation level for escalate tasks that remain "In Progress" beyond the estimated completion time, OnHoldReason to allow technicians to set a task to "On Hold" for specific reasons, ResidentEditableFlag (to enforce FR-9.7), and an ImageURL that is optional.], [TicketId is PK, requester’s ID, TechnicianID, and LocationID are required Foreign keys, description minimum length is 20 chars, ReportedAt is required, AssignedAt is optional, ResolvedAt is optional, ImageURL is optional
], [- Each maintenance request is assigned to one location. 
- One location can have many requests.],

[*Location*
], [The Location entity represents the building or place where maintenance is required, facilitating easy navigation and assignment of work to the correct place.
], [Each location has a LocationID (PK). It also includes fields for zone, building name, location criticality, GeoCoordinates for heat map, and a column for other details if there is a specific description of the components needed for repairs. Additional useful fields include room number and floor number and they are optional.
], [LocationID is the Primary Key, BuildingName is required
], [Each request is associated with exactly one location (one to many).],

[*Maintenance Schedule*], [The Maintenance Schedule entity includes a list of planned maintenance tasks.
], [Each schedule has a ScheduleID (PK), TechnicianID (FK referring to Technician), LinkedRequestID to indicate which maintenance request the schedule is created for, expected duration, scheduled start time, recurrence pattern (None (default), Daily, Weekly, Monthly, Yearly), schedule status (Scheduled, Completed, Cancelled) and notes (String, optional).], [ScheduleID is the Primary Key, TechnicianID is a Foreign Key, scheduled start time is required.], [One technician can have many scheduled tasks.],

[*Notifications*], [The Notifications entity tracks alerts sent to users.], [NotificationID (PK), UserID (FK), RelatedTiketID (FK to Maintenance Request table), expiration date (90 days as it is set in the rules), notification type (StatusChange, Assignment, Alert…),  message (String), IsRead (Boolean), CreatedAt (DateTime).], [ NotificationID is the Primary Key, UserID is a Foreign Key, Message is required, CreatedAt is required.], [One user receives many notifications.],

 )
, caption: [Data Requirements]
)

<datarequirements>


And to allow the system to automate workflows, these entities we listed are interconnected in a centralized database, interacting with each other to streamline the maintenance lifecycle from issue reporting to resolution and performance optimization.