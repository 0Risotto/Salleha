//shaima

== Object-Oriented Design

=== Class Diagram

#figure(
  image(
"../../assets/chapter4/classdiagram.svg"
),
  caption: [Class Diagram]
)<classdiagram>

//orjoan
=== Sequence Diagrams

//shaima
=== Classes and Components Design

*Class Specifications*

*1. User Classes (Abstract Base Class)*

Class: User
Attributes:
- userID: String (private)
- fullName: String (private)
- email: String (private)
- nationalID: String (private)
- username: String (private)
- passwordHash: String (private)
- phoneNumber: String (private, optional)
- role: String (private)
- isEmailVerified: Boolean (private)
- accountStatus: String (private)
- failedLoginAttempts: Integer (private)
- lastLoginAt: DateTime (private)
- sessionToken: String (private)
- registrationDate: DateTime (private)
Methods:
+ register(fullName: String, email: String, nationalID: String, username: String, password: String, role: String): Boolean
+ login(username: String, password: String, captcha: String): Boolean
+ logout(): Boolean
+ resetPassword(email: String, nationalID: String): Boolean
+ verifyEmail(token: String): Boolean
+ updateProfile(fullName: String, email: String, password: String): Boolean
- isAccountLocked(): Boolean
- validateCredentials(): Boolean
- hashPassword(password: String): String
- validatePasswordStrength(password: String): Boolean
- incrementFailedLoginAttempts(): void
- resetFailedLoginAttempts(): void

Responsibilities:
- Handle user registration, authentication, and session management
- Enforce password security and account locking rules
- Provide base functionality for all system user roles

*2. Resident Class (Inherits User)*

Class: Resident
Attributes:
- profilePictureURL: String (private)

Methods:
+ submitMaintenanceRequest(category: String, description: String, locationID: String, priority: String, images: List): String
+ viewDashboard(): void
+ viewTicketStatus(ticketID: String): String
+ addTicketComment(ticketID: String, comment: String): Boolean
+ markTicketAsUrgent(ticketID: String): Boolean
+ configureNotificationPreferences(): void

Responsibilities:
- Submit and track maintenance requests
- Monitor ticket status and history
- Receive and manage notifications related to submitted tickets

*3. Technician Class (Inherits User)*

Class: Technician
Attributes:
- technicianID: String (private)
- specialization: String (private)
- skillLevel: String (private)
- availabilityStatus: String (private)
- workZone: String (private)
- teamLeadFlag: Boolean (private)
- averageResolutionTime: Double (private)
- customerSatisfactionRating: Double (private)

Methods:
+ viewAssignedTasks(): List
+ acceptTask(ticketID: String): Boolean
+ declineTask(ticketID: String, reason: String): Boolean
+ updateTaskStatus(ticketID: String, status: String): Boolean
+ uploadMaintenanceEvidence(ticketID: String, images: List, notes: String): Boolean
+ requestAdditionalInfo(ticketID: String): Boolean
+ setAvailabilityStatus(status: String): void

Responsibilities:
- Perform maintenance tasks and update their status
- Upload completion evidence and notes
- Communicate with residents and administrators

*4. Administrator Class (Inherits User)*

Class: Administrator
Attributes:
- adminLevel: String (private)

Methods:
+ viewSystemDashboard(): void
+ assignTicket(ticketID: String, technicianID: String): Boolean
+ reassignTicket(ticketID: String, technicianID: String): Boolean
+ manageUserAccount(userID: String, action: String): Boolean
+ updateTicketPriority(ticketID: String, priority: String): Boolean
+ generateReports(type: String, dateRange: String): File
+ configureSystemRules(): void

Responsibilities:
- Oversee system operations and performance
- Manage users, tickets, and technician assignments
- Analyze system data and generate reports

*5. Maintenance Request Class*

Class: MaintenanceRequest
Attributes:
- ticketID: String (private)
- title: String (private)
- description: String (private)
- category: String (private)
- priority: String (private)
- status: String (private)
- reportedAt: DateTime (private)
- assignedAt: DateTime (private)
- resolvedAt: DateTime (private)
- requesterID: String (private)
- technicianID: String (private)
- locationID: String (private)
- estimatedCompletionTime: DateTime (private)
- isUrgentFlag: Boolean (private)
- similarityFlag: Boolean (private)

Methods:
+ create(): Boolean
+ updateStatus(status: String): Boolean
+ addComment(comment: String): Boolean
+ attachImages(images: List): Boolean
- checkForDuplicates(): Boolean
- calculateEstimatedCompletion(): DateTime

Responsibilities:
- Store and manage maintenance request lifecycle
- Prevent duplicate ticket submissions
- Track status, priority, and escalation

*6. Notification Class*

Class: Notification
Attributes:
- notificationID: String (private)
- userID: String (private)
- relatedTicketID: String (private)
- message: String (private)
- notificationType: String (private)
- isRead: Boolean (private)
- createdAt: DateTime (private)
- expirationDate: DateTime (private)

Methods:
+ markAsRead(): void
- deleteExpired(): void
- send(): Boolean

Responsibilities:
- Notify users of important system events
- Track notification history and read status

*7. Location Class*

Class: Location
Attributes:
- locationID: String (private)
- buildingName: String (private)
- zone: String (private)
- floorNumber: String (private)
- roomNumber: String (private)
- geoCoordinates: String (private)

Methods:
+ getLocationDetails(): String

Responsibilities:
- Represent physical locations for maintenance requests
- Support analytics and technician assignment

\
*Note*
*There* are private methods represented with (-) because they encapsulate internal implementation details, reduce system complexity, and are only accessed within the class itself, not directly by external classes.

\
*State Diagrams*

*1. User authentication and account lifecycle*
States: Logged Out (Initial), Registering, Email verification Pending, Account active, Entering credentials, CAPTCHA validation, Authenticated, Session active, Session expired, Account locked, Password recovery, Password reset successful.

Transitions:
- Logged Out → Registering [user clicks Sign Up]
- Registering → Email Verification Pending [all inputs valid and registration submitted]
- Email Verification Pending → Account Active [email activation link verified]
- Logged Out → Entering Credentials [user clicks Sign In]
- Entering Credentials → CAPTCHA Validation [3 consecutive failed login attempts]
- CAPTCHA Validation → Authenticated [CAPTCHA valid and credentials correct]
- Entering Credentials → Authenticated [credentials correct and attempts < 3]
- Any State → Account Locked [5 consecutive failed login attempts]
- Account Locked → Entering Credentials [account unlocked by admin or email verification]
- Authenticated → Session Active [successful login and role identified]
- Session Active → Session Expired [inactivity timeout reached]
- Session Active → Logged Out [user logs out]
- Logged Out → Password Recovery [forgot password clicked]
- Password Recovery → Password Reset Successful [verification code valid]
- Password Reset Successful → Logged Out [confirmation sent]

Entry Actions:
- Registering: validate input fields in real-time.
- Email Verification Pending: invoke Notification.send() with activation email.
- Authenticated: load role-specific dashboard.
- Session Active: start session timer.
- Account Locked: disable login and invoke Notification.send() with lock message and unlock instructions.
- Password Recovery: invoke Notification.send() with verification code.

Exit Actions:
- Session Active: clear session tokens.
- Password Recovery: invalidate verification code.

*2. Maintenance ticket lifecycle*
States: Draft (Initial), Submitted, Duplicate check, Open, Escalated, Assigned, In Progress, On Hold, Fixed, Closed.

Transitions:
- Draft → Submitted [resident submits ticket]
- Submitted → Duplicate Check [system checks tickets within last 7 days]
- Duplicate Check → Open [no duplicate detected]
- Open → Escalated [resident marks ticket as Urgent]
- Open → Assigned [admin and system assigns technician]
- Escalated → Assigned [technician with high skill level assigned]
- Assigned → In Progress [technician accepts task]
- Assigned → Open [technician declines task]
- In Progress → On Hold [waiting for parts and availability]
- On Hold → In Progress [blocking issue resolved]
- In Progress → Fixed [technician uploads evidence]
- Fixed → Closed [admin review and resident verification completed]
- Any State → Closed [admin manually closes]

Entry Actions:
- Submitted: generate ticket ID and store timestamp.
- Duplicate Check: compare category, location, and description.
- Escalated: recalculate estimated completion time and invoke Notification.send() to Admin.
- Assigned: invoke Notification.send() to technicianID.
- In Progress: record start time.
- Fixed: validate evidence and invoke Notification.send() to requesterID for verification.
- Closed: archive ticket, update analytics, and invoke Notification.send() to resident.

*3. Resident interaction*
States: Dashboard (Initial), Viewing ticket feed, Creating ticket, Viewing ticket details, Adding comment, Viewing notifications, Managing profile.

Transitions:
- Dashboard → Viewing Ticket Feed [view reports feed]
-Dashboard → Creating Ticket [open maintenance ticket]
- Creating Ticket → Viewing Ticket Details [ticket submitted successfully]
- Viewing Ticket Details → Adding Comment [resident adds comment]
- Adding Comment → Viewing Ticket Details [comment saved]
- Any State → Viewing Notifications [notification icon clicked]
- Any State → Managing Profile [profile selected]

Entry Actions:
- Dashboard: load ticket summary widgets.
- Creating Ticket: validate inputs and preview images.
- Viewing Ticket Details: load status timeline.
- Viewing Notifications: invoke Notification.markAsRead().

*4. Technician task handling*
States: Available (Initial), Task assigned, Task accepted, Task In Progress, Task On Hold, Task Fixed, Task reassigned.

Transitions:
- Available → Task Assigned [new ticket assigned]
- Task Assigned → Task Accepted [technician accepts]
- Task Assigned → Task Reassigned [technician declines]
- Task Accepted → Task In Progress [work started]
- Task In Progress → Task On Hold [issue encountered]
- Task In Progress → Task Fixed [work completed and evidence submitted]
- Task Fixed → Available [task closed]

Entry Actions:
-Task Assigned: invoke Notification.send() with ticket details.
- Task In Progress: record start time.
- Task Fixed: invoke Notification.send() to admin and resident for evidence review.

*5. Administrator ticket management*
States: Dashboard (Initial), Reviewing tickets, Assigning ticket, Monitoring progress, Reviewing completion, Generating reports.

Transitions:
- Dashboard → Reviewing Tickets [view pending]
- Reviewing Tickets → Assigning Ticket [assign technician]
- Assigning Ticket → Monitoring Progress [assignment completed]
- Monitoring Progress → Reviewing Completion [ticket marked as fixed]
- Reviewing Completion → Dashboard [ticket approved/closed]
- Dashboard → Generating Reports [export analytics]

Entry Actions:
- Reviewing Tickets: sort tickets by priority/urgency.
-Assigning Ticket: check technician workload and expertise.
- Generating Reports: compile analytics data.

\
*Component Dependencies*

*1. Authentication and user management component*

- Dependencies: Data access layer, Email service, CAPTCHA Service, Password hashing library.
- Provides: User registration, login, logout, role-based authentication, account locking, session management.
- Interfaces: IAuthenticationService, IUserAccountManager, ISessionService.

*2. Resident management component*

- Dependencies: Data access layer, Authentication component, Notification management Ccmponent.
- Provides: Resident dashboard data, profile management, ticket viewing, ticket tracking.
- Interfaces: IResidentService, IProfileManager, IDashboardProvider.

*3. Maintenance ticket management component*

- Dependencies: Data access layer, Authentication component, File and evidence storage component, Duplicate detection engine, Notification management component.
- Provides: Maintenance ticket creation, ticket validation, duplicate detection, ticket lifecycle management.
- Interfaces: IMaintenanceTicketService, ITicketRepository, IDuplicateChecker.

*4. Technician task management component*

- Dependencies: Data access layer, Authentication component, Notification management component, File and evidence storage component.
- Provides: Task assignment handling, task acceptance or rejection, task status updates, maintenance evidence submission.
- Interfaces: ITaskManager, ITaskAssignmentService, IEvidenceService.

*5. Administrator management component*
- Dependencies: Data access layer, Authentication component, Technician task management component, Maintenance ticket management component, Notification management component.
- Provides: Ticket assignment, priority management, user account management, system monitoring.
- Interfaces: IAdminService, ITicketAssignmentManager, IUserManagementService.

*6. Notification management component*

- Dependencies: Email service, SMS gateway, In-App notification engine, Queue service (for asynchronous delivery).
- Provides: Notification delivery, notification preferences handling, notification history tracking.
- Interfaces: INotificationService, IMessageDispatcher, INotificationRepository.

*7. Analytics and reporting component*

- Dependencies: Data access layer, Chart libraries, Export services (PDF, Excel), Maintenance ticket management component, Technician task management component.
- Provides: Maintenance analytics, technician performance analysis, trend visualization, report generation.
- Interfaces: IAnalyticsEngine, IReportGenerator, IDataAggregator.

*8. File and evidence storage component*

- Dependencies: Cloud Storage API (e.g. AWS S3, Azure Blob), Security Access Control.
- Provides: Image upload, document storage, secure file access, file metadata management.
- Interfaces: IFileStorageService, IEvidenceRepository.

*9. System configuration and rules engine component*

- Dependencies: Data access layer.
- Provides: Priority rules, assignment automation policies (Auto-assign), notification thresholds, system configuration settings.
- Interfaces: IConfigurationService, IRuleEngine.

*Component Design Diagram*

#figure(
  image(
"../../assets/chapter4/componentdiagram.svg"
),
  caption: [Component Diagram]
)<componentdiagram>
