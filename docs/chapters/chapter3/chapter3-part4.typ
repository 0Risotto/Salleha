// Orjoan 
== 3.5 Functional Requirements Specification 
The functional requirements for the Maintenance Management System are detailed in the table below. Each requirement is assigned a unique number for reference.

FR-1 Role Based Registeration
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-1.1], [The system shall allow users to create an account by providing necessary information such as name, email, and password according to thier Role in the system.],
      [FR-1.2], [The system shall send a verification email to the user's provided email address to confirm account creation.],
      [FR-1.3], [The system shall store user account information securely in the database.],
      [FR-1.4], [The system shall allow users to set and update their profile information after account creation.],
      [FR-1.5], [ Each role has his own required register information:
      - Requester Login : Requester email, password and Requester ID.
      - Maintenance Staff Login : Maintenance staff personal email, password and phone number.
      - Administrator Login: Admin email, password, employee ID and admin code that is provided by the organization.]
    )

FR-2 Login
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-2.1], [The system shall authenticate users using valid credentials (username and password) that used in logging-in to other university platforms based on the selected role.],
      [FR-2.2],[The system shall redirect users to their respective dashboards upon successful login according to thier registered role-based.],
      [FR-2.3], [The system shall display a CAPTCHA verification code for all users during login to prevent bots. The CAPTCHA shall change with each page refresh. The CAPTCHA
      length is 5 numbers and characters.],
      [FR-2.4], [Provide a SMS verification code to Maintenance Staff and Administrators for two-factor authentication during login.],
      [FR-2.5], [The System shall display an error message for invalid login attempts, prompting users to re-enter their credentials. ]
    )

    FR-3 Password Recovery
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-3.1], [The system shall allow users to initiate a password recovery process by providing their registered email address.],
      [FR-3.2], [The system shall send a password reset link to the user's registered email address.],
      [FR-3.3], [The system shall allow users to reset their password by clicking on the link provided in the email and entering a new password.],
      [FR-3.4], [The system shall validate the password reset link to ensure it is valid and has not expired before allowing the user to set a new password.],
      [FR-3.5], [The system shall limit the resent link .],
      [FR-3.6], [The system shall confirm the successful password reset and allow the user to log in with the new password.]
    )

    FR-4 Logout
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-4.1],[The system shall display the name of
      the logged-in user in the top navigation area or
      header of the interface],
      [FR-4.2], []
    )

    FR-5 Submit Maintenance Request
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-5.1], [The system shall allow Requesters to submit maintenance requests by providing necessary details such as the type of issue, location, description, and any relevant attachments (e.g., photos).],
      [FR-5.2], [The system shall generate a unique ticket ID for each submitted maintenance request for tracking purposes.],
      [FR-5.3], [The system shall send a confirmation email to the Requester upon successful submission of a maintenance request, including the ticket ID and details of the request.],
      [FR-5.4], [The system shall validate the input fields to ensure all required information is provided before allowing submission of the maintenance request.],
      [FR-5.5], [The system shall allow Requesters to view, edit an delete their submitted maintenance requests before they are assigned to Maintenance Staff.],
      [FR-5.6], [The system shall send a notificationfor the requster when their requst is approved by maintenance staff, including the staff member’s name and phone number.],
      [FR-5.7], [The system shall allow Requesters to duplicat a previous maintenance request to quickly submit similar requests in the future.]
    )

    FR-6 Notifications
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-6.1], [The system shall generate notifications for users when there is an update to the status of their submitted feedback ],
      [FR-6.2], [The system shall allow users to mark notifications as read or unread.],
      [FR-6.3], [The system shall provide an option for users to delete individual notifications or clear all notifications at once.],
      [FR-6.4], [The system shall send email notifications to users for critical updates, such as when a maintenance request is completed.],
      [FR-6.5], [The system shall allow users to customize their notification preferences, including the types of notifications they wish to receive and the delivery method (e.g., email, in-app).]
    )

    FR-7 Role Based Dashboards
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-6.1], [the system shall provide a dashboard for each user role (Requester, Maintenance Staff, Administrator) that displays relevant information and functionalities based on their role.],
      [FR-6.2], [The Requester dashboard shall display submitted maintenance requests, their statuses, and options to submit new requests.],
      [FR-6.3], [The Maintenance Staff dashboard shall display assigned maintenance requests, their statuses, and options to update request progress.],
      [FR-6.4], [The Administrator dashboard shall provide an overview of all maintenance requests, user management options, and system settings.],
      [FR-6.5], [The dashboards shall be designed to be user-friendly and provide easy navigation to different sections of the system.],
      [FR-6.6], [The dashboards shall include visual indicators (e.g., charts, graphs) to represent maintenance request statistics and performance metrics for the maintenance staff and list of bouns easy requests.],
      [FR-6.7], [The dashboards shall allow maintenance staff to filter and sort maintenance requests based on various criteria such as date, status, and priority. ],
      [FR-6.8], [The dashboards shall provide  quick access to frequently used features and actions relevant to each user role. ],
      [FR-6.9], [The dashboards shall be responsive and accessible on various devices, including desktops, tablets, and mobile phones. ],
      [FR-6.10], [The dashboards shall include a search functionality to allow users to quickly find specific maintenance requests or information. ],
      [FR-6.11], [The dashboards shall provide real-time updates on maintenance request statuses and notifications to keep users informed of any changes. ],
      [FR-6.12], [The dashboards shall allow the administrators to manage user accounts, including creating, editing, and deleting users based on their roles. ],
      [FR-6.13], [The dashboards shall allow the administrators to overview all the maintenance requestswith their status. ], 
      [FR-6.14], [Provides detailed statistics and reports on maintenance activities, including the most frequently serviced locations and the number of requests received over time. ],
      [FR-6.15], [The dashboards shall include a help section or user guide to assist users in navigating and utilizing the system effectively. ],
      [FR-6.16], [The dashboards shall allow the administrators the ratings for the services and the maintenance staff that did they maintenance. ]
    )

    FR-8 Feedback and Rating
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-7.1], [The system shall allow Requesters to provide feedback on the maintenance services they received after a request is marked as completed.],
      [FR-7.2], [The system shall provide a rating scale (e.g., 1 to 5 stars) for Requesters to rate their satisfaction with the maintenance service.],
      [FR-7.3], [The system shall allow Requesters to submit additional comments or suggestions along with their ratings.],
      [FR-7.4], [The system shall store feedback and ratings in the database for future reference and analysis.],
      [FR-7.5], [The system shall provide Maintenance Staff and Administrators with access to feedback and ratings for performance evaluation and improvement purposes.],
      [FR-7.6], [The system shall send a notification to Requesters prompting them to provide feedback and rate the service after their maintenance request is completed.],
      [FR-7.7], [The system shall allow Requesters to edit or update their feedback and ratings within a specified time frame after submission.],
      [FR-7.8], [The system shall generate reports for Administrators summarizing feedback and ratings to identify areas for improvement in maintenance services.]
    )
    FR-9 Maintenance History
    #table(
      columns: 2,
      [*Number*], [*Description*],
      [FR-8.1], [The system shall maintain a history of all maintenance requests submitted by each Requester, including details such as request date, issue type, status, and resolution.],
      [FR-8.2], [ The system shall allow Requesters to view their maintenance history through their dashboard, with options to filter and sort requests based on various criteria such as date, status, and issue type.],
      [FR-8.3], [The system shall provide Maintenance Staff and Administrators with access to maintenance history records for performance evaluation and reporting purposes.],
      [FR-8.4], [The system shall generate reports summarizing maintenance history data for Administrators to analyze trends and identify areas for improvement in maintenance services.]
    )
