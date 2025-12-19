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
], [UserID (PK), FullName, Role which can be User, Technician, Admin, or other staff. Email address will also be stored for communication. In addition, a PhoneNumber will be an optional field.
], [UserID is the Primary Key, Email has a uniqueness constraint, Role can be User, Technician, Admin, or other staff.], [- One user can submit many requests (one to many).
 - One user receives multiple notifications (one to many). 
 - A user can be linked to zero or one technician record depending on their role (one to one or one to zero).
],

[*Technician*], [The Technician entity represents technicians or teams responsible for carrying out maintenance tasks.], [This entity tracks their skills, availability, certifications, work schedules, and specialization. It also tracks their performance, such as the number of tasks they have completed, and an availability status to indicate whether they are available, busy, or offline. Each technician has a unique TechnicianID (PK) and a UserID, which is a FK referring to the User table.
], [TechnicianID is the Primary Key, UserID is a Foreign Key referring to the User table, specialization is required.], [- One technician may handle many requests. 
- One technician can have many scheduled tasks.],

[*Maintenance Request*
], [The Maintenance Request entity documents the actual problem submitted by users or a need for service.
], [This entity documents the actual problem submitted by users or a need for service. A request captures details such as the issue description, the requester’s ID (a FK referring to the User table), TechnicianID (FK), LocationID (FK), ReportedAt, AssignedAt, and ResolvedAt. It also includes Priority (Low, Medium, High, Critical), current status (new, in progress, completed, rejected), and an ImageURL that is optional.], [requester’s ID is a required FK, TechnicianID is a FK, LocationID is a required FK, ReportedAt is required, AssignedAt is optional, ResolvedAt is optional, ImageURL is optional.
], [- Each maintenance request is assigned to one location. 
- One location can have many requests.],

[*Location*
], [The Location entity represents the building or place where maintenance is required, facilitating easy navigation and assignment of work to the correct place.
], [Each location has a LocationID (PK). It also includes fields for BuildingName and a column for other details if there is a specific description of the components needed for repairs. Additional useful fields include room number and floor mumber and they are optional.
], [LocationID is the Primary Key, BuildingName is required
], [Each request is associated with exactly one location (one to many).],

[*Maintenance Schedule*], [The Maintenance Schedule entity includes a list of planned maintenance tasks.
], [Each schedule has a ScheduleID (PK), TechnicianID (FK referring to Technician), scheduled date, and notes (String, optional).], [ScheduleID is the Primary Key, TechnicianID is a Foreign Key, scheduled date is required.], [One technician can have many scheduled tasks.],

[*Notifications*], [The Notifications entity tracks alerts sent to users.], [NotificationID (PK), UserID (FK), Message (String), IsRead (Boolean), CreatedAt (DateTime).], [ NotificationID is the Primary Key, UserID is a Foreign Key, Message is required, CreatedAt is required.], [One user receives many notifications.],

 )
, caption: [Data Requirements]
)

<datarequirements>


And to allow the system to automate workflows, these entities we listed are interconnected in a centralized database, interacting with each other to streamline the maintenance lifecycle from issue reporting to resolution and performance optimization.
