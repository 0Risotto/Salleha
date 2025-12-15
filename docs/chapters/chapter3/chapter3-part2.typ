// Mosa

== User Requirements
#show figure: set block(breakable:true)
#figure(
  table(
    columns: 4,
    [FR ID], [Function Name], [Description], [User/Role],
    [FR-1], [User Registration], [The system shall provide a registration interface where users can create an account by entering full name, email, national ID, username, password, and selecting their role. All fields shall be validated.], [All Users],
    [FR-2], [User Login], [The system shall allow users to log in using only their username and password. The system shall automatically retrieve the user’s role from the database and redirect to the appropriate dashboard.], [All Users],
    [FR-3], [Logout], [The system shall provide a logout option accessible from the navigation menu that securely ends the session and redirects to the login page.], [All Users],
    [FR-4], [Password Recovery], [The system shall provide a password recovery mechanism using registered email and national ID with a one-time verification code.], [All Users],
    [FR-5], [Resident Dashboard], [Upon login, residents shall see a dashboard displaying an overview of reported tickets and their current statuses.], [Resident],
    [FR-6], [Resident Navigation Menu], [Residents shall have a navigation menu containing Home, Report Status, Open Ticket, Notifications, Profile.], [Resident],
    [FR-7], [View Reports Feed], [Residents shall view a feed of reported maintenance issues with ticket title, category, location, and status (Open, In Progress, Fixed).], [Resident],
    [FR-8], [Open Maintenance Ticket], [Residents shall open a maintenance ticket with issue category, description, location, priority, and optional images.], [Resident],
    [FR-9], [Track Ticket Status], [Residents shall track the real-time status of their submitted tickets.], [Resident],
    [FR-10], [Notifications for Residents], [Residents shall receive notifications when ticket status changes.], [Resident],
    [FR-11], [Avoid Duplicate Reports], [Residents shall see existing reports to avoid duplicate ticket submissions.], [Resident],
    [FR-12], [Profile Management], [Residents shall view and edit their profile, excluding their role.], [Resident],
    [FR-13], [Technician Dashboard], [Technicians shall see a dashboard showing assigned tasks, pending requests, and statuses.], [Technician],
    [FR-14], [Technician Navigation Menu], [Technicians shall have a navigation menu with Home, Assigned Tasks, Maintenance History, Notifications, Profile.], [Technician],
    [FR-15], [Accept Maintenance Requests], [Technicians shall view and accept maintenance requests assigned by the system or administrators.], [Technician],
    [FR-16], [Update Task Status], [Technicians shall update task status (Open, In Progress, Fixed) as work progresses.], [Technician],
    [FR-17], [Upload Maintenance Evidence], [Technicians shall upload images or notes as evidence of maintenance completion.], [Technician],
    [FR-18], [Technician Notifications], [Technicians shall receive notifications when a new task is assigned or updated.], [Technician],
    [FR-19], [View Maintenance History], [Technicians shall view maintenance history, including equipment and location details.], [Technician],
    [FR-20], [Technician Analytics], [Technicians shall see basic analytics for completed tasks, equipment, and areas.], [Technician],
    [FR-21], [Admin Dashboard], [Administrators shall see a dashboard displaying total tickets, open issues, resolved issues, and technician workload.], [Administrator],
    [FR-22], [Admin Navigation Menu], [Administrators shall have a navigation menu with Home, Ticket Management, Technician Management, Analytics and Reports, Profile.], [Administrator],
    [FR-23], [Assign Tickets], [Administrators shall assign maintenance tickets to technicians based on priority, availability, and expertise.], [Administrator],
    [FR-24], [Set Ticket Priority], [Administrators shall set and modify ticket priority levels.], [Administrator],
    [FR-25], [Admin Notifications], [Administrators shall receive notifications of new tickets, overdue tasks, and completed maintenance work.], [Administrator],
    [FR-26], [View Analytics], [Administrators shall view analytics dashboards for maintenance trends, frequently reported areas, equipment performance, and task completion times.], [Administrator],
    [FR-27], [Export Reports], [Administrators shall export maintenance reports and analytics in PDF or Excel.], [Administrator],
    [FR-28], [Manage Users], [Administrators shall manage registered users, including activating, deactivating, or updating accounts.], [Administrator],
  ),
  caption: [Functional Requirements for Smart Maintenance System with Function Names],
)

