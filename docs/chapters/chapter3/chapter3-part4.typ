// Orjoan 
== 3.5 Functional Requirements Specification 
The functional requirements for the Maintenance Management System are detailed in the table below. Each requirement is assigned a unique number for reference.
#figure(
  align(left)[
    #table(
      columns: 3,

      [*Number*], [*Functional Requirements*], [*Description*],

      table.cell(colspan: 3)[#align(center)[Users Requirements]],

      [1], [Create account], [The user registers their personal information, including name, email, mobile number and selects the account type],

      [2], [Role Based Login], [The system allows users to log in based on their role (e.g., requester, technician, manager) using their email and password.
      Each role has his own required login information:
      - Requester Login : Requester email, password and Requester ID.
      - Maintenance Staff Login : Maintenance staff personal email, password and phone number.
      - Administrator Login: Admin email, password, employee ID and admin code],

      [3], [Logout], [Users can log out of their accounts securely to protect their personal information.],

      [4], [Edit/Update Profile], [Users can update thier information in their profile like phone number, location and efficiency for certain jobs.],

      [5], [Go To The Home Page], [Users can update thier information in their profile like phone number, location and efficiency for certain jobs.],

      [6], [Notifications], [Stakeholders should be able to monitor the status of their requests (e.g., received, scheduled, in progress, completed) and receive automated updates.],

      // ⬇️ FULL-WIDTH ROW (after requirement 6)
      table.cell(colspan: 3)[#align(center)[System Requirements]],
      [7], [Role Based Dashboards], [
        Each user sees a customized dashboard depending on their role in the system:
        #v(0.5em)
        *Requester:* \
        • List of their submitted tickets, their status and the names of maintenance Staff that assigned to. \
        • Profile information including name, email and Requester ID. \
        • Pie chart showing the number of tickets by status (e.g., open, in progress, completed). \
        • Names and contact information of assigned maintenance staff.
        
        #v(0.5em)
        *Maintenance Staff:* \
        • List of assigned maintenance tasks. \
        • Their work history \
        • List of their submitted tickets, their status and the names of the Requester and their contact information. \
        • Profile information including name, email and phone number. \
        • Bonus small tasks that they can do in their free time. \
        • Pie chart showing the number of tickets by status (e.g., open, in progress, completed). \
        
        #v(0.5em)
        *Administrator:* \
        • Overview of all maintenance requests and their statuses. \
        • User management tools to add, remove, or modify user accounts. \
        • System performance metrics and reports. \
        • Profile information including name, email and employee ID. \
        • Provides detailed statistics and reports on maintenance activities, including the most frequently serviced locations and the number of requests received over time.
      ],


      [8], [Ticket Submission], [Users submit their maintenance tickets through the website interface; it must include text description for the issue ,specifying the location, and a media like photos, videos, or other relevant documents. ],

      [9], [Maintenance History], [Complete maintenance history for all items,like date of maintenance, the action performed, the personnel responsible, and any related notes or outcomes.],

      [10], [Automated Prioritization], [The system must automatically prioritize requests based on predefined criteria (e.g., safety risks, operational impact, asset criticality).],

      [11], [Multimedia Attachments], [Ability to attach photos, videos, or other relevant documents to provide clarity on the issue.],

      [12], [Repeat / Duplicate The Issue], [Users can report the same problem if it occurs again.],

      [13], [], [],
    )
  ]
)


