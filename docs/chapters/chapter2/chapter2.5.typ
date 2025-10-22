#show figure: set columns(7)
#show figure: set block(breakable: true)

//headers
#let header1 = ([*Phase*], [*Task*], [*Detailed task*], [*EstimatedTime*])
#let header2 = ([], [*Resources Needed*], [*Dependencies and Constraints*], [*Deliverables & Milestones*])
\
#figure(
table(columns: 4,
  ..header1,


  fill: (_, y) =>
    if calc.even(y) {rgb(126, 166, 224) }
    else { rgb(189,193,201) },
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
  [],[],[],[],
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
  [],[],[],[],

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
  [],[],[],[],

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
  [],[],[],[],

  ..header1,
  [Testing],
  list(
    [Test Planning (T16)],
    [Integration Testing (T17)],
    [System & Acceptance Testing (T18)],
    [Regression & Release Testing (T19)],
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
  [],[],[],[],

  ..header1,
  [Deployment],
  list(
    [Release Planning (T20)],
    [Environment Provisioning (T21)],
    [Go-Live Execution (T22)],
    [Transition & Support (T23)],
    [Post-Deployment Review (T24)],
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
  [],[],[],[],

))