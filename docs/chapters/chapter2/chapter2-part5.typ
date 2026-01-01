== Assigning Team Members to Tasks 

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
      [T20], [System Administrator ( Mosa ), Project Manager (Anas ), Software Engineer (Haneen & Shaima)],
      [T21], [System Administrator ( Mosa ), Database Engineer ( Mosa)],
      [T22], [System Administrator ( Mosa ), Software Engineer (Haneen & Shaima), InfoSec Engineer (Ext.)]
     
    ),
    caption: [Task-to-Team Member Assignment]
  )
]

#pagebreak()

== Monitoring and Controlling Mechanisms 
   Earned value management  
#show figure: set par(justify: false)
#figure(
    table(
      columns: 7, align:left,
      [*Phase*], [*Estimated cost*], [*Cumulative estimate*], [*Estimated duration*], [*Stage completed*], [*Actual cost of Phase to date*], [*Actual cost of project to date*],

      [Planning], [4,000 JD], [4,000 JD], [2 weeks], [80%], [1,000 JD], [1,000 JD],
      [Analysis], [6,500 JD], [10,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Design], [8,000 JD], [18,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Implem
      entation ], [16,000 JD], [34,500 JD], [4 weeks], [0%], [Not yet begun], [Not yet begun],
      [Testing], [8,000 JD], [42,500 JD], [2 weeks], [0%], [Not yet begun], [Not yet begun],
      [Deployment], [5,000 JD], [47,500 JD], [1 week], [0%], [Not yet begun], [Not yet begun]
    ),
    caption: [Earned Value Management Progress Tracking]
  )



- *$P = 80%$* 
- *Planned Value ($P V$) = 4,000 JD*

- *Actual Cost ($A C$) = 1,000 JD *

- *Earned Value ($E V$) = 3,200 JD*

- *Cost Variance (CV) = 2,200 JD* 
  - We have saved 2,200 JD on the planning phase

- *Schedule Variance ($S V$) = (-800) JD *
  - This indicates delayed progress in the planning phase.

- * Cost Performance Index ($C P I$)= (3.2)  *
  - We are under budget. The team is spending less than planned to accomplish the work.


- * Schedule Performance Index ($S P I$) = \(0.8\) *
  - We are behind schedule. The progress is slower than expected.

- * Estimate to Complete ($E T C$) = (13,593.75) JD *

- *Estimate at Completion ($E A C$) = 14843.75 JD*


- Based on information we gained from EVM analysis, we have to expedite our schedule.
#align(center)[
  #figure(
    table(
      columns: 4,
      align: left,
      [*Activity*], [*Estimated duration (days)*], [*Crash time (days)*], [*Cost/day (JD)*],
      [T1], [5], [3], [200],
      [T2], [4], [4], [200],
      [T3], [3], [3], [300],
      [T4], [5], [4], [450],
      [T5], [2], [2], [300],
      [T6], [5], [5], [300],
      [T7], [5], [5], [300],
      [T8], [4], [4], [300],
      [T9], [4], [4], [300],
      [T10], [5], [4], [250],
      [T11], [20], [17], [350],
      [T12], [20], [19], [400],
      [T13], [10], [18], [450],
      [T14], [3], [3], [250],
      [T15], [4], [4], [250],
      [T16], [4], [4], [300],
      [T17], [3], [2], [300],
      [T18], [1], [1], [300],
      [T19], [1], [1], [250],
      [T20], [1], [1], [250],
      [T21], [2], [1], [150],
      [T22], [2], [2], [300]
   
    ),
    caption: [ Time and Cost Options ]
  )
]



  #figure(
    table(
      columns: 7,
      align: center,
      stroke: 0.5pt,
        table.cell(rowspan: 3)[*Eligible activities*],
        table.cell( rowspan: 3)[*Activity chosen*],
        table.cell( rowspan: 2,colspan: 3)[*Time for each path (Days)*],
        table.cell( rowspan: 3)[*Cost (JD/day)*],
        table.cell(rowspan: 3)[*Cumulative cost (JD)*],


        table.cell(fill: rgb("#A6CCEB"))[*83*],
        table.cell(fill: rgb("#A6CCEB"))[*83*],
        table.cell(fill: rgb("#A6CCEB"))[*73*],
      

      [T1,T4,
      T10,T11,T12,
      T17,T21], [T21], [82], [82], [72], [150], [150],

      
       [T1,T4,
      T10,T11,T12,
      T17], [T1], [81], [81], [71], [200], [350],

      [T1,T4,
      T10,T11,T12,
      T17], [T1], [80], [80], [70], [200], [550],

      [T4,
      T10,T11,T12,
      T17], [T10], [79], [79], [69], [250], [800],

      [T4,
      ,T11,T12,
      T17], [T17], [78], [78], [68], [300], [1100],

      [T4,
      ,T11,T12,
      T17], [T17], [77], [77], [67], [300], [1400],

      [T4,
      ,T11,T12,
      ], [T11], [76], [77], [67], [350], [1750],

      [T4,
      ,T11,T12,
      ], [T11], [75], [77], [67], [350], [2100],


      [T4,
      ,T11,T12,
      ], [T11], [74], [77], [67], [350], [2450],

      [T4,
      ,T12,
      ], [T12], [74], [76], [67], [400], [2850],

      [T4
      
      ], [T4], [73], [75], [66], [450], [3300],



    ),
    caption: [Schedule Expediting Table]
  )




