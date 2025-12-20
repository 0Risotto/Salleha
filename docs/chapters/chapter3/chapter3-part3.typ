== Context Diagram
#figure(
  image(
"../../assets/chapter3/ContextDiagram.png"
),
  caption: [Context Diagram]
)<Context_Diagram>

// Haneen
== Use Case Model
=== Use Case diagram 
#show figure:set block(width:70%)
#show figure.caption:set align(center)

#show figure.caption:set block(width:100%)


#figure(
  image(
"../../assets/chapter3/ucd1.png"
),
  caption: [Use Case Diagram - All Users ]
)<Use_Case_DiagramOne>

#show figure:set block(width:50%)


#figure(
  image(
"../../assets/chapter3/ucd2.png"
),
  caption: [Use Case Diagram - Resident ]
)<Use_Case_DiagramTwo>

#figure(
  image(
"../../assets/chapter3/ucd3.png"
),
  caption: [Use Case Diagram - Technician ]
)<Use_Case_DiagramThree>

#figure(
  image(
"../../assets/chapter3/ucd4.png"
),
  caption: [Use Case Diagram - Administrator ]
)<Use_Case_DiagramFour>

#pagebreak()

#show figure:set block(width:100%)
=== Use Case descriptions
#show figure: set block(breakable:true)
#figure(
table(
columns: 2,
align: left,
[*Use Case*],[*Brief Use Case description *],
[Sign Up], [Allows users to create an account by entering and validating personal information and role selection.],
[Sign In], [Allows users to log in using username and password and redirects them to the appropriate dashboard. ],
[Reset Password], [Allows users to reset their password using email, national ID, and a one-time verification code. ],
[Logout], [ Allows users to securely end their session and return to the login page.],
[Manage Profile], [ Allows users to view and edit their personal profile information.],
[See existing reports], [ Displays existing reports to prevent submitting duplicate maintenance tickets.],
[Get Ticket Status notification], [Notifies users when the status of their maintenance tickets changes. ],
[Track Ticket Status], [Allows users to monitor the real-time status of submitted maintenance tickets. ],
[Open Maintenance Ticket], [Allows users to submit a new maintenance ticket with issue details and optional images. ],
[View Reports Feed], [Allows users to view a list of reported maintenance issues with details and status. ],
[Navigate resident Menu], [ Provides access to system features through a resident navigation menu.],
[View resident Dashboard], [ Displays an overview of reported tickets and their current statuses after login.],

[View Technician Dashboard], [ Displays assigned tasks, pending requests, and task statuses.],
[Navigate Technician Menu], [ Provides technicians with access to task-related features through a navigation menu],
[Accept Maintenance Requests], [ Allows technicians to view and accept assigned maintenance tasks.],
[Update Task Status], [Allows technicians to update the status of maintenance tasks as work progresses. ],
[Upload Maintenance Evidence], [Allows technicians to upload images or notes as proof of task completion. ],
[Get new task notification], [ Notifies technicians when tasks are assigned or updated.],
[View Maintenance History], [ Allows technicians to view completed maintenance tasks with location and equipment details.],
[see analytics for tasks], [ Displays basic analytics related to completed maintenance tasks and areas.],

[View Admin Dashboard], [ Displays an overview of tickets, issue statuses, and technician workload],
[Navigate Admin Menu], [ Provides administrators with access to management and analytics features.],
[Assign Tickets], [ Allows administrators to assign maintenance tickets to technicians based on criteria.],
[Set Ticket Priority], [ Allows administrators to set or modify maintenance ticket priority levels.],
[Get New Tickets notification], [ Notifies administrators of new, overdue, or completed maintenance tasks.],
[View Maintenance Trends], [Allows administrators to analyze maintenance trends and performance metrics. ],
[Export Reports], [ Allows administrators to export maintenance reports and analytics in PDF or Excel format.],
[Manage Users], [Allows administrators to activate, deactivate, or update user accounts. ],

),
caption: [Use Cases Descriptions ],
)


