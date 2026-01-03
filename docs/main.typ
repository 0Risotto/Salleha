#set page(margin:0em )
#image("assets/cover/projectcover.png", height: 100%)
#counter(page).update(0)
#pagebreak()

#set page(
  paper: "a4",
  header: align(left)[Systems Analysis and Design Project],
  margin: 2cm,
  numbering:"i",
 )

#set text(size: 12pt,font: "Times New Roman Cyr")
#set table(fill: (coloum, row) => if  row == 0  { rgb(126, 166, 224)} else if coloum == 0  { rgb(189,193,201) },)
//#set text(size: 12pt,)
#v(4cm)
#align(center)[

  #image("assets/logo/salleha_logo.png",height: 23%)

  Systems Analysis and Design \
  Supervised by: Dr.Hamad Alsawalqah \ 
  #let date = datetime(
  year: 2025,
  month: 10,
  day: 15  
  )                      
 First Semester #date.display()
  #table(columns: 2,gutter: 2pt, 
    [*Student Name*],[*ID*],
    [Anas AL-Jallad],[0225343],
    [Orjoan Aldabaibah],[0224933],
    [Mosa Daradkah],[0222634],
    [Haneen Alajaleen],[0226320],
    [Shaima Hasan],[0227646],

  )

]
#pagebreak()
#text(size: 16pt,[*Version Control*])
#table(
  columns: 2,
  align: left,

  [*Version*], [*Description*],

  [Version 1.0],
  [Initial version of the software documentation. Added Chapter 1 (Project Initiation) and Chapter 2 (Project Management Plan).],

  [Version 2.0],
  [Updated version of the software documentation. Added Chapter 3 (Software Requirements Specifications).],

  [Version 3.0],
  [Updated version of the software documentation. Added Chapter 4 (System Analysis and Design), Chapter 5 (User Manual), and Chapter 6 (References), excluding implementation details.]
)
#text(size: 16pt,[*Excutive Summary*])


#pagebreak()


#set heading(numbering: "1.", )
#outline()


#pagebreak()
#outline(
  title: [Tables],
  target: figure.where(kind: table),
)
#pagebreak()
#outline(
  title: [Figures],
  target: figure.where(kind: image),
)
#pagebreak()

#show figure.where(kind:table): set figure.caption(position: top)
#set par(justify: true,spacing: 2em)
#set page(numbering:"1")
#counter(page).update(1)

#include "chapters/chapter1/chapter1.typ"
#include "chapters/chapter2/chapter2.typ"
#include "chapters/chapter3/chapter3.typ"
#include "chapters/chapter4/chapter4.typ"

#include "chapters/endingchapters/endingchapters.typ"

