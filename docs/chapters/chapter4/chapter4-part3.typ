
// mousa
== System Architecture Design

=== Architectural Style

==== Primary Architecture Pattern: Three-Tier Client-Server Architecture

The SALLEHA system follows a *three-tier client-server architecture* with clear separation of concerns:

- *Presentation Tier*: Web (React) and Mobile (Flutter) applications
- *Application Tier*: RESTful API backend services (Node.js + Java)
- *Data Tier*: MySQL relational database with ORM layer

==== Architectural Characteristics

*Layered Architecture*: Each tier operates independently with well-defined interfaces:
- Enhances maintainability (NFR-6)
- Supports scalability for 24/7 operation (NFR-2)
- Enables parallel development across teams

*Service-Oriented Design*: Backend exposes RESTful APIs consumed by multiple clients (web + mobile), promoting reusability and platform independence.

*Event-Driven Components*: Real-time notification system using push notifications and email alerts for status changes.

=== Technology Stack

==== Frontend Technologies

===== Web Application
- *Framework*: React 18.x
- *UI Library*: Bootstrap 5.x + Tailwind CSS (for responsive design)
- *State Management*: React Context API / Redux (for complex state)
- *HTTP Client*: Axios
- *Form Validation*: Formik + Yup
- *Routing*: React Router v6
- *Real-time Updates*: WebSocket (Socket.io-client)
- *Charts/Analytics*: Recharts or Chart.js

===== Mobile Application
- *Framework*: Flutter 3.x
- *Language*: Dart
- *State Management*: Provider / Riverpod
- *HTTP Client*: Dio
- *Local Storage*: Shared Preferences
- *Push Notifications*: Firebase Cloud Messaging (FCM)
- *Image Handling*: image_picker, cached_network_image

==== Backend Technologies

===== API Server
- *Primary Runtime*: Node.js (v18 LTS) with Express.js framework
- *Secondary Services*: Java (Spring Boot) for computationally intensive analytics
- *API Architecture*: RESTful services with JSON data exchange
- *Authentication*: JWT (JSON Web Tokens) + bcrypt for password hashing
- *Session Management*: Redis (for session storage and caching)
- *File Upload*: Multer middleware (max 5MB per image)
- *Email Service*: Nodemailer with SMTP
- *SMS Service*: Twilio API (optional notifications)
- *Real-time Communication*: Socket.io for WebSocket connections

===== Database Layer
- *RDBMS*: MySQL 8.x
- *ORM*: Sequelize (Node.js) / Hibernate (Java)
- *Migration Management*: Sequelize CLI
- *Connection Pooling*: Built-in Sequelize pooling
- *Backup Strategy*: Automated daily backups with 90-day retention

==== Infrastructure & DevOps

- *Version Control*: GitHub (with Git Flow branching strategy)
- *CI/CD Pipeline*: GitHub Actions (automated testing + deployment)
- *Hosting*: 
  - *Web*: Vercel or Netlify (static frontend hosting)
  - *API*: AWS EC2 or DigitalOcean Droplets
  - *Database*: AWS RDS MySQL or managed MySQL hosting
- *Cloud Storage*: AWS S3 (for ticket images and documents)
- *Monitoring*: PM2 (process management), CloudWatch (AWS monitoring)
- *Load Balancing*: Nginx (reverse proxy + load balancer)
- *SSL/TLS*: Let's Encrypt certificates

==== Development & Testing Tools

- *Code Editor*: Visual Studio Code
- *API Testing*: Postman, Thunder Client
- *Unit Testing*: Jest (Node.js), JUnit (Java), Flutter Test
- *Code Quality*: ESLint, Prettier, SonarQube
- *Documentation*: Typst (project docs), Swagger/OpenAPI (API docs)
- *Design & Prototyping*: Figma (UI/UX), Draw.io (diagrams)

=== Component/Module-Level View

==== System Components Diagram

#figure(
  image(
"../../assets/chapter4/salleha_arch_diagram.svg"
),
  caption: [System Components Diagram]
)<systemcomponentsdiagram>
==== Core Modules and Components

===== MODULE 1: Authentication & Authorization Module
*Responsibilities:*
- User registration with email verification (FR-1)
- Login authentication with JWT token generation (FR-2)
- Password recovery with one-time verification codes (FR-4)
- Session management with role-based access control (RBAC)
- Account lockout after failed login attempts (FR-2.6)
- CAPTCHA integration for security (FR-2.5)

*Components:*
- `AuthController`: Handles authentication endpoints
- `TokenService`: JWT token generation and validation
- `PasswordHashService`: bcrypt password hashing
- `EmailVerificationService`: Sends and validates verification codes
- `SessionManager`: Redis-based session storage

*Technologies:* Node.js, JWT, bcrypt, Redis

===== MODULE 2: User Management Module
*Responsibilities:*
- User profile management (FR-12, FR-28)
- Role assignment and permissions management
- User account activation/deactivation (FR-28.2)
- Profile picture upload and storage
- Audit logging of user activities
- Bulk user operations (FR-28.5)

*Components:*
- `UserController`: User CRUD operations
- `ProfileService`: Profile update logic
- `RoleManager`: Role-based permission validation
- `AuditLogger`: Tracks all user management activities
- `FileUploadHandler`: Manages profile picture uploads

*Technologies:* Node.js, Multer, AWS S3

===== MODULE 3: Maintenance Request Management Module
*Responsibilities:*
- Ticket submission with validation (FR-8)
- Duplicate detection algorithm (FR-11)
- Ticket status lifecycle management (FR-9)
- Image upload handling (max 5 images, 5MB each)
- Real-time status tracking (FR-9)
- Maintenance request feed (FR-7)

*Components:*
- `TicketController`: Ticket CRUD operations
- `DuplicateDetectionService`: Similarity algorithm (category, location, keywords)
- `StatusManager`: Status transition workflow (Submitted → Assigned → In Progress → Fixed → Closed)
- `ImageUploadService`: Image validation, compression, S3 storage
- `TicketValidationService`: 20-character minimum description validation

*Technologies:* Node.js, Multer, AWS S3, Text similarity algorithms

===== MODULE 4: Task Assignment & Scheduling Module
*Responsibilities:*
- Automatic ticket assignment to technicians (FR-23)
- Manual assignment override by admins
- Priority-based task distribution (FR-24)
- Workload balancing across technicians
- Maintenance scheduling (FR for Maintenance Schedule entity)
- Escalation for overdue tasks

*Components:*
- `AssignmentEngine`: Auto-assignment algorithm (expertise, workload, location)
- `PriorityManager`: Priority level management (Low/Medium/High/Urgent/Emergency)
- `ScheduleService`: Technician schedule management
- `EscalationService`: Monitors and escalates overdue tasks
- `WorkloadBalancer`: Distributes tasks evenly

*Technologies:* Node.js, Scheduling algorithms

===== MODULE 5: Technician Workflow Module
*Responsibilities:*
- Task acceptance/decline by technicians (FR-15)
- Task status updates with timestamps (FR-16)
- Maintenance evidence submission (FR-17)
- Access to maintenance history (FR-19)
- Technician performance tracking (FR-20)

*Components:*
- `TechnicianTaskController`: Task management endpoints
- `EvidenceService`: Image/note uploads as completion proof
- `MaintenanceHistoryService`: Historical data retrieval
- `PerformanceTracker`: Completion rates, resolution time analytics
- `StatusUpdateService`: Handles status transitions with notifications

*Technologies:* Node.js, AWS S3

===== MODULE 6: Notification & Communication Module
*Responsibilities:*
- Real-time push notifications (FR-10, FR-18, FR-25)
- Email notifications for status changes
- SMS alerts for urgent tickets (optional)
- Notification preference management
- Notification history (90-day retention)

*Components:*
- `NotificationController`: Notification CRUD operations
- `PushNotificationService`: WebSocket (Socket.io) + FCM integration
- `EmailService`: Nodemailer SMTP integration
- `SMSService`: Twilio API integration
- `NotificationScheduler`: Batches and schedules notifications

*Technologies:* Node.js, Socket.io, Firebase Cloud Messaging, Nodemailer, Twilio

===== MODULE 7: Analytics & Reporting Module
*Responsibilities:*
- Admin analytics dashboard (FR-26)
- Maintenance trend analysis
- Equipment performance metrics (MTBF)
- Cost analysis (labor, parts, total expenditure)
- Predictive analytics for preventive maintenance
- Custom report generation (FR-27)

*Components:*
- `AnalyticsEngine`: Data aggregation and statistical analysis (Java/Spring Boot)
- `ReportGenerator`: PDF/Excel export functionality
- `TrendAnalyzer`: Pattern recognition for recurring issues
- `DashboardService`: KPI calculation (total tickets, resolution time, completion rates)
- `PredictiveModel`: ML-based preventive maintenance suggestions

*Technologies:* Java (Spring Boot), Apache POI (Excel), iText (PDF), Chart.js/Recharts

===== MODULE 8: Location & Equipment Management Module
*Responsibilities:*
- Location data management
- Geographic heat map generation (FR-21.5)
- Equipment tracking and history
- Zone-based assignment

*Components:*
- `LocationController`: Location CRUD operations
- `HeatMapService`: Generates issue density visualizations
- `EquipmentService`: Equipment history and warranty tracking
- `ZoneManager`: Manages work zones for technician assignment

*Technologies:* Node.js, Geolocation APIs

===== MODULE 9: Data Access Layer (DAL)
*Responsibilities:*
- Database connection management
- ORM-based CRUD operations
- Query optimization
- Data migration and seeding
- Connection pooling

*Components:*
- `UserRepository`: User entity operations
- `TicketRepository`: Maintenance request operations
- `TechnicianRepository`: Technician entity operations
- `LocationRepository`: Location entity operations
- `NotificationRepository`: Notification entity operations
- `DatabaseMigrator`: Schema migrations

*Technologies:* Sequelize ORM (Node.js), MySQL

=== Module Responsibilities Summary Table

#figure(
  table(
    columns: 4,
    align: left,
    [*Module*], [*Primary Responsibility*], [*Key Technologies*], [*User Roles Affected*],
    [Authentication & Authorization], [User login, registration, password recovery, session management], [Node.js, JWT, bcrypt, Redis], [All Users],
    [User Management], [Profile management, role assignment, account lifecycle], [Node.js, AWS S3], [All Users, Admin],
    [Maintenance Request Management], [Ticket submission, duplicate detection, status tracking], [Node.js, AWS S3, Similarity algorithms], [Resident, Admin],
    [Task Assignment & Scheduling], [Automatic/manual assignment, priority management, escalation], [Node.js, Scheduling algorithms], [Admin, Technician],
    [Technician Workflow], [Task acceptance, status updates, evidence upload, history], [Node.js, AWS S3], [Technician],
    [Notification & Communication], [Push notifications, email/SMS alerts, notification history], [Socket.io, FCM, Nodemailer, Twilio], [All Users],
    [Analytics & Reporting], [Dashboard analytics, trend analysis, report export], [Java (Spring Boot), Apache POI, iText], [Admin, Technician],
    [Location & Equipment Management], [Location tracking, heat maps, equipment history], [Node.js, Geolocation APIs], [Admin, Technician],
    [Data Access Layer], [Database operations, ORM, migrations], [Sequelize, MySQL], [Backend Services],
  )
)

=== Architectural Design Decisions

==== Why Three-Tier Architecture?

1. *Separation of Concerns*: Presentation, business logic, and data layers are independent
2. *Scalability*: Each tier can be scaled independently (e.g., add more API servers)
3. *Maintainability*: Easier to update one layer without affecting others (NFR-6)
4. *Security*: Database is isolated from direct client access (NFR-3)
5. *Multi-Platform Support*: Same API serves both web (React) and mobile (Flutter)

==== Why RESTful API?

1. *Platform Independence*: Web and mobile apps consume the same endpoints
2. *Statelessness*: Each request contains all necessary information (JWT tokens)
3. *Caching*: HTTP caching mechanisms improve performance (NFR-1)
4. *Industry Standard*: Well-documented and widely supported

==== Why Node.js + Java Hybrid Backend?

1. *Node.js*: Excellent for I/O-bound operations (ticket management, notifications)
2. *Java (Spring Boot)*: Better for CPU-intensive analytics and complex computations (FR-26)
3. *Team Expertise*: Leverages team skills (Table 6, 7)

==== Why MySQL?

1. *Relational Data*: Strong relationships between entities (Users, Tickets, Technicians)
2. *ACID Compliance*: Ensures data integrity for critical operations (NFR-2)
3. *Mature Ecosystem*: Excellent tooling, backup, and recovery options
4. *Cost-Effective*: Open-source with strong community support

==== Why Redis for Sessions?

1. *Performance*: In-memory storage for fast session retrieval (NFR-1)
2. *Expiration*: Built-in TTL for session timeout (FR-2.7)
3. *Scalability*: Supports distributed caching for multiple API servers

=== Security Architecture

==== Security Measures

1. *Authentication*: JWT tokens with 15-60 minute expiration
2. *Authorization*: Role-based access control (RBAC) middleware
3. *Data Encryption*: 
   - Passwords: bcrypt hashing (cost factor 12)
   - Data in transit: HTTPS/TLS 1.3
   - Sensitive data at rest: AES-256 encryption
4. *Input Validation*: Server-side validation for all inputs (SQL injection prevention)
5. *File Upload Security*: 
   - MIME type validation
   - File size limits (5MB for images)
   - Malware scanning (ClamAV integration)
6. *Rate Limiting*: API rate limiting to prevent DDoS attacks
7. *CAPTCHA*: After 3 failed login attempts (FR-2.5)
8. *Account Lockout*: After 5 failed attempts (FR-2.6)
9. *Audit Logging*: All sensitive operations logged with timestamps and IP addresses

==== Data Privacy

1. *Email Verification*: Required before account activation (FR-1.7)
2. *Anonymous Reporting*: Residents can submit tickets anonymously (Constraint 1.2.3.4)
3. *90-Day Notification History*: Automatic deletion after retention period
4. *Data Export*: Users can export their profile data (FR-12.7)

=== Performance Optimization Strategies

1. *Database Indexing*: Indexes on TicketID, UserID, LocationID, Status
2. *Query Optimization*: ORM query optimization, eager loading
3. *Caching*: Redis caching for frequently accessed data (user sessions, notifications)
4. *Image Compression*: Automatic compression before S3 upload
5. *Pagination*: Results limited to 20 items per page (FR-7.8)
6. *Lazy Loading*: Frontend lazy loading of images and components
7. *Connection Pooling*: Database connection pooling (Sequelize built-in)
8. *CDN*: Static assets (CSS, JS) served via CDN
9. *Load Balancing*: Nginx distributes traffic across multiple API servers
10. *Asynchronous Processing*: Background jobs for email/SMS notifications

=== Deployment Architecture

==== Production Environment

#figure(
  image(
"../../assets/chapter4/salleha_deployment_diagram.svg"
),
  caption: [Deployment Diagram]
)<deploymentdiagram>

==== Continuous Integration/Deployment

1. *Development*: Feature branches → Pull Request → Code Review
2. *Testing*: Automated tests via GitHub Actions (Jest, JUnit)
3. *Staging*: Deploy to staging environment for QA testing
4. *Production*: Blue-green deployment to minimize downtime

=== Monitoring & Observability

1. *Application Monitoring*: PM2 for Node.js process management
2. *Performance Monitoring*: AWS CloudWatch metrics (CPU, memory, response time)
3. *Error Tracking*: Sentry for error logging and alerting
4. *Log Aggregation*: ELK Stack (Elasticsearch, Logstash, Kibana)
5. *Uptime Monitoring*: Pingdom or UptimeRobot (24/7 availability check)
6. *Database Monitoring*: Query performance, slow query logs

=== Scalability Considerations

1. *Horizontal Scaling*: Add more API servers behind load balancer
2. *Database Read Replicas*: MySQL read replicas for analytics queries
3. *Microservices Migration*: Future migration to microservices if needed
4. *Message Queue*: RabbitMQ/Redis for asynchronous task processing
5. *Auto-Scaling*: AWS Auto Scaling Groups based on traffic patterns

=== Alignment with Non-Functional Requirements

#figure(
  table(
    columns: 2,
    align: left,
    [*NFR*], [*Architectural Support*],
    [*Performance (NFR-1)*], [Redis caching, database indexing, pagination, CDN, load balancing],
    [*Dependability (NFR-2)*], [24/7 hosting, automated backups, health monitoring, redundant servers],
    [*Security (NFR-3)*], [JWT auth, bcrypt, HTTPS, input validation, rate limiting, RBAC],
    [*Usability (NFR-4)*], [React/Flutter for intuitive UIs, responsive design, error messages],
    [*Operational Constraints (NFR-5)*], [Web browsers (React), mobile devices (Flutter), stable internet],
    [*Maintainability (NFR-6)*], [Modular architecture, ORM, comprehensive logging, CI/CD pipeline],
  )
)

=== Future Enhancements

1. *GraphQL API*: For more flexible data querying
2. *Microservices*: Split monolithic API into independent services
3. *Machine Learning*: Predictive maintenance models
4. *Offline Mode*: Mobile app offline functionality with sync
5. *WebAssembly*: Performance-critical frontend components
6. *Kubernetes*: Container orchestration for better scalability
