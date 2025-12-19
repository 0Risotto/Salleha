== System Stakeholders and Requirement Sources
=== System Stakeholders
#show figure:set align(left)
#show figure.caption:set align(center)
#show figure:set block(breakable:true)

+ *Operational Stakeholders*
  - End Users
    - Residents, Students, Employees.
    - Invdiviuals who report maintenance issues through the application.
    - Their main concerns are ease of use, privacy and clear updates with minimum delay.

  - Techinicians 
    - Invdiviuals who resolve maintenance requests assigned by the admin.
    - Their main concerns are clear task assignments, prioritization, smooth workflow and centralization.
+ *Internal Stakeholders*
   - Maintenance Administrators
    - Invdiviuals who oversee the whole maintenance workflow.
    - Their main concerns are efficiency, resource optimization and centralization.

  - Project Manager
    - Resposible for overall planning and coordination and project execution.
    - Main concerns are great communication, maintaining quality standards and ensuring project completion.
  - System Administrators
    - Invdiviuals who are responsible for the systems infrastructure, backups, user access controls and system performance.
    - Their main concerns are to ensure data integrity and smooth operation through out all the application processes.

+ *Excutive Stakeholders*
  - Executive Management  / Facility Management Leadership
    - Use system reports and analytics for decision-making.
    - Their main concerns are efficiency, cost control, and performance monitoring.

+ *External Stakeholders* 
  - Regulatory Authorities
    - Ensuring that the system complies with national laws.
  - Institution Responsible for Maintenance Services
    - Funds and authorizes the development of the system.
    - Main concerns are return on investment, system reliability, and long-term sustainability.
=== Information Gathering
To make sure the project's vision is well understoond and defined, while also having the culture in mind, we will preform a set of techniques in our search for information.

#pagebreak()
==== Interviews
#figure(
  table(
    columns: 2,
    table.cell(colspan: 2)[*End Users (Residents, Students, Employees)*],
    [*Question*],[*Question  Type*],
    [How do you currently report maintenance issues?], [open-ended],
    [Do you find the current maintenance reporting process easy to use?], [close-ended: yes or no],
    [What difficulties do you face when submitting a maintenance request?], [open-ended],
    [How important is privacy when reporting maintenance issues?], [scale],
    [Do you receive timely updates about the status of your requests?], [close-ended: yes or no],
    [What type of notifications or updates would you prefer to receive?], [open-ended],
    [How satisfied are you with the response time for maintenance issues?], [scale],
    [Would you use a centralized application for all maintenance-related issues?], [close-ended: yes or no],
 table.cell(colspan: 2,fill:rgb("#7EA6E0"))[*Technicians*],
    [*Question*],[*Question  Type*],
    [How are maintenance tasks currently assigned to you?], [open-ended],
    [Are task priorities clearly defined when you receive assignments?], [close-ended: yes or no],
    [What information do you need most to complete a maintenance task efficiently?], [open-ended],
    [How easy is it to track your assigned tasks and their status?], [scale],
    [Do you face delays due to unclear or incomplete requests?], [close-ended: yes or no],
    [What features would improve your daily maintenance workflow?], [open-ended],
    [Would a centralized system improve communication between you and administrators?], [close-ended: yes or no],
  ),
  caption:[Operational Stakeholders Interviews ]
)



#figure(
  table(
    columns: 2,

    table.cell(colspan: 2,fill:rgb("#7BA2DA"))[*Maintenance Administrators*],

    [How do you currently manage and track maintenance requests?], [open-ended],
    [Do you find it difficult to prioritize maintenance tasks?], [close-ended: yes or no],
    [How effective is the current system in allocating technicians and resources?], [scale],
    [What challenges do you face in overseeing the entire maintenance workflow?], [open-ended],
    [Do you require reporting or analytics to support decision-making?], [close-ended: yes or no],
    [What type of reports would be most useful for you?], [open-ended],
    [Would automation help reduce your workload?], [close-ended: yes or no],
    table.cell(colspan: 2,fill:rgb("#7EA6E0"))[*Project Manager*],

    [*Question*],[*Question  Type*],
    [What are the key objectives you expect this system to achieve?], [open-ended],
    [Do you believe the current maintenance process meets project goals?], [close-ended: yes or no],
    [How important is cross-team communication in this project?], [scale],
    [What risks do you foresee in implementing this system?], [open-ended],
    [Do you require milestone tracking and progress reports?], [close-ended: yes or no],
    [What indicators would you use to measure project success?], [open-ended],
 
)

   , caption:[Internal Stakeholders Interviews],
)



#figure(
  table(columns: 2,
  table.cell(colspan: 2,fill:rgb("#7EA6E0"))[*Executive Management / Facility Management Leadership*],

    [*Question*],[*Question Type*],
    [How do you currently evaluate maintenance performance?], [open-ended],
    [Do you rely on reports and analytics for decision-making?], [close-ended: yes or no],
    [How important is cost efficiency in maintenance operations?], [scale],
    [What key performance indicators would you like to monitor?], [open-ended],
    [Would real-time dashboards improve strategic oversight?], [close-ended: yes or no],
    table.cell(colspan: 2,fill:rgb("#7EA6E0"))[*System Administrators*],
    [*Question*],[*Question Type*],
    [What systems or tools are currently used to manage maintenance data?], [open-ended],
    [Is data security a major concern for this system?], [close-ended: yes or no],
    [How critical is system availability and uptime?], [scale],
    [What access control mechanisms are required for different users?], [open-ended],
    [Do you require regular backups and recovery mechanisms?], [close-ended: yes or no],
    [What performance issues do you anticipate as the system scales?], [open-ended],



  ),caption:[Executive Stakeholder Interviews])

#figure(
table(columns: 2,
table.cell(colspan: 2,fill:rgb("#7EA6E0"))[*Regulatory Authorities*],
    [*Question*],[*Question Type*],
    [What regulations must this system comply with?], [open-ended],
    [Is data protection compliance mandatory for this system?], [close-ended: yes or no],
    [How strict are reporting and audit requirements?], [scale],
    [What documentation or logs are required for compliance checks?], [open-ended],
  ),caption:[External Stakeholder Interview]
)

==== Questionnaires

#text(fill:red,size:50pt)[NOT DONE YET ]
 i will do it soon please dont kill me  lol
==== Document Analysis 
In this project, we systematically reviewed a range of institutional maintenance-related documents to gain a deeper understanding of stakeholder needs. These included historical maintenance service records, internal workflow reports, facility management evaluations, and previous user feedback from residents, students, and staff. This analysis helped identify inefficiencies, recurring issues, and key areas for improvement within the existing maintenance process. Additionally, it enabled us to uncover implicit requirements not directly expressed by stakeholders, ensuring that the proposed application addresses operational, usability, and performance needs effectively.
==== Observation
Based on the analysis of the questionnaire responses, it was observed that a significant number of participants expressed dissatisfaction with the current organization of maintenance services. Respondents frequently reported unclear reporting procedures, lack of prioritization, and delays caused by poor coordination between involved parties. Many users indicated that they often feel stressed or uncertain due to the absence of timely updates regarding the status of their requests. The findings suggest that implementing a centralized maintenance management system would improve organization, enhance transparency, and ensure continuous status updates. Such a system would reduce user stress, improve communication, and increase overall satisfaction by providing a more structured and reliable maintenance process.
==== Prototype
#text(fill:red,size:50pt)[NOT DONE YET] will do it later after we are good  with the user requirements
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
  caption: [High level Functional Requirements ],
)

