== 2.7 Assigning Team Members to Tasks 


#align(center)[
  #figure(
    table(
      columns: 2, align:left,
      [*Task ID*], [*Assigned to*],

      [T1], [Project Manager (Anas), Technical Clerk ( Orjoan)],
      [T2], [Project Manager (Anas )],
      [T3], [System Analyst (Anas ), Requirement Analyst ( Anas), Technical Clerk (  Orjoan )],
      [T4], [System Analyst (Anas ), Requirement Analyst (Anas )],
      [T5], [System Analyst (Anas ), Technical Clerk ( Orjoan  )],
      [T6], [Software Engineer ( Haneen & Shaima ), Hardware Engineer (Mosa ), Web Designer (Haneen & Shaima  )],
      [T7], [Software Engineer ( Haneen & Shaima), Database Engineer (  Mosa )],
      [T8], [Software Engineer (  Haneen & Shaima ), Database Engineer ( Mosa  ), Web Designer ( Haneen & Shaima )],
      [T9], [System Analyst ( Anas), Software Engineer ( Haneen & Shaima ), InfoSec Engineer (Ext.)],
      [T10], [Software Engineer (Haneen & Shaima )],
      [T11], [Software Engineer ( Haneen & Shaima )],
      [T12], [Software Engineer ( Haneen & Shaima )],
      [T13], [Database Engineer ( Mosa )],
      [T14], [Software Engineer ( Haneen & Shaima ), Software QA Engineer (External)],
      [T15], [Software Engineer (Haneen & Shaima )],
      [T16], [Software QA Engineer (External), System Analyst ( Anas)],
      [T17], [Software QA Engineer (External), Software Engineer ( Haneen & Shaima)],
      [T18], [Software QA Engineer (External), System Analyst (Anas )],
      [T19], [Software QA Engineer (External)],
      [T20], [System Administrator ( Mosa ), Project Manager (Anas ), Software Engineer ()],
      [T21], [System Administrator ( Mosa ), Database Engineer ( Mosa)],
      [T22], [System Administrator ( Mosa ), Software Engineer (Haneen & Shaima), InfoSec Engineer (Ext.)],
      [T23], [System Administrator (Mosa  ), Information Security Engineer (External)],
      [T24], [Project Manager ( Anas), All Key Roles]
    ),
    caption: [Task-to-Team Member Assignment]
  )
]

#pagebreak()

== 2.8 Monitoring and Controlling Mechanisms 


   Earned value management  



#align(center)[
  #figure(
    table(
      columns: 7, align:left,
      [*Phase*], [*Estimated cost*], [*Cumulative estimate*], [*Estimated duration*], [*Stage completed*], [*Actual cost of Phase to date*], [*Actual cost of project to date*],

      [Planning], [4,000 JD], [4,000 JD], [2 weeks], [80%], [1,000 JD], [1,000 JD],
      [Analysis], [6,500 JD], [10,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Design], [8,000 JD], [18,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Implementation ], [16,000 JD], [34,500 JD], [4 weeks], [0%], [Not yet begun], [Not yet begun],
      [Testing], [8,000 JD], [42,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Deployment], [5,000 JD], [47,500 JD], [1 week], [0%], [Not yet begun], [Not yet begun]
    ),
    caption: [Earned Value Management Progress Tracking]
  )
]


#strong[P = 80%]

**#strong[Planned Value (PV)]** = 4,000 JD
    
**#strong[Actual Cost (AC)]** = 1,000 JD

**#strong[Earned Value (EV)]** = 3,200 JD
#linebreak()
#linebreak()

**#strong[Cost Variance (CV)]** = 2,200 JD

 --**We have saved 2,200 JD on the planning phase
#linebreak()#linebreak()


**#strong[Schedule Variance (SV)]** = \(-800\) JD

--* *This indicates delayed progress in the planning phase.
#linebreak()#linebreak()


**#strong[Cost Performance Index (CPI)]** = \(3.2\)

--* *We are under budget. The team is spending less than planned to accomplish the work.
#linebreak()#linebreak()


**#strong[Schedule Performance Index (SPI)]** = \(0.8\)

--* *We are behind schedule. The progress is slower than expected.
#linebreak()#linebreak()


**#strong[Estimate to Complete (ETC)]** = \(13,593.75\) JD
#linebreak()#linebreak()
**#strong[Estimate at Completion (EAC)]** = 14843.75 JD


#pagebreak()
Based on information we gained from EVM analysis, we have to expedite our schedule.
#align(center)[
  #figure(
    table(
      columns: 4,
      align: left,
      [*Activity*], [*Estimated duration (days)*], [*Crash time (days)*], [*Cost/day (JD)*],
      [T1], [3], [1], [200],
      [T2], [2], [2], [200],
      [T3], [4], [2], [300],
      [T4], [3.5], [2], [400],
      [T5], [2.5], [1.5], [300],
      [T6], [1], [1], [300],
      [T7], [2], [2], [300],
      [T8], [4], [3], [300],
      [T9], [3], [2], [300],
      [T10], [4], [2], [250],
      [T11], [11], [9], [250],
      [T12], [11], [10], [400],
      [T13], [11], [10], [400],
      [T14], [4], [2], [250],
      [T15], [2], [2], [250],
      [T16], [3], [3], [300],
      [T17], [2], [2], [300],
      [T18], [2.2], [2], [300],
      [T19], [3], [2], [250],
      [T20], [0.75], [0.75], [250],
      [T21], [1.25], [1.25], [250],
      [T22], [1.5], [1.5], [300],
      [T23], [1.25], [1.25], [300],
      [T24], [0.75], [0.75], [300]
    ),
    caption: [ Time and Cost Options ]
  )
]




#align(center)[
  #figure(
    table(
      columns: 5,
      align: center,
      [*Activity chosen*], [*Expediting time (days)*], [*Cumulative time saved*], [*Cost (JD)*], [*Cumulative cost (JD)*],
      [T1], [2], [2], [400], [],
      [T10], [2], [4], [600], [],
      [T14], [1.5], [5.5], [600], [],
      [T19], [1], [6.5], [300], [],
      [T5], [1], [7.5], [300], [],
      [T9], [1], [8.5], [300], [],
      [T8], [2], [10.5], [500], [],
      [T4], [2], [12.5], [500], [],
     
    ),
    caption: [Implemented Schedule Acceleration Plan]
  )
]