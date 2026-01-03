== Process Specifications

=== Fragment 1: User Management Processes

*Number:* 1.1  
*Name:* User Registration  
*Description:* Creates a new user account by validating input data, hashing password, storing user information, and sending email verification.

*Input Data Flow:*
- Registration Details (from Resident/Admin/Technician)
  - Full Name
  - Email
  - National ID
  - Username
  - Password
  - Role

*Output Data Flow:*
- User Profile Data (to User Database D1)
- Email Verification Request (to Email Service)
- Registration Confirmation (to User)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `registerUser()`

*Process Logic (Structured English):*

```
BEGIN Process 1.1: User Registration

READ Registration Details from User

VALIDATE Email Format
IF Email Format Invalid THEN
    DISPLAY "Invalid email format"
    EXIT Process
ENDIF

VALIDATE Password Strength
IF Password Length < 8 OR 
   Missing Uppercase OR 
   Missing Lowercase OR 
   Missing Number OR 
   Missing Special Character THEN
    DISPLAY "Password does not meet strength requirements"
    EXIT Process
ENDIF

CHECK Email Uniqueness in User Database
IF Email Already Exists THEN
    DISPLAY "Email already registered"
    EXIT Process
ENDIF

CHECK National ID Uniqueness in User Database
IF National ID Already Exists THEN
    DISPLAY "National ID already registered"
    EXIT Process
ENDIF

HASH Password using bcrypt
GENERATE UserID
SET IsEmailVerified = FALSE
SET AccountStatus = "Pending Verification"
SET RegistrationDate = CURRENT_DATETIME
SET FailedLoginAttempts = 0

WRITE User Record to User Database (D1)

GENERATE Email Verification Token
SEND Verification Email with Activation Link

DISPLAY "Registration successful. Please check your email to verify your account."

END Process
```

*Refer to:*
- FR-1.1 through FR-1.8
- Table 52: Data Flow 1 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Email Format Valid], [Y], [Y], [Y], [Y], [N],
    [Password Strength Valid], [Y], [Y], [Y], [N], [-],
    [Email Unique], [Y], [Y], [N], [-], [-],
    [National ID Unique], [Y], [N], [-], [-], [-],
    [Create User Account], [X], [-], [-], [-], [-],
    [Send Verification Email], [X], [-], [-], [-], [-],
    [Display "National ID exists"], [-], [X], [-], [-], [-],
    [Display "Email exists"], [-], [-], [X], [-], [-],
    [Display "Weak password"], [-], [-], [-], [X], [-],
    [Display "Invalid email"], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None



*Number:* 1.2  
*Name:* User Authentication  
*Description:* Authenticates user credentials, manages failed login attempts, enforces CAPTCHA and account locking, creates session tokens, and redirects to role-specific dashboards.

*Input Data Flow:*
- Login Credentials (from Resident/Technician/Admin)
  - Username
  - Password
  - CAPTCHA (if required)

*Output Data Flow:*
- Session Token & Dashboard Redirect (to User)
- Updated Failed Login Attempts (to User Database D1)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `authenticateUser()`

*Process Logic (Structured English):*

```
BEGIN Process 1.2: User Authentication

READ Username and Password from User

RETRIEVE User Record from User Database (D1) by Username
IF User Record Not Found THEN
    DISPLAY "Invalid credentials"
    EXIT Process
ENDIF

CHECK AccountStatus
IF AccountStatus = "Locked" THEN
    DISPLAY "Account is locked. Contact administrator or verify email to unlock."
    EXIT Process
ENDIF

CHECK FailedLoginAttempts
IF FailedLoginAttempts >= 3 AND FailedLoginAttempts < 5 THEN
    REQUIRE CAPTCHA Validation
    IF CAPTCHA Invalid THEN
        DISPLAY "Invalid CAPTCHA"
        EXIT Process
    ENDIF
ENDIF

VERIFY Password against PasswordHash using bcrypt
IF Password Incorrect THEN
    INCREMENT FailedLoginAttempts
    
    IF FailedLoginAttempts >= 5 THEN
        SET AccountStatus = "Locked"
        SEND Notification "Account Locked" to User Email
        DISPLAY "Account locked due to multiple failed attempts"
    ELSE
        DISPLAY "Invalid credentials"
    ENDIF
    
    UPDATE User Record in User Database (D1)
    EXIT Process
ENDIF

CHECK IsEmailVerified
IF IsEmailVerified = FALSE THEN
    DISPLAY "Please verify your email before logging in"
    EXIT Process
ENDIF

// Successful Authentication
SET FailedLoginAttempts = 0
SET LastLoginAt = CURRENT_DATETIME
GENERATE Session Token (JWT)

DETERMINE Session Timeout based on Role
IF Role = "Resident" THEN
    SET SessionTimeout = 30 minutes
ELSIF Role = "Technician" THEN
    SET SessionTimeout = 15 minutes
ELSIF Role = "Administrator" THEN
    SET SessionTimeout = 60 minutes
ENDIF

STORE Session in Redis Cache
UPDATE User Record in User Database (D1)

REDIRECT to Role-Specific Dashboard
    IF Role = "Resident" THEN REDIRECT to Resident Dashboard
    ELSIF Role = "Technician" THEN REDIRECT to Technician Dashboard
    ELSIF Role = "Administrator" THEN REDIRECT to Administrator Dashboard
    ENDIF

END Process
```

*Refer to:*
- FR-2.1 through FR-2.8
- Table 55: Data Flow 4 Details
- Table 56: Data Flow 5 Details

#pagebreak()

*Decision Tree:*

#figure(
  image(
    "../../assets/chapter4/dt1.1.png",
    height:90%
  ),
)

#figure(
  image(
    "../../assets/chapter4/dt1.2.png",
    height:70%
  ),
  caption: [Decision Tree 1.2]
)

*Number:* 1.3  
*Name:* Password Recovery  
*Description:* Allows users to reset forgotten passwords by verifying email and national ID, sending one-time verification code, and updating password after validation.

*Input Data Flow:*
- Recovery Request (from Resident/Technician/Admin)
  - Email OR National ID
  - Verification Code (after email sent)
  - New Password
  - Password Confirmation

*Output Data Flow:*
- Account Verification Data (from User Database D1)
- Updated Password (to User Database D1)
- Verification Email (to Email Service)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `recoverPassword()`

*Process Logic (Structured English):*

```
BEGIN Process 1.3: Password Recovery

// Step 1: Initiate Recovery
READ Email and National ID from User

RETRIEVE User Record from User Database (D1)
IF User Record Not Found OR 
   Email Not Matching OR 
   National ID Not Matching THEN
    DISPLAY "Invalid information provided"
    EXIT Process
ENDIF

GENERATE One-Time Verification Code (6-digit random number)
SET Code Expiration = CURRENT_DATETIME + 15 minutes
STORE Verification Code with UserID and Expiration in Redis Cache

SEND Verification Code to User Email
DISPLAY "Verification code sent to your email"

// Step 2: Verify Code
READ Verification Code from User

RETRIEVE Stored Code from Redis Cache by UserID
IF Code Not Found THEN
    DISPLAY "Verification code expired or invalid"
    EXIT Process
ENDIF

IF Current Time > Code Expiration THEN
    DELETE Code from Redis Cache
    DISPLAY "Verification code expired. Please request a new one."
    EXIT Process
ENDIF

IF Entered Code ≠ Stored Code THEN
    DISPLAY "Invalid verification code"
    EXIT Process
ENDIF

// Step 3: Reset Password
READ New Password and Password Confirmation from User

IF New Password ≠ Password Confirmation THEN
    DISPLAY "Passwords do not match"
    EXIT Process
ENDIF

VALIDATE Password Strength
IF Password Length < 8 OR 
   Missing Uppercase OR 
   Missing Lowercase OR 
   Missing Number OR 
   Missing Special Character THEN
    DISPLAY "Password does not meet strength requirements"
    EXIT Process
ENDIF

RETRIEVE Last 3 Passwords from User Database (D1)
FOR EACH Previous Password DO
    IF bcrypt Compare(New Password, Previous Password Hash) = TRUE THEN
        DISPLAY "Cannot reuse recent passwords"
        EXIT Process
    ENDIF
ENDFOR

HASH New Password using bcrypt
UPDATE PasswordHash in User Database (D1)
ARCHIVE Old Password Hash to Password History
DELETE Verification Code from Redis Cache

SEND Confirmation Email "Password Changed Successfully"
DISPLAY "Password reset successful. Please login with your new password."

END Process
```

*Refer to:*
- FR-4.1 through FR-4.10
- Table 57: Data Flow 6 Details
- Table 58: Data Flow 7 Details

*Decision Table:*


#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [User Found with Email+ID], [Y], [Y], [Y], [Y], [Y], [N],
    [Code Valid & Not Expired], [Y], [Y], [Y], [Y], [N], [-],
    [Passwords Match], [Y], [Y], [Y], [N], [-], [-],
    [Password Strength Valid], [Y], [Y], [N], [-], [-], [-],
    [Not in Last 3 Passwords], [Y], [N], [-], [-], [-], [-],
    [Update Password], [X], [-], [-], [-], [-], [-],
    [Send Confirmation Email], [X], [-], [-], [-], [-], [-],
    [Display "Cannot reuse password"], [-], [X], [-], [-], [-], [-],
    [Display "Weak password"], [-], [-], [X], [-], [-], [-],
    [Display "Passwords don't match"], [-], [-], [-], [X], [-], [-],
    [Display "Code expired/invalid"], [-], [-], [-], [-], [X], [-],
    [Display "Invalid information"], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None




*Number:* 1.4  
*Name:* Account Management  
*Description:* Allows users to view and update profile information, and allows administrators to manage user accounts (activate, deactivate, update roles).

*Input Data Flow:*
- Profile Update Data (from Resident)
- User Management Commands (from Administrator)
- User Profile Data (from User Database D1)

*Output Data Flow:*
- Updated Profile/Account Status (to User Database D1)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `manageUserAccount()`

*Process Logic (Structured English):*

```
BEGIN Process 1.4: Account Management

READ Action Type (View, Update Profile, Admin Action)

// Resident Profile Update
IF Action = "Update Profile" THEN
    READ UserID and Updated Fields from Resident
    RETRIEVE Current Profile from User Database (D1)
    
    IF Updating Sensitive Field (Email, Password) THEN
        REQUIRE Password Verification
        IF Password Verification Fails THEN
            DISPLAY "Password verification required"
            EXIT Process
        ENDIF
    ENDIF
    
    IF Updating Email THEN
        CHECK Email Uniqueness
        IF Email Already Exists THEN
            DISPLAY "Email already in use"
            EXIT Process
        ENDIF
        
        GENERATE Email Verification Token
        SEND Verification Email to New Email Address
        SET PendingEmail = New Email
        DISPLAY "Verification email sent. Email will be updated after verification."
    ENDIF
    
    IF Updating Password THEN
        VALIDATE Password Strength
        IF Password Strength Invalid THEN
            DISPLAY "Password does not meet requirements"
            EXIT Process
        ENDIF
        
        CHECK Last 3 Passwords
        IF Password Used Recently THEN
            DISPLAY "Cannot reuse recent passwords"
            EXIT Process
        ENDIF
        
        HASH New Password
        UPDATE PasswordHash
    ENDIF
    
    IF Updating Profile Picture THEN
        VALIDATE File Type (JPEG, PNG)
        VALIDATE File Size (< 5MB)
        IF Validation Fails THEN
            DISPLAY "Invalid file format or size"
            EXIT Process
        ENDIF
        UPLOAD to AWS S3
        UPDATE ProfilePictureURL
    ENDIF
    
    IF Updating Full Name THEN
        UPDATE FullName
    ENDIF
    
    LOG Profile Change with Timestamp and IP Address
    UPDATE User Record in User Database (D1)
    DISPLAY "Profile updated successfully"
ENDIF

// Administrator User Management
IF Action = "Admin Manage User" THEN
    VERIFY Admin Privileges
    IF Not Administrator THEN
        DISPLAY "Unauthorized action"
        EXIT Process
    ENDIF
    
    READ TargetUserID and Admin Action
    
    IF Admin Action = "Activate Account" THEN
        SET AccountStatus = "Active"
        SET IsEmailVerified = TRUE
        SEND Notification to User
    ELSIF Admin Action = "Deactivate Account" THEN
        SET AccountStatus = "Suspended"
        INVALIDATE All Active Sessions
        SEND Notification to User
    ELSIF Admin Action = "Delete Account" THEN
        SOFT DELETE User Record (mark as deleted)
        INVALIDATE All Active Sessions
        ARCHIVE User Data
    ELSIF Admin Action = "Unlock Account" THEN
        SET AccountStatus = "Active"
        SET FailedLoginAttempts = 0
        SEND Notification to User
    ELSIF Admin Action = "Reset Password" THEN
        GENERATE Temporary Password
        HASH Temporary Password
        UPDATE PasswordHash
        SET ForcePasswordChange = TRUE
        SEND Temporary Password to User Email
    ELSIF Admin Action = "Update Role" THEN
        REQUIRE Approval Workflow
        IF Approval Granted THEN
            UPDATE Role
            UPDATE Permissions
            SEND Notification to User
        ENDIF
    ELSIF Admin Action = "Assign Technician Specialization" THEN
        IF User Role = "Technician" THEN
            UPDATE Specialization
            UPDATE SkillLevel
            UPDATE WorkZone
        ELSE
            DISPLAY "User is not a technician"
        ENDIF
    ENDIF
    
    LOG Admin Action with Timestamp and Admin ID
    UPDATE User Record in User Database (D1)
    DISPLAY "User account updated successfully"
ENDIF

END Process
```

*Refer to:*
- FR-12 (Resident Profile Management)
- FR-28 (User Account Management)
- Table 59: Data Flow 8 Details
- Table 60: Data Flow 9 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Actor = Resident], [Y], [Y], [Y], [N], [N],
    [Actor = Administrator], [N], [N], [N], [Y], [Y],
    [Updating Sensitive Field], [Y], [Y], [N], [-], [-],
    [Password Verified], [Y], [N], [-], [-], [-],
    [Admin Privileges Valid], [-], [-], [-], [Y], [N],
    [Allow Profile Update], [X], [-], [X], [-], [-],
    [Require Password Verification], [X], [X], [-], [-], [-],
    [Deny Update], [-], [X], [-], [-], [X],
    [Allow Admin Action], [-], [-], [-], [X], [-],
    [Log Change], [X], [-], [X], [X], [-],
  )
)

*Unresolved Issues:* None


=== Fragment 2: Maintenance Request Management Processes




*Number:* 2.1  
*Name:* Create Maintenance Ticket  
*Description:* Validates and creates a new maintenance ticket, checks for duplicates, uploads images, generates unique ticket ID, and stores ticket information.

*Input Data Flow:*
- New Ticket Submission Data (from Resident)
  - Category
  - Description
  - Location
  - Priority
- Ticket Attachments/Images (from Resident)

*Output Data Flow:*
- New Ticket Record (to Tickets Database D2)
- Ticket Confirmation (to Resident)
- Notification Trigger (to Process 2.5)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `createMaintenanceTicket()`

*Process Logic (Structured English):*

```
BEGIN Process 2.1: Create Maintenance Ticket

READ Ticket Details from Resident
    Category, Description, Location, Priority, Images

VALIDATE Mandatory Fields
IF Category = NULL OR 
   Description = NULL OR 
   Location = NULL OR 
   Priority = NULL THEN
    DISPLAY "All mandatory fields must be filled"
    EXIT Process
ENDIF

VALIDATE Description Length
IF Description Length < 20 characters THEN
    DISPLAY "Description must be at least 20 characters"
    EXIT Process
ENDIF

VALIDATE Images (if provided)
IF Images Attached THEN
    IF Number of Images > 5 THEN
        DISPLAY "Maximum 5 images allowed"
        EXIT Process
    ENDIF
    
    FOR EACH Image DO
        VALIDATE File Type (JPEG, PNG only)
        VALIDATE File Size (< 5MB per image)
        IF Validation Fails THEN
            DISPLAY "Invalid image format or size"
            EXIT Process
        ENDIF
    ENDFOR
ENDIF

// Duplicate Detection
CHECK for Similar Tickets in Last 7 Days
QUERY Tickets Database (D2) WHERE:
    Category = Input Category AND
    Location = Input Location AND
    ReportedAt >= (CURRENT_DATE - 7 days)

CALCULATE Similarity Score for Description
FOR EACH Retrieved Ticket DO
    COMPUTE Text Similarity (Cosine Similarity, Levenshtein Distance)
    IF Similarity Score > 80% THEN
        SET SimilarityFlag = TRUE
        ADD Ticket to Similar Tickets List
    ENDIF
ENDFOR

IF SimilarityFlag = TRUE THEN
    DISPLAY Warning "Similar tickets found:"
    DISPLAY Similar Tickets List with Links
    PROMPT User "Proceed with submission?" OR "Add comment to existing ticket" OR "Cancel"
    
    IF User Selects "Cancel" THEN
        EXIT Process
    ELSIF User Selects "Add comment to existing ticket" THEN
        REDIRECT to Process 2.4 (Add Comment)
        EXIT Process
    ENDIF
    // If Proceed, continue below
ENDIF

// Upload Images to AWS S3
IF Images Attached THEN
    FOR EACH Image DO
        COMPRESS Image (if size > 1MB)
        GENERATE Unique Image Name
        UPLOAD to AWS S3 Bucket
        STORE Image URL
    ENDFOR
ENDIF

// Create Ticket
GENERATE Unique TicketID (Format: TKT-YYYYMMDD-XXXXX)
SET Status = "Open"
SET ReportedAt = CURRENT_DATETIME
SET RequesterID = Current User ID
SET TechnicianID = NULL (not yet assigned)
SET AssignedAt = NULL
SET ResolvedAt = NULL
SET IsUrgentFlag = FALSE
SET EstimatedCompletionTime = CALCULATE based on Priority

WRITE Ticket Record to Tickets Database (D2)

// Calculate Estimated Response Time
IF Priority = "Emergency" THEN
    EstimatedResponse = "Within 1 hour"
ELSIF Priority = "Urgent" THEN
    EstimatedResponse = "Within 4 hours"
ELSIF Priority = "High" THEN
    EstimatedResponse = "Within 24 hours"
ELSIF Priority = "Medium" THEN
    EstimatedResponse = "Within 3 days"
ELSE // Low
    EstimatedResponse = "Within 7 days"
ENDIF

SEND Notification to Administrators (Process 2.5)
DISPLAY Confirmation Page
    "Ticket Created Successfully"
    "Ticket ID: " + TicketID
    "Estimated Response Time: " + EstimatedResponse

REDIRECT to Ticket Details View

END Process
```

*Refer to:*
- FR-8 (Open Maintenance Ticket)
- FR-11 (Duplicate Ticket Prevention)
- Table 61: Data Flow 10 Details
- Table 62: Data Flow 11 Details
- Table 63: Data Flow 12 Details
- Table 64: Data Flow 13 Details

*Decision Table:*


#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [All Mandatory Fields Filled], [Y], [Y], [Y], [Y], [Y], [N],
    [Description >= 20 chars], [Y], [Y], [Y], [Y], [N], [-],
    [Images Valid (if provided)], [Y], [Y], [Y], [N], [-], [-],
    [Duplicate Detected], [Y], [Y], [N], [-], [-], [-],
    [User Proceeds Anyway], [Y], [N], [-], [-], [-], [-],
    [Create Ticket], [X], [-], [X], [-], [-], [-],
    [Generate Ticket ID], [X], [-], [X], [-], [-], [-],
    [Send Admin Notification], [X], [-], [X], [-], [-], [-],
    [Show Confirmation], [X], [-], [X], [-], [-], [-],
    [Show Duplicates Warning], [X], [X], [-], [-], [-], [-],
    [User Chooses Action], [X], [X], [-], [-], [-], [-],
    [Display "Invalid images"], [-], [-], [-], [X], [-], [-],
    [Display "Description too short"], [-], [-], [-], [-], [X], [-],
    [Display "Missing fields"], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:*  
Should the expected arrival date of goods on order be considered when calculating estimated completion time for tickets requiring parts?



*Number:* 2.2  
*Name:* View/Search Tickets  
*Description:* Retrieves and displays tickets based on search criteria, applies filters, paginates results, and shows ticket details.

*Input Data Flow:*
- View/Search Criteria (from Resident/Technician/Admin)
  - Ticket ID (optional)
  - Status
  - Category
  - Date Range
  - Keyword

*Output Data Flow:*
- Ticket List/Ticket Details (from Tickets Database D2 to User)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `viewSearchTickets()`

*Process Logic (Structured English):*

```
BEGIN Process 2.2: View/Search Tickets

READ Search Criteria from User
    Optional: TicketID, Status, Category, DateRange, Keyword

GET Current User Role and UserID

// Build Query
INITIALIZE Query = "SELECT * FROM Tickets WHERE 1=1"

// Role-based filtering
IF User Role = "Resident" THEN
    ADD to Query "AND RequesterID = Current UserID"
ELSIF User Role = "Technician" THEN
    ADD to Query "AND (TechnicianID = Current UserID OR Status = 'Open')"
ELSIF User Role = "Administrator" THEN
    // No restriction - can view all tickets
ENDIF

// Apply Search Filters
IF TicketID Provided THEN
    ADD to Query "AND TicketID = Input TicketID"
ENDIF

IF Status Provided THEN
    IF Status is Multi-Select THEN
        ADD to Query "AND Status IN (Selected Statuses)"
    ELSE
        ADD to Query "AND Status = Input Status"
    ENDIF
ENDIF

IF Category Provided THEN
    ADD to Query "AND Category = Input Category"
ENDIF

IF Date Range Provided THEN
    ADD to Query "AND ReportedAt BETWEEN StartDate AND EndDate"
ENDIF

IF Keyword Provided THEN
    ADD to Query "AND (Title LIKE '%Keyword%' OR Description LIKE '%Keyword%')"
ENDIF

// Execute Query
EXECUTE Query against Tickets Database (D2)
SET Tickets = Query Results

// Check if results found
IF Tickets is Empty THEN
    DISPLAY "No tickets found matching your criteria"
    EXIT Process
ENDIF

// Sort Results
IF User Specifies Sort Order THEN
    SORT Tickets by Specified Field (Priority DESC, ReportedAt DESC, etc.)
ELSE
    // Default sorting
    IF User Role = "Administrator" THEN
        SORT by Priority DESC, then ReportedAt DESC
    ELSIF User Role = "Technician" THEN
        SORT by AssignedAt DESC, then Priority DESC
    ELSE // Resident
        SORT by ReportedAt DESC
    ENDIF
ENDIF

// Pagination
SET ItemsPerPage = 20
CALCULATE TotalPages = CEILING(Tickets Count / ItemsPerPage)
GET Current Page from User (default = 1)
SET StartIndex = (Current Page - 1) * ItemsPerPage
SET EndIndex = StartIndex + ItemsPerPage
EXTRACT Page Items = Tickets[StartIndex to EndIndex]

// Prepare Display Data
FOR EACH Ticket in Page Items DO
    // Mark user's own tickets for residents
    IF User Role = "Resident" AND Ticket.RequesterID = Current UserID THEN
        SET Ticket.IsOwned = TRUE
    ENDIF
    
    // Hide sensitive information
    IF User Role ≠ "Administrator" THEN
        REMOVE Ticket.RequesterPersonalInfo
        REMOVE Ticket.InternalNotes
    ENDIF
    
    // Format display fields
    FORMAT Ticket.ReportedAt as "MMM DD, YYYY HH:MM"
    FORMAT Ticket.Status with Status Badge/Color
    FORMAT Ticket.Priority with Priority Icon
ENDFOR

// Display Results
DISPLAY Ticket List with:
    - Ticket ID
    - Title
    - Category
    - Location
    - Status
    - Priority
    - Reported Date
    - Assigned Technician (if applicable)
    - "Your Ticket" badge (if applicable)

DISPLAY Pagination Controls
DISPLAY Search/Filter Panel
DISPLAY "Total Results: " + Tickets Count

// Real-time Updates
IF Real-time Mode Enabled THEN
    ESTABLISH WebSocket Connection
    LISTEN for Ticket Updates
    ON Ticket Update Received DO
        IF Updated Ticket matches Current Filters THEN
            UPDATE Ticket in Display List
            SHOW Notification "Ticket Updated"
        ENDIF
    ENDDO
ENDIF

END Process
```

*Refer to:*
- FR-7 (View Reports Feed)
- FR-9 (Track Ticket Status)
- Table 65: Data Flow 14 Details
- Table 66: Data Flow 15 Details

#pagebreak()

*Decision Tree:*

#figure(
  image(
    "../../assets/chapter4/dt2.1.png",
    height:90%
  ),
)
#figure(
  image(
    "../../assets/chapter4/dt2.2.png",
  height:90%
  ),
  caption: [Decision Tree 2.3]
)

*Unresolved Issues:* None




*Number:* 2.3  
*Name:* Update Ticket Status  
*Description:* Updates the status of maintenance tickets based on technician progress or administrator actions, validates status transitions, and triggers notifications.

*Input Data Flow:*
- Assignment/Priority Update (from Administrator)
- Status Update (from Technician)

*Output Data Flow:*
- Updated Ticket Status/Assignment/Priority (to Tickets Database D2)
- Status Change Notification (to Process 2.5)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `updateTicketStatus()`

*Process Logic (Structured English):*

```
BEGIN Process 2.3: Update Ticket Status

READ Update Request from User (Technician or Administrator)
    TicketID, New Status/Assignment/Priority, Optional Notes

RETRIEVE Current Ticket from Tickets Database (D2)
IF Ticket Not Found THEN
    DISPLAY "Ticket not found"
    EXIT Process
ENDIF

GET Current User Role and UserID
SET Current Status = Ticket.Status

// Authorization Check
IF User Role = "Technician" THEN
    IF Ticket.TechnicianID ≠ Current UserID THEN
        DISPLAY "You are not authorized to update this ticket"
        EXIT Process
    ENDIF
ELSIF User Role = "Administrator" THEN
    // Administrators can update any ticket
ELSE
    DISPLAY "Unauthorized action"
    EXIT Process
ENDIF

// Process Administrator Updates
IF User Role = "Administrator" THEN
    IF Updating Assignment THEN
        READ New TechnicianID
        
        VALIDATE Technician Exists and Is Active
        IF Technician Invalid THEN
            DISPLAY "Invalid technician selected"
            EXIT Process
        ENDIF
        
        // Check technician availability and workload
        GET Technician Current Workload
        GET Technician Availability Status
        GET Technician Specialization
        
        IF Availability Status = "On Break" OR Availability Status = "Busy" THEN
            WARN "Technician is currently " + Availability Status
            PROMPT "Proceed anyway?"
            IF User Declines THEN
                EXIT Process
            ENDIF
        ENDIF
        
        // Check expertise match
        IF Ticket.Category NOT IN Technician.Specialization THEN
            WARN "Technician specialization doesn't match ticket category"
            PROMPT "Proceed anyway?"
            IF User Declines THEN
                EXIT Process
            ENDIF
        ENDIF
        
        SET Ticket.TechnicianID = New TechnicianID
        SET Ticket.AssignedAt = CURRENT_DATETIME
        SET Ticket.Status = "Assigned"
        
        SEND Notification to New Technician (Process 2.5)
        LOG "Ticket assigned to " + Technician.Name + " by " + Admin.Name
    ENDIF
    
    IF Updating Priority THEN
        READ New Priority Level
        
        VALIDATE Priority Level IN (Low, Medium, High, Urgent, Emergency)
        IF Priority Invalid THEN
            DISPLAY "Invalid priority level"
            EXIT Process
        ENDIF
        
        SET Old Priority = Ticket.Priority
        SET Ticket.Priority = New Priority
        
        // Recalculate estimated completion time
        CALCULATE Estimated Completion Time based on New Priority
        SET Ticket.EstimatedCompletionTime = Calculated Time
        
        IF New Priority > Old Priority THEN
            SET Ticket.IsUrgentFlag = TRUE
            SEND Notification to Assigned Technician (Process 2.5)
        ENDIF
        
        LOG "Priority changed from " + Old Priority + " to " + New Priority
    ENDIF
    
    IF Manually Closing Ticket THEN
        SET Ticket.Status = "Closed"
        SET Ticket.ResolvedAt = CURRENT_DATETIME
        LOG "Ticket manually closed by administrator"
        SEND Notification to Requester (Process 2.5)
    ENDIF
ENDIF

// Process Technician Status Updates
IF User Role = "Technician" THEN
    READ New Status, Optional Notes
    
    // Validate Status Transition
    CALL ValidateStatusTransition(Current Status, New Status)
    IF Transition Invalid THEN
        DISPLAY "Invalid status transition from " + Current Status + " to " + New Status
        EXIT Process
    ENDIF
    
    IF New Status = "In Progress" THEN
        IF Current Status ≠ "Assigned" AND Current Status ≠ "On Hold" THEN
            DISPLAY "Cannot set to In Progress from current status"
            EXIT Process
        ENDIF
        
        SET Ticket.Status = "In Progress"
        SET Ticket.ActualStartTime = CURRENT_DATETIME
        
        CALCULATE Expected Completion = ActualStartTime + EstimatedDuration
        SET Ticket.ExpectedCompletionTime = Expected Completion
        
        LOG "Work started by " + Technician.Name
        SEND Notification to Requester (Process 2.5)
    ENDIF
    
    IF New Status = "On Hold" THEN
        IF Current Status ≠ "In Progress" THEN
            DISPLAY "Can only put In Progress tickets on hold"
            EXIT Process
        ENDIF
        
        REQUIRE On Hold Reason
        READ Hold Reason (Waiting for Parts, Requires Specialist, Resident Not Available)
        IF Hold Reason Not Provided THEN
            DISPLAY "Please provide a reason for putting ticket on hold"
            EXIT Process
        ENDIF
        
        SET Ticket.Status = "On Hold"
        SET Ticket.OnHoldReason = Hold Reason
        SET Ticket.OnHoldDate = CURRENT_DATETIME
        
        LOG "Ticket placed on hold: " + Hold Reason
        SEND Notification to Administrator and Requester (Process 2.5)
    ENDIF
    
    IF New Status = "Fixed" THEN
        IF Current Status ≠ "In Progress" THEN
            DISPLAY "Ticket must be In Progress before marking as Fixed"
            EXIT Process
        ENDIF
        
        REQUIRE Completion Evidence (handled by Process 2.4)
        // Technician must submit evidence before fixing
        CHECK if Evidence Submitted for This Ticket
        IF No Evidence THEN
            DISPLAY "Please upload completion evidence before marking as Fixed"
            REDIRECT to Evidence Upload (Process 2.4)
            EXIT Process
        ENDIF
        
        SET Ticket.Status = "Fixed"
        SET Ticket.ResolvedAt = CURRENT_DATETIME
        
        CALCULATE Actual Resolution Time = ResolvedAt - ActualStartTime
        SET Ticket.ActualResolutionTime = Actual Resolution Time
        
        // Update technician performance metrics
        UPDATE Technician.AverageResolutionTime
        UPDATE Technician.CompletionRate
        
        LOG "Ticket marked as Fixed by " + Technician.Name
        SEND Notification to Administrator and Requester for Review (Process 2.5)
    ENDIF
    
    IF New Status = "Closed" THEN
        IF Current Status ≠ "Fixed" THEN
            DISPLAY "Only Fixed tickets can be closed"
            EXIT Process
        ENDIF
        
        // Usually closed by Administrator after review
        DISPLAY "Ticket will be closed after administrator review"
        EXIT Process
    ENDIF
    
    IF Notes Provided THEN
        SET Ticket.UpdateNotes = Notes
    ENDIF
ENDIF

// Check for Overdue Escalation
IF Current Status = "In Progress" THEN
    IF CURRENT_DATETIME > Ticket.EstimatedCompletionTime THEN
        SET Ticket.IsUrgentFlag = TRUE
        INCREMENT Ticket.EscalationLevel
        SEND Escalation Notification to Administrator (Process 2.5)
        LOG "Ticket escalated due to overdue status"
    ENDIF
ENDIF

// Update Database
UPDATE Ticket Record in Tickets Database (D2)
SET Ticket.LastUpdated = CURRENT_DATETIME

// Trigger Notifications
SEND Status Change Notification (Process 2.5)

DISPLAY "Ticket updated successfully"

END Process
```

*Subfunction: ValidateStatusTransition*
```
FUNCTION ValidateStatusTransition(Current Status, New Status) RETURNS Boolean

// Valid Transitions Matrix
SET Valid Transitions = {
    "Open": ["Assigned"],
    "Assigned": ["In Progress", "Open"],
    "In Progress": ["On Hold", "Fixed"],
    "On Hold": ["In Progress"],
    "Fixed": ["Closed"],
    "Closed": []
}

IF New Status IN Valid Transitions[Current Status] THEN
    RETURN TRUE
ELSE
    RETURN FALSE
ENDIF

END FUNCTION
```

*Refer to:*
- FR-16 (Task Status Updates)
- FR-23 (Ticket Assignment Management)
- FR-24 (Ticket Priority Management)
- Table 70: Data Flow 19 Details
- Table 71: Data Flow 20 Details
- Table 72: Data Flow 21 Details

*Decision Table (Technician Status Updates):*


#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [Current Status = Assigned], [Y], [N], [N], [N], [N], [N],
    [Current Status = In Progress], [N], [Y], [Y], [Y], [N], [N],
    [Current Status = On Hold], [N], [N], [N], [N], [Y], [N],
    [Current Status = Fixed], [N], [N], [N], [N], [N], [Y],
    [New Status = In Progress], [Y], [N], [N], [N], [Y], [N],
    [New Status = On Hold], [N], [Y], [N], [N], [N], [N],
    [New Status = Fixed], [N], [N], [Y], [N], [N], [N],
    [Evidence Submitted], [-], [-], [Y], [N], [-], [-],
    [Set Status = In Progress], [X], [-], [-], [-], [X], [-],
    [Record Start Time], [X], [-], [-], [-], [-], [-],
    [Set Status = On Hold], [-], [X], [-], [-], [-], [-],
    [Require Hold Reason], [-], [X], [-], [-], [-], [-],
    [Set Status = Fixed], [-], [-], [X], [-], [-], [-],
    [Update Metrics], [-], [-], [X], [-], [-], [-],
    [Display "Need Evidence"], [-], [-], [-], [X], [-], [-],
    [Display "Invalid Transition"], [-], [-], [-], [-], [-], [X],
    [Send Notifications], [X], [X], [X], [-], [X], [-],
  )
)

*Unresolved Issues:* None




*Number:* 2.4  
*Name:* Manage Comments & Evidence  
*Description:* Allows residents to add comments to tickets and technicians to upload maintenance completion evidence (images, notes, documents).

*Input Data Flow:*
- Comment Submission (from Resident)
- Completion Evidence (from Technician)

*Output Data Flow:*
- Maintenance Completion Record (to Maintenance History D3)
- Updated Ticket with Evidence (to Tickets Database D2)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `manageCommentsEvidence()`

*Process Logic (Structured English):*

```
BEGIN Process 2.4: Manage Comments & Evidence

READ Action Type (Add Comment OR Upload Evidence)

// ============================================
// RESIDENT: Add Comment to Ticket
// ============================================
IF Action = "Add Comment" THEN
    READ TicketID and Comment Text from Resident
    
    RETRIEVE Ticket from Tickets Database (D2)
    IF Ticket Not Found THEN
        DISPLAY "Ticket not found"
        EXIT Process
    ENDIF
    
    VERIFY Resident is Ticket Owner
    IF Ticket.RequesterID ≠ Current UserID THEN
        DISPLAY "You can only comment on your own tickets"
        EXIT Process
    ENDIF
    
    CHECK Ticket Status
    IF Ticket.Status = "Closed" THEN
        IF Ticket.ResidentEditableFlag = FALSE THEN
            DISPLAY "Cannot add comments to closed tickets"
            EXIT Process
        ENDIF
    ENDIF
    
    VALIDATE Comment Text
    IF Comment Text is Empty OR Length < 5 characters THEN
        DISPLAY "Comment must be at least 5 characters"
        EXIT Process
    ENDIF
    
    GENERATE CommentID
    CREATE Comment Record
        CommentID = Generated ID
        TicketID = Input TicketID
        UserID = Current UserID
        Content = Comment Text
        CreatedAt = CURRENT_DATETIME
        IsInternal = FALSE
    
    WRITE Comment to Database
    
    // Send notification to assigned technician (if any)
    IF Ticket.TechnicianID ≠ NULL THEN
        SEND Notification to Technician (Process 2.5)
            "New comment added to ticket " + TicketID
    ENDIF
    
    // Send notification to administrators
    SEND Notification to Administrators (Process 2.5)
    
    DISPLAY "Comment added successfully"
ENDIF

// ============================================
// TECHNICIAN: Upload Maintenance Evidence
// ============================================
IF Action = "Upload Evidence" THEN
    READ TicketID, Images, Notes, Documents from Technician
    
    RETRIEVE Ticket from Tickets Database (D2)
    IF Ticket Not Found THEN
        DISPLAY "Ticket not found"
        EXIT Process
    ENDIF
    
    VERIFY Technician is Assigned to Ticket
    IF Ticket.TechnicianID ≠ Current UserID THEN
        DISPLAY "You can only upload evidence for your assigned tickets"
        EXIT Process
    ENDIF
    
    CHECK Ticket Status
    IF Ticket.Status ≠ "In Progress" AND Ticket.Status ≠ "Fixed" THEN
        DISPLAY "Evidence can only be uploaded for In Progress or Fixed tickets"
        EXIT Process
    ENDIF
    
    // Validate Images
    IF Images Provided THEN
        IF Number of Images > 10 THEN
            DISPLAY "Maximum 10 evidence images allowed"
            EXIT Process
        ENDIF
        
        FOR EACH Image DO
            VALIDATE File Type (JPEG, PNG)
            VALIDATE File Size (< 10MB per image)
            IF Validation Fails THEN
                DISPLAY "Invalid image format or size. Allowed: JPEG, PNG up to 10MB"
                EXIT Process
            ENDIF
        ENDFOR
    ENDIF
    
    // Validate Documents
    IF Documents Provided THEN
        FOR EACH Document DO
            VALIDATE File Type (PDF only)
            VALIDATE File Size (< 20MB)
            IF Validation Fails THEN
                DISPLAY "Invalid document. Only PDF files up to 20MB allowed"
                EXIT Process
            ENDIF
        ENDFOR
    ENDIF
    
    // Validate that at least one piece of evidence is provided
    IF Images is Empty AND Notes is Empty AND Documents is Empty THEN
        DISPLAY "Please provide at least one piece of evidence (image or notes)"
        EXIT Process
    ENDIF
    
    // Upload Images to AWS S3
    IF Images Provided THEN
        FOR EACH Image DO
            COMPRESS Image (if size > 2MB, compress to maintain quality)
            GENERATE Unique Filename
                Format: evidence_<TicketID>_<Timestamp>_<Index>.<ext>
            
            UPLOAD to AWS S3
                Bucket: maintenance-evidence
                Path: /<Year>/<Month>/<TicketID>/
            
            STORE Image URL
            
            // Add caption if provided
            IF Caption Provided for Image THEN
                STORE Caption with Image URL
            ENDIF
        ENDFOR
    ENDIF
    
    // Upload Documents to AWS S3
    IF Documents Provided THEN
        FOR EACH Document DO
            GENERATE Unique Filename
            UPLOAD to AWS S3
                Bucket: maintenance-documents
                Path: /<Year>/<Month>/<TicketID>/
            STORE Document URL
        ENDFOR
    ENDIF
    
    // Get Standard Completion Checklist for Category
    RETRIEVE Completion Checklist Template
        based on Ticket.Category
    
    IF Checklist Items Provided THEN
        FOR EACH Checklist Item DO
            VALIDATE Item is Checked or Has Note
            STORE Checklist Response
        ENDFOR
    ENDIF
    
    // Create Evidence Record
    GENERATE EvidenceID
    CREATE Evidence Record
        EvidenceID = Generated ID
        TicketID = Input TicketID
        TechnicianID = Current UserID
        CompletionNotes = Input Notes
        ImagesURL = Uploaded Image URLs Array
        DocumentsURL = Uploaded Document URLs Array
        ChecklistData = Completed Checklist
        WorkPerformed = Notes.WorkPerformed
        PartsUsed = Notes.PartsUsed
        TimeSpent = Notes.TimeSpent
        FollowUpRequired = Notes.FollowUpRequired
        UploadedAt = CURRENT_DATETIME
    
    WRITE Evidence Record to Database
    
    // Update Ticket with Evidence Reference
    UPDATE Ticket in Tickets Database (D2)
        SET EvidenceID = Generated EvidenceID
        SET HasEvidence = TRUE
    
    // Store in Maintenance History
    IF Ticket.Status = "Fixed" THEN
        CREATE Maintenance History Record
            TicketID = Input TicketID
            TechnicianID = Current UserID
            LocationID = Ticket.LocationID
            Category = Ticket.Category
            ResolutionSummary = Notes
            CompletionDate = CURRENT_DATETIME
            EvidenceID = Generated EvidenceID
            ActualResolutionTime = Ticket.ActualResolutionTime
        
        WRITE to Maintenance History (D3)
    ENDIF
    
    // Send Notification
    SEND Notification to Requester (Process 2.5)
        "Maintenance work completed with evidence"
    SEND Notification to Administrators (Process 2.5)
        "Evidence uploaded for ticket " + TicketID
    
    DISPLAY "Evidence uploaded successfully"
    DISPLAY "Ticket ID: " + TicketID
    DISPLAY "Evidence ID: " + EvidenceID
ENDIF

END Process
```

*Refer to:*
- FR-17 (Maintenance Evidence Submission)
- FR-9.6 (Resident Comments)
- Table 67: Data Flow 16 Details
- Table 68: Data Flow 17 Details
- Table 69: Data Flow 18 Details

*Decision Table (Evidence Upload):*


#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [Assigned to Technician], [Y], [Y], [Y], [Y], [Y], [N],
    [Status = In Progress/Fixed], [Y], [Y], [Y], [Y], [N], [-],
    [Images Provided], [Y], [Y], [Y], [N], [-], [-],
    [Images Valid], [Y], [Y], [N], [-], [-], [-],
    [Notes Provided], [Y], [N], [-], [Y], [-], [-],
    [Upload Images], [X], [X], [-], [-], [-], [-],
    [Store Evidence Record], [X], [X], [-], [X], [-], [-],
    [Update Ticket], [X], [X], [-], [X], [-], [-],
    [Update History (if Fixed)], [X], [X], [-], [X], [-], [-],
    [Send Notifications], [X], [X], [-], [X], [-], [-],
    [Display "Invalid images"], [-], [-], [X], [-], [-], [-],
    [Display "Wrong status"], [-], [-], [-], [-], [X], [-],
    [Display "Not authorized"], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None




*Number:* 2.5  
*Name:* Send Notifications  
*Description:* Central notification dispatcher that sends real-time notifications via in-app, email, and SMS channels based on ticket events and status changes.

*Input Data Flow:*
- Notification Trigger (from Processes 2.1, 2.3, 2.4, 3.2, 4.1)

*Output Data Flow:*
- Notification (to Resident/Technician/Administrator)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `sendNotification()`

*Process Logic (Structured English):*

```
BEGIN Process 2.5: Send Notifications

READ Notification Trigger Data
    TicketID, Event Type, RecipientRole, RecipientUserID

RETRIEVE Ticket Details from Tickets Database (D2)
RETRIEVE Recipient User Data from User Database (D1)

// Determine Notification Type
SET Notification Type based on Event
IF Event = "Ticket Created" THEN
    SET Type = "Alert"
ELSIF Event = "Status Changed" THEN
    SET Type = "StatusChange"
ELSIF Event = "Ticket Assigned" THEN
    SET Type = "Assignment"
ELSIF Event = "Priority Changed" THEN
    SET Type = "PriorityChange"
ELSIF Event = "Comment Added" THEN
    SET Type = "StatusChange"
ELSIF Event = "Evidence Uploaded" THEN
    SET Type = "StatusChange"
ELSIF Event = "Ticket Overdue" THEN
    SET Type = "Alert"
ELSE
    SET Type = "System"
ENDIF

// Determine Priority Level
IF Event = "Ticket Overdue" OR 
   Event = "Emergency Ticket" OR 
   Event = "Account Locked" THEN
    SET Priority Level = "High" // Immediate delivery
ELSIF Event = "Status Changed" OR 
      Event = "Priority Changed" OR 
      Event = "Ticket Assigned" THEN
    SET Priority Level = "Medium" // Within 15 minutes
ELSE
    SET Priority Level = "Low" // Within 1 hour
ENDIF

// Check User Notification Preferences
RETRIEVE User Notification Preferences from User Database (D1)
IF Recipient.DoNotDisturb = TRUE THEN
    IF Priority Level ≠ "High" THEN
        QUEUE Notification for Later Delivery
        EXIT Process
    ENDIF
ENDIF

// Check if Notification Should Be Grouped
CHECK for Recent Similar Notifications (within last 10 minutes)
IF Similar Notifications Exist THEN
    GROUP Notifications Together
    UPDATE Existing Notification with Latest Status
ELSE
    CREATE New Notification
ENDIF

// Build Notification Message
SET Message = ""
IF Event = "Ticket Created" THEN
    SET Message = "New maintenance ticket created: " + Ticket.Title
ELSIF Event = "Status Changed" THEN
    SET Message = "Ticket " + TicketID + " status changed to " + Ticket.Status
ELSIF Event = "Ticket Assigned" THEN
    SET Message = "New ticket assigned to you: " + Ticket.Title + " (Priority: " + Ticket.Priority + ")"
ELSIF Event = "Priority Changed" THEN
    SET Message = "Ticket " + TicketID + " priority changed to " + Ticket.Priority
ELSIF Event = "Comment Added" THEN
    SET Message = "New comment added to your ticket " + TicketID
ELSIF Event = "Evidence Uploaded" THEN
    SET Message = "Maintenance evidence uploaded for ticket " + TicketID
ELSIF Event = "Ticket Overdue" THEN
    SET Message = "ALERT: Ticket " + TicketID + " is overdue"
ENDIF

GENERATE NotificationID
CREATE Notification Record
    NotificationID = Generated ID
    UserID = RecipientUserID
    RelatedTicketID = TicketID
    NotificationType = Type
    Message = Message
    Priority = Priority Level
    IsRead = FALSE
    CreatedAt = CURRENT_DATETIME
    ExpirationDate = CURRENT_DATETIME + 90 days

WRITE Notification to Database

// Send via Multiple Channels
// 1. In-App Notification
IF Recipient.Preferences.InAppEnabled = TRUE THEN
    SEND via WebSocket to Active User Sessions
    UPDATE Notification Badge Count
ENDIF

// 2. Email Notification
IF Recipient.Preferences.EmailEnabled = TRUE THEN
    IF Priority Level = "High" OR 
       Recipient.Preferences.EmailForAllUpdates = TRUE THEN
        
        COMPOSE Email
            Subject = "SALLEHA: " + Message
            Body = Build HTML Email Template with:
                - Ticket Details
                - Status/Update Information
                - Direct Link to View Ticket
                - User Preferences Link
        
        SEND Email via Nodemailer SMTP
        LOG Email Sent
    ENDIF
ENDIF

// 3. SMS Notification (Optional - Only for Urgent)
IF Recipient.Preferences.SMSEnabled = TRUE THEN
    IF Priority Level = "High" OR Ticket.Priority = "Emergency" THEN
        IF Recipient.PhoneNumber ≠ NULL THEN
            COMPOSE SMS Message (max 160 chars)
                "SALLEHA ALERT: " + Message + " View: " + Short URL
            
            SEND SMS via Twilio API
            LOG SMS Sent
        ENDIF
    ENDIF
ENDIF

// 4. Push Notification (Mobile App)
IF Recipient Has Active Mobile Session THEN
    COMPOSE Push Notification
        Title = "SALLEHA Maintenance"
        Body = Message
        Data = {TicketID, Type, DeepLink}
    
    SEND via Firebase Cloud Messaging (FCM)
    LOG Push Notification Sent
ENDIF

DISPLAY "Notification sent successfully"

END Process
```

*Refer to:*
- FR-10 (Status Change Notifications)
- FR-18 (Technician Notifications)
- FR-25 (Administrator Notifications)
- Table 73: Data Flow 22 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Priority Level = High], [Y], [Y], [N], [N], [N],
    [Do Not Disturb Active], [Y], [N], [Y], [N], [N],
    [In-App Enabled], [-], [Y], [-], [Y], [Y],
    [Email Enabled], [-], [Y], [-], [Y], [N],
    [SMS Enabled], [-], [Y], [-], [N], [-],
    [Send Immediately], [X], [X], [-], [-], [-],
    [Queue for Later], [-], [-], [X], [-], [-],
    [Send In-App], [X], [X], [-], [X], [X],
    [Send Email], [X], [X], [-], [X], [-],
    [Send SMS], [X], [X], [-], [-], [-],
    [Send Push Notification], [X], [X], [-], [X], [X],
    [Group Notifications], [-], [X], [-], [X], [X],
  )
)

*Unresolved Issues:* None


=== Fragment 3: Assignment & Task Management Processes




*Number:* 3.1  
*Name:* View Pending/Unassigned Tickets  
*Description:* Displays all tickets that haven't been assigned to technicians, sorted by priority and submission time for administrator review.

*Input Data Flow:*
- View Pending Tickets Request (from Administrator)

*Output Data Flow:*
- Pending Tickets List (from Tickets Database D2 to Administrator)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `viewPendingTickets()`

*Process Logic (Structured English):*

```
BEGIN Process 3.1: View Pending/Unassigned Tickets

VERIFY User is Administrator
IF User Role ≠ "Administrator" THEN
    DISPLAY "Unauthorized access"
    EXIT Process
ENDIF

READ Filter Options from Administrator (Optional)
    Priority Filter, Category Filter, Date Range, Location Filter

// Query Pending Tickets
QUERY Tickets Database (D2) WHERE:
    Status IN ("Open", "Assigned") AND
    (TechnicianID IS NULL OR Status = "Open")

// Apply Optional Filters
IF Priority Filter Provided THEN
    FILTER Results by Priority IN Selected Priorities
ENDIF

IF Category Filter Provided THEN
    FILTER Results by Category = Selected Category
ENDIF

IF Date Range Provided THEN
    FILTER Results by ReportedAt BETWEEN StartDate AND EndDate
ENDIF

IF Location Filter Provided THEN
    FILTER Results by LocationID = Selected Location
ENDIF

SET Pending Tickets = Query Results

IF Pending Tickets is Empty THEN
    DISPLAY "No pending tickets found"
    EXIT Process
ENDIF

// Sort by Priority and Time
SORT Pending Tickets by:
    1. Priority DESC (Emergency > Urgent > High > Medium > Low)
    2. IsUrgentFlag DESC
    3. ReportedAt ASC (oldest first)

// Calculate Wait Times
FOR EACH Ticket in Pending Tickets DO
    CALCULATE Wait Time = CURRENT_DATETIME - Ticket.ReportedAt
    SET Ticket.WaitTime = Wait Time
    
    // Highlight overdue tickets
    IF Wait Time > Expected Response Time for Priority THEN
        SET Ticket.IsOverdue = TRUE
    ENDIF
    
    // Get available technicians for this ticket
    QUERY Available Technicians WHERE:
        AvailabilityStatus = "Available" AND
        Specialization MATCHES Ticket.Category
    
    SET Ticket.AvailableTechnicians = Query Results Count
ENDFOR

// Display Statistics
CALCULATE Total Pending = Pending Tickets Count
CALCULATE Total Overdue = Count of Tickets WHERE IsOverdue = TRUE
CALCULATE Avg Wait Time = AVERAGE(All Tickets WaitTime)

DISPLAY Dashboard Header
    "Total Pending: " + Total Pending
    "Overdue: " + Total Overdue
    "Average Wait Time: " + Avg Wait Time

// Display Ticket List
FOR EACH Ticket in Pending Tickets DO
    DISPLAY Ticket Row
        TicketID (Clickable)
        Title
        Category
        Location
        Priority (Color-coded badge)
        Reported Time (Relative: "2 hours ago")
        Wait Time
        Available Technicians Count
        "Assign" Button
        "View Details" Link
    
    IF Ticket.IsOverdue THEN
        HIGHLIGHT Row in Red
        SHOW "OVERDUE" Badge
    ENDIF
ENDFOR

// Provide Quick Actions
DISPLAY Quick Action Buttons
    "Auto-Assign All"
    "Bulk Assign by Category"
    "Refresh List"
    "Export to Excel"

END Process
```

*Refer to:*
- FR-23 (Ticket Assignment Management)
- Table 74: Data Flow 23 Details
- Table 75: Data Flow 24 Details

#pagebreak()

*Decision Tree:*

#figure(
  image(
    "../../assets/chapter4/dt3.1.png",
    height:90%
  ),
)
#figure(
  image(
    "../../assets/chapter4/dt3.2.png",
    height:60%
  ),
  caption: [Decision Tree 3.2]
)

*Unresolved Issues:* None




*Number:* 3.2  
*Name:* Assign Ticket & Set Priority  
*Description:* Assigns maintenance tickets to technicians based on availability, expertise, and workload. Sets or updates ticket priority levels.

*Input Data Flow:*
- Assignment Decision (from Administrator)
  - TicketID
  - TechnicianID
  - Priority Level

*Output Data Flow:*
- Assignment & Priority Update (to Tickets Database D2)
- Assigned Task Notification (to Process 3.3 → Technician)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `assignTicketAndSetPriority()`

*Process Logic (Structured English):*

```
BEGIN Process 3.2: Assign Ticket & Set Priority

VERIFY User is Administrator
IF User Role ≠ "Administrator" THEN
    DISPLAY "Unauthorized access"
    EXIT Process
ENDIF

READ Assignment Data from Administrator
    TicketID, TechnicianID, Priority Level (Optional)

RETRIEVE Ticket from Tickets Database (D2)
IF Ticket Not Found THEN
    DISPLAY "Ticket not found"
    EXIT Process
ENDIF

RETRIEVE Technician from User Database (D1)
IF Technician Not Found OR Technician.Role ≠ "Technician" THEN
    DISPLAY "Invalid technician selected"
    EXIT Process
ENDIF

// Check Ticket is Assignable
IF Ticket.Status = "Closed" THEN
    DISPLAY "Cannot assign closed tickets"
    EXIT Process
ENDIF

// Validate Technician Status
IF Technician.AccountStatus ≠ "Active" THEN
    DISPLAY "Selected technician account is not active"
    EXIT Process
ENDIF

// Check Availability
GET Technician Current Availability
IF Technician.AvailabilityStatus = "On Break" THEN
    WARN "Technician is currently on break"
    PROMPT "Assign anyway?"
    IF Administrator Declines THEN
        EXIT Process
    ENDIF
ENDIF

// Check Workload
GET Technician Current Assigned Tasks Count
CALCULATE Current Workload = Count of Tickets WHERE:
    TechnicianID = Selected Technician AND
    Status IN ("Assigned", "In Progress")

IF Current Workload >= 10 THEN
    WARN "Technician already has " + Current Workload + " active tasks"
    DISPLAY "Average workload: 5 tasks"
    PROMPT "Assign anyway?"
    IF Administrator Declines THEN
        SUGGEST Alternative Technicians with Lower Workload
        EXIT Process
    ENDIF
ENDIF

// Check Expertise Match
GET Technician Specialization
IF Ticket.Category NOT IN Technician.Specialization THEN
    WARN "Technician specialization: " + Technician.Specialization
    WARN "Ticket category: " + Ticket.Category
    WARN "Specializations don't match"
    PROMPT "Assign anyway?"
    IF Administrator Declines THEN
        // Suggest better matched technicians
        QUERY Technicians WHERE:
            Specialization CONTAINS Ticket.Category AND
            AvailabilityStatus = "Available"
        DISPLAY "Suggested Technicians: " + Query Results
        EXIT Process
    ENDIF
ENDIF

// Check Location Proximity (if WorkZone defined)
IF Technician.WorkZone ≠ NULL THEN
    GET Ticket Location Zone
    IF Technician.WorkZone ≠ Ticket.Location.Zone THEN
        INFO "Technician's work zone: " + Technician.WorkZone
        INFO "Ticket location zone: " + Ticket.Location.Zone
        PROMPT "Proceed with cross-zone assignment?"
        IF Administrator Declines THEN
            EXIT Process
        ENDIF
    ENDIF
ENDIF

// Update Priority (if provided)
IF Priority Level Provided THEN
    VALIDATE Priority IN (Low, Medium, High, Urgent, Emergency)
    IF Priority Invalid THEN
        DISPLAY "Invalid priority level"
        EXIT Process
    ENDIF
    
    SET Old Priority = Ticket.Priority
    SET Ticket.Priority = New Priority Level
    
    // Recalculate estimated times
    CALCULATE Estimated Response Time based on New Priority
    CALCULATE Estimated Completion Time based on New Priority
    
    IF New Priority > Old Priority THEN
        SET Ticket.IsUrgentFlag = TRUE
    ENDIF
    
    LOG "Priority changed from " + Old Priority + " to " + New Priority + " by " + Admin.Name
ENDIF

// Set Expected Completion Instructions (Optional)
IF Administrator Provides Special Instructions THEN
    SET Ticket.AdminNotes = Special Instructions
    SET Ticket.RequiredTools = Specified Tools
    SET Ticket.RequiredParts = Specified Parts
ENDIF

// Perform Assignment
IF Ticket Already Assigned to Different Technician THEN
    SET Old TechnicianID = Ticket.TechnicianID
    LOG "Ticket reassigned from Technician " + Old TechnicianID + " to " + TechnicianID
    
    // Notify old technician of reassignment
    SEND Notification to Old Technician (Process 2.5)
        "Ticket " + TicketID + " has been reassigned"
ENDIF

SET Ticket.TechnicianID = Selected TechnicianID
SET Ticket.AssignedAt = CURRENT_DATETIME
SET Ticket.Status = "Assigned"

// Calculate Expected Completion Based on Priority and Historical Data
QUERY Historical Average Resolution Time WHERE:
    Category = Ticket.Category AND
    Priority = Ticket.Priority

IF Historical Data Available THEN
    SET Estimated Duration = Historical Average
ELSE
    // Use default estimates
    IF Priority = "Emergency" THEN
        SET Estimated Duration = 1 hour
    ELSIF Priority = "Urgent" THEN
        SET Estimated Duration = 4 hours
    ELSIF Priority = "High" THEN
        SET Estimated Duration = 1 day
    ELSIF Priority = "Medium" THEN
        SET Estimated Duration = 3 days
    ELSE // Low
        SET Estimated Duration = 7 days
    ENDIF
ENDIF

SET Ticket.ExpectedCompletionTime = CURRENT_DATETIME + Estimated Duration

// Update Database
UPDATE Ticket in Tickets Database (D2)
SET Ticket.LastUpdated = CURRENT_DATETIME

// Maintain Assignment History
CREATE Assignment History Record
    TicketID = TicketID
    TechnicianID = TechnicianID
    AssignedBy = Administrator.UserID
    AssignedAt = CURRENT_DATETIME
    Priority = Ticket.Priority
    Reasoning = Assignment Notes

WRITE to Assignment History Table

// Send Notification to Technician
TRIGGER Process 3.3 (Notify Technician)
    TicketID, TechnicianID, Priority

// Send Notification to Requester
SEND Notification to Ticket Requester (Process 2.5)
    "Your ticket has been assigned to a technician"

DISPLAY "Ticket " + TicketID + " successfully assigned to " + Technician.FullName

END Process
```

*Refer to:*
- FR-23 (Ticket Assignment Management)
- FR-24 (Ticket Priority Management)
- Table 76: Data Flow 25 Details
- Table 77: Data Flow 26 Details

*Decision Table:*


#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [Technician Active], [Y], [Y], [Y], [Y], [Y], [N],
    [Ticket Assignable], [Y], [Y], [Y], [Y], [N], [-],
    [Workload < 10 Tasks], [Y], [Y], [Y], [N], [-], [-],
    [Expertise Matches], [Y], [Y], [N], [-], [-], [-],
    [Admin Confirms Mismatch], [-], [-], [Y], [-], [-], [-],
    [Zone Matches (if defined)], [Y], [N], [-], [-], [-], [-],
    [*Actions*],
    [Assign Ticket], [X], [X], [X], [X], [-], [-],
    [Update Priority], [X], [X], [X], [X], [-], [-],
    [Send Notification], [X], [X], [X], [X], [-], [-],
    [Log Assignment], [X], [X], [X], [X], [-], [-],
    [Warn Zone Mismatch], [-], [X], [-], [-], [-], [-],
    [Warn Expertise Mismatch], [-], [-], [X], [-], [-], [-],
    [Warn High Workload], [-], [-], [-], [X], [-], [-],
    [Display "Not Assignable"], [-], [-], [-], [-], [X], [-],
    [Display "Invalid Technician"], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None




*Number:* 3.3  
*Name:* Notify Technician  
*Description:* Sends notification to technician when a new task is assigned, including ticket details and priority information.

*Input Data Flow:*
- Assignment Notification Trigger (from Process 3.2)

*Output Data Flow:*
- Assigned Task Notification (to Technician)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `notifyTechnicianAssignment()`

*Process Logic (Structured English):*

```
BEGIN Process 3.3: Notify Technician

READ Notification Trigger Data
    TicketID, TechnicianID, Priority

RETRIEVE Ticket Details from Tickets Database (D2)
RETRIEVE Technician Data from User Database (D1)

// Build Notification Message
SET Message = "New ticket assigned: " + Ticket.Title
SET Details = {
    "Ticket ID": TicketID,
    "Category": Ticket.Category,
    "Location": Ticket.Location.BuildingName + " - " + Ticket.Location.RoomNumber,
    "Priority": Ticket.Priority,
    "Reported": Ticket.ReportedAt (Relative Time),
    "Expected Completion": Ticket.ExpectedCompletionTime
}

IF Ticket.AdminNotes ≠ NULL THEN
    ADD "Special Instructions: " + Ticket.AdminNotes to Details
ENDIF

IF Ticket.RequiredTools ≠ NULL THEN
    ADD "Required Tools: " + Ticket.RequiredTools to Details
ENDIF

// Determine Notification Priority
IF Ticket.Priority IN ("Emergency", "Urgent") THEN
    SET Notification Priority = "High" // Immediate
ELSIF Ticket.Priority = "High" THEN
    SET Notification Priority = "Medium" // Within 15 min
ELSE
    SET Notification Priority = "Low" // Within 1 hour
ENDIF

// Create Notification Record
GENERATE NotificationID
CREATE Notification
    NotificationID = Generated ID
    UserID = TechnicianID
    RelatedTicketID = TicketID
    NotificationType = "Assignment"
    Message = Message
    Details = Details JSON
    Priority = Notification Priority
    IsRead = FALSE
    CreatedAt = CURRENT_DATETIME
    ExpirationDate = CURRENT_DATETIME + 90 days

WRITE to Notifications Database

// Send Multi-Channel Notifications
// 1. In-App Push Notification
SEND Real-time Notification via WebSocket
    IF Technician Has Active Session THEN
        PUSH Notification to Dashboard
        UPDATE Notification Badge
        PLAY Notification Sound (if Priority = High)
    ENDIF

// 2. Email Notification
IF Technician.Preferences.EmailNotifications = TRUE THEN
    COMPOSE Email
        To: Technician.Email
        Subject: "[SALLEHA] New Task Assigned - Priority: " + Priority
        Body: HTML Template with:
            - Ticket Summary
            - Location and Category
            - Priority Badge
            - Expected Completion Time
            - "View Ticket" Button (Deep Link)
            - "Accept Task" Quick Action Link
    
    SEND via Email Service
ENDIF

// 3. SMS (Only for Urgent/Emergency)
IF Ticket.Priority IN ("Emergency", "Urgent") THEN
    IF Technician.Preferences.SMSNotifications = TRUE THEN
        IF Technician.PhoneNumber ≠ NULL THEN
            COMPOSE SMS (max 160 chars)
                "URGENT: New task " + TicketID + " at " + Location + ". Priority: " + Priority + ". View: " + Short URL
            
            SEND via SMS Service (Twilio)
        ENDIF
    ENDIF
ENDIF

// 4. Mobile Push Notification
IF Technician Has Mobile App Installed THEN
    COMPOSE Push Notification
        Title: "New Task Assigned"
        Body: Ticket.Title + " (" + Priority + ")"
        Badge: Increment Unread Count
        Sound: (Priority = High ? "urgent.mp3" : "default.mp3")
        Data: {
            type: "assignment",
            ticketID: TicketID,
            priority: Priority,
            deepLink: "salleha://tickets/" + TicketID
        }
    
    SEND via Firebase Cloud Messaging (FCM)
ENDIF

LOG "Assignment notification sent to Technician " + TechnicianID + " for Ticket " + TicketID

END Process
```

*Refer to:*
- FR-18 (Technician Notifications)
- Table 78: Data Flow 27 Details


*Decision Tree:*

#figure(
  image(
    "../../assets/chapter4/dt4.1.png",
  ),
)
#figure(
  image(
    "../../assets/chapter4/dt4.2.png",
  ),
  caption: [Decision Tree 3.3]
)

*Unresolved Issues:* None




*Number:* 3.4  
*Name:* Update Assignment Status  
*Description:* Updates ticket assignment status based on technician response (accept or decline), handles reassignment if declined.

*Input Data Flow:*
- Assignment Response (from Technician)
  - TicketID
  - Response (Accept/Decline)
  - Decline Reason (if declining)

*Output Data Flow:*
- Assignment Status Update (to Tickets Database D2)
- Reassignment Trigger (if declined)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `updateAssignmentStatus()`

*Process Logic (Structured English):*

```
BEGIN Process 3.4: Update Assignment Status

READ Assignment Response from Technician
    TicketID, Response Status, Optional Decline Reason

RETRIEVE Ticket from Tickets Database (D2)
IF Ticket Not Found THEN
    DISPLAY "Ticket not found"
    EXIT Process
ENDIF

VERIFY Technician is Assigned to Ticket
IF Ticket.TechnicianID ≠ Current UserID THEN
    DISPLAY "You are not assigned to this ticket"
    EXIT Process
ENDIF

CHECK Ticket Current Status
IF Ticket.Status ≠ "Assigned" THEN
    DISPLAY "Ticket cannot be accepted/declined in current status"
    EXIT Process
ENDIF

// ============================================
// TECHNICIAN ACCEPTS TASK
// ============================================
IF Response Status = "Accept" THEN
    SET Ticket.Status = "Accepted"
    SET Ticket.AcceptedAt = CURRENT_DATETIME
    
    UPDATE Ticket in Tickets Database (D2)
    
    LOG "Ticket " + TicketID + " accepted by Technician " + Technician.Name
    
    // Send Notification to Requester
    SEND Notification to Ticket Requester (Process 2.5)
        "Your ticket has been accepted by a technician"
    
    // Send Notification to Administrator
    SEND Notification to Administrators (Process 2.5)
        "Ticket " + TicketID + " accepted by " + Technician.Name
    
    DISPLAY "Task accepted successfully"
    REDIRECT to Ticket Details Page
ENDIF

// ============================================
// TECHNICIAN DECLINES TASK
// ============================================
IF Response Status = "Decline" THEN
    // Require Decline Reason
    IF Decline Reason is Empty THEN
        DISPLAY "Please provide a reason for declining"
        PROMPT Reason Selection:
            - "Outside my specialization"
            - "Current workload too high"
            - "Lack required equipment/parts"
            - "Urgent personal matter"
            - "Other (specify)"
        READ Decline Reason
        
        IF Decline Reason is Still Empty THEN
            DISPLAY "Reason is required to decline task"
            EXIT Process
        ENDIF
    ENDIF
    
    // Log Decline
    CREATE Decline Record
        TicketID = TicketID
        TechnicianID = Current UserID
        DeclinedAt = CURRENT_DATETIME
        DeclineReason = Decline Reason
    
    WRITE to Decline History
    
    // Clear Assignment
    SET Old TechnicianID = Ticket.TechnicianID
    SET Ticket.TechnicianID = NULL
    SET Ticket.AssignedAt = NULL
    SET Ticket.Status = "Open"
    SET Ticket.DeclineCount = Ticket.DeclineCount + 1
    
    UPDATE Ticket in Tickets Database (D2)
    
    LOG "Ticket " + TicketID + " declined by Technician " + Old TechnicianID + ". Reason: " + Decline Reason
    
    // If ticket declined multiple times, escalate
    IF Ticket.DeclineCount >= 3 THEN
        SET Ticket.IsUrgentFlag = TRUE
        INCREMENT Ticket.EscalationLevel
        SEND Urgent Notification to Administrator (Process 2.5)
            "ALERT: Ticket " + TicketID + " declined " + Ticket.DeclineCount + " times"
    ENDIF
    
    // Auto-Reassign to Next Available Technician
    QUERY Available Technicians WHERE:
        AvailabilityStatus = "Available" AND
        Specialization MATCHES Ticket.Category AND
        UserID ≠ Old TechnicianID // Exclude technician who declined
    
    ORDER BY:
        1. SkillLevel DESC
        2. Current Workload ASC
        3. CustomerSatisfactionRating DESC
    
    LIMIT 1
    
    IF Next Technician Found THEN
        // Auto-assign
        SET Ticket.TechnicianID = Next Technician.UserID
        SET Ticket.AssignedAt = CURRENT_DATETIME
        SET Ticket.Status = "Assigned"
        SET Ticket.AutoAssigned = TRUE
        
        UPDATE Ticket in Tickets Database (D2)
        
        // Notify new technician
        TRIGGER Process 3.3 (Notify Technician)
            TicketID, Next Technician.UserID, Ticket.Priority
        
        // Notify administrator
        SEND Notification to Administrator (Process 2.5)
            "Ticket " + TicketID + " auto-reassigned to " + Next Technician.Name + " after decline"
        
        DISPLAY "Task declined. Ticket has been reassigned to another technician."
    ELSE
        // No available technician found
        SEND Urgent Notification to Administrator (Process 2.5)
            "ALERT: Ticket " + TicketID + " declined but no available technician found for manual reassignment"
        
        DISPLAY "Task declined. Administrator will manually reassign this ticket."
    ENDIF
ENDIF

END Process
```

*Refer to:*
- FR-15 (Accept Maintenance Requests)
- Table 79: Data Flow 28 Details
- Table 80: Data Flow 29 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Response = Accept], [Y], [N], [N], [N], [N],
    [Response = Decline], [N], [Y], [Y], [Y], [N],
    [Decline Reason Provided], [-], [Y], [Y], [Y], [-],
    [Next Technician Available], [-], [Y], [Y], [N], [-],
    [Decline Count >= 3], [-], [N], [Y], [-], [-],
    [Set Status = Accepted], [X], [-], [-], [-], [-],
    [Notify Requester + Admin], [X], [-], [-], [-], [-],
    [Record Decline], [-], [X], [X], [X], [-],
    [Clear Assignment], [-], [X], [X], [X], [-],
    [Auto-Reassign], [-], [X], [X], [-], [-],
    [Escalate (Urgent Flag)], [-], [-], [X], [-], [-],
    [Alert Admin (No Technician)], [-], [-], [-], [X], [-],
    [Display "Reason Required"], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None


=== Fragment 4: Analytics & Reporting Processes




*Number:* 4.1  
*Name:* Record Maintenance Completion  
*Description:* Records the completion of maintenance work, validates evidence submission, updates ticket status, and calculates resolution metrics.

*Input Data Flow:*
- Completion Data (from Technician)
  - TicketID
  - Completion Notes
  - Completion Time
  - Evidence Reference

*Output Data Flow:*
- Maintenance Completion Record (to Process 4.2 → Maintenance History D3)
- Ticket Final Status Update (to Tickets Database D2)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `recordMaintenanceCompletion()`

*Process Logic (Structured English):*

```
BEGIN Process 4.1: Record Maintenance Completion

READ Completion Data from Technician
    TicketID, Completion Notes, Work Summary, Parts Used, Time Spent

RETRIEVE Ticket from Tickets Database (D2)
IF Ticket Not Found THEN
    DISPLAY "Ticket not found"
    EXIT Process
ENDIF

VERIFY Technician Ownership
IF Ticket.TechnicianID ≠ Current UserID THEN
    DISPLAY "You are not authorized to complete this ticket"
    EXIT Process
ENDIF

CHECK Ticket Status
IF Ticket.Status ≠ "In Progress" THEN
    DISPLAY "Ticket must be In Progress to mark as completed"
    EXIT Process
ENDIF

// Verify Evidence Was Submitted
CHECK if Evidence Exists for Ticket
IF Ticket.EvidenceID IS NULL OR Ticket.HasEvidence = FALSE THEN
    DISPLAY "Please upload completion evidence before marking as complete"
    REDIRECT to Evidence Upload (Process 2.4)
    EXIT Process
ENDIF

// Validate Completion Notes
IF Completion Notes is Empty OR Length < 20 characters THEN
    DISPLAY "Please provide detailed completion notes (minimum 20 characters)"
    EXIT Process
ENDIF

// Retrieve Evidence Record
RETRIEVE Evidence from Evidence Table WHERE EvidenceID = Ticket.EvidenceID

// Update Ticket Status
SET Ticket.Status = "Fixed"
SET Ticket.ResolvedAt = CURRENT_DATETIME

// Calculate Resolution Metrics
IF Ticket.ActualStartTime ≠ NULL THEN
    CALCULATE Actual Resolution Time = ResolvedAt - ActualStartTime
    SET Ticket.ActualResolutionTime = Actual Resolution Time
ELSE
    // If start time wasn't recorded, use assigned time
    CALCULATE Actual Resolution Time = ResolvedAt - AssignedAt
    SET Ticket.ActualResolutionTime = Actual Resolution Time
ENDIF

// Compare with Estimated Time
IF Ticket.EstimatedCompletionTime ≠ NULL THEN
    IF ResolvedAt > EstimatedCompletionTime THEN
        SET Ticket.CompletedLate = TRUE
        CALCULATE Delay = ResolvedAt - EstimatedCompletionTime
        SET Ticket.DelayDuration = Delay
    ELSE
        SET Ticket.CompletedOnTime = TRUE
    ENDIF
ENDIF

// Update Ticket Final Details
SET Ticket.CompletionNotes = Completion Notes
SET Ticket.ResolutionSummary = Work Summary
SET Ticket.PartsUsed = Parts Used
SET Ticket.LaborHours = Time Spent

UPDATE Ticket in Tickets Database (D2)

// Update Technician Performance Metrics
GET Technician Current Metrics
CALCULATE New Average Resolution Time
    = (Current Avg * Completed Count + Actual Resolution Time) / (Completed Count + 1)

INCREMENT Technician.CompletedTasksCount
UPDATE Technician.AverageResolutionTime = New Average Resolution Time
CALCULATE Technician.CompletionRate 
    = (CompletedTasksCount / TotalAssignedTasks) * 100

UPDATE Technician Record in User Database (D1)

// Prepare Completion Record for History
CREATE Completion Data Object
    TicketID = TicketID
    TechnicianID = Ticket.TechnicianID
    LocationID = Ticket.LocationID
    Category = Ticket.Category
    Priority = Ticket.Priority
    ResolutionSummary = Work Summary
    CompletionNotes = Completion Notes
    PartsUsed = Parts Used
    LaborHours = Time Spent
    CompletionDate = ResolvedAt
    ActualResolutionTime = Actual Resolution Time
    EvidenceID = Ticket.EvidenceID
    CompletedOnTime = Ticket.CompletedOnTime

// Send to Maintenance History Process
TRIGGER Process 4.2 (Update Maintenance History)
    Pass Completion Data Object

// Send Notifications
// 1. Notify Administrator for Review
SEND Notification to Administrators (Process 2.5)
    "Ticket " + TicketID + " marked as Fixed by " + Technician.Name + ". Awaiting review."

// 2. Notify Requester
SEND Notification to Ticket Requester (Process 2.5)
    "Your ticket " + TicketID + " has been completed. Please verify the work."

LOG "Ticket " + TicketID + " completed by Technician " + Technician.Name
DISPLAY "Maintenance work completed successfully"
DISPLAY "Ticket ID: " + TicketID
DISPLAY "Resolution Time: " + Actual Resolution Time

END Process
```

*Refer to:*
- FR-16.3 (Task Status Updates - Fixed)
- Table 81: Data Flow 30 Details
- Table 82: Data Flow 31 Details
- Table 83: Data Flow 32 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Status = In Progress], [Y], [Y], [Y], [Y], [N],
    [Evidence Submitted], [Y], [Y], [Y], [N], [-],
    [Completion Notes Valid], [Y], [Y], [N], [-], [-],
    [Completed On Time], [Y], [N], [-], [-], [-],
    [Set Status = Fixed], [X], [X], [-], [-], [-],
    [Calculate Metrics], [X], [X], [-], [-], [-],
    [Update Technician Performance], [X], [X], [-], [-], [-],
    [Send to History], [X], [X], [-], [-], [-],
    [Send Notifications], [X], [X], [-], [-], [-],
    [Flag as Late], [-], [X], [-], [-], [-],
    [Display "Notes too short"], [-], [-], [X], [-], [-],
    [Display "Need evidence"], [-], [-], [-], [X], [-],
    [Display "Wrong status"], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None




*Number:* 4.2  
*Name:* Update Maintenance History  
*Description:* Archives completed maintenance records for historical tracking, trend analysis, and performance reporting.

*Input Data Flow:*
- Maintenance Completion Record (from Process 4.1)

*Output Data Flow:*
- Stored Maintenance History Entry (to Maintenance History D3)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `updateMaintenanceHistory()`

*Process Logic (Structured English):*

```
BEGIN Process 4.2: Update Maintenance History

READ Completion Data from Process 4.1
    TicketID, TechnicianID, LocationID, Category, Priority,
    ResolutionSummary, CompletionNotes, PartsUsed, LaborHours,
    CompletionDate, ActualResolutionTime, EvidenceID, CompletedOnTime

GENERATE History Record ID
CREATE Maintenance History Record
    HistoryID = Generated ID
    TicketID = Input TicketID
    TechnicianID = Input TechnicianID
    TechnicianName = Get from User Database
    LocationID = Input LocationID
    LocationDetails = Get from Location Database
    Category = Input Category
    Priority = Input Priority
    IssueDescription = Get from Original Ticket
    ResolutionSummary = Input ResolutionSummary
    CompletionNotes = Input CompletionNotes
    WorkPerformed = Extract from Notes
    PartsUsed = Input PartsUsed
    PartsOrderPrice = Calculate Total (if Parts Cost Available)
    LaborHours = Input LaborHours
    LaborCost = Calculate (LaborHours * Hourly Rate)
    TotalCost = PartsOrderPrice + LaborCost
    CompletionDate = Input CompletionDate
    ActualResolutionTime = Input ActualResolutionTime
    EvidenceID = Input EvidenceID
    CompletedOnTime = Input CompletedOnTime
    RecordedAt = CURRENT_DATETIME

// Link to Equipment (if equipment ID was specified)
IF Ticket Contains Equipment Information THEN
    SET EquipmentID = Ticket.EquipmentID
    SET ManufacturerDetails = Get from Equipment Database
    SET WarrantyInfo = Get from Equipment Database
    
    // Update Equipment Maintenance Log
    ADD History Record ID to Equipment.MaintenanceHistory
ENDIF

// Calculate MTBF (Mean Time Between Failures) for Equipment
IF EquipmentID ≠ NULL THEN
    QUERY Previous Maintenance for Same Equipment
    IF Previous Records Exist THEN
        GET Last Maintenance Date
        CALCULATE Time Between Failures = CompletionDate - Last Maintenance Date
        UPDATE Equipment.MTBF Calculation
    ENDIF
ENDIF

WRITE Maintenance History Record to Maintenance History (D3)

// Update Location Statistics
UPDATE Location Statistics
    INCREMENT Location.TotalMaintenanceCount
    ADD Category to Location.MaintenanceCategories
    CALCULATE Location.AverageResolutionTime

// Update Category Statistics
UPDATE Category Statistics
    INCREMENT Global Category Count
    CALCULATE Average Resolution Time for Category
    UPDATE Most Common Issues List

LOG "Maintenance history archived for Ticket " + TicketID

END Process
```

*Refer to:*
- FR-19 (Maintenance History Access)
- FR-26 (Analytics and Reporting)
- Table 84: Data Flow 33 Details

*Structured English (Simplified):*

```
BEGIN

READ completion data
GENERATE history record ID

CREATE comprehensive history record with:
    - Ticket details
    - Technician details
    - Location details
    - Work performed
    - Parts and costs
    - Time metrics
    - Evidence reference

IF equipment involved THEN
    UPDATE equipment maintenance log
    CALCULATE MTBF for equipment
ENDIF

WRITE to maintenance history database

UPDATE location statistics
UPDATE category statistics

LOG archive completion

END
```

*Unresolved Issues:* None




*Number:* 4.3  
*Name:* Generate Reports & Metrics  
*Description:* Compiles maintenance data, calculates KPIs, generates analytics dashboards, and produces reports for administrators.

*Input Data Flow:*
- Report Request (from Administrator)
  - Date Range
  - Filters
  - Report Type

*Output Data Flow:*
- Reports & Metrics Store (to Reports & Analytics D4)
- Analytics Dashboard Data (from D2, D3 to Administrator)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `generateReportsAndMetrics()`

*Process Logic (Structured English):*

```
BEGIN Process 4.3: Generate Reports & Metrics

VERIFY User is Administrator
IF User Role ≠ "Administrator" THEN
    DISPLAY "Unauthorized access"
    EXIT Process
ENDIF

READ Report Parameters from Administrator
    Report Type, Date Range, Filters (Category, Location, Technician, Priority)

// Default to Current Month if no date range specified
IF Date Range Not Provided THEN
    SET Start Date = First Day of Current Month
    SET End Date = CURRENT_DATE
ENDIF

VALIDATE Date Range
IF Start Date > End Date THEN
    DISPLAY "Invalid date range"
    EXIT Process
ENDIF

// ============================================
// COLLECT DATA BASED ON REPORT TYPE
// ============================================

IF Report Type = "Overall Dashboard" OR Report Type = "Summary" THEN
    // === KEY PERFORMANCE INDICATORS ===
    
    // 1. Total Tickets
    QUERY COUNT(*) FROM Tickets WHERE
        ReportedAt BETWEEN Start Date AND End Date
    SET KPI.TotalTickets = Query Result
    
    // 2. Open Issues
    QUERY COUNT(*) FROM Tickets WHERE
        Status IN ("Open", "Assigned", "In Progress") AND
        ReportedAt BETWEEN Start Date AND End Date
    SET KPI.OpenIssues = Query Result
    
    // 3. Resolved Issues
    QUERY COUNT(*) FROM Tickets WHERE
        Status IN ("Fixed", "Closed") AND
        ResolvedAt BETWEEN Start Date AND End Date
    SET KPI.ResolvedIssues = Query Result
    
    // 4. Average Resolution Time
    QUERY AVG(ActualResolutionTime) FROM Tickets WHERE
        Status = "Fixed" OR Status = "Closed" AND
        ResolvedAt BETWEEN Start Date AND End Date
    SET KPI.AvgResolutionTime = Query Result
    CONVERT to Hours or Days
    
    // 5. Completion Rate
    CALCULATE Completion Rate = (ResolvedIssues / TotalTickets) * 100
    SET KPI.CompletionRate = Completion Rate + "%"
    
    // 6. On-Time Completion Rate
    QUERY COUNT(*) FROM Tickets WHERE
        CompletedOnTime = TRUE AND
        ResolvedAt BETWEEN Start Date AND End Date
    SET On Time Count = Query Result
    CALCULATE On Time Rate = (On Time Count / ResolvedIssues) * 100
    SET KPI.OnTimeCompletionRate = On Time Rate + "%"
ENDIF

IF Report Type = "Maintenance Trends" OR Report Type = "Summary" THEN
    // === TREND ANALYSIS ===
    
    // Tickets by Category
    QUERY Category, COUNT(*) as Count FROM Tickets
    WHERE ReportedAt BETWEEN Start Date AND End Date
    GROUP BY Category
    ORDER BY Count DESC
    SET Trends.ByCategory = Query Results
    
    // Tickets by Priority
    QUERY Priority, COUNT(*) as Count FROM Tickets
    WHERE ReportedAt BETWEEN Start Date AND End Date
    GROUP BY Priority
    SET Trends.ByPriority = Query Results
    
    // Tickets Over Time (Daily/Weekly/Monthly)
    DETERMINE Time Granularity based on Date Range
    IF Date Range <= 7 days THEN
        SET Granularity = "Daily"
    ELSIF Date Range <= 90 days THEN
        SET Granularity = "Weekly"
    ELSE
        SET Granularity = "Monthly"
    ENDIF
    
    QUERY Date, COUNT(*) as Count FROM Tickets
    WHERE ReportedAt BETWEEN Start Date AND End Date
    GROUP BY Date (Grouped by Granularity)
    ORDER BY Date ASC
    SET Trends.TicketsOverTime = Query Results
    
    // Recurring Issue Patterns
    QUERY Category, LocationID, COUNT(*) as Frequency FROM Tickets
    WHERE ReportedAt BETWEEN Start Date AND End Date
    GROUP BY Category, LocationID
    HAVING Frequency >= 3
    ORDER BY Frequency DESC
    SET Trends.RecurringIssues = Query Results
ENDIF

IF Report Type = "Frequently Reported Areas" OR Report Type = "Summary" THEN
    // === LOCATION ANALYSIS ===
    
    QUERY 
        L.LocationID,
        L.BuildingName,
        L.Zone,
        COUNT(T.TicketID) as IssueCount,
        AVG(T.ActualResolutionTime) as AvgResolutionTime
    FROM Tickets T
    JOIN Locations L ON T.LocationID = L.LocationID
    WHERE T.ReportedAt BETWEEN Start Date AND End Date
    GROUP BY L.LocationID
    ORDER BY IssueCount DESC
    LIMIT 10
    
    SET LocationData.TopLocations = Query Results
    
    // Generate Heat Map Data
    QUERY LocationID, GeoCoordinates, COUNT(*) as Density
    FROM Tickets T
    JOIN Locations L ON T.LocationID = L.LocationID
    WHERE ReportedAt BETWEEN Start Date AND End Date
    GROUP BY LocationID
    
    SET LocationData.HeatMapData = Query Results (for FR-21.5)
ENDIF

IF Report Type = "Equipment Performance" OR Report Type = "Summary" THEN
    // === EQUIPMENT ANALYSIS ===
    
    QUERY 
        EquipmentID,
        EquipmentType,
        COUNT(*) as MaintenanceFrequency,
        AVG(ActualResolutionTime) as AvgRepairTime,
        SUM(TotalCost) as TotalMaintenanceCost
    FROM Maintenance_History
    WHERE CompletionDate BETWEEN Start Date AND End Date
    AND EquipmentID IS NOT NULL
    GROUP BY EquipmentID
    ORDER BY MaintenanceFrequency DESC
    
    SET EquipmentData = Query Results
    
    // Calculate MTBF for Equipment
    FOR EACH Equipment DO
        QUERY Previous Maintenance Dates for Equipment
        CALCULATE Average Time Between Failures
        SET Equipment.MTBF = Calculated MTBF
    ENDFOR
ENDIF

IF Report Type = "Technician Performance" OR Report Type = "Summary" THEN
    // === TECHNICIAN ANALYSIS ===
    
    QUERY 
        T.TechnicianID,
        U.FullName,
        COUNT(CASE WHEN T.Status IN ('Fixed','Closed') THEN 1 END) as CompletedTasks,
        COUNT(CASE WHEN T.Status IN ('Assigned','In Progress') THEN 1 END) as ActiveTasks,
        AVG(T.ActualResolutionTime) as AvgResolutionTime,
        AVG(CASE WHEN T.CompletedOnTime = TRUE THEN 1.0 ELSE 0.0 END) * 100 as OnTimeRate,
        Technician.CustomerSatisfactionRating
    FROM Tickets T
    JOIN Users U ON T.TechnicianID = U.UserID
    JOIN Technician ON U.UserID = Technician.UserID
    WHERE T.AssignedAt BETWEEN Start Date AND End Date
    GROUP BY T.TechnicianID
    ORDER BY CompletedTasks DESC
    
    SET TechnicianData.Performance = Query Results
    
    // Workload Distribution
    QUERY TechnicianID, COUNT(*) as CurrentWorkload
    FROM Tickets
    WHERE Status IN ('Assigned', 'In Progress')
    GROUP BY TechnicianID
    
    SET TechnicianData.WorkloadDistribution = Query Results
ENDIF

IF Report Type = "Cost Analysis" OR Report Type = "Summary" THEN
    // === COST ANALYSIS ===
    
    QUERY 
        SUM(PartsOrderPrice) as TotalPartsCost,
        SUM(LaborCost) as TotalLaborCost,
        SUM(TotalCost) as TotalMaintenanceCost
    FROM Maintenance_History
    WHERE CompletionDate BETWEEN Start Date AND End Date
    
    SET CostData.Summary = Query Results
    
    // Cost by Category
    QUERY Category, SUM(TotalCost) as TotalCost
    FROM Maintenance_History
    WHERE CompletionDate BETWEEN Start Date AND End Date
    GROUP BY Category
    ORDER BY TotalCost DESC
    
    SET CostData.ByCategory = Query Results
    
    // Cost Trend Over Time
    QUERY 
        DATE(CompletionDate) as Date,
        SUM(TotalCost) as DailyCost
    FROM Maintenance_History
    WHERE CompletionDate BETWEEN Start Date AND End Date
    GROUP BY DATE(CompletionDate)
    ORDER BY Date ASC
    
    SET CostData.Trend = Query Results
ENDIF

// ============================================
// GENERATE VISUALIZATIONS
// ============================================

CREATE Chart Data Objects

// 1. Tickets by Status Pie Chart
PREPARE Pie Chart Data
    Labels: ["Open", "In Progress", "Fixed", "Closed"]
    Values: [Count for Each Status]
    Colors: [Status-specific colors]

// 2. Tickets Over Time Line Chart
PREPARE Line Chart Data
    X-Axis: Dates
    Y-Axis: Ticket Count
    Data: Trends.TicketsOverTime

// 3. Category Distribution Bar Chart
PREPARE Bar Chart Data
    X-Axis: Categories
    Y-Axis: Count
    Data: Trends.ByCategory

// 4. Technician Performance Comparison
PREPARE Multi-Bar Chart Data
    X-Axis: Technician Names
    Y-Axis: Metrics
    Series 1: Completed Tasks
    Series 2: Active Tasks
    Data: TechnicianData.Performance

// 5. Location Heat Map
PREPARE Heat Map Data
    Coordinates: Location.GeoCoordinates
    Intensity: Issue Density
    Data: LocationData.HeatMapData

// ============================================
// STORE REPORT
// ============================================

GENERATE Report ID
CREATE Report Record
    ReportID = Generated ID
    ReportType = Report Type
    GeneratedBy = Administrator.UserID
    GeneratedAt = CURRENT_DATETIME
    DateRange = {Start Date, End Date}
    Filters = Applied Filters
    KPIs = KPI Data Object
    Trends = Trends Data Object
    LocationData = Location Data Object
    EquipmentData = Equipment Data Object
    TechnicianData = Technician Data Object
    CostData = Cost Data Object
    Charts = Chart Data Objects

WRITE Report to Reports & Analytics (D4)

LOG "Report " + Report ID + " generated by " + Administrator.Name

// Return Report for Display
RETURN Report Data Object

END Process
```

*Refer to:*
- FR-26 (Analytics and Reporting)
- Table 85-87: Data Flow 35-37 Details

#pagebreak()

*Decision Tree:*

#figure(
  image(
    "../../assets/chapter4/dt5.png",
    height:85%
  ),
  caption: [Decision Tree 4.3]
)

*Unresolved Issues:* None




*Number:* 4.4  
*Name:* Provide Analytics Dashboard / Export  
*Description:* Displays analytics dashboards to administrators and allows exporting reports in PDF, Excel, or CSV formats.

*Input Data Flow:*
- Analytics View/Export Request (from Administrator)
  - Report ID (optional, for existing reports)
  - Export Format (PDF/Excel/CSV)

*Output Data Flow:*
- Analytics Dashboard / Exported Report (to Administrator)

*Type of Process:*
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `provideAnalyticsDashboard()`

*Process Logic (Structured English):*

```
BEGIN Process 4.4: Provide Analytics Dashboard / Export

VERIFY User is Administrator
IF User Role ≠ "Administrator" THEN
    DISPLAY "Unauthorized access"
    EXIT Process
ENDIF

READ Request Type (View Dashboard OR Export Report)

// ============================================
// VIEW ANALYTICS DASHBOARD
// ============================================
IF Request Type = "View Dashboard" THEN
    // Check for existing recent report
    QUERY Most Recent Report from Reports & Analytics (D4)
    WHERE GeneratedBy = Administrator.UserID
    AND GeneratedAt >= (CURRENT_DATE - 1 day)
    
    IF Recent Report Exists THEN
        RETRIEVE Report Data from D4
    ELSE
        // Generate new report
        TRIGGER Process 4.3 (Generate Reports & Metrics)
        WITH Report Type = "Summary"
        WAIT for Report Generation
        RETRIEVE Generated Report Data
    ENDIF
    
    // Render Dashboard
    DISPLAY Dashboard Header
        Title: "Maintenance Analytics Dashboard"
        Date Range: Report.DateRange
        Last Updated: Report.GeneratedAt
    
    // Display KPIs in Cards
    DISPLAY KPI Cards Grid
        Card 1: Total Tickets (KPI.TotalTickets)
        Card 2: Open Issues (KPI.OpenIssues) - Red Badge
        Card 3: Resolved Issues (KPI.ResolvedIssues) - Green Badge
        Card 4: Avg Resolution Time (KPI.AvgResolutionTime)
        Card 5: Completion Rate (KPI.CompletionRate)
        Card 6: On-Time Rate (KPI.OnTimeCompletionRate)
    
    // Display Charts
    RENDER Chart Section "Tickets Overview"
        Pie Chart: Tickets by Status
        Line Chart: Tickets Over Time
        Bar Chart: Tickets by Category
    
    RENDER Chart Section "Location Analysis"
        Heat Map: Issue Density by Location
        Top 10 Locations Table: Most Reported Areas
    
    RENDER Chart Section "Technician Performance"
        Multi-Bar Chart: Completed vs Active Tasks
        Table: Detailed Technician Metrics
        Workload Distribution Pie Chart
    
    RENDER Chart Section "Cost Analysis"
        Line Chart: Cost Trend Over Time
        Pie Chart: Cost by Category
        Summary Cards: Total Costs
    
    RENDER Chart Section "Equipment Performance"
        Table: Equipment Maintenance Frequency
        Bar Chart: MTBF by Equipment Type
    
    // Provide Dashboard Actions
    DISPLAY Action Buttons
        "Refresh Data"
        "Export Report"
        "Customize Filters"
        "Schedule Automated Report"
    
    // Enable Drill-Down
    FOR EACH Interactive Chart Element DO
        ON CLICK Event DO
            SHOW Detailed View
            ALLOW Filtering by Clicked Element
        ENDDO
    ENDFOR
ENDIF

// ============================================
// EXPORT REPORT
// ============================================
IF Request Type = "Export Report" THEN
    READ Export Format and Report ID from Administrator
    
    RETRIEVE Report Data from Reports & Analytics (D4)
    IF Report Not Found THEN
        DISPLAY "Report not found. Please generate a report first."
        EXIT Process
    ENDIF
    
    VALIDATE Export Format
    IF Export Format NOT IN ("PDF", "Excel", "CSV") THEN
        DISPLAY "Invalid export format. Supported: PDF, Excel, CSV"
        EXIT Process
    ENDIF
    
    // === EXPORT TO PDF ===
    IF Export Format = "PDF" THEN
        CREATE PDF Document using iText Library
        
        // Add Header
        ADD Company Logo (if available)
        ADD Title "SALLEHA Maintenance Report"
        ADD Date Range
        ADD Generated By: Administrator.Name
        ADD Generated At: Report.GeneratedAt
        ADD Page Numbers
        
        // Add Executive Summary Section
        ADD Section "Executive Summary"
        ADD KPIs Table
            Row: Total Tickets | KPI.TotalTickets
            Row: Open Issues | KPI.OpenIssues
            Row: Resolved Issues | KPI.ResolvedIssues
            Row: Avg Resolution Time | KPI.AvgResolutionTime
            Row: Completion Rate | KPI.CompletionRate
        
        // Add Charts as Images
        ADD Section "Maintenance Trends"
        CONVERT Chart to Image (PNG)
        EMBED Chart Images in PDF
        
        ADD Section "Location Analysis"
        ADD Top Locations Table
        EMBED Heat Map Image
        
        ADD Section "Technician Performance"
        ADD Technician Performance Table
        EMBED Performance Charts
        
        ADD Section "Equipment Analysis"
        ADD Equipment Table with MTBF
        
        ADD Section "Cost Analysis"
        ADD Cost Summary Table
        ADD Cost Breakdown by Category
        
        // Add Footer
        ADD Disclaimer: "Generated by SALLEHA Maintenance System"
        ADD Contact Information
        
        SET Filename = "SALLEHA_Report_" + Report.DateRange + "_" + TIMESTAMP + ".pdf"
        SAVE PDF File
    ENDIF
    
    // === EXPORT TO EXCEL ===
    IF Export Format = "Excel" THEN
        CREATE Excel Workbook using Apache POI
        
        // Sheet 1: Summary
        CREATE Sheet "Summary"
        ADD Title Row
        ADD KPIs Table with Formatting
            - Bold Headers
            - Color-coded Cells based on Values
            - Conditional Formatting
        ADD Charts (Excel Native Charts)
        
        // Sheet 2: Tickets Data
        CREATE Sheet "Tickets Detail"
        ADD Headers: TicketID, Title, Category, Location, Status, Priority, ReportedAt, ResolvedAt, ResolutionTime
        QUERY All Tickets in Date Range
        FOR EACH Ticket DO
            ADD Row with Ticket Data
        ENDFOR
        APPLY AutoFilter
        FREEZE Top Row
        
        // Sheet 3: Location Analysis
        CREATE Sheet "Locations"
        ADD Location Statistics Table
        ADD Formulas for Calculations
        
        // Sheet 4: Technician Performance
        CREATE Sheet "Technicians"
        ADD Technician Performance Table
        ADD Formulas for Metrics
        ADD Charts
        
        // Sheet 5: Cost Analysis
        CREATE Sheet "Costs"
        ADD Cost Breakdown Table
        ADD SUM Formulas
        ADD Cost Charts
        
        // Sheet 6: Raw Data (for pivot tables)
        CREATE Sheet "Raw Data"
        ADD Complete Dataset
        ENABLE Pivot Table Creation
        
        SET Filename = "SALLEHA_Report_" + Report.DateRange + "_" + TIMESTAMP + ".xlsx"
        SAVE Excel File
    ENDIF
    
    // === EXPORT TO CSV ===
    IF Export Format = "CSV" THEN
        CREATE CSV File
        
        // Determine CSV Content based on Report Type
        IF Administrator Selects "All Data" THEN
            // Export comprehensive dataset
            ADD CSV Headers
                TicketID, Title, Description, Category, Location, Priority, Status,
                RequesterID, TechnicianID, TechnicianName, ReportedAt, AssignedAt,
                ResolvedAt, ActualResolutionTime, PartsUsed, LaborHours, TotalCost,
                CompletedOnTime, EvidenceID
            
            QUERY All Tickets in Date Range
            JOIN with Related Tables
            FOR EACH Ticket DO
                ADD Row with All Fields
                ESCAPE Commas and Quotes in Text Fields
            ENDFOR
        ELSIF Administrator Selects "Summary Only" THEN
            // Export aggregated data
            ADD CSV Headers
                Metric, Value
            
            ADD Rows
                "Total Tickets", KPI.TotalTickets
                "Open Issues", KPI.OpenIssues
                "Resolved Issues", KPI.ResolvedIssues
                ...
        ENDIF
        
        SET Filename = "SALLEHA_Report_" + Report.DateRange + "_" + TIMESTAMP + ".csv"
        SAVE CSV File
    ENDIF
    
    // Store Export History
    CREATE Export Record
        ReportID = Report.ReportID
        ExportedBy = Administrator.UserID
        ExportedAt = CURRENT_DATETIME
        ExportFormat = Export Format
        Filename = Filename
    
    WRITE to Export History Table
    
    // Provide Download
    GENERATE Download Link
    SET Download Expiration = CURRENT_DATETIME + 24 hours
    
    DISPLAY "Report exported successfully"
    DISPLAY "Format: " + Export Format
    DISPLAY "Filename: " + Filename
    PROVIDE Download Button
    
    LOG "Report " + Report.ReportID + " exported by " + Administrator.Name + " as " + Export Format
ENDIF

END Process
```

*Refer to:*
- FR-27 (Report Export Functionality)
- Table 88-90: Data Flow 38-40 Details

*Decision Table:*


#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Request = View Dashboard], [Y], [N], [N], [N], [N],
    [Request = Export], [N], [Y], [Y], [Y], [N],
    [Recent Report Exists], [Y], [-], [-], [-], [-],
    [Export Format = PDF], [-], [Y], [N], [N], [-],
    [Export Format = Excel], [-], [N], [Y], [N], [-],
    [Export Format = CSV], [-], [N], [N], [Y], [-],
    [Retrieve Existing Report], [X], [-], [-], [-], [-],
    [Generate New Report], [-], [X], [X], [X], [-],
    [Render Dashboard], [X], [-], [-], [-], [-],
    [Export as PDF], [-], [X], [-], [-], [-],
    [Export as Excel], [-], [-], [X], [-], [-],
    [Export as CSV], [-], [-], [-], [X], [-],
    [Provide Download Link], [-], [X], [X], [X], [-],
    [Display Error], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None

#pagebreak()


=== Fragment 5: Notification Management Processes


*Number:* 5.1 \
*Name:* Receive Trigger \
*Description:* Receives and validates notification triggers from various system processes (ticket creation, status changes, assignments, etc.) and prepares them for notification generation.

*Input Data Flow:*
- Notification triggers from various processes (2.1, 2.3, 2.4, 3.2, 4.1)
  - Event Type
  - TicketID
  - Affected UserIDs
  - Priority Level
  - Timestamp

*Output Data Flow:*
- Notification Trigger Details (to Process 5.2)

*Type of Process:* \
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `receiveTrigger()`

*Process Logic (Structured English):*

```
BEGIN Process 5.1: Receive Trigger

READ Trigger Event from Source Process
    Event Type, TicketID, Affected UserIDs, Additional Data

VALIDATE Trigger Data
IF Event Type is NULL OR TicketID is NULL THEN
    LOG "Invalid trigger received"
    EXIT Process
ENDIF

// Determine affected users based on event type
INITIALIZE Recipients List

IF Event Type = "Ticket Created" THEN
    ADD All Active Administrators to Recipients
ELSIF Event Type = "Status Changed" THEN
    RETRIEVE Ticket from Tickets Database (D2)
    ADD Ticket.RequesterID to Recipients
    IF Ticket.TechnicianID ≠ NULL THEN
        ADD Ticket.TechnicianID to Recipients
    ENDIF
ELSIF Event Type = "Ticket Assigned" THEN
    RETRIEVE Ticket from Tickets Database (D2)
    ADD Ticket.TechnicianID to Recipients
    ADD Ticket.RequesterID to Recipients
ELSIF Event Type = "Priority Changed" THEN
    RETRIEVE Ticket from Tickets Database (D2)
    IF Ticket.TechnicianID ≠ NULL THEN
        ADD Ticket.TechnicianID to Recipients
    ENDIF
    ADD All Active Administrators to Recipients
ELSIF Event Type = "Comment Added" THEN
    RETRIEVE Ticket from Tickets Database (D2)
    ADD Ticket.RequesterID to Recipients
    IF Ticket.TechnicianID ≠ NULL THEN
        ADD Ticket.TechnicianID to Recipients
    ENDIF
ELSIF Event Type = "Evidence Uploaded" THEN
    RETRIEVE Ticket from Tickets Database (D2)
    ADD Ticket.RequesterID to Recipients
    ADD All Active Administrators to Recipients
ELSIF Event Type = "Ticket Overdue" THEN
    ADD All Active Administrators to Recipients
    RETRIEVE Ticket from Tickets Database (D2)
    IF Ticket.TechnicianID ≠ NULL THEN
        ADD Ticket.TechnicianID to Recipients
    ENDIF
ENDIF

// Remove duplicate user IDs
REMOVE Duplicates from Recipients List

// Determine notification priority
IF Event Type IN ("Ticket Overdue", "Emergency Ticket", "Account Locked") THEN
    SET Priority Level = "High"
ELSIF Event Type IN ("Status Changed", "Priority Changed", "Ticket Assigned") THEN
    SET Priority Level = "Medium"
ELSE
    SET Priority Level = "Low"
ENDIF

// Create trigger details object
CREATE Trigger Details Object
    TriggerID = GENERATE UUID
    EventType = Event Type
    TicketID = TicketID
    Recipients = Recipients List
    PriorityLevel = Priority Level
    Timestamp = CURRENT_DATETIME
    AdditionalData = Additional Data

LOG "Notification trigger received: " + Event Type + " for Ticket " + TicketID

// Pass to notification preparation
TRIGGER Process 5.2 (Prepare Notification)
    Pass Trigger Details Object

END Process
```

*Refer to:*
- Table 91: Data Flow 41 Details
- Figure 44: DFD Level 1-Fragment 5

*Decision Table:*

#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*],
    [Event Type Valid], [Y], [Y], [Y], [Y], [N],
    [TicketID Provided], [Y], [Y], [Y], [N], [-],
    [Event = Ticket Created], [Y], [N], [N], [-], [-],
    [Event = Status Changed], [N], [Y], [N], [-], [-],
    [Event = Ticket Assigned], [N], [N], [Y], [-], [-],
    [Identify Recipients], [X], [X], [X], [-], [-],
    [Set Priority Level], [X], [X], [X], [-], [-],
    [Create Trigger Object], [X], [X], [X], [-], [-],
    [Pass to Process 5.2], [X], [X], [X], [-], [-],
    [Display "Invalid TicketID"], [-], [-], [-], [X], [-],
    [Display "Invalid Event Type"], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None


*Number:* 5.2 \
*Name:* Prepare Notification \
*Description:* Retrieves ticket details and user contact information, constructs personalized notification messages, and determines delivery methods based on user preferences.

*Input Data Flow:*
- Notification Trigger Details (from Process 5.1)
- Ticket Details (from Tickets Database D2)
- User Contact Information (from User Database D1)

*Output Data Flow:*
- Prepared Notification Message (to Process 5.3)

*Type of Process:* \
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `prepareNotification()`

*Process Logic (Structured English):*

```
BEGIN Process 5.2: Prepare Notification

READ Trigger Details from Process 5.1
    TriggerID, EventType, TicketID, Recipients, PriorityLevel, Timestamp

// Retrieve ticket information
QUERY Tickets Database (D2) WHERE TicketID = Input TicketID
IF Ticket Not Found THEN
    LOG "Ticket not found for notification: " + TicketID
    EXIT Process
ENDIF

RETRIEVE Ticket Details
    Title, Category, Status, Priority, Location, RequesterID, TechnicianID

// Retrieve location details for context
IF Ticket.LocationID ≠ NULL THEN
    QUERY Locations Database WHERE LocationID = Ticket.LocationID
    SET Location Details = BuildingName + " - " + RoomNumber
ELSE
    SET Location Details = "Unspecified"
ENDIF

// Process notifications for each recipient
FOR EACH RecipientID in Recipients List DO

    // Retrieve recipient information
    QUERY User Database (D1) WHERE UserID = RecipientID
    IF User Not Found THEN
        LOG "User not found: " + RecipientID
        CONTINUE to Next Recipient
    ENDIF
    
    RETRIEVE User Details
        FullName, Email, PhoneNumber, Role
    
    // Retrieve notification preferences
    QUERY Notification Preferences WHERE UserID = RecipientID
    IF Preferences Not Found THEN
        // Use default preferences
        SET InAppEnabled = TRUE
        SET EmailEnabled = TRUE
        SET SMSEnabled = FALSE
        SET PushEnabled = TRUE
    ELSE
        RETRIEVE Preferences
            InAppEnabled, EmailEnabled, SMSEnabled, PushEnabled,
            DoNotDisturbStart, DoNotDisturbEnd
    ENDIF
    
    // Check Do Not Disturb settings
    SET Current Time = CURRENT_TIME
    IF DoNotDisturbStart ≠ NULL AND DoNotDisturbEnd ≠ NULL THEN
        IF Current Time BETWEEN DoNotDisturbStart AND DoNotDisturbEnd THEN
            IF PriorityLevel ≠ "High" THEN
                LOG "User " + RecipientID + " in Do Not Disturb mode"
                QUEUE Notification for Later Delivery
                CONTINUE to Next Recipient
            ENDIF
        ENDIF
    ENDIF
    
    // Build notification message based on event type and user role
    INITIALIZE Message = ""
    INITIALIZE Subject = ""
    
    IF EventType = "Ticket Created" THEN
        SET Subject = "New Maintenance Ticket Created"
        SET Message = "A new maintenance ticket has been submitted."
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "Title: " + Ticket.Title + "\n" +
                     "Category: " + Ticket.Category + "\n" +
                     "Location: " + Location Details + "\n" +
                     "Priority: " + Ticket.Priority
    
    ELSIF EventType = "Status Changed" THEN
        SET Subject = "Ticket Status Updated"
        IF User.Role = "Resident" THEN
            SET Message = "Your maintenance ticket status has been updated to: " + 
                         Ticket.Status
        ELSE
            SET Message = "Ticket " + TicketID + " status changed to: " + Ticket.Status
        ENDIF
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "New Status: " + Ticket.Status + "\n" +
                     "Location: " + Location Details
    
    ELSIF EventType = "Ticket Assigned" THEN
        SET Subject = "New Task Assigned"
        IF User.Role = "Technician" THEN
            SET Message = "A new maintenance task has been assigned to you."
            SET Details = "Ticket ID: " + TicketID + "\n" +
                         "Title: " + Ticket.Title + "\n" +
                         "Category: " + Ticket.Category + "\n" +
                         "Priority: " + Ticket.Priority + "\n" +
                         "Location: " + Location Details
        ELSE
            SET Message = "Your ticket has been assigned to a technician."
            SET Details = "Ticket ID: " + TicketID
        ENDIF
    
    ELSIF EventType = "Priority Changed" THEN
        SET Subject = "Ticket Priority Updated"
        SET Message = "The priority of ticket " + TicketID + 
                     " has been changed to: " + Ticket.Priority
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "New Priority: " + Ticket.Priority + "\n" +
                     "Location: " + Location Details
    
    ELSIF EventType = "Comment Added" THEN
        SET Subject = "New Comment on Your Ticket"
        SET Message = "A new comment has been added to your maintenance ticket."
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "Status: " + Ticket.Status
    
    ELSIF EventType = "Evidence Uploaded" THEN
        SET Subject = "Maintenance Evidence Submitted"
        IF User.Role = "Resident" THEN
            SET Message = "The technician has uploaded completion evidence for your ticket."
        ELSE
            SET Message = "Completion evidence has been uploaded for ticket " + TicketID
        ENDIF
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "Please review the evidence."
    
    ELSIF EventType = "Ticket Overdue" THEN
        SET Subject = "URGENT: Ticket Overdue"
        SET Message = "Ticket " + TicketID + " is overdue and requires immediate attention."
        SET Details = "Ticket ID: " + TicketID + "\n" +
                     "Category: " + Ticket.Category + "\n" +
                     "Priority: " + Ticket.Priority + "\n" +
                     "Location: " + Location Details
    ENDIF
    
    // Determine notification type for database
    IF EventType = "Ticket Created" OR EventType = "Ticket Overdue" THEN
        SET NotificationType = "Alert"
    ELSIF EventType = "Ticket Assigned" THEN
        SET NotificationType = "Assignment"
    ELSIF EventType = "Priority Changed" THEN
        SET NotificationType = "PriorityChange"
    ELSE
        SET NotificationType = "StatusChange"
    ENDIF
    
    // Check for notification grouping (last 10 minutes)
    QUERY Notifications Database WHERE
        UserID = RecipientID AND
        RelatedTicketID = TicketID AND
        NotificationType = NotificationType AND
        CreatedAt >= (CURRENT_DATETIME - 10 minutes) AND
        IsRead = FALSE
    
    IF Similar Unread Notification Exists THEN
        // Update existing notification instead of creating new
        SET GroupedNotification = TRUE
        UPDATE Existing Notification
            Message = "Multiple updates for ticket " + TicketID
            UpdatedAt = CURRENT_DATETIME
    ELSE
        SET GroupedNotification = FALSE
    ENDIF
    
    // Generate notification ID
    GENERATE NotificationID
    
    // Create prepared notification object
    CREATE Prepared Notification
        NotificationID = NotificationID
        UserID = RecipientID
        UserName = User.FullName
        UserEmail = User.Email
        UserPhone = User.PhoneNumber
        UserRole = User.Role
        RelatedTicketID = TicketID
        NotificationType = NotificationType
        Subject = Subject
        Message = Message
        Details = Details
        PriorityLevel = PriorityLevel
        DeliveryMethods = {
            InApp: InAppEnabled,
            Email: EmailEnabled,
            SMS: SMSEnabled,
            Push: PushEnabled
        }
        IsGrouped = GroupedNotification
        CreatedAt = CURRENT_DATETIME
        ExpirationDate = CURRENT_DATETIME + 90 days
    
    LOG "Notification prepared for User " + RecipientID + " - " + EventType
    
    // Send to delivery process
    TRIGGER Process 5.3 (Send Notification)
        Pass Prepared Notification Object

ENDFOR

END Process
```

*Refer to:*
- Table 92-96: Data Flow 42-46 Details
- FR-10 (Status Change Notifications)
- FR-18 (Technician Notifications)
- FR-25 (Administrator Notifications)

*Decision Table:*

#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [Ticket Found], [Y], [Y], [Y], [Y], [Y], [N],
    [User Found], [Y], [Y], [Y], [Y], [N], [-],
    [In DND Mode], [Y], [Y], [N], [N], [-], [-],
    [Priority = High], [Y], [N], [-], [-], [-], [-],
    [Recent Similar Notification], [-], [-], [Y], [N], [-], [-],
    [Retrieve Preferences], [X], [X], [X], [X], [-], [-],
    [Build Message], [X], [X], [X], [X], [-], [-],
    [Override DND], [X], [-], [-], [-], [-], [-],
    [Queue for Later], [-], [X], [-], [-], [-], [-],
    [Group Notification], [-], [-], [X], [-], [-], [-],
    [Create New Notification], [X], [-], [-], [X], [-], [-],
    [Send to Process 5.3], [X], [-], [X], [X], [-], [-],
    [Log "User Not Found"], [-], [-], [-], [-], [X], [-],
    [Log "Ticket Not Found"], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None


*Number:* 5.3 \
*Name:* Send Notification \
*Description:* Delivers notifications to users through multiple channels (in-app, email, SMS, push notifications) based on user preferences and priority levels.

*Input Data Flow:*
- Prepared Notification Message (from Process 5.2)

*Output Data Flow:*
- Notification (to Resident/Technician/Administrator)
- Stored Notification Record (to Notifications Database)

*Type of Process:* \
☑ Online  ☐ Batch  ☐ Manual

*Subprogram/Function Name:* `sendNotification()`

*Process Logic (Structured English):*

```
BEGIN Process 5.3: Send Notification

READ Prepared Notification from Process 5.2
    NotificationID, UserID, UserName, UserEmail, UserPhone, UserRole,
    RelatedTicketID, NotificationType, Subject, Message, Details,
    PriorityLevel, DeliveryMethods, IsGrouped, CreatedAt, ExpirationDate

// Store notification in database first
CREATE Notification Record
    NotificationID = NotificationID
    UserID = UserID
    RelatedTicketID = RelatedTicketID
    NotificationType = NotificationType
    Message = Message
    IsRead = FALSE
    DeliveryMethod = "multi-channel"
    PriorityLevel = PriorityLevel
    ExpirationDate = ExpirationDate
    CreatedAt = CreatedAt

WRITE Notification Record to Notifications Database

LOG "Notification " + NotificationID + " stored for User " + UserID

// Track delivery status for each channel
INITIALIZE Delivery Status = {
    InApp: FALSE,
    Email: FALSE,
    SMS: FALSE,
    Push: FALSE
}

// ============================================
// CHANNEL 1: IN-APP NOTIFICATION
// ============================================

IF DeliveryMethods.InApp = TRUE THEN
    TRY
        // Check if user has active session
        QUERY Active Sessions WHERE UserID = UserID
        
        IF Active Session Exists THEN
            // Send via WebSocket
            CREATE WebSocket Payload
                type: "notification"
                notificationID: NotificationID
                ticketID: RelatedTicketID
                subject: Subject
                message: Message
                priority: PriorityLevel
                timestamp: CreatedAt
            
            SEND WebSocket Message to User Session
            
            // Update notification badge count
            INCREMENT User.NotificationBadgeCount
            SEND Badge Update via WebSocket
            
            // Play sound for high priority
            IF PriorityLevel = "High" THEN
                SEND Sound Trigger "urgent.mp3"
            ELSE
                SEND Sound Trigger "notification.mp3"
            ENDIF
            
            SET Delivery Status.InApp = TRUE
            LOG "In-app notification sent to User " + UserID
        ELSE
            LOG "No active session for User " + UserID + " - notification queued"
        ENDIF
    
    CATCH Error
        LOG "In-app notification failed: " + Error.Message
        SET Delivery Status.InApp = FALSE
    ENDTRY
ENDIF

// ============================================
// CHANNEL 2: EMAIL NOTIFICATION
// ============================================

IF DeliveryMethods.Email = TRUE THEN
    IF UserEmail ≠ NULL AND UserEmail ≠ "" THEN
        TRY
            // Build HTML email template
            CREATE Email Content
                To: UserEmail
                Subject: "[SALLEHA] " + Subject
                
                Body (HTML):
                    <html>
                    <body style="font-family: Arial, sans-serif;">
                        <div style="background: #f5f5f5; padding: 20px;">
                            <div style="background: white; padding: 20px; border-radius: 8px;">
                                <h2 style="color: #333;">Hello, {UserName}</h2>
                                <p>{Message}</p>
                                <div style="background: #f9f9f9; padding: 15px; margin: 15px 0;">
                                    <pre style="margin: 0;">{Details}</pre>
                                </div>
                                <a href="https://salleha.system.com/tickets/{RelatedTicketID}" 
                                   style="display: inline-block; background: #007bff; 
                                          color: white; padding: 10px 20px; 
                                          text-decoration: none; border-radius: 5px;">
                                    View Ticket
                                </a>
                                <hr style="margin: 20px 0;">
                                <p style="font-size: 12px; color: #666;">
                                    You are receiving this notification because you have 
                                    email notifications enabled. 
                                    <a href="https://salleha.system.com/preferences">
                                        Manage your notification preferences
                                    </a>
                                </p>
                            </div>
                        </div>
                    </body>
                    </html>
            
            // Send email via Nodemailer
            SEND Email via SMTP
                Service: Gmail SMTP / SendGrid / AWS SES
                From: "SALLEHA System <no-reply@salleha.system.com>"
                
            SET Delivery Status.Email = TRUE
            LOG "Email sent to " + UserEmail
            
        CATCH Error
            LOG "Email delivery failed: " + Error.Message
            SET Delivery Status.Email = FALSE
        ENDTRY
    ELSE
        LOG "No email address for User " + UserID
    ENDIF
ENDIF

// ============================================
// CHANNEL 3: SMS NOTIFICATION
// ============================================

IF DeliveryMethods.SMS = TRUE THEN
    IF PriorityLevel = "High" OR PriorityLevel = "Immediate" THEN
        IF UserPhone ≠ NULL AND UserPhone ≠ "" THEN
            TRY
                // Build SMS message (max 160 characters)
                SET SMS Text = "SALLEHA ALERT: " + Message
                IF LENGTH(SMS Text) > 140 THEN
                    SET SMS Text = SUBSTRING(SMS Text, 0, 137) + "..."
                ENDIF
                
                // Add short URL
                GENERATE Short URL for Ticket
                    FullURL: "https://salleha.system.com/tickets/" + RelatedTicketID
                    ShortURL: "https://slh.tk/t/" + RelatedTicketID
                
                SET SMS Text = SMS Text + " View: " + ShortURL
                
                // Send via Twilio API
                SEND SMS via Twilio
                    To: UserPhone
                    From: Configured Twilio Number
                    Body: SMS Text
                
                SET Delivery Status.SMS = TRUE
                LOG "SMS sent to " + UserPhone
                
            CATCH Error
                LOG "SMS delivery failed: " + Error.Message
                SET Delivery Status.SMS = FALSE
            ENDTRY
        ELSE
            LOG "No phone number for User " + UserID
        ENDIF
    ELSE
        LOG "SMS only sent for high priority notifications"
    ENDIF
ENDIF

// ============================================
// CHANNEL 4: PUSH NOTIFICATION (Mobile App)
// ============================================

IF DeliveryMethods.Push = TRUE THEN
    TRY
        // Check if user has FCM token (mobile app installed)
        QUERY Firebase Tokens WHERE UserID = UserID
        
        IF FCM Token Exists THEN
            // Build push notification payload
            CREATE Push Notification
                to: User.FCMToken
                notification:
                    title: Subject
                    body: Message
                    sound: (PriorityLevel = "High" ? "urgent.mp3" : "default.mp3")
                    badge: User.NotificationBadgeCount + 1
                    icon: "ic_notification"
                    color: "#007bff"
                data:
                    type: NotificationType
                    ticketID: RelatedTicketID
                    notificationID: NotificationID
                    priority: PriorityLevel
                    deepLink: "salleha://tickets/" + RelatedTicketID
            
            // Send via Firebase Cloud Messaging
            SEND Push Notification via FCM API
            
            SET Delivery Status.Push = TRUE
            LOG "Push notification sent to User " + UserID
        ELSE
            LOG "No FCM token for User " + UserID + " - mobile app not installed"
        ENDIF
        
    CATCH Error
        LOG "Push notification failed: " + Error.Message
        SET Delivery Status.Push = FALSE
    ENDTRY
ENDIF

// ============================================
// UPDATE DELIVERY STATUS
// ============================================

// Store delivery attempts
CREATE Delivery Log Record
    NotificationID = NotificationID
    InAppDelivered = Delivery Status.InApp
    EmailDelivered = Delivery Status.Email
    SMSDelivered = Delivery Status.SMS
    PushDelivered = Delivery Status.Push
    AttemptedAt = CURRENT_DATETIME

WRITE to Delivery Log Table

// Check if at least one channel succeeded
SET Success Count = 0
IF Delivery Status.InApp = TRUE THEN INCREMENT Success Count
IF Delivery Status.Email = TRUE THEN INCREMENT Success Count
IF Delivery Status.SMS = TRUE THEN INCREMENT Success Count
IF Delivery Status.Push = TRUE THEN INCREMENT Success Count

IF Success Count = 0 THEN
    // All channels failed - queue for retry
    LOG "WARNING: All notification channels failed for " + NotificationID
    CREATE Retry Job
        NotificationID = NotificationID
        RetryAt = CURRENT_DATETIME + 5 minutes
        RetryCount = 1
    WRITE to Notification Retry Queue
ELSE
    LOG "Notification " + NotificationID + " delivered via " + Success Count + " channel(s)"
ENDIF

// Send success response
DISPLAY "Notification sent successfully"

END Process
```

*Refer to:*
- Table 97-98: Data Flow 47 Details
- FR-10 (Status Change Notifications)
- FR-18 (Technician Notifications)
- FR-25 (Administrator Notifications)

*Decision Table:*

#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    stroke: 0.5pt,
    [*Conditions*], [*Rule 1*], [*Rule 2*], [*Rule 3*], [*Rule 4*], [*Rule 5*], [*Rule 6*],
    [In-App Enabled], [Y], [Y], [Y], [N], [N], [N],
    [Email Enabled], [Y], [Y], [N], [Y], [Y], [N],
    [SMS Enabled], [Y], [N], [N], [Y], [N], [N],
    [Priority = High], [Y], [Y], [Y], [Y], [N], [-],
    [Send In-App], [X], [X], [X], [-], [-], [-],
    [Send Email], [X], [X], [-], [X], [X], [-],
    [Send SMS], [X], [-], [-], [X], [-], [-],
    [Send Push], [X], [X], [X], [X], [X], [-],
    [Store in Database], [X], [X], [X], [X], [X], [X],
    [Log Delivery], [X], [X], [X], [X], [X], [X],
    [Queue for Retry (if all fail)], [-], [-], [-], [-], [-], [X],
  )
)

*Unresolved Issues:* None


=== Summary of All Process Specifications

This document contains *20 comprehensive process specifications* covering all major system processes:

*Fragment 1: User Management* (4 Processes)
1. *1.1 User Registration* - Account creation with validation and email verification
2. *1.2 User Authentication* - Login with JWT, CAPTCHA, and session management
3. *1.3 Password Recovery* - Reset forgotten passwords with verification codes
4. *1.4 Account Management* - Profile updates and admin user management

*Fragment 2: Maintenance Requests* (5 Processes)
5. *2.1 Create Maintenance Ticket* - Submit tickets with duplicate detection
6. *2.2 View/Search Tickets* - Query and filter tickets by various criteria
7. *2.3 Update Ticket Status* - Manage ticket lifecycle and assignments
8. *2.4 Manage Comments & Evidence* - Add comments and upload completion evidence
9. *2.5 Send Notifications* - Multi-channel notification dispatcher

 *Fragment 3: Assignment & Tasks* (4 Processes)
10. *3.1 View Pending/Unassigned Tickets* - Display unassigned tickets for admins
11. *3.2 Assign Ticket & Set Priority* - Assign technicians and set priorities
12. *3.3 Notify Technician* - Send assignment notifications to technicians
13. *3.4 Update Assignment Status* - Handle accept/decline and reassignment

 *Fragment 4: Analytics & Reporting* (4 Processes)
14. *4.1 Record Maintenance Completion* - Archive completed work with metrics
15. *4.2 Update Maintenance History* - Store historical records for analysis
16. *4.3 Generate Reports & Metrics* - Compile data and calculate KPIs
17. *4.4 Provide Analytics Dashboard / Export* - Display dashboards and export reports

*Fragment 5: Notification Management* (3 Processes)
18. *5.1 Receive Trigger* - Capture notification events and identify affected users
19. *5.2 Prepare Notification* - Construct personalized messages with ticket context
20. *5.3 Send Notification* - Deliver via multiple channels (in-app, email, SMS, push)
