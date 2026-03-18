#set document(
  title: "ChompChamps",
  author: "Juan Ignacio Raggio",
)

#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 2cm,
    right: 2cm,
  ),
  numbering: "1",
  number-align: bottom + right,

  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Juan Ignacio Raggio],
      [],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],

  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Pagina #counter(page).display() / #counter(page).final().first()
    ]
  ]
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "es",
  hyphenate: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
  spacing: 1.2em,
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")

#show heading: it => {
  v(0.5em)
  it
  v(0.3em)
}

#set list(indent: 1em, marker: ("•", "◦", "▪"))
#set enum(indent: 1em, numbering: "1.a.")

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

#show link: underline
// ====================================
// PORTADA
// ====================================

#align(center)[
  #v(1em)
  #text(size: 24pt, weight: "bold")[Sistemas Operativos]
  #v(0.5em)
  #text(size: 18pt)[Trabajo practico numero 1]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Notas \
    #datetime.today().display("[day]/[month]/[year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

// ====================================
// FUNCIONES UTILES
// ====================================

// Funcion para crear una caja de nota/observacion
#let nota(contenido) = {
  block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1976D2"))[Nota:] #contenido
  ]
}

// Funcion para crear una caja de advertencia
#let importante(contenido) = {
  block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#F57C00"))[Importante:] #contenido
  ]
}

// Funcion para crear una caja de error comun
#let error(contenido) = {
  block(
    fill: rgb("#FFEBEE"),
    stroke: rgb("#D32F2F") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#D32F2F"))[Error Comun:] #contenido
  ]
}

// Funcion para crear una caja de tip
#let tip(contenido) = {
  block(
    fill: rgb("#E8F5E9"),
    stroke: rgb("#388E3C") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#388E3C"))[Tip:] #contenido
  ]
}

// Funcion para crear una caja de duda con pregunta y respuesta
#let doubt(pregunta, respuesta) = {
  block(
    fill: rgb("#F3E5F5"),
    stroke: rgb("#7B1FA2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Pregunta:]
    #v(0.3em)
    #pregunta
    #v(0.5em)
    #line(length: 100%, stroke: 0.5pt + rgb("#7B1FA2"))
    #v(0.5em)
    #text(weight: "bold", fill: rgb("#7B1FA2"), size: 11pt)[Respuesta:]
    #v(0.3em)
    #respuesta
  ]
}

= Introduccion

Estamos del lado del consumidor, vamos a aprender sobre interprocess
comunication


== Que tenemos que impedir en este trabajo practico

#nota[ 
  *Espera activa*

  Proceso constantemente pregunta si tiene que actuar o no
  esto consume CPU

  *NO podemos permitir la espera activa*
]


#nota[
  *Condicion de carrera*

  2+ procesos que quieren consumir una misma zona de memoria se pisan
  entre si
]


= Que es este proyecto?

- La *vista* ganadora se lleva un premio
- El *jugador* ganador se lleva otro premio


== Arq

_Tenemos 3 nodos_

- Master: En el enunciado estan las aclaraciones de que tiene que hacer el mismo

- Del lado izq. del master tenemos una vista, hace los refrescos por salida std.

- Del lado der. del master tenemos todos los jugadores, que se van a estar comunicando a travez de IPC con el master


#importante[
  - Que no escriba dos veces consecutivas el mismo jugador (en caso de
    que la velocidad de escritura de uno sea el doble que la otra)

  - No hacer un kill al final del juego, *hay que hacer un wait para
    garantizar que se limpien todos los recursos* y el mismo retorna
    el status
]


== Proceso vista

Tiene que ser notificado por el master que tiene que actualizar la 
salida std.

Es una comunicacion bidireccional

#nota[

]

== Proceso jugador


#doubt[
  Se puede usar <stdatomic.h> y/o <stdlib.h>?
][

]


Si un jugador quiere escribir, le tiene que avisar al master por un
pipe


No progresa porque el recurso siempre esta tomado por alguien mas


#error[
  Que el master vaya uno por uno por los jugadores si hay algo por 
  hacer, ahi se bloquea en cada pipe y no es la idea. En este caso 
  estariamos haciendo un juego por turnos y *esta mal*, un jugador que
  es mas rapido y puede hacer mas movimientos, deberia ser permitido
]

#importante[
  Syscall select $=>$ Deja leer varios pipes a la vez, si hay alguno 
  que quiere escribir, select retorna una coleccion de file descriptors
  y cuando haces un read de esos, deberiamos poder leer los movimientos


  *Evitar sesgo*...
  
  Select podria retornar:

  1

  1 2

  1 2 3

  En este caso, no queremos que se juegue siempre el 1, hay que hacer
  una estrategia para que no haya un sesgo para ciertos FDs
]

#importante[
  El jugador simplemente escribe por salida standard, el write deberia
  solucionar solo el "problema" de condiciones de carrera para escribir
]


== README

Quieren ver que hay realmente cabeza puesta en el trabajo y design
decitions explicadas. Es una parte fundamental del trabajo


= Evaluacion

- 1 pto. Deadline
- 5 pts. Funcionalidad (Mandatorio)
- 3 pts. Calidad de Codigo
- 1 pto. Limpieza de recursos del sistema
- Defensa => No esta definido si va a ser grupal



= Librerias

Vistas: ncurses.h


= Master

Para ver lo que hace el master provisto, hay que usar la opcion "-i"
para poder despues ver el strace para ver las syscalls que hace
el binario







