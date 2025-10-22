== Software Process Model
\
We are going to use the Waterfall Software Process Model. This model is suitable because our project goals and requirements are clearly defined from the beginning, and we have a strict timeline to follow. Since this model is based on a highly structured approach, it will help us maintain organization and ensure that all deliverables are completed on time.

#image("../../assets/chapter2/waterfallimage.jpg")

The main phases include:

- Requirements Analysis and Specification:

Requirements Analysis: Gathering and understanding all the requirements of the client, then documenting and analyzing them.

Requirement Specification: Documenting the analyzed requirements in a software requirement specification document that serves as a reference for the next phases.

\
- System Design:
Translating the requirements from the requirement specification document into a detailed system design as well as creating the overall architecture.

\
- Development:
Developing the web and mobile applications according to the designs created earlier, using a suitable programming languages and frameworks.

\
- Testing and Deployment:
Testing the whole software and verifying that all components work correctly and satisfy user expectations. After testing, the software is ready and available for use.

\
- Maintenance:
The final, ongoing phase. It ensures that the software remains functional, secure, and up-to-date throughout its operational life.

\
== Project Environment 

#text([
- Procedures: \ #text([
  - Initiation:
Establish the project team, define the requirements goals, and potential risks.
  - Planning:
Create a detailed project plan using the Waterfall methodology, this includes outlining all necessary steps, allocating resources, and developing cost, schedule, and communication plans to achieve our outcomes.

  - Execution and Testing:
Implement the planned activities and test them carefully to ensure quality and functionality.

  - Monitoring:
Track progress and compare it with planned goals to ensure timely delivery and quality control.

  - Documentation:
All design diagrams, reports, and testing results are documented using Typst and stored in a shared repository to ensure collaboration among team members.

])

])

\
- Tools:

#import table: cell, header

#figure(
  table(
    fill: none,
    stroke: none,
    columns: 2,
    align: left,
    [Development Tools],
  [ Visual Studio Code for developing the web application, and Flutter for building a responsive mobile application using one shared codebase.],
  [Documentation], [Typst for creating our PDF documentation.],
  [Version Control],[GitHub for sharing and tracking project progress and managing team collaboration.],
  [Design & Prototyping],[Figma for creqting UI/UX design, and Draw.io for diagrams.],
  [Database Management],[MySQL, chosen for its reliability, speed, and support for relational data.],
  [Testing ],[JUnit, an open-source testing framework, to verify our code’s correctness and performance.],
  [Communication Tools],[Google Meet, WhatsApp, and GitHub for coordination.]
  ),
  caption: [Tools],
)
<toolsTable>

\
- Hardware (HW) Resources:

#figure(
  table(
    fill: none,
    stroke: none,
    columns: 2,
    align: left,
    [Backend Server],
  [ Personal laptops and PCs for developing both the web and mobile applications.],
  [Database Server], [A server for hosting MySQL database, optimized for security and data backup.],
  [Testing Devices],[PCs for testing the website, and Android smartphones for mobile testing],
  ),
    caption: [Hardware (HW) Resources],
)
<HardwareTable>

\
- Software (SW) Resources:

#figure(
  table(
    fill: none,
    stroke: none,
    columns: 2,
    align: left,
    [Frontend Technologies],
  [ HTML, Tailwind CSS, and JavaScript for dynamic and responsive designs.],
  [Mobile Development], [Flutter for building the mobile app.],
  [Frameworks and Libraries],[React for web development, and Flutter for mobile.],
  [Backend Technologies],
  [Java and Node.js for handling server-side operations and building a secure and scalable backend.],
  [Database],[MySQL for storing and managing maintenance request data efficiently.],
  [Operating System],[Windows]
  ),
    caption: [Software (SW) Resources],
)
<SoftwareTable>

\
== Communication Plan

\
Our team will maintain communication through online meetings using Google Meet, and instant messaging using a WhatsApp group to assign tasks and ensure that everyone is updated on progress and deadlines.

Communication Methods:

In-Class Meetings: Held every Sunday to discuss progress, issues, and next steps.

Out-of-Class Meetings: Through Google Meet whenever there is a need for rapid discussion.

Messaging: A WhatsApp group for updates and daily coordination.

Version Control: GitHub is used for tracking code updates and version history.

\
- We also use GitHub to store and organize our documentation created using Typst, ensuring all of us can access the latest versions easily.