= Project initiation 
== Project Overview

SALLEHA is a platform designed for managing maintenance requests in 
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
#let issue3 = text([Users rarely receive updates on the status of their maintenance requests. This lack of visibility creates frustration and reduces trust in the system, while maintenance teams struggle to keep everyone informed. ])
#let issue4 = text([Users lack Privacy through and through with traditional reporting methods, this can lead to an upset and distrust to some people. Users care for their own privacy hence why some reports have never been sent before because of their own worry about the system.  ])
#table(stroke: none,columns: 2,
      fill: white  ,

        [*Issue*],[*weight*],
        [#issue1],[10],
        [#issue2],[9],
        [#issue3],[7],
        [#issue4],[6]
)

=== Objectives 
+ Simplify and centralize issue reporting through a user-friendly web/mobile interface that allows users to easily report maintenance problems and is available 24/7.
+ Enhance communication and transparency by providing real-time updates and notifications on request statuses
+ Create an analytics dashboard to provide administrators with insights and help them to identify trends and areas needing improvement.
+ Create a confidential system that ensures users anonymity and keeping their data secure and private from intruders.
=== Requirements
+ The system must ensure data security and protect the privacy of all users.
+ The system must be intuitive and user-friendly, allowing non-technical users to navigate and interact with it easily.
+ The analytics dashboard must be restricted to administrators only.
+ Maintenance reports must be submitted anonymously to ensure user comfort and honesty.

=== Constraints
+ Development costs must not exceed 45,000 JD
+ The project should be done by Sunday 4, Jan 2026
=== Vision Document
==== Problem Description
Ever since the digitalization of almost everything, people's expectations rose. People are
in constant demand of systems that fulfills there needs. Current methods are almost obsolete
they are ineffecient and insuffecient because the older methods have lack of transparency,
increased delays, and unavaliable hence the overall user frustration, not to mention the 
diffuculty of managing the reports.

Without a system to hold everything together it require a lot of effort to pull through the maintenance tasks.
To satisfy users, they need a system to adapt to their needs. Providing a smooth, painless experience
through an easy to use interface. A system is needed such that it enables feedback submission, tracks administrative responses, and provides data-driven
insights for continuous service improvement. Delaying this solution risks further dissatisfaction and
missed opportunities for institutional growth.

==== System Capabilities
+ Ticket Submission Capabilities. \ #text([
- Users are able to submit maintenance tickets through a user-friendly interface.
- Tickets include: \ #text([
  - Text description of the issue.
  - Image attachments to provide visual context.
  - Location tagging to help technicians identify where the issue is.
])])

+ Role-Based Dashboards. \ #text([
- The system provides separate dashboards based on user roles.
- Roles include: \ #text([
  - Users: Can submit and track tickets, view status updates, and provide feedback.
  - Technicians: Can view assigned tickets, update task statuses, and log maintenance work.
  - Administrators: Can assign tasks, monitor performance, and access analytics dashboards (restricted access).
])])

+ Task Assignment and Scheduling. \ #text([
- Administrators can assign tasks to technicians based on priority and availability.
- System supports: \ #text([
  - Priority-based task distribution depending on if its urgent or normal. 
  - Scheduling of tasks to optimize technician workload and response time.
\ ])])
+ Push and Email Notifications. \ #text([
- The system provides real time updates on ticket statuses.
- Notification types include: \ #text([
  - Push notifications via web or mobile.
  - Email alerts for important status changes.
])])
+ Maintenance History and Analytics. \ #text([
- System keeps a log of all past maintenance activities.
- Analytics dashboard features: \ #text([
  - Insights into frequent issues by area or equipment.
  - Performance tracking for continuous improvement.
  - Access restricted to administrators only.
])])
==== Business Benefits
- Providing a better quality of life.
- Overall increase of the user satisfaction.
- Increasing speed of maintenance tasks.
- Eliminating delays and lessening risks.
- Providing better communication channels.
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

All the required resources including hardware, software tools, and hosting services are already available and accessible, ensuring smooth development and operation of the SALLEHA platform.

Since all these technologies are part of what we have learned at university and
practiced in various projects,
we are fully capable of developing
and maintaining the SALLEHA platform
using them. Our academic background
and hands-on experience give us the technical foundation and confidence to build this system successfully.
=== Operational Feasibility
The proposed web and mobile application is operationally feasible. It is designed to receive maintenance requests in facilities such as universities, offices, or residential buildings, enabling users to report issues, track progress, and receive updates.
Since it is both a web and mobile application, users can access it from anywhere.
We expect that our system will gain wide acceptance from users, admins, and technicians because it addresses an essential need and saves time and effort.
It will have clear privacy guidelines and mechanisms to ensure that our users’ data will be secured, and it complies with the policies set by the country's laws and institutions.
Additionally, the system is well-suited to the local culture and environment. The end users are capable of using it smoothly and effectively without requiring extensive training, due to its simple and user-friendly design.

The proposed web and mobile application is operationally feasible. It is designed to receive maintenance requests in facilities such as universities, offices, or residential buildings, enabling users to report issues, track progress, and receive updates.
Since it is both a web and mobile application, users can access it from anywhere.
We expect that our system will gain wide acceptance from users, admins, and technicians because it addresses an essential need and saves time and effort.
It will have clear privacy guidelines and mechanisms to ensure that our users’ data will be secured, and it complies with the policies set by the country's laws and institutions.
Additionally, the system is well-suited to the local culture and environment. The end users are capable of using it smoothly and effectively without requiring extensive training, due to its simple and user-friendly design.
#pagebreak()
=== Economic Feasibility
*Development Costs:*   
#align(center)[
  #figure(
  table(

  columns: 2,align:left,
[*Expense Category*], [*Amount*],
[Salaries],[20,000 JD],
[Equipment and installations],[8,000 JD],
[Training],[1,500 JD],
[Facilities],[2,000 JD],
[Utilities],[1,000 JD],
[Travel\\Miscellaneous],[2,000 JD],
 [*Total*],[*39,500 JD*] )
, caption: [Devlopment Costs]
)]

*Operational Costs:*   
#align(center)[
  #figure(
  table(
  columns: 2,align:left,
[*Service*], [*Annual Cost(Per year)*],
[Operational maintenance],[7,000 JD],
[*Total Cost*],[*7,000 JD*]
  )
, caption: [Operational Costs]
)]

#align(center)[
  #figure(
  table(
  columns: 1,align:left,

    align(center)[*Intangible Benefits*],
      [Enhanced Institutional Trust and  reputation],
      [Increasing users satisfaction],
      [Saving time and effort for both users and Institutions],
  )
, caption: [Intangible Benefits]
)]
#pagebreak()
*Benefit and Payback Analysis:*
#align(center)[
  #show figure : set par(justify: false) 
  #figure(
    table(
      align: horizon,
      columns: 7,
        [*Category*], [*Year 0*], [*Year 1*], [*Year 2*], [*Year 3*], [*Year 4*], [*Year 5*],
        [*Value of benefits*], [0], [16,000 JD], [17,000 JD], [18,000 JD], [19,000 JD], [20,000 JD],
        [*Development costs*], [-39,500 JD], [0], [0], [0], [0], [0],
        [*Annual expenses*], [0], [-7,000 JD], [-7,000 JD], [-7,000 JD], [-7,000 JD], [-7,000 JD],
        [*Net Benefit / Costs*], [-39,500 JD], [9,000 JD], [10,000 JD], [11,000 JD], [12,000 JD], [13,000 JD],
        [*Discount Rate (7%)*], [1], [0.934], [0.873], [0.813], [0.763], [0.713],
        [*Net Present Value (NPV)*], [-39,500 JD], [8,406 JD], [8,730 JD], [8,943 JD], [9,156 JD], [9,269 JD],
        [*Cumulative NPV*], [-39,500 JD], [-31,094 JD], [-22,364 JD], [-13,421 JD], [-4,265 JD], [5,004 JD],
        [*Payback Period*], [*4 years+*],table.cell(colspan: 5,align: right)[*4.6 years*],
    
    ),
    caption: [Benefit and Payback Analysis]
  )
]
*Lifetime ROI* = *$(90,000-74,500)/(74,500) =0.208 or 20.8% $*

#h(1cm)*Annual ROI* = *$(20.8%)/5 = 4.16%$*



=== Schedule Feasibility

#align(center)[
  #figure(
  table(
  columns: 3,align:left,
[*Phase*], [*Task*],[*Estimated Time*],
[*Planning*],[Define Project Scope & Objectives],[1 week],
[*Analysis*],[Requirements Gathering, Process Analysis, \ and Document Delivery],[2 weeks],
[*Design*],[System Architecture and Interface Design],[2 weeks],
[*Implementation*],[Development of Core Features],[4 weeks],
[*Testing*],[System Testing and Quality Assurance],[2 weeks],
[*Deployment*],[System Deployment ],[1 week],
)
, caption: [Project Development Schedule]
)]

=== Legal Feasibility
The proposed platform fully aligns with Jordanian laws,
university policies, and institutional standards. 
All required approvals will be obtained from the University of Jordan’s relevant
departments before deployment. The system does not infringe upon any legal frameworks
or intellectual property rights.

*Licensing Compliance:*
All development tools, frameworks,
and libraries used in the platform
will be properly licensed.
Open-source components will
be used in accordance with
their respective licenses,
while any proprietary
technologies will be incorporated only after acquiring valid usage rights.

*Copyright and Intellectual Property Protection:* 
The platform will comply with the Jordanian Copyright Law No. 22 of 1992 and its amendments.
Any third-party content whether text, images, or software will be original, licensed,
or used under fair use conditions with full attribution.

*Data Privacy and Confidentiality:*
To comply with the Jordanian Personal Data Protection Law No. 24 of 2023, the system will:

+ Obtain explicit user consent prior to collecting or processing personal information.
+ Employ encryption and secure storage for sensitive data.
+ Ensure that personal data is used strictly for its intended purpose and accessed only by authorized personnel.

*Electronic Communication and Records Compliance:*
Under the Electronic Transactions Law No. 15 of 2015,
all digital communications and transactions carried out
through the platform will be handled as legally recognized
records, protected through appropriate technical and procedural safeguards.

*Terms of Service and Legal Disclosures:*
Users will be provided with clear Terms of Service and Privacy Policy agreements outlining:
- Data collection and usage practices
- User rights and responsibilities
- Risk disclosures and security provisions
These documents will comply with both university IT regulations and national legal requirements. 

== Recommended Solution and Expected Project Deliverables
To manage the maintenance requests of issues as they arise,
we can use a great solution: a Maintenance Request software system
that allows requesters to report maintenance issues directly
to the maintenance team using a web-based form or mobile app.
It helps streamline communication,
submission, and tracking without wasting time
gathering complete and accurate information or delaying repairs.
The people who the maintenance teams usually rely on,
such as employees and visitors,
will be able to submit detailed maintenance
forms that include descriptions, images,
and location information. Other processes
such as workflows for reviewing and
approving requests will be managed through a
dashboard that allows the team to assign,
prioritize, and monitor tasks.
Technicians can update the status of
each request in real time, and notifications
will be sent to users to inform them about progress and completion.

#underline[Expected Deliverables:]
A Maintenance Request Software that will include:
- *Request Submission:*
Maintenance teams will accept requests through
the system to ensure they collect all necessary
information to proceed with other maintenance processes.\
Users will submit it like a post; It'll have a title, location, photo and description.

- *Review and Approve Requests:*
A dashboard and analysis tool will help
the organization review all forms and decide
which requests will be approved.
Each request will be evaluated to
ensure that it is valid,
not redundant, and not already being addressed.

*Status Updates to Deliver Better Customer Service:*
To build trust between managers and customers, there will be a communication tool that responds back to requesters to inform them that their requests are accepted and to update them about the status of their issues until completion. These updates will be automated through real-time notifications.

*Database Design and Documentation:*
For storing and tracking requests, there will be request records that provide a clear view of all issues, and a database that documents what issues were reported, how they were resolved, and when. This will help with future planning and decision-making, as well as provide tools for summarizing the analysis, design, and implementation process.

*Performance Tracking:*
Updates on team work status for measuring team performance will help ensure that the original problem has been addressed and will identify bottlenecks in the request process. This will lead to providing excellent customer service and demonstrate that the maintenance team is responsive, works well, and continues improving the organization’s overall reputation. This will be done by tracking average response time and turnaround time.

== Local and Global Impact of the Proposed Solution 
*Locally:* The maintenance request system will ensure accuracy and enable the maintenance team to begin planning and scheduling maintenance work more quickly through automatically generated work orders from approved requests. Following best practices will also provide better customer service in this area. Automation means better experiences! It will reduce delays in handling requests, minimize manual paperwork, and ensure maintenance work is managed from start to finish through automated tools. This can lead to better resource management, higher efficiency, and greater satisfaction not just among staff but also among customers by keeping them updated about the status of their requests without delaying feedback.

*Globally:* It contributes to digital transformation and sustainability efforts. It is essential for businesses of all sizes to rely on such systems in their operations to efficiently allocate resources and maximize the performance of their assets.
A well-designed maintenance request system demonstrates how technology enables organizations to make data-driven decisions to achieve better operational efficiency by centralizing all maintenance requests in one platform.



