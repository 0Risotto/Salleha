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
+ Development costs must not exceed 45,000 JD
+ The project should be done by Sunday 4, Jan 2026
=== Vision Document 
#text(red)[
  *Not done yet.*
]

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
        [*Payback Period*], [*4 years+*],[4.6 years],
    
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
[*Implementation*],[Development of Core Features],[2 weeks],
[*Testing*],[System Testing and Quality Assurance],[5 weeks],
[*Deployment*],[System Deployment ],[1 week],
)
, caption: [Project Development Schedule]
)]

