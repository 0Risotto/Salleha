// Orjoan
== 3.7 Non-Functional Requirements
The non-functional requirements for the Maintenance Management System are outlined in the table below. Each requirement is assigned a unique number for reference.
#figure(
  align(left)[
    #table(columns: 3, 
    [*Number*],[*Non-Functional Requirements*],[*Description*],
    [1],
    [Performance ],
    [Users must be able to submit and track maintenance requests without delays or timeouts, even during peak usage times.],

    [2],
    [Dependability],  
    [The System must operate 24/7 with minimal downtime.],

    [3],
    [Security],
    [The system must prevent unauthorized access and encrypt data such as login credentials and ticket details.],

    [4],
    [Usability],
    [The system must have a simple , user-friendly interface that is easy to understand for all users. ],

    [5],
    [Operational and Environmental Constraints],
    [The system must run in web browsers and mobile devices and require a stable internet connection ; data will be stored using a database management system.
],

    [6],
    [Maintainability and Supportability],
    [The system must be easy to maintain , and it should deal with errors and solve them when they appear in the system.]
  )
  ]
)

== 3.9 Requirements Validation and Review Summary

== How We Verified the Requirements

We verified the requirements by reviewing them with both our team and the stakeholders.

=== Team Review
All team members *(Anas, Shaima, Orjoan, Musa, and Hanen)* reviewed the requirements together.  
We went through each requirement to ensure everyone fully understood it.  
Each member provided feedback and suggestions, which were used to refine the requirements.

=== Stakeholder Review
We presented the requirements to *Dr. Hamad* for validation.  
We also gathered feedback from three classmates acting as potential users.  
We updated and improved the requirements based on their comments and suggestions.

---

== How We Confirmed the Requirements Are Correct, Clear, and Complete

We used two main methods to validate the clarity and correctness of the requirements: **Mockups** and **Walkthroughs**.

=== Method 1: Mockups

*What we did:*  
We created UI mockups using Figma.

*What we showed:*  
- User dashboard showing submitted maintenance requests  
- Technician dashboard with assigned tasks organized by priority  
- Admin panel for monitoring and managing maintenance requests  
- Notification screen showing status updates  

*How this helped:*  
- Clarified how users will report maintenance issues  
- Confirmed that role-based dashboards function correctly  
- Verified that priority assignment and task flow work as intended  

=== Method 2: Walkthroughs

*What we did:*  
We conducted a full system walkthrough during a meeting.

*How we did it:*  
We explained each feature step-by-step and demonstrated how it works for the different user roles.  
We walked through realistic scenarios such as:  
- “A student reports a broken AC.”  
- “A technician receives the notification and accepts the task.”  
- “An admin monitors all requests and reassigns urgent tasks.”  

*How this helped:*  
- Ensured everyone clearly understood the maintenance workflow  
- Confirmed that email and system notifications meet requirements  
- Verified that priority-based task assignment is correct  
- Ensured that requirements for maintenance history and analytics are complete  

