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

