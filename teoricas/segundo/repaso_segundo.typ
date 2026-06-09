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

= Scheduling

== Introduccion

Lo importante es *entender el problema del scheduling y los 
tradeoffs* que implica cada decision

Las preguntas "importantes" a responder son:

- Que pasa si aumentamos el quantum? Que pasa si lo bajamos?

- Este algoritmo X puede producir inanicion? En que casos?

- Como mantiene el balance del sistema?


== Algoritmos para sistemas batch

*No existe un usuario interactuando en tiempo real*. Se busca 
procesar grandes volumenes de trabajo de la manera mas eficiente 
posible.
*El tiempo de respuesta inmediato no es un objetivo prioritario*


=== First Come First Served

FCFS es esencialmente una *FIFO*. El primer proceso que llega es el
primero en ejeccutarse, sin importar cuanto tiempo tarde. Es
*non-preemptive*, entonces un proceso que empieza a ejecutar 
continua hasta que *termina o se bloquea*.


#nota[
  Como no hay un usuario esperando feedback inmediato en este tipo
  de sistemas (_batch_), el objetivo es completar todos los 
  trabajos, y como los switches introducen overhead, mejor ejecutar
  de forma ininterrumpida.
]

==== Que pasa cuando un proceso se bloquea?

Cuando un proceso se bloquea, por ejemplo para esperar una 
operacion de disco, simplemente *pasa al final de la cola* y se
atiende al siguiente proceso disponible


==== El objetivo de balance del sistema

#importante[
  Uno de los grandes objetivos del scheduler es *mantener todas las
  partes del sistema ocupadas*
]

No alcanza con tener el CPU al 100%, tambien necesitamos que el
disco este trabajando, la red este activa, etc.

Esto es *paralelismo a nivel de hardware*


==== Caso patologico de FCFS

Consideremos un escenario con un proceso CPU-bound y varios 
procesos I/O-bound. Si el proceso CPU-bound llega primero con FCFS:

    - El proceso CPU-bound monopoliza el CPU durante su rafaga de 
      1seg.
    - Los otros procesos I/O-bound esperan en la cola sin poder 
      solicitar disco.
    - El disco permanece ocioso durante ese tiempo

*Como se resuelve?*

  1. *Cambiando el orden*: Primero atender I/O, de esta forma 
     lanzan sus solicitudes de disco y el disco comenzaria a 
     trabajar en paralelo con el CPU

  2. *Usando preemption*: El CPU puede interrumpir el proceso
     CPU-bound periodicamente, atender un poquito a cada proceso
     I/O-bound y asi *mantener el disco ocupado en paralelo con el 
     CPU*


=== Shortest Job First (SJF)

SJF elige siempre al proceso con *menor tiempo total de ejecucion
estimado*. Tambien es un algoritmo non-preemptive, adecuado para
batch systems

==== Como se cual es el trabajo mas corto?

#importante[
  $ "Sistema interactivo" => "Tiempo impredecible" $
  $ "Sistema batch" => "Tiempo predecible de calcular" $
]

  En un sistema *interactivo*, seria *imposible saberlo*.
  Esto es porque las acciones del usuario son completamente 
  impredecibles.

  Como el sistema es *batch*, las tareas son repetitivas y 
  homogeneas (procesar N transacciones, cada una con tiempo T)
  $=>$ *determinar el tiempo de ejecucion es posible*

==== Ventaja importante sobre SJF

  El *turnaround time* se reduce: tiempo total que un proceso pasa
  en el sistema desde que llega hasta que termina, incluyendo
  tiempo de espera en cola

  SJF minimiza el TAT promedio.
  _El razonamiento es..._

    - Pones los trabajos mas largos al principio, ese tiempo largo
      'se arrastra' en el calculo del turnaround time de *todos los
      trabajos* que vienen atras.

    - Si pones los mas cortos primero, los trabajos largos aparecen
      solo una vez al final de la suma.

#nota[
  Ejercicio tipico de parcial:

  _Calcular el turnaround time promedio para FCFS y para SJF, dado
  un conjunto de procesos con sus tiempos de llegada y ejecucion_
]

==== Problema - Inanicion

  Si siempre llegan trabajos mas cortos que cierto proceso X, ese
  proceso X *nunca sera elegido*. Esto se llama inanicion: el 
  proceso muere de hambre esperando CPU que nunca llega


=== Shortest Remaining Time Next (SRTN)

  Es la version *preemptive* de SJF. En lugar de elegir el trabajo
  con el menor tiempo total, se elige el proceso al que le queda
  *menos tiempo para terminar*


  Entonces a medida que llegan nuevos trabajos, puede llegar uno
  cuyo tiempo total de ejecucion sea menor al tiempo restante del
  proceso que esta corriendo actualmente.


  #nota[
    _El razonamiento es..._
    Cada vez que llega un nuevo trabajo, se compara su tiempo total
    de ejecucion con el tiempo restante del proceso en ejecucion.
    Si el nuevo tiene menor tiempo restante, se lo expulsa al
    actual y se ejecuta el nuevo.
  ]

#importante[
  SRTN tambien puede producir inanicion, ya que podrian seguir
  llegando trabajos con menor tiempo restante que cierto proceso 
  largo, impidiendo que ese proceso progrese indefinidamente
]


== Algoritmos para sistemas interactivos

En los sistemas interactivos hay usuarios trabajando en tiempo real

Entonces aca el objetivo principal:

    $ "Tiempo de respuesta inmediato" $


=== Round Robin

  Es una *cola circular*, se le asigna a cada proceso un pequeño
  intervalo de tiempo llamado *quantum* y se va rotando entre todos
  los procesos en orden.

  Si un proceso se bloquea antes de que venza su quantum, se pasa
  al siguiente. Si su quantum vence sin que se bloquee, se lo
  interrumpe y se lo coloca al final de la cola circular.

  Se implementa con:
    - *Lista de procesos en estado READY*

    - Procesos bloqueados se mueven a otras listas y vuelven a 
      READY cuando su evento se resuelve


=== El quantum - Tamaño y Tradeoffs

Es el *tiempo maximo* que un proceso puede usar el CPU antes de
ser interrumpido.

A $50 H z$ (cada $1/50 s$ se interrumpe) $=>$ 50 interrupciones 
por seg o sea que el quantum es de $20 m s$.

A $500 H z$, el quantum es de $2 m s$


==== Quantum corto vs largo

  *Quantum muy corto:* Mas frecuencia de interrupciones $=>$ 
                       se hacen mas Context Switching

  *Quantum muy largo:* El sistema se vuelve *menos responsivo*. Si 
  un proceso CPU-bound acapara el CPU durante mucho tiempo, el 
  usuario notara retrasos al hacer click o escribir


  #nota[
      Se puede variar el quantum dinamicamente?

      En general la frecuencia del timer de hardware es fija. Sin
      embargo, el sistema operativo puede optar por *no cambiar el 
      proceso en cada interrupcion*.

      Cada proceso lleva un contador de *tiempo virtual*, o sea el
      tiempo total que estuvo ejecutando en el CPU, cuando ese 
      tiempo alcanza un umbral, se cambia el proceso. Este 
      mecanismo permite implementar prioridades de forma sencilla
  ]


==== El verdadero costo del context switch

  El costo real de cambiar de proceso no es la ejecucion de la 
  rutina del kernel sino que...

    $ "La Invalidacion de la cache" $

  Cuando un proceso deja de ejecutar y empieza otro, toda la info.
  que el CPU habia cargado en su cache debe invalidarse, porque
  el nuevo proceso tiene su propia memoria. Las instrucciones y
  datos del neuvo proceso no estan en cache, habria mucho 
  *cache misses* hasta que se repopule


  #nota[
    El *codigo del kernel* esta mapeado en la misma direccion 
    virtual en todos los procesos. Entonces la *cache* asociada a 
    las instrucciones del *kernel*, *no necesita invalidarse* en 
    cada context switch
  ]


=== Prioridades

  Round Robin basico asume que todos los procesos son igualmente 
  importantes. Pero necesitamos que ciertos procesos progresen mas 
  rapido que otros


  #error[
    El scheduler *NO DETERMINA LAS PRIORIDADES*, solo las respeta.
    Las prioridades son establecidas externamente por:
        - el usr
        - system
        - app

    La responsabilidad del scheduler es 
    *elegir al siguiente proceso a ejecutar*, priorizando los que
    correspondan. Pero esto no es lo mismo que *definir quien tiene
    esa prioridad*
  ]

  Las prioridades deben ajustarse periodicamente para evitar 
  inanicion, *si un proceso siempre tiene baja prioridad y siempre 
  hay procesos de alta prioridad disponibles, nunca sera atendido*


==== Asignacion dinamica de prioridades

  Una strat muy efectiva es asignar prioridades dinamicamente en
  funcion del comportamiento reciente del proceso.

  $ "prioridad" = 1/f $

  Donde *f* es la fraccion del ultimo quantum que el proceso 
  utilizo

  Esta strategy *beneficia a los procesos I/O-bound*, que son los
  que se bloquean rapidamente y usan solo una fraccion pequeña del
  quantum.

  El objetivo como siempre es hacer que el disco trabaje en 
  paralelo con el CPU


=== Colas multinivel

  Las colas multinivel extienden la idea de prioridades dinamicas
  con una estructura mas organizada. Se agrupan los procesos en
  *clases de prioridad* y dentro de cada clase se aplica 
  round robin.

  El funcionamiento es...
    - hay procesos en la clase de mayor prioridad 
      $=>$ se los atiende con Round Robin.

    - cuando esa clase se vacia, se pasa a la siguiente, y asi 
      sucesivamente

  *Mecanismo de degradacion*: Cuando un proceso usa su quantum 
  completo, se lo baja de clase. Cuando un proceso se bloquea
  antes de agotar su quantum, permanece en su clase o puede ser
  promovido. (*similar al que vimos antes de $1/f$, donde f es la
  fraccion del ultimo quantum que el proceso utilizo*)
  
  Esto hace que los procesos I/O-bound se mantengan en las clases
  altas y los CPU-bound vayan cayendo hacia las clases mas bajas

  #nota[
    *Quantums de mayor tamaño para clases bajas*: Un proceso CPU
    bound que llego a una clase baja puede recibir un quantum mas
    largo. Asi, aunque se lo interrumpe con menor frecuencia, 
    cuando eventualmente es atendido puede ejecutar durante mas 
    tiempo, reduciendo el overhead de switches
  ]


=== Shortest Process Next (SPN)

  SJF asumia tiempos conocidos, lo cual es razonable en sistemas
  batch pero NO lo es en sistemas interactivos.

  Para sistemas interactivos se usa Shortes Process Next, que
  *estima el tiempo de ejecucion* en base al historial de 
  ejecuciones previas del mismo proceso.

  La tecnica se llama *media exponencial ponderada*:

  $ T_"nueva" = a times T_"vieja" + (1 - a) times T_"medida" $

  $T_"nueva": "La nueva estimacion del tiempo de ejecucion"$
  $T_"vieja": "La estimacion anterior"$
  $T_"medida": "El tiempo real medido en la ultima ejecucion"$
  $a in [0, 1]: "Controla el peso relativo"$

  - $0 < a < 0.5$: *poco peso al pasado*. La nueva depende casi 
    solo de la ultima medicion. Se olvida rapidamente del historial

  - $0.5 < a < 1$: *mucho peso al pasado*. Las ejecuciones 
    recientes tienen poco impacto

  - $a = 0.5$: Igual peso al pasado y al presente

  #nota[
    Se suelen tomar ejercicios asi y en general se eligen a's que
    generen numeros redondos
  ]

=== Guaranteed Scheduling

  *Cada usr recibira $1/N$ del tiempo de CPU*, donde N es la cant.
  de usuarios activos.

  Si hay un solo usuario con P procesos, cada proceso recibira 
  $1/P$ del tiempo

  La impl. requiere llevar un registro del tiempo de CPU usado por
  cada proceso/usuario. El scheduler siempre elige el proceso que
  ha recibido *menos CPU en relacion a lo que deberia haber 
  recibido*, manteniendo asi el balance permanentemente.


=== Lottery Scheduling

Se realiza un *sorteo aleatorio* para decidir que proceso ejecuta

Cada proceso recibe una cantidad de *tickets de loteria*.

Mas tickets $=>$ Mas probabilidad de ser elegido

50 Hz $=>$ 50 sorteos por segundo

- *Semantica mas clara*: Si un proceso tiene el doble de tickets 
  que otro, recibira aprox. el doble de CPU

- *Transferencia de tickets*: Los procesos pueden cooperar 
  transfiriendose tickets entre si

- *Mapeo directo con el problema*: 3 procesos de streaming con 10,
  20 y 50 FPS, les asigno 10, 20 y 50 tickets. Cada proceso 
  recibira CPU proporcional a su carga real



=== Fair-Share Scheduling

Extiende la idea de equidad al nivel de *usuario en lugar de 
proceso*. Si hay 2 usuarios, cada uno recibe 50% del CPU total, sin
importar cuantos procesos tenga cada uno.



= Virtual Memory y Paginacion













