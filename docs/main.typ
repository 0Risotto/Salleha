#set page(
  paper: "a4",
  header: align(left)[Systems Analysis and Design Project],
  margin: 2cm,
  numbering:"1",
 )

#set text(size: 12pt)


#v(4cm)
#align(center)[

 

  #text(size: 16pt)[SALLEHA]

  Systems Analysis and Design \
  Supervised by : Dr. Hamad Alsawalqah \ 
  #let date = datetime(
  year: 2025,
  month: 10,
  day: 15  
  )                      
 First Semester #date.display()
  #table(columns: 2,gutter: 2pt, 
    [*Student Name*],[*ID*],
    [Anas AL-Jallad],[0225343],
    [Orjoan Ali Aldabaibah],[0224933],
    [Mosa Mohammad Daradkah],[0222634],
    [Haneen Saqer Falah Alajaleen],[0226320],
    [Shaima Hasan],[0227646],

  )

]
#pagebreak()
#text(size: 16pt,[*Version Control*])
#table(
  columns :2, align: left,
  [*Version*], [*Description*],
  [Version 1.0],[Initial version for the software documentation. Added Project Initiation and Project Management Plan]

)
#text(size: 16pt,[*Excutive Summary*])


#pagebreak()


#set heading(numbering: "1.")
#outline()


#pagebreak()
#outline(
  title: [Tables],
  target: figure.where(kind: table),
)
#pagebreak()

#set par(justify: true,spacing: 2em)


#include "chapters/chapter1.typ"

