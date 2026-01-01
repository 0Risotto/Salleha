== DFDs

#figure(
  image(
"../../assets/chapter4/DFD/Level0.png"
),
  caption: [DFD Level 0]
)<DFD_Level0>

#figure(
  image(
"../../assets/chapter4/DFD/Level1D1.png"
),
  caption: [DFD Level 1-Fragment 1]
)<DFD_Level1F1>

#figure(
  image(
"../../assets/chapter4/DFD/dfdlevel1d2.png"
),
  caption: [DFD Level 1-Fragment 2]
)<DFD_Level1F2>

#figure(
  image(
"../../assets/chapter4/DFD/level1D3.png"
),
  caption: [DFD Level 1-Fragment 3]
)<DFD_Level1F3>

#figure(
  image(
"../../assets/chapter4/DFD/level1D4.png"
),
  caption: [DFD Level 1-Fragment 4]
)<DFD_Level1F4>

#figure(
  image(
"../../assets/chapter4/DFD/level1D5.png"
),
  caption: [DFD Level 1-Fragment 5]
)<DFD_Level1F5>


== Data Dictionaries
=== Data flow



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Registration Details],
[Description], [User information submitted during account registration.],
[Source], [External Entities: Resident / Admin],
[Destination], [Process 1.1: User Registration],
[Type], [Screen],
[Data Structure], [Name, Email, Role, National ID],
[Volume/Time], [Per registration],
[Comments], [Used to create a new user account.]
),
caption: [Data Flow 1 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [User Profile Data],
[Description], [User profile information stored or retrieved from database.],
[Source], [User Database (D1)],
[Destination], [Processes 1.4],
[Type], [Database Read],
[Data Structure], [User ID, Name, Email, Role, Account Status],
[Volume/Time], [On demand],
[Comments], [Represents stored user account information.]
),
caption: [Data Flow 2 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Login Credentials],
[Description], [Credentials submitted by user for authentication.],
[Source], [External Entities: Resident / Technician / Admin],
[Destination], [Process 1.2: User Authentication],
[Type], [Screen],
[Data Structure], [Username, Password],
[Volume/Time], [Per login attempt],
[Comments], [Validated against stored credentials.]
),
caption: [Data Flow 3 Details],
)

#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Stored Credentials & User Role],
[Description], [Stored authentication data retrieved for validation.],
[Source], [User Database (D1)],
[Destination], [Process 1.2: User Authentication],
[Type], [Database Read],
[Data Structure], [Username, Hashed Password, Role, Account Status],
[Volume/Time], [Per login attempt],
[Comments], [Used to verify user identity and access level.]
),
caption: [Data Flow 4 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Session Token & Dashboard Redirect],
[Description], [Authentication response indicating successful login.],
[Source], [Process 1.2: User Authentication],
[Destination], [External Entities: Resident / Technician / Admin],
[Type], [System Response],
[Data Structure], [Session Token, User Role, Redirect Path],
[Volume/Time], [Per successful login],
[Comments], [Grants access to authorized system functions.]
),
caption: [Data Flow 5 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Recovery Request],
[Description], [User request to recover account access.],
[Source], [External Entity: Resident,Admin,Technician],
[Destination], [Process 1.3: Password Recovery],
[Type], [Screen],
[Data Structure], [Email or National ID],
[Volume/Time], [On demand],
[Comments], [Used to initiate password recovery.]
),
caption: [Data Flow 6 Details],
)

#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Account Verification Data],
[Description], [User data used to verify identity during recovery.],
[Source], [User Database (D1)],
[Destination], [Process 1.3: Password Recovery],
[Type], [Database Read],
[Data Structure], [User ID, Email, National ID, Account Status],
[Volume/Time], [Per recovery request],
[Comments], [Ensures recovery request is valid.]
),
caption: [Data Flow 7 Details],
)


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Updated Profile / Account Status],
[Description], [Updated user profile or account status information.],
[Source], [Process 1.4: Account Management],
[Destination], [User Database (D1)],
[Type], [Database Write],
[Data Structure], [User ID, Updated Fields, Account Status],
[Volume/Time], [Per update],
[Comments], [Reflects administrative or user profile changes.]
),
caption: [Data Flow 8 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[Field], [Details],
[Name], [Profile Update Data],
[Description], [Profile changes submitted by resident for account update.],
[Source], [External Entity: Resident],
[Destination], [Process 1.4: Account Management],
[Type], [Screen],
[Data Structure], [User ID, Updated Profile Fields],
[Volume/Time], [On demand],
[Comments], [Used to update resident profile information.]
),
caption: [Data Flow 9 Details],
)
#pagebreak()
#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [New Ticket Submission Data],
[Description], [Resident submits information to create a new maintenance ticket.],
[Source], [External Entity: Residents],
[Destination], [Process 2.1: Create Maintenance Ticket],
[Type], [Screen / Form],
[Data Structure], [Category, Description, Location, Priority],
[Volume/Time], [On demand (per new ticket)],
[Comments], [Core input required to open a new ticket.]
),
caption: [Data Flow 10 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket Attachments (Images)],
[Description], [Images uploaded by resident as supporting evidence for the ticket.],
[Source], [External Entity: Residents],
[Destination], [Process 2.1: Create Maintenance Ticket],
[Type], [File Upload],
[Data Structure], [Image File(s), File Type, File Size, (Optional) Attachment Reference],
[Volume/Time], [0..N images per ticket],
[Comments], [Stored as files or references/URLs depending on implementation.]
),
caption: [Data Flow 11 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket Confirmation (Ticket ID)],
[Description], [Confirmation sent to resident after successful ticket creation.],
[Source], [Process 2.1: Create Maintenance Ticket],
[Destination], [External Entity: Residents],
[Type], [Screen / Message],
[Data Structure], [Ticket ID, Status (=Open), Created Date/Time],
[Volume/Time], [Per ticket submission],
[Comments], [Used by resident to track the ticket.]
),
caption: [Data Flow 12 Details],
)
#pagebreak()
#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [New Ticket Record],
[Description], [New ticket record written into the tickets database.],
[Source], [Process 2.1: Create Maintenance Ticket],
[Destination], [Tickets Database (D2)],
[Type], [Database Write],
[Data Structure], [Ticket ID, Resident ID, Category, Description, Location, Priority, Status=Open, Created Date, Attachment References],
[Volume/Time], [Per new ticket],
[Comments], [Initializes the ticket life-cycle in D2.]
),
caption: [Data Flow 13 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [View/Search Criteria],
[Description], [Criteria entered by resident to search or filter tickets (query merged here).],
[Source], [External Entity: Residents],
[Destination], [Process 2.2: View / Search Tickets],
[Type], [Screen],
[Data Structure], [Ticket ID (optional), Status, Category, Date Range, Keyword],
[Volume/Time], [On demand],
[Comments], [Used to define ticket search conditions.]
),
caption: [Data Flow 14 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket List / Ticket Details],
[Description], [Matching tickets returned from D2 for list view or detailed view.],
[Source], [Tickets Database (D2)],
[Destination], [Process 2.2: View / Search Tickets],
[Type], [Database Read Result],
[Data Structure], [Ticket ID, Category/Title, Description, Location, Priority, Status, Created Date, Assigned Technician (optional), Last Updated, Notes (optional)],
[Volume/Time], [Depends on number of matches],
[Comments], [Retrieved ticket data for display purposes]
),
caption: [Data Flow 15 Details],
)
#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Comment Submission (Ticket ID + Comment)],
[Description], [Resident submits a comment related to an existing ticket.],
[Source], [External Entity: Residents],
[Destination], [Process 2.4: Manage Comments & Evidence],
[Type], [Screen],
[Data Structure], [Ticket ID, Resident ID, Comment Text, Comment Date/Time],
[Volume/Time], [0..N per ticket],
[Comments], [Stored and used for communication/updates.]
),
caption: [Data Flow 16 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Completion Evidence (Images/Notes)],
[Description], [Technician uploads evidence/notes for progress or completion.],
[Source], [External Entity: Technicians],
[Destination], [Process 2.4: Manage Comments & Evidence],
[Type], [Screen / File Upload],
[Data Structure], [Ticket ID, Technician ID, Notes, Evidence Image(s)/References, Evidence Date/Time],
[Volume/Time], [Per update/completion],
[Comments], [Supports verification and maintenance history logging.]
),
caption: [Data Flow 17 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Maintenance Completion Record],
[Description], [Completion details stored in maintenance history.],
[Source], [Process 2.4: Manage Comments & Evidence],
[Destination], [Maintenance History (D3)],
[Type], [Database Write],
[Data Structure], [Ticket ID, Technician ID, Work Summary/Notes, Completion Date/Time, Evidence References, Final Status],
[Volume/Time], [Typically once per completed ticket],
[Comments], [Archived record used for reporting and future reference.]
),
caption: [Data Flow 18 Details],
)
#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assignment/Priority Update],
[Description], [Admin assigns a technician and sets/updates ticket priority.],
[Source], [External Entity: Admins],
[Destination], [Process 2.3: Update Ticket Status],
[Type], [Screen],
[Data Structure], [Ticket ID, Technician ID, Priority, (Optional) Notes],
[Volume/Time], [Per assignment/change],
[Comments], [Changes are written to D2 and may trigger notifications.]
),
caption: [Data Flow 19 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Status Update (Ticket ID + New Status + Notes)],
[Description], [Technician updates ticket status with optional notes.],
[Source], [External Entity: Technicians],
[Destination], [Process 2.3: Update Ticket Status],
[Type], [Screen],
[Data Structure], [Ticket ID, New Status, Notes (optional), Updated Date/Time],
[Volume/Time], [Per status change],
[Comments], [Example statuses: In Progress, Completed, On Hold.]
),
caption: [Data Flow 20 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Updated Ticket Status/Assignment/Priority],
[Description], [Updated ticket information written back to the tickets database.],
[Source], [Process 2.3: Update Ticket Status],
[Destination], [Tickets Database (D2)],
[Type], [Database Write],
[Data Structure], [Ticket ID, Status, Technician ID (optional), Priority (optional), Notes (optional), Last Updated],
[Volume/Time], [Per update],
[Comments], [Ensures D2 reflects the latest ticket state.]
),
caption: [Data Flow 21 Details],
)
#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Notification],
[Description], [System-generated notification sent to users based on ticket updates or comments.],
[Source], [Process 2.5: Send Notifications],
[Destination], [External Entities: Residents / Technicians / Admins],
[Type], [Notification],
[Data Structure], [Ticket ID, Notification Type, Status/Priority (as applicable), Message Summary, Timestamp],
[Volume/Time], [As triggered],
[Comments], [Unified structure for all system notifications.]
),
caption: [Data Flow 22 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [View Pending /  Tickets Request],
[Description], [Request sent by Admin to view all pending or unassigned tickets.],
[Source], [External Entity: Admin],
[Destination], [Process 3.1: View Pending / Unassigned Tickets],
[Type], [Screen],
[Data Structure], [Request Parameters],
[Volume/Time], [On demand],
[Comments], [Used to retrieve tickets that are not yet assigned.]
),
caption: [Data Flow 23 Details],
)


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Pending Tickets List],
[Description], [List of pending or unassigned tickets returned from database.],
[Source], [Tickets Database (D2)],
[Destination], [Process 3.1: View Pending / Unassigned Tickets],
[Type], [Database],
[Data Structure], [Ticket ID, Title, Description, Status, Created Date],
[Volume/Time], [Depends on number of tickets],
[Comments], [Displayed to admin for assignment decision.]
),
caption: [Data Flow 24 Details],
)
#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assignment Decision],
[Description], [Admin selects technician and sets ticket priority.],
[Source], [External Entity: Admin],
[Destination], [Process 3.2: Assign Ticket & Set Priority],
[Type], [Screen],
[Data Structure], [Ticket ID, Technician ID, Priority],
[Volume/Time], [Per assignment],
[Comments], [Ticket status becomes Assigned.]
),
caption: [Data Flow 25 Details],
)

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assignment & Priority Update],
[Description], [Updates ticket assignment and priority in database.],
[Source], [Process 3.2: Assign Ticket & Set Priority],
[Destination], [Tickets Database (D2)],
[Type], [Database],
[Data Structure], [Ticket ID, Technician ID, Priority, Status],
[Volume/Time], [Per assignment],
[Comments], [Status is set to Assigned.]
),
caption: [Data Flow 26 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assigned Task Notification],
[Description], [Notification sent to technician for assigned ticket.],
[Source], [Process 3.3: Notify Technician],
[Destination], [External Entity: Technician],
[Type], [Notification],
[Data Structure], [Ticket ID, Priority],
[Volume/Time], [Per assignment],
[Comments], [Notification via system, email, or sms.]
),
caption: [Data Flow 27 Details],
)
#pagebreak()


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assignment Response],
[Description], [Technician accepts or declines assigned task.],
[Source], [External Entity: Technician],
[Destination], [Process 3.4: Update Assignment Status],
[Type], [Screen],
[Data Structure], [Ticket ID, Response Status],
[Volume/Time], [Per notification],
[Comments], [Determines next assignment status.]
),
caption: [Data Flow 28 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Assignment Status Update],
[Description], [Updates ticket status based on technician response.],
[Source], [Process 3.4: Update Assignment Status],
[Destination], [Tickets Database (D2)],
[Type], [Database],
[Data Structure], [Ticket ID, Status],
[Volume/Time], [Per response],
[Comments], [Status may be Accepted or Declined.]
),
caption: [Data Flow 29 Details],
)


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Completion Data],
[Description], [Maintenance completion information submitted by technician.],
[Source], [External Entity: Technician],
[Destination], [Process 4.1: Record Maintenance Completion],
[Type], [Screen],
[Data Structure], [Ticket ID, Completion Notes, Completion Time, Evidence Reference],
[Volume/Time], [Per completed ticket],
[Comments], [Used to record task completion.]
),
caption: [Data Flow 30 Details],
)
#pagebreak()

#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Maintenance Completion Record],
[Description], [Completed maintenance record sent for history update.],
[Source], [Process 4.1: Record Maintenance Completion],
[Destination], [Process 4.2: Update Maintenance History],
[Type], [Internal Data],
[Data Structure], [Ticket ID, Resolution Details, Completion Time, Evidence Reference],
[Volume/Time], [Per completion],
[Comments], [Passed for archival storage.]
),
caption: [Data Flow 31 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket Final Status Update],
[Description], [Final ticket status written after maintenance completion.],
[Source], [Process 4.1: Record Maintenance Completion],
[Destination], [Tickets Database (D2)],
[Type], [Database Write],
[Data Structure], [Ticket ID, Final Status (Fixed/Closed), Last Updated],
[Volume/Time], [Per completed ticket],
[Comments], [Closes the ticket life-cycle.]
),
caption: [Data Flow 32 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Stored Maintenance History Entry],
[Description], [Archived maintenance history entry.],
[Source], [Process 4.2: Update Maintenance History],
[Destination], [Maintenance History (D3)],
[Type], [Database Write],
[Data Structure], [Ticket ID, Resolution Details, Completion Timestamp],
[Volume/Time], [Per completion],
[Comments], [Used for reporting and audits.]
),
caption: [Data Flow 33 Details],
)

#pagebreak()


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Report Request],
[Description], [Request parameters for generating reports or analytics.],
[Source], [External Entity: Admin],
[Destination], [Process 4.3: Generate Reports & Metrics],
[Type], [Screen],
[Data Structure], [Date Range, Filters, Report Type],
[Volume/Time], [On demand],
[Comments], [Defines report scope.]
),
caption: [Data Flow 34 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Tickets Data / Metrics Inputs],
[Description], [Ticket data used for analytics and KPI calculations.],
[Source], [Tickets Database (D2)],
[Destination], [Process 4.3: Generate Reports & Metrics],
[Type], [Database Read],
[Data Structure], [Ticket ID, Status, Priority, Timestamps],
[Volume/Time], [As requested],
[Comments], [Provides operational metrics.]
),
caption: [Data Flow 35 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Maintenance History Data],
[Description], [Historical maintenance data retrieved for analysis.],
[Source], [Maintenance History (D3)],
[Destination], [Process 4.3: Generate Reports & Metrics],
[Type], [Database Read],
[Data Structure], [Ticket ID, Resolution Details, Completion Time],
[Volume/Time], [As requested],
[Comments], [Supports performance analysis.]
),
caption: [Data Flow 36 Details],
)

#pagebreak()


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Reports & Metrics Store],
[Description], [Generated reports and analytics data stored for access.],
[Source], [Process 4.3: Generate Reports & Metrics],
[Destination], [Reports & Analytics (D4)],
[Type], [Database Write],
[Data Structure], [Report ID, KPI Data, Charts Data, Generated Date],
[Volume/Time], [Per report],
[Comments], [Enables reuse and export.]
),
caption: [Data Flow 37 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Analytics View / Export Request],
[Description], [Admin request to view or export analytics reports.],
[Source], [External Entity: Admin],
[Destination], [Process 4.4: Provide Analytics Dashboard / Export],
[Type], [Screen],
[Data Structure], [Report ID, Export Format (PDF/Excel/CSV)],
[Volume/Time], [On demand],
[Comments], [Triggers dashboard or export.]
),
caption: [Data Flow 38 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Analytics Dashboard Data / Report File Data],
[Description], [Analytics data or exported report returned to admin.],
[Source], [Reports & Analytics (D4)],
[Destination], [Process 4.4: Provide Analytics Dashboard / Export],
[Type], [Database Read],
[Data Structure], [KPI Values, Charts Data, Report File],
[Volume/Time], [Per request],
[Comments], [Prepared for presentation or download.]
),
caption: [Data Flow 39 Details],
)

#pagebreak()


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Analytics Dashboard / Exported Report],
[Description], [Final analytics dashboard or exported report.],
[Source], [Process 4.4: Provide Analytics Dashboard / Export],
[Destination], [External Entity: Admin],
[Type], [Screen / File],
[Data Structure], [Dashboard View or Report File],
[Volume/Time], [On demand],
[Comments], [Supports monitoring and decision-making.]
),
caption: [Data Flow 40 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Notification Trigger Details],
[Description], [Trigger details passed for notification preparation.],
[Source], [Process 5.1: Receive Trigger],
[Destination], [Process 5.2: Prepare Notification],
[Type], [Internal Data],
[Data Structure], [Ticket ID, Trigger Type (Status/Assignment/Priority)],
[Volume/Time], [Per trigger],
[Comments], [Defines what notification is needed.]
),
caption: [Data Flow 41 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket Information Query],
[Description], [Request to retrieve ticket details using the ticket ID.],
[Source], [Process 5.2: Prepare Notification],
[Destination], [Tickets Database (D2)],
[Type], [Database Read],
[Data Structure], [Ticket ID],
[Volume/Time], [Per trigger],
[Comments], [Fetches ticket context for the message.]
),
caption: [Data Flow 42 Details],
)
#pagebreak()



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Ticket Details],
[Description], [Ticket information returned for notification preparation.],
[Source], [Tickets Database (D2)],
[Destination], [Process 5.2: Prepare Notification],
[Type], [Database Read Result],
[Data Structure], [Ticket ID, Owner, Assigned Technician, Status, Priority],
[Volume/Time], [Per query],
[Comments], [Used to personalize notification content.]
),
caption: [Data Flow 43 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [User Contact Data Query],
[Description], [Request to retrieve contact info for notification delivery.],
[Source], [Process 5.2: Prepare Notification],
[Destination], [User Database (D1)],
[Type], [Database Read],
[Data Structure], [User ID(s) (Owner/Technician/Admin)],
[Volume/Time], [Per trigger],
[Comments], [Retrieves recipient contact details.]
),
caption: [Data Flow 44 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [User Contact Information],
[Description], [Recipient contact details returned from user database.],
[Source], [User Database (D1)],
[Destination], [Process 5.2: Prepare Notification],
[Type], [Database Read Result],
[Data Structure], [User ID, Name, Email, Phone (optional), Role],
[Volume/Time], [Per query],
[Comments], [Used to route notifications correctly.]
),
caption: [Data Flow 45 Details],
)

#pagebreak()


#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Prepared Notification Message],
[Description], [Final notification message prepared for sending.],
[Source], [Process 5.2: Prepare Notification],
[Destination], [Process 5.3: Send Notification],
[Type], [Internal Data],
[Data Structure], [Ticket ID, Recipient Role, Notification Type, Message Summary, Timestamp],
[Volume/Time], [Per notification],
[Comments], [Ready for delivery to recipients.]
),
caption: [Data Flow 46 Details],
)



#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Field*], [*Details*],
[Name], [Notification],
[Description], [Notification delivered to system users.],
[Source], [Process 5.3: Send Notification],
[Destination], [External Entities: Technician / Admin / Resident],
[Type], [Notification],
[Data Structure], [Ticket ID, Notification Type, Message Summary, Timestamp],
[Volume/Time], [As triggered],
[Comments], [Unified structure for all recipients.]
),
caption: [Data Flow 47 Details],
)

