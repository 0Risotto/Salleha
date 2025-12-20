== Functional Requirements Specification

#show figure: set block(breakable:true)
#show figure:set align(left)
#show figure.caption:set align(center)

#figure(
caption:[FR-1 User Registration],
table(
columns: 2,
[Number], [Description],
[FR-1.1], [The system shall allow users to create an account by providing necessary information such as full name, email address, national ID number, username, and password.],
[FR-1.2], [The system shall require users to select their role during registration: Resident, Technician, or Administrator.],
[FR-1.3], [The system shall validate all input fields in real-time, including email format, password strength (minimum 8 characters with uppercase, lowercase, number, and special character), and national ID uniqueness.],
[FR-1.4], [The system shall display clear error messages when validation fails and prevent form submission until all fields are valid.],
[FR-1.5], [The system shall securely hash and store passwords in the database using industry-standard encryption algorithms.],
[FR-1.6], [The system shall send a confirmation email to the user's registered email address with an activation link to verify the account.],
[FR-1.7], [The system shall require email verification before allowing the user to log in to the system.],
[FR-1.8], [The system shall prevent duplicate registrations using the same email address or national ID number.]
)
)

#figure(
caption:[FR-2 User Login],
table(
columns: 2,
[Number], [Description],
[FR-2.1], [The system shall provide a login interface where users can enter their username and password.],
[FR-2.2], [The system shall authenticate users against stored credentials in the database.],
[FR-2.3], [The system shall automatically retrieve the user's role from the database upon successful authentication.],
[FR-2.4], [The system shall redirect users to their role-specific dashboard after successful login: Resident Dashboard, Technician Dashboard, or Administrator Dashboard.],
[FR-2.5], [The system shall display a CAPTCHA challenge after 3 consecutive failed login attempts to prevent brute-force attacks.],
[FR-2.6], [The system shall lock the account temporarily after 5 consecutive failed login attempts, requiring administrative intervention or email verification to unlock.],
[FR-2.7], [The system shall maintain user sessions with appropriate timeout periods: 30 minutes of inactivity for Residents, 15 minutes for Technicians, and 60 minutes for Administrators.],
[FR-2.8], [The system shall provide a "Remember Me" option that extends the session duration to 30 days for convenience.]
)
)

#figure(
caption:[FR-3 Logout],
table(
columns: 2,
[Number], [Description],
[FR-3.1], [The system shall provide a logout option accessible from the main navigation menu on all pages.],
[FR-3.2], [The system shall immediately terminate the user's session upon logout.],
[FR-3.3], [The system shall clear all session data and authentication tokens.],
[FR-3.4], [The system shall redirect the user to the login page after successful logout.],
[FR-3.5], [The system shall display a confirmation message indicating successful logout.]
)
)

#figure(
caption:[FR-4 Password Recovery],
table(
columns: 2,
[Number], [Description],
[FR-4.1], [The system shall provide a "Forgot Password" link on the login page.],
[FR-4.2], [The system shall require users to enter their registered email address and national ID number to initiate password recovery.],
[FR-4.3], [The system shall verify that the email and national ID match a valid user account in the database.],
[FR-4.4], [The system shall generate a unique, time-limited (15 minutes) one-time verification code and send it to the user's registered email.],
[FR-4.5], [The system shall require users to enter the verification code received via email.],
[FR-4.6], [The system shall allow users to create a new password only after successful verification code validation.],
[FR-4.7], [The system shall require password confirmation (re-typing the new password) to prevent typographical errors.],
[FR-4.8], [The system shall enforce the same password strength requirements as during registration.],
[FR-4.9], [The system shall prevent reusing the last 3 previously used passwords.],
[FR-4.10], [The system shall send a confirmation email to the user's registered email address once the password has been successfully changed.]
)
)

#figure(
caption:[FR-5 Resident Dashboard],
table(
columns: 2,
[Number], [Description],
[FR-5.1], [The system shall display a personalized dashboard for residents upon successful login.],
[FR-5.2], [The dashboard shall show an overview of all tickets submitted by the resident, categorized by status: Open, In Progress, Fixed.],
[FR-5.3], [The system shall display a summary widget showing: total tickets submitted, currently open tickets, and tickets fixed in the last 30 days.],
[FR-5.4], [The system shall provide a quick action button to "Report New Issue" prominently displayed on the dashboard.],
[FR-5.5], [The system shall show recent activity, including status changes to tickets, with timestamps.],
[FR-5.6], [The system shall provide a search functionality to filter tickets by ticket ID, category, or date range.],
[FR-5.7], [The system shall display notifications count in a badge on the dashboard header.],
[FR-5.8], [The dashboard shall be responsive and adapt to different screen sizes (desktop, tablet, mobile).]
)
)

#figure(
caption:[FR-6 Resident Navigation Menu],
table(
columns: 2,
[Number], [Description],
[FR-6.1], [The system shall provide a consistent navigation menu accessible from all resident pages.],
[FR-6.2], [The navigation menu shall include the following items: Home (Dashboard), Report Status, Open Ticket, Notifications, Profile.],
[FR-6.3], [The system shall highlight the currently active menu item for user orientation.],
[FR-6.4], [The navigation menu shall collapse to a hamburger menu on mobile devices.],
[FR-6.5], [The system shall display the user's name and role in the navigation header.],
[FR-6.6], [The system shall include a logout button in the navigation menu.]
)
)

#figure(
caption:[FR-7 Maintenance Issue Feed],
table(
columns: 2,
[Number], [Description],
[FR-7.1], [The system shall display a feed of reported maintenance issues accessible to residents.],
[FR-7.2], [Each entry in the feed shall display: Ticket Title, Category, Location (Building/Room), Status (Open/In Progress/Fixed), and Date Reported.],
[FR-7.3], [The system shall allow residents to filter the feed by: Category (Plumbing, Electrical, HVAC, Structural, Other), Status, and Date Range.],
[FR-7.4], [The system shall provide a search functionality within the feed to find specific issues by keywords.],
[FR-7.5], [The system shall indicate tickets submitted by the logged-in resident with a "Your Ticket" badge.],
[FR-7.6], [The system shall prevent display of sensitive information or personal details of other residents.],
[FR-7.7], [The system shall update the feed in real-time when new tickets are submitted or statuses change.],
[FR-7.8], [The system shall paginate results if more than 20 items are displayed.]
)
)

#figure(
caption:[FR-8 Open Maintenance Ticket],
table(
columns: 2,
[Number], [Description],
[FR-8.1], [The system shall provide a form for residents to submit new maintenance tickets.],
[FR-8.2], [The form shall require the following mandatory fields: Issue Category (dropdown), Description (text area), Location (dropdown or text), Priority (Low/Medium/High/Urgent).],
[FR-8.3], [The system shall allow residents to upload up to 5 images (JPEG, PNG, max 5MB each) to illustrate the issue.],
[FR-8.4], [The system shall provide a preview of uploaded images before submission.],
[FR-8.5], [The system shall validate that the description contains at least 20 characters to ensure adequate detail.],
[FR-8.6], [The system shall check for duplicate tickets by comparing category, location, and description with recent (last 7 days) submissions.],
[FR-8.7], [The system shall show a warning if a similar ticket exists, with an option to proceed or cancel.],
[FR-8.8], [The system shall generate a unique ticket ID (format: TKT-YYYYMMDD-XXXXX) upon successful submission.],
[FR-8.9], [The system shall display a confirmation page with the ticket ID and estimated response time based on priority.]
)
)

#figure(
caption:[FR-9 Ticket Status Tracking],
table(
columns: 2,
[Number], [Description],
[FR-9.1], [The system shall allow residents to track the real-time status of their submitted tickets.],
[FR-9.2], [The system shall display a visual status indicator showing the current stage: Submitted → Assigned → In Progress → Fixed → Closed.],
[FR-9.3], [The system shall show the timestamp for each status change.],
[FR-9.4], [For tickets "In Progress," the system shall display the assigned technician's name (if available).],
[FR-9.5], [The system shall provide estimated time to completion based on priority and historical data.],
[FR-9.6], [The system shall allow residents to add follow-up comments to their tickets, which will be visible to technicians and administrators.],
[FR-9.7], [The system shall prevent residents from modifying the original ticket details after submission, except for adding comments.],
[FR-9.8], [The system shall provide a "Mark as Urgent" option for tickets that have exceeded their estimated completion time.]
)
)

#figure(
caption:[FR-10 Status Change Notifications],
table(
columns: 2,
[Number], [Description],
[FR-10.1], [The system shall automatically notify residents when their ticket status changes.],
[FR-10.2], [Notifications shall be delivered through: In-app notification bell, Email (optional), SMS (optional, configurable).],
[FR-10.3], [The notification shall include: Ticket ID, New Status, Timestamp, and a direct link to view the ticket details.],
[FR-10.4], [The system shall allow residents to configure notification preferences for each type of status change.],
[FR-10.5], [The system shall group related notifications (multiple status changes within a short period) to avoid notification overload.],
[FR-10.6], [The system shall maintain a notification history accessible to residents for 90 days.]
)
)

#figure(
caption:[FR-11 Duplicate Ticket Prevention],
table(
columns: 2,
[Number], [Description],
[FR-11.1], [The system shall show residents existing reports in the same location/category before they submit a new ticket.],
[FR-11.2], [The system shall automatically detect potential duplicates by comparing: issue category, location, description keywords, and submission date (within last 7 days).],
[FR-11.3], [When a potential duplicate is detected, the system shall display a warning message with links to the existing similar tickets.],
[FR-11.4], [The system shall provide residents with the option to: proceed with new submission, add a comment to existing ticket, or cancel submission.],
[FR-11.5], [The system shall allow residents to "follow" existing tickets to receive updates on their progress.],
[FR-11.6], [The system shall track duplicate detection accuracy and allow administrators to adjust sensitivity thresholds.]
)
)

#figure(
caption:[FR-12 Resident Profile Management],
table(
columns: 2,
[Number], [Description],
[FR-12.1], [The system shall allow residents to view their profile information including: full name, email, national ID, username, registration date.],
[FR-12.2], [The system shall allow residents to edit the following fields: full name, email address, password, profile picture.],
[FR-12.3], [The system shall prevent residents from editing their role, national ID, and registration date.],
[FR-12.4], [The system shall require password verification before allowing sensitive changes (email, password).],
[FR-12.5], [The system shall validate new email addresses by sending a verification link before applying the change.],
[FR-12.6], [The system shall maintain an audit log of all profile changes with timestamp and IP address.],
[FR-12.7], [The system shall allow residents to export their profile data in PDF format.]
)
)

#figure(
caption:[FR-13 Technician Dashboard],
table(
columns: 2,
[Number], [Description],
[FR-13.1], [The system shall display a personalized dashboard for technicians upon successful login.],
[FR-13.2], [The dashboard shall show assigned tasks categorized by: Pending (not started), In Progress, Completed Today, Overdue.],
[FR-13.3], [The system shall display key performance metrics: total assigned tasks, completion rate (%), average resolution time, customer satisfaction rating.],
[FR-13.4], [The system shall provide a calendar view showing scheduled maintenance tasks.],
[FR-13.5], [The dashboard shall display urgent/high-priority tasks in a prominent "Priority Queue" section.],
[FR-13.6], [The system shall show notifications for: new task assignments, task status updates from residents, scheduled maintenance reminders.],
[FR-13.7], [The system shall provide quick action buttons: "Start Next Task", "View All Tasks", "Update Status".],
[FR-13.8], [The dashboard shall display workload distribution across technicians (visible to technicians with team lead permissions).]
)
)

#figure(
caption:[FR-14 Technician Navigation Menu],
table(
columns: 2,
[Number], [Description],
[FR-14.1], [The system shall provide a consistent navigation menu accessible from all technician pages.],
[FR-14.2], [The navigation menu shall include: Home (Dashboard), Assigned Tasks, Maintenance History, Notifications, Profile, Logout.],
[FR-14.3], [For technicians with team lead permissions, the menu shall include additional items: Team Schedule, Performance Reports.],
[FR-14.4], [The system shall display the technician's current status (Available/Busy/On Break) in the navigation header.],
[FR-14.5], [The system shall provide a quick status toggle button in the navigation menu to update availability.],
[FR-14.6], [The navigation menu shall show badge counts for: pending tasks, unread notifications.],
[FR-14.7], [The system shall collapse the navigation menu to an icon-only view on tablet devices.]
)
)

#figure(
caption:[FR-15 Maintenance Request Management],
table(
columns: 2,
[Number], [Description],
[FR-15.1], [The system shall allow technicians to view maintenance requests assigned by the system or administrators.],
[FR-15.2], [The system shall display request details including: ticket ID, issue category, location, priority, description, submitted images, resident contact information.],
[FR-15.3], [Technicians shall be able to accept or decline assigned tasks, with a required reason for declining.],
[FR-15.4], [The system shall automatically reassign declined tasks to the next available technician based on expertise and workload.],
[FR-15.5], [Technicians shall be able to filter tasks by: priority, location, category, due date, or status.],
[FR-15.6], [The system shall provide a "Claim Task" feature for technicians to voluntarily take unassigned tasks matching their expertise.],
[FR-15.7], [The system shall display estimated time to complete based on similar historical tasks.],
[FR-15.8], [Technicians shall be able to request additional information from the resident before accepting a task.]
)
)

#figure(
caption:[FR-16 Task Status Updates],
table(
columns: 2,
[Number], [Description],
[FR-16.1], [The system shall allow technicians to update task status through the following workflow: Open $->$ In Progress $->$ Fixed $->$ Closed.],
[FR-16.2], [When changing status to "In Progress," the system shall record start time and expected completion time.],
[FR-16.3], [When changing status to "Fixed," the system shall require: completion notes, actual resolution time, and optional images.],
[FR-16.4], [Technicians shall be able to set a task to "On Hold" with reason codes: Waiting for Parts, Requires Specialist, Resident Not Available.],
[FR-16.5], [The system shall automatically escalate tasks that remain "In Progress" beyond the estimated completion time.],
[FR-16.6], [Technicians shall be able to reassign tasks to other technicians with proper justification and administrator approval.],
[FR-16.7], [All status changes shall be timestamped and recorded in the task history.],
[FR-16.8], [The system shall notify the resident and administrator of significant status changes.]
)
)

#figure(
caption:[FR-17 Maintenance Evidence Submission],
table(
columns: 2,
[Number], [Description],
[FR-17.1], [The system shall allow technicians to upload images as evidence of maintenance completion.],
[FR-17.2], [The system shall support multiple image formats: JPEG, PNG, with maximum file size of 10MB per image.],
[FR-17.3], [Technicians shall be able to add descriptive captions to each uploaded image.],
[FR-17.4], [The system shall allow technicians to add completion notes describing: work performed, parts used, time spent, any follow-up required.],
[FR-17.5], [The system shall provide a checklist of standard completion criteria based on issue category.],
[FR-17.6], [Technicians shall be able to attach PDF documents such as: warranty information, part specifications, safety checklists.],
[FR-17.7], [The system shall require at least one piece of evidence (image or detailed notes) before marking a task as "Fixed."],
[FR-17.8], [All submitted evidence shall be stored securely with timestamps and technician identification.]
)
)

#figure(
caption:[FR-18 Technician Notifications],
table(
columns: 2,
[Number], [Description],
[FR-18.1], [The system shall notify technicians when a new task is assigned to them.],
[FR-18.2], [The system shall notify technicians of updates to assigned tasks, including: resident comments, priority changes, due date adjustments.],
[FR-18.3], [Notifications shall be delivered through: in-app notifications, push notifications (mobile app), SMS for urgent tasks.],
[FR-18.4], [The system shall provide priority-based notification levels: High (immediate), Medium (within 15 minutes), Low (within 1 hour).],
[FR-18.5], [Technicians shall be able to set "Do Not Disturb" periods during which only emergency notifications are delivered.],
[FR-18.6], [The system shall group related notifications to reduce notification fatigue.],
[FR-18.7], [Technicians shall be able to customize notification preferences by: notification type, delivery method, time of day.]
)
)

#figure(
caption:[FR-19 Maintenance History Access],
table(
columns: 2,
[Number], [Description],
[FR-19.1], [The system shall provide technicians access to complete maintenance history for equipment and locations.],
[FR-19.2], [The history shall include: ticket ID, issue description, location details, equipment ID, technician assigned, resolution details, date/time stamps.],
[FR-19.3], [Technicians shall be able to filter history by: equipment ID, location, date range, technician, issue category.],
[FR-19.4], [The system shall display recurring issues patterns and suggest preventive maintenance schedules.],
[FR-19.5], [Technicians shall be able to view equipment-specific history including: all previous maintenance, warranty information, manufacturer details.],
[FR-19.6], [The system shall provide a "Similar Issues" feature showing historical resolutions for current problems.],
[FR-19.7], [Technicians shall be able to export maintenance history for specific equipment or locations in CSV format.]
)
)

#figure(
caption:[FR-20 Basic Analytics for Technicians],
table(
columns: 2,
[Number], [Description],
[FR-20.1], [The system shall provide technicians with basic analytics on completed tasks.],
[FR-20.2], [Analytics shall include: tasks completed per period (day/week/month), average resolution time, completion rate by category.],
[FR-20.3], [The system shall display equipment performance trends showing frequency of issues by equipment type.],
[FR-20.4], [Technicians shall be able to view area-specific statistics showing most frequently serviced locations.],
[FR-20.5], [The system shall provide personal performance metrics compared to team averages.],
[FR-20.6], [Analytics shall be visualized through: bar charts, line graphs, pie charts, and trend lines.],
[FR-20.7], [Technicians shall be able to set personal performance goals and track progress.],
[FR-20.8], [The system shall provide recommendations for skill development based on frequently assigned task categories.]
)
)

#figure(
caption:[FR-21 Administrator Dashboard],
table(
columns: 2,
[Number], [Description],
[FR-21.1], [The system shall display a comprehensive dashboard for administrators upon successful login.],
[FR-21.2], [The dashboard shall show key performance indicators (KPIs) including: total tickets (current month), open issues, resolved issues (last 7 days), average resolution time.],
[FR-21.3], [The system shall display technician workload distribution showing: assigned tasks per technician, completion rates, current availability status.],
[FR-21.4], [The dashboard shall include a real-time ticker showing: new tickets submitted, tickets resolved, overdue tasks.],
[FR-21.5], [The system shall provide geographical heat map showing issue density by building/location.],
[FR-21.6], [Administrators shall be able to customize dashboard widgets and rearrange layout according to preference.],
[FR-21.7], [The dashboard shall display system health metrics: active users, system uptime, database performance.],
[FR-21.8], [The system shall provide quick action buttons: "Assign Pending Tickets", "Generate Reports", "Manage Users".]
)
)

#figure(
caption:[FR-22 Administrator Navigation Menu],
table(
columns: 2,
[Number], [Description],
[FR-22.1], [The system shall provide a comprehensive navigation menu accessible from all administrator pages.],
[FR-22.2], [The navigation menu shall include: Home (Dashboard), Ticket Management, Technician Management, Analytics and Reports, System Configuration, User Management, Profile, Logout.],
[FR-22.3], [The system shall display administrator privileges and access level in the navigation header.],
[FR-22.4], [The navigation menu shall include sub-menus for each main category with expanded options.],
[FR-22.5], [The system shall highlight critical alerts in the navigation menu (e.g., "5 Urgent Tickets Pending").],
[FR-22.6], [Administrators shall be able to pin frequently used menu items to a quick access bar.],
[FR-22.7], [The system shall provide keyboard shortcuts for common navigation actions.]
)
)

#figure(
caption:[FR-23 Ticket Assignment Management],
table(
columns: 2,
[Number], [Description],
[FR-23.1], [The system shall allow administrators to assign maintenance tickets to technicians manually or automatically.],
[FR-23.2], [For manual assignment, the system shall show: technician availability, current workload, expertise match, location proximity.],
[FR-23.3], [The system shall support automatic assignment based on: priority level, technician specialization, workload balancing, geographical zones.],
[FR-23.4], [Administrators shall be able to override automatic assignments with manual reassignments.],
[FR-23.5], [The system shall provide bulk assignment functionality for multiple tickets at once.],
[FR-23.6], [When assigning tickets, administrators shall be able to set: expected completion time, special instructions, required tools/parts.],
[FR-23.7], [The system shall maintain assignment history showing all assignment changes with timestamps and reasoning.],
[FR-23.8], [Administrators shall be able to set up assignment rules and automation policies for recurring ticket types.]
)
)

#figure(
caption:[FR-24 Ticket Priority Management],
table(
columns: 2,
[Number], [Description],
[FR-24.1], [The system shall allow administrators to set and modify ticket priority levels: Low, Medium, High, Urgent, Emergency.],
[FR-24.2], [Priority levels shall determine: response time expectations, assignment order, escalation rules.],
[FR-24.3], [Administrators shall be able to bulk update priorities for multiple tickets based on criteria.],
[FR-24.4], [The system shall automatically adjust priorities based on: time since submission, number of similar issues, affected users count.],
[FR-24.5], [Administrators shall be able to define custom priority rules based on: location criticality, time of day, equipment importance.],
[FR-24.6], [Priority changes shall trigger notifications to assigned technicians and residents.],
[FR-24.7], [The system shall maintain audit trail of all priority changes with justification notes.]
)
)

#figure(
caption:[FR-25 Administrator Notifications],
table(
columns: 2,
[Number], [Description],
[FR-25.1], [The system shall notify administrators of new high-priority ticket submissions.],
[FR-25.2], [Administrators shall receive notifications for: overdue tasks (exceeding expected completion time), unassigned tickets exceeding threshold time.],
[FR-25.3], [The system shall notify administrators when maintenance work is completed, requiring quality assurance review.],
[FR-25.4], [Notifications shall be categorized by: urgency (Immediate/High/Medium/Low), department, location.],
[FR-25.5], [Administrators shall be able to configure notification thresholds and escalation paths.],
[FR-25.6], [The system shall provide notification summary reports showing: notification volume, response times, unresolved alerts.],
[FR-25.7], [Administrators shall be able to snooze notifications or set "Out of Office" auto-replies.]
)
)

#figure(
caption:[FR-26 Analytics and Reporting],
table(
columns: 2,
[Number], [Description],
[FR-26.1], [The system shall provide comprehensive analytics dashboards showing maintenance trends over time.],
[FR-26.2], [Analytics shall include: frequently reported areas/equipment, recurring issue patterns, seasonal trends.],
[FR-26.3], [The system shall display equipment performance analytics: MTBF (Mean Time Between Failures), maintenance costs, downtime analysis.],
[FR-26.4], [Administrators shall be able to analyze task completion times by: technician, category, location, priority.],
[FR-26.5], [The system shall provide predictive analytics suggesting preventive maintenance schedules.],
[FR-26.6], [Analytics shall include cost analysis: labor costs, parts costs, total maintenance expenditure by period.],
[FR-26.7], [Administrators shall be able to create custom reports using drag-and-drop report builder.],
[FR-26.8], [The system shall support comparative analysis: month-over-month, year-over-year, location comparisons.]
)
)

#figure(
caption:[FR-27 Report Export Functionality],
table(
columns: 2,
[Number], [Description],
[FR-27.1], [The system shall allow administrators to export maintenance reports in multiple formats: PDF, Excel (XLSX), CSV.],
[FR-27.2], [PDF exports shall include: company logo, report title, date range, pagination, professional formatting.],
[FR-27.3], [Excel exports shall preserve: formulas, charts, filters, and data validation where applicable.],
[FR-27.4], [Administrators shall be able to schedule automated report generation and email distribution.],
[FR-27.5], [The system shall provide pre-built report templates: monthly maintenance summary, technician performance, equipment history.],
[FR-27.6], [Exported reports shall include all relevant metadata: generation timestamp, exported by, report parameters.],
[FR-27.7], [Administrators shall be able to export raw data for external analysis in statistical software.],
[FR-27.8], [The system shall maintain export history with download logs for audit purposes.]
)
)

#figure(
caption:[FR-28 User Account Management],
table(
columns: 2,
[Number], [Description],
[FR-28.1], [The system shall allow administrators to manage all registered user accounts.],
[FR-28.2], [Administrators shall be able to: activate, deactivate, suspend, or delete user accounts.],
[FR-28.3], [For technician accounts, administrators shall be able to: assign specializations, set work zones, define skill levels.],
[FR-28.4], [Administrators shall be able to update user information: contact details, role changes (with approval workflow), access permissions.],
[FR-28.5], [The system shall provide bulk user management operations: import users from CSV, bulk role assignment, mass communication.],
[FR-28.6], [Administrators shall be able to reset user passwords and force password change on next login.],
[FR-28.7], [The system shall maintain comprehensive audit logs of all user management activities.],
[FR-28.8], [Administrators shall be able to set account expiration dates and receive renewal reminders.]
)
)










