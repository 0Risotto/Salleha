== Project tasks

#show figure: set columns(7)
#show figure: set block(breakable: true)
#show figure: set align(left)
#show figure: set par(justify: false)
//headers
#let header1 = (table.cell(fill: rgb(126, 166, 224) )[*Phase*], table.cell(fill: rgb(126, 166, 224))[*Task*], table.cell(fill: rgb(126, 166, 224))[*Detailed task*], table.cell(fill: rgb(126, 166, 224))[*EstimatedTime*])
#let header2 = (table.cell()[],table.cell(fill: rgb("#92c0e6d0"))[*Resources Needed*], table.cell(fill: rgb("#92c0e6d0"))[*Dependencies and Constraints*], table.cell(fill: rgb("#92c0e6d0"))[*Deliverables & Milestones*])

#let a = table.cell(colspan: 4, inset: 0pt)[]
#figure(
  caption: [Project Tasks],
table(columns: 4,
  ..header1,



  list(
    [Resource & Schedule Planning (T1)],
    [Requirements Gathering (T2)],

  ),
  list(
    [Develop Work Breakdown Structure for web and mobile app development],
    [Create risk register and define quality standards for the application],
  ),
  list(
    [ Define project phases and deliverables],
    [Assign WBS elements to team members],
    [ Identify risks and quality objectives],
    [Define acceptance criteria and mitigation strategies],
  ),
  [1 weeks],

  
  ..header2,
 
  []
,
list(
 [N/A]
),
list(
  [ *Dependencies*
- Approved project charter
- Availability of key stakeholders for interviews such as the requesters and the facility managers
  ],
  [*Constraints*

- Budget constraints
]
),
list(
  [ *Deliverables*
- Work breakdown structure diagram
- Table with risk, impact, probability, priority, and mitigation
- Quality standards document (acceptance criteria checklist)
  ],[
*Milestones*
- M1.1: Charter Approved and communicated to the team.
- M1.2: Work Breakdown Structure completed and reviewed by all members. 
- M1.3: Resource plan and schedule baseline approved.
- M1.4: Risk register and quality standards finalized.
]
),
  ..header1,

  
  [Analysis],
  list(
    [Requirements Elicitation (T3)],
    [Requirements Modeling & Documentation (T4)],
    [Requirements Validation (T5)],
  ),
  list(
    [Conduct stakeholder interviews],
    [Distribute surveys to end-users],
    [Observe existing maintenance request processes],
    [Write Software Requirements Specification (SRS)],
    [Create use-case diagrams for maintenance workflows],
    [Develop entity-relationship diagrams (ERDs) for database],
    [Document non-functional requirements (performance, security, compatibility)],
    [Facilitate requirements review sessions],
    [Build wireframes for React web and Flutter mobile interfaces],
    [Resolve conflicts and ambiguities],
    [Obtain formal sign-off on SRS],
  ),
  [2 weeks],

  ..header2,
  
 
  []
,
list(
  [N/A]
),
list(
  [*Dependencies*
  
  - Access to collaboration tools so the informations can be shared and reviewed.
],
  [*Constraints*
  
  - Stakeholder time; limited availability may restrict depth of interviews
  - Data privacy when handaling the facility data
]
),
list(
  [*Deliverables*
- Software Requirements Specification
- Use-case diagrams for the main maintenance workflows 
- Entity-Relationship Diagram
- Wireframes
- Survey results and interview notes 
- Non-functional requirements list 
- Requirements validation report
- Requirements Traceability Matrix
  ],
[*Milestones*

- M2.1: Software Requirements Specification (SRS) reviewed and approved by stakeholders.
- M2.2: Requirements validation and traceability matrix completed.

]
),
  ..header1,
  [Design],
  list(
    [Architectural Design (T6)],
    [High-Level (Logical) Design (T7)],
    [Detailed (Physical) Design (T8)],
    [Design Review & Approval (T9)],
  ),
  list(
    [Choose overall system architecture for web and mobile],
    [Define network topology and cloud infrastructure],
    [Break system into modules (frontend, backend, database)],
    [Define REST API contracts and module interfaces],
    [Draft high-level sequence diagrams for maintenance request workflows],
    [Create class diagrams for React and Flutter components],
    [Design database schema with tables, indices, and constraints],
    [Specify UI layouts and navigation flows for web and mobile],
    [Define error-handling and logging approaches],
    [Organize design walkthroughs with team and stakeholders],
  ),
  [2 weeks],

  ..header2,
  
  []
,
list(
  [
 Information Security Engineer
]
),
list(
  [*Dependencies*

- Completion and approval of Software Requirements Specification 
- UI design depends on confirmed user workflows and functional requirements because they show what the user needs to do and how the system should respond 
      ],
[*Constraints*

- Technology constraints
- Design must comply with quality standards and security requirements

]
),
list(
  [*Deliverables*

- Web and Mobile System Architecture Document 
- High-Level Design including  system modules and interaction diagrams
- Detailed Design including Class diagrams, Sequence diagrams, Database schema and API documentation
- UI/UX prototypes for web and mobile
      ],
[*Milestones*

- M3.1: System architecture approved.
- M3.2: High-level and detailed design documents completed.
- M3.3: UI/UX prototypes finalized and validated with stakeholders.
- M3.4: Design reviewed and approved by all stakeholders.
]
),
  ..header1,
  [Development],
  list(
    [Development Setup (T10)],
    [Front-end Code (T11)],
    [Back-end Code (T12)],
    [Database Physical Design (T13)],
  ),

  list(
    [Configure Git repository and version control],
    [Set up web development environment],
    [Set up Flutter development environment with Android/iOS SDKs],
    [Initialize backend framework and dependencies],
    [Configure linters, formatters, and testing frameworks],
    [Implement web frontend components for maintenance request management],
    [Build Flutter screens for mobile app navigation],
    [Develop responsive UI for web and mobile platforms],
    [Create RESTful API endpoints for maintenance operations],
    [Implement authentication and authorization logic],
    [Build business logic for request processing and notifications],
    [Create database tables, indices, and relationships],
    [Implement data access layer with ORM],
    [Set up database migrations and seeders],
  ),
  [4 weeks],

  ..header2,

  []
,
list(
  [ N/A
]
),
list(
  [*Dependencies*
- Depends on approved design phase deliverables auch as architecture, and database schema
  ],
[*Constraints*
- Follow the coding standards, security rules, and framework versions that were set in the earlier phases
- Internet or cloud service interruptions may slow down integration and testing activities
]
),
list(
  [*Deliverables*
- Git repository 
- Working web and mobile front-end modules (React and Flutter)
- Implemented database schema 
- Unit testing and integration tests
  ],[
* Milestones*
- M4.1: Development environment configured and repository initialized.
- M4.2: Initial Functional prototype completed.
- M4.3: Unit and integration testing completed with 80% code coverage.
- M4.4: Quality assurance (QA) verification passed and build approved for testing.
- M4.5: Production environment prepared and ready for deployment.
]
),

  ..header1,
  [Testing],
  list(
    [Test Planning (T14)],
    [Integration Testing (T15)],
    [System & Acceptance Testing (T16)],
    [Regression & Release Testing (T17)],
  ),

  list(
    [Develop comprehensive test plan for web and mobile platforms],
    [Define test environments (development, staging, production)],
    [Prepare test data sets for maintenance request scenarios],
    [Test integration between web frontend and backend API],
    [Test integration between Flutter mobile app and backend API],
    [Verify database operations and data integrity],
    [Conduct end-to-end system testing across all platforms],
    [Perform user acceptance testing with stakeholders],
    [Test cross-platform compatibility (iOS, Android, Web browsers)],
    [Execute regression tests after bug fixes],
    [Perform security and performance testing],
    [Conduct final release testing and quality checks],
  ),
  [2 weeks],

  ..header2,
  
  [],
list(
  [
    External QA engineers
]
),
list(
  [*Dependencies*
- Test data and environment setup depends on finalized database
- Test plan and test cases finalized
  ],
  [*Constraints*
  - Availability of performance-test and security-test tools
- Limited time for testing may constrain full regression coverage
- Must follow project’s quality assurance and version control procedures

]
),
list(
  [*Deliverables*
- Completed integration and system test reports
- Signed-off User Acceptance Test report from stakeholders to be ready for deployment 
  ],[*Milestones*
- M5.1: Test plan and test cases developed and approved.
- M5.2: System and integration tests executed successfully.
- M5.3: User Acceptance Testing (UAT) completed and approved.
- M5.4: Exit criteria met and testing phase formally closed.

]
),

  ..header1,
  [Deployment],
  list(
    [Release Planning (T18)],
    [Environment Provisioning (T19)],
    [Go-Live Execution (T20)],
    [Transition & Support (T21)],
    [Post-Deployment Review (T22)],
  ),

  list(
    [Create release plan with rollback strategy],
    [Prepare deployment documentation and checklists],
    [Schedule go-live date with stakeholders],
    [Provision cloud servers and configure network],
    [Set up production database with security settings],
    [Configure CI/CD pipelines for automated deployment],
    [Deploy web application to hosting platform],
    [Publish Flutter mobile app to App Store and Google Play],
    [Configure production environment variables and API keys],
    [Conduct user training sessions for web and mobile platforms],
    [Provide technical documentation and user guides],
    [Establish helpdesk and support channels],
    [Monitor system performance and user feedback],
    [Review deployment metrics and KPIs],
    [Document lessons learned and improvement areas],
  ),
  [1 weeks],

  ..header2,
  []
  ,
  list(
  [ N/A
]
  ),
  list(
  [*Dependencies*
- Dependent on successful completion of testing 
  ],[
*Constraints*
- It must be scheduled 
- Risk of configuration errors 
- Security and data compliance must be checked and confirmed before the system goes live
]
  ),
  list(
  [*Deliverables*
- Successfully deployed web and mobile applications
- User training and support materials completed
- Documented post-deployment review and lessons learned
],[
*Milestones*
- M6.1: Final stakeholder approval for production release obtained.
- M6.2: Web and mobile applications deployed to production environment.
- M6.3: User training sessions completed.
- M6.4: Post-deployment review completed.
- M6.5: Project officially closed.
]
  ),
))
#pagebreak()
