= Project initiation 
== Project Overview

Salleha is a platform designed for managing maintenance requests in 
facilities like offices or residential buildings, making maintenance and 
reporting more efficient and easier. Users can report issues, track progress, 
and get updates. Admins and technicians can assign, prioritize, and resolve
tasks effectively.

== Problem Definition 
In many residential buildings, offices, and shared facilities people often  
face significant challenges in reaching authority of those In charge of
maintenance managers and staff. In traditional methods such as : emails, 
paper forms, or phone calls, are typically inefficient, lack transparency and lead to delays.
This often creates a communication  gap between users and the authorities responsible, which results in frustration, unaddressed issues, and potential safety hazards.

=== Issues
#let issue1 = text([Users often struggle to reach the right maintenance personnel, resulting in delays or ignored requests. Without a centralized and accessible system, reporting issues becomes time-consuming and unreliable.])
#let issue2 = text([Maintenance teams often work without proper tools to prioritize, assign, and track tasks. This leads to missed or delayed repairs, no clear ownership of responsibilities, and no data to measure performance or improve operations.])
#let Issues = text([Users rarely receive updates on the status of their maintenance requests. This lack of visibility creates frustration and reduces trust in the system, while maintenance teams struggle to keep everyone informed. ])
#table(stroke: none,columns: 2,
        [*Issue*],[*weight*],
        [#issue1],[10],
        [#issue2],[9],
        [#issue1],[7],
)

=== Objectives 
+ Simplify and centralize issue reporting through a user-friendly web/mobile interface that allows users to easily report maintenance problems and is available 24/7.
+ Enhance communication and transparency by providing real-time updates and notifications on request statuses
+ Create an analytics dashboard to provide administrators with insights and help them to identify trends and areas needing improvement.
=== Requirements
+ The system must ensure data security and protect the privacy of all users.
+ The system must be intuitive and user-friendly, allowing non-technical users to navigate and interact with it easily.
+ The analytics dashboard must be restricted to administrators only.
+ Maintenance reports must be submitted anonymously to ensure user comfort and honesty.

=== Constraints
+ Development costs must not exceed \$45000 JDS
+ The project should be done by Sunday 4, Jan 2026
=== Vision Document 
  woah not done yet
== Feasbility Studies
=== Techinical Feasibility
The technical feasibility assesses the technological components necessary 
to develop and operate the SALLEHA platform. This includes 
evaluating the required hardware, software tools, and the technical skills 
essential for building and maintaining the system.

Technology: The SALLEHA website is built using basic and easy-to-use 
Web tools like HTML, CSS, JavaScript, Bootstrap, and jQuery. These  
Tools help  create a clean and responsive design that works well on Different devices.
We also use Canva to design simple and clear images and graphics, 
making the website easy for Seniors users to understand and use .

Cloud Hosting: We are using GitHub to store and manage the project online. 
It helps us work together, keep track of changes, and easily share the project with others.
=== Operational Feasibility
The proposed web and mobile application is operationally feasible, it
designed to get maintenance requests in facilities like universities,offices, or residential buildings, enabling the users to report issues, track 
progress, and get updates.
It’s a web and mobile application, so the users can access it from any
We expected that our system will gain a wide acceptance from users, admins 
And technicians because it solves a very needed problem and saves time and effort.
It will have clear privacy guidelines and mechanisms to ensure that our users will be secured.      
it complies with the policies set by the country's laws and Institutions.
#pagebreak()
=== Economic Feasibility
Development Costs :   
#align(center)[
  #figure(
  table(
  columns: 2,align:left,
[*Expense Category*], [*Amount*],
[Salaries],[\$20,000 JD],
[Equipment and installations],[\$8,000 JD],
[Training],[\$1,500 JD],
[Facilities],[\$2,000 JD],
[Utilities],[\$1,000 JD],
[Travel\\Miscellaneous],[\$2,000 JD]
  )
, caption: [Devlopment Costs]
)]
