#set document(
  title: "Sistemas Operativos",
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
      [Juan Ignacio Raggio], [], [#datetime.today().display("[day]/[month]/[year]")],
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
  ],
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
  #text(size: 18pt)[Teoria]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    Toma de notas teorica \
    #datetime.today().display("[day]/[month]/[year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

// ====================================
// TABLA DE CONTENIDOS
// ====================================

#outline(
  title: [Índice],
  depth: 3,
  indent: auto,
)

#pagebreak()

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

== Profesores

- #link("github.com/fgleiser")[Fernando Gleiser]
- #link("github.com/guidommogni")[Guido Mogni]
- #link("github.com/alejoaquili")[Alejo Aquili]
- #link("github.com/gbeade")[Gonzalo Beade]
- #link("github.com/agodio")[Ariel Godio]

=== Comunicacion

- Foro: #link("https://groups.google.com")[Google Groups]
- #link("sistemasoperativos@itba.edu.ar")[Mail Sistemas Operativos] para consultas mas particulares en las que no deberian verlos los demas alumnos

=== Criterios de aprobacion


==== Parciales

- Nota minima 5
- Solo uno de los dos parciales recuperable


==== Trabajos practicos

- Se aprueban con 6
- Ambos recuperables


==== Nota de cursada

- Promedio plano


=== Grupos

- 1 semana para armarlos
- no mas de 3 alumnos
- inscripcion manual via campus


=== Bibliografia - Teoria

- Abraham Silberschatz
- *Andrew Tanenbaum*
- William Stalling
- #link("https://pages.cs.wisc.edu/~remzi/OSTEP/")[Three Easy Pieces]


=== Bibliografia - Practica

- The C Programming Language
- The Linux Programming Interface - Kerrisk, Michael
- Advanced Programming in the UNIX Environment - W. Richard Stevens, Stephen A. Rago
- Unix System Programming - Kay A. Robbins, Steven Robbins
- Intel / AMD


=== Otras fuentes

- #link("https://wiki.osdev.org/Expanded_Main_Page")[OSDev]
- #link("https://github.com/alejoaquili/ITBA-72.11-SO.git")[Ejemplos, guias y tests]


=== Herramientas

- valgrind
- s/bpf/d/l - trace
- PVS-studio
- lldb

\

= Bash



= POSIX

#table(columns: 2)[Call][Description][`pid = fork()`][Create a child process identical to the parent][`pid = waitpid(pid, &statloc, options)`][Wait for a child to terminate][`s = execve(name, argv, environp)`][Replace a process core image - *NO RETORNA, LIMPIA EL STACK* incluyendo el stack pointer][`exit(status)`][Terminate process execution and return status]


#importante[
  - El pid del proceso mismo se solicita con `getpid()`, el pid
    del proceso padre se solicita con `getppid()`.
  - Es buena practica justo despues del execve, poner un valor
    de exit "raro"
  - Todos los procesos tienen un padre
  - El primer proceso se llama init
  - *Cerrar los file descriptors despues del fork*
  - La diferencia que hay entre dos procesos es el valor de
    retorno de fork
]

Ambos procesos o mejor, todos los procesos ejecutan el mismo
"bloque de codigo", si queremos diferenciar el comportamiento,
tenemos que diferenciarlos mediante condicionales de la
siguiente forma:

```c
pid_t pid = fork();
// A partir de aca corren LOS DOS

if (pid == 0) { // Solo el hijo entra acá }
else { // Solo el padre entra acá }
```

R = Running
Z = Zombie

Ser "Zombie" es quedar muerto pero todavia el padre no llamo a
`waitpid(...)`, por lo que sigue existiendo


== Pair programming

```c

#define TRUE 1

while (TRUE) {
  type_prompt();
  real_command
}

```


== Copy on Write



== Open - Read - Write - Close

_En UNIX todo es un archivo_

- Universalidad de I/O en UNIX
- Eficiencia read write
- Protocolo
  - EOF
  - Read 0
  - Read block


#table(columns: 2)[Call][Description][`fd = open(file, how, ...)`][Open a file for reading, writing, or both][`s = close(fd)`][Close an open file][`n = read(fd, buffer, nbytes)`][Read data from a file into a buffer][`n = write(fd, buffer, nbytes)`][Write data from a buffer into a file][`position = lseek(fd, offset, whence)`][Move the file pointer][`s = stat(name, &buf)`][Get a file's status information]


Si se leyo menos, read retorna cuanto leyo y ya.
Dentro del filesystem, esta la informacion del size de un
archivo



= Administrador de recursos


= Overhead del sistema operativo

Es significativo pero es menos laburo modear un so hecho que hacerlo de cero

- [ ] DOUBT Preguntarle a Fer como medir el overhead que agrega el sistema operativo al hardware. Ya que el mismo te agrega bastante overhead justamente por todos los chequeos que se necesitan

- bpftrace te da observabilidad sobre el overhead creado por el hardware

- Cada proceso tiene su propia tabla de pagina y se detecto que las TP ocupaban muchisima memoria y encima usaban todos la misma tabla de pagina, como tenian muchisimos procesos distintos y cada uno tenia su tabla de pagina entonces ocupaba muchisimo mas de lo que deberia ocupar. La solucion fue hacer que procesos compartan tablas de pagina, justamente aprovechando que tenian el mismo contenido



= Estructura de un Sistema Operativo

- Monolithic system:
  - Todo el sistema operativo se compila como un unico binario
  - Toda funcion tiene visibilidad del resto de las funciones
  - Un error en cualquier funcion hace fallar el sistema operativo
    completo
  - Soportan *shared libraries* o *DLLs*
  - De todos modos, existe una estructura

*Ejemplos:* Linux, FreeBSD, OpenBSD, NetBSD, Microsoft Windows, Solaries

- Microkernels
  - El objetivo es dejar en el kernel tan poco codigo como se pueda
  - Un error fuera del kernel no hace fallar al sistema operativo completo
  - El resto de componentes corre en user-mode
  - Alta confiabilidad

*Ejemplos*: Integrity, K42, MINIX


- *Reincarnation server*:
  - Padre de todos los drivers y servers
  - Chequea constantemente si los drivers y servers estan vivos
  - Limpia los drivers y servers muertos
  - Chequea en una tabla la accion por defecto, ej: reiniciarlo

#importante[
  En un sistema monolitico, todo corre en modo kernel.
  En un Microkernel, puede fallar un driver y no pasa nada.
]

== Mecanismo vs politica

- La separacion entre mecanismo y politica es una estrategia que permite reducir el size del kernel. *Dejar lo mecanismos en el kernel es una buena idea*

- Colocar el mecanismo en el kernel y la politica por fuera, por ejemplo, asignar prioridades a los procesos y ejecutarlos segun estas prioridades:

Elegir al proceso de mayor *prioridad (mecanismo)*


= Que es un proceso?

- Codigo
- Tiene su memoria (dentro de la misma el stack)
- Registros
- Instruction pointer



== POSIX - Files

#importante[
  En POSIX todo es un archivo
]

=== Pipe

Es un "tubo" en el cual el proceso 1 escribe en una punta y el
proceso 2 escribe en la otra punta, de esta forma se comunican procesos

_Es un canal de comunicacion, primer primitiva de comunicacion entre procesos que hay_

#importante[
  Que los limitan?

  - Solo se pueden mandar mensajes *entre procesos que tienen un ancestro* en comun
  - Son unidireccionales $=>$ Podes leer o escribir, no podes leer y escribir
]


Esto pasa porque la filosofia de UNIX es hacer una cosa y hacerla bien,
no deberia haber programas que sean tipo "navaja suiza" que te haga
muchas cosas.

#nota[
  Si queres hacer un programa que haga muchas cosas, se hace a travez
  de pipelines.

  *Linux crea un buffer por cada pipe*
]


#importante[
  Que es un pipe?

  Par de 2 file descriptors con IN y OUT, se leen automaticamente.
  Son siempre de un solo sentido

  \

  Como esta implementado?

  Se crea un buffer por cada pipe y el proceso 1 escribe, mientras que
  el otro lee

  \

  Que pasa si se llena el buffer? Osea se escribio todo y no se llego
  a leer

  En el caso de POSIX, se deja de escribir. Esto quiere decir que el
  proceso espera hasta tener espacio en el buffer osea el write se
  queda colgado, no retorna.

  \
]

#nota[
  Cuando un write retorna -1?

  Cuando ya no hay forma de que alguien lea lo que se escribio, osea
  que se cerro el pipe del otro lado

  \

  Cuando read retorna 0?

  Cuando no hay mas bytes para leer y se cerro el pipe del otro lado,
  si no hay nada que leer se queda colgado esperando que se escriba o
  que se cierre el pipe


]

#doubt[
  fer, una consulta. El read lee cuando el write retorna o podria pasar concurrentemente segun como le asigne ejecucion el cpu? O como resuelve el kernel, el write + read de forma eficiente, entiendo que quizas es conveniente que se puedan ir intercalando las escrituras con las lecturas asi tenes menos chances de que se te llene el buffer
][
  El valor de retorno de write
]

#doubt[
  Como se da cuenta un endpoint si se cerro o sigue abierto un pipe?
][
  El Kernel se encarga de que cada file descriptors tenga un contador
  de cuantos procesos lo tienen abierto. Entonces cada vez que vos lo
  cerras, se refresca el contador, cuando llega a cero quiere decir
  que ya no hay mas nadie que lo vaya a leer
]


#nota[
  Existe un NOBLOCKINGIO para que no se bloquee nunca, para que retorne
  inmediatamente. Si le decis que escriba 200 y el valor de retorno es
  100, en ese caso podes decidir vos que hacer con esos 100 bytes
]


== Como funciona el pipe

1. Shell deja con acceso a ambos extremos del pipe a ambos hijos
2. Shell cierra su pipe para que los procesos hijos sean los encargados de leer/escribir
3. El proceso hijo1 que solo escribe, cierra el r-end (read endpoint)
4. El proceso hijo2 que solo lee, cierra el w-end (write endpoint)
5. Tenes que setear para que el hijo1 tenga como std output el pipe
6. Tenes que setear para que el hijo2 tenga como std input el pipe

#importante[
  - Ambos procesos tienen a la shell como ancestro en comun
  - De esta forma cada hijo solo puede hacer lo que deberia
  - El 2. y 3. se hacen usando close y el file descriptor
  - El 4. y 5. se hacen usando *dup2* y el file descriptor (es preferible sobre dup porque es atomico y permite especificar el FD destino)
]

```c
//...
case PIPE:
pcmd = (struct pipecmd*)cmd;
if(pipe(p) < 0)
panic("pipe");
if(fork1() == 0){
  close(1);
  dup(p[1]);
  close(p[0]);
  close(p[1]);
  runcmd(pcmd->left);
}
if(fork1() == 0){
  close(0);
  dup(p[0]);
  close(p[0]);
  close(p[1]);
  runcmd(pcmd->right);
}
close(p[0]);
close(p[1]);
wait();
wait();
break;
//...
```

= Procesos

== Procesos Secuenciales - Multiprogramming

- Todo el software ejecutable se organiza en *procesos secuenciales* o
  simplemente *procesos*

- *Proceso*: Abstraccion de programa en ejecucion

- *Programa*: Almacenado en disco, no hice nada

- Un programa corriendo 2+ veces? Es posible ya que se puede ejecutar
  en dos procesos distintos, tambien lo podes ejecutar dos veces

  \

- Conceptualmente un proceso tiene su propio CPU

- *Posee sus propios registros y variables*

#nota[
  Esto viene de que la vision de la realidad del proceso es que todos
  los recursos son para el, pero esto es conceptual desde la
  perspectiva del proceso.

  La realidad es que el CPU es usado por muchos procesos.
]

\

- Proveen pseudo concurrencia incluso con un unico CPU

- Se lo suele llamar pseudo paralelismo

- *Paralelismo real: Multiples CPUs compartiendo memoria fisica*

\

- Facilita pensar en una coleccion de procesos corriendo pseudo
  paralelamente en lugar de pensar en los switches $->$
  multiprogramming

- Este switch no es uniforme ni reproducible $->$ supuestos sobre
  tiempo de ejecucion


#importante[
  Una *secuencia de procesos o proceso* es solo una instancia de la
  ejecucion de un programa. Cada proceso tiene su propio CPU virtual,
  esto es una simplificacion de la realidad pero desde la perspectiva
  del proceso eso es lo que esta pasando.

  *Multiprogramming* es la forma en la que el CPU distribuye su
  ejecucion a travez de multiples procesos
]



== Creacion de procesos - UNIX

- fork
- execve



== Creacion de procesos - Win32

- createProcess (10 parametros)
  - programa a ejecutar
  - parametros
  - argumentos
  - atributos de seguridad y control
  - prioridad
  - ventana a asociar con el proceso

+100 syscalls extras para administrar y sync procesos


== UNIX - Win32

En ambos casos los procesos creados tienen su propio espacio de
direcciones


== Terminacion de procesos

Casos en los que ocurre
- Salida normal
  - exit(0) / return 0
  - \_start()

- Salida por error (voluntaria)
  - exit(!= 0) / return != 0;

- Error fatal (involuntario)
  - Instrucciones invalidas
  - Signals

- Muerto por otro proceso (involuntario)
  - kill
  - permisos $->$ usuarios $->$ kernel/user mode?


== Estados de procesos

- *running*: usando el cpu en este instante
- *ready*: ejecutable; detenido temporalmente para dejar que se
  ejecute otro proceso
- *blocked*: no se puede ejecutar hasta que ocurra algun evento
  externo. En el momento en el que un proceso este bloqueado, se va
  "iterando" por los otros (multiprogramming)

#nota[
  Proceso IDLE es un proceso especifico que se ejecuta cuando no hay
  procesos a la espera para consumir CPU
]


=== Demo ps

1. Process blocks for input
2. Scheduler picks another process
3. Scheduler picks this process
4. Input becomes available

== Implementacion de procesos

- *Process management*: registers, PC, program status word,
  stack pointer, process state, priority, scheduling parameters,
  process id, parent process, process group, signals, time when
  process started, CPU time used, Children's CPU name, time to next
  alarm

- *Memory management*: Pointer to text segment info, pointer to data
  segment info, pointer to stack segment info.

- *File management*: Root dir., working dir., file descriptors,
  user id, group id


== Modelando Multiprogramacion


Analisis muy simple

- Si tenemos 1 proceso que consume 20% del tiempo el CPU
- 5 procesos entonces consumen 100% del tiempo el CPU


Analisis

- Probabilisticamente
- Un proceso pasa una proporcion p del tiempo esperando por I/O
- Con n procesos en memoria al mismo tiempo, la probabilidad de que
  los n esten esperando (CPU libre) es $p^n$
- El uso de CPU se puede expresar como:

$ "Utilizacion del CPU" = 1 - p^n $


== IPC - Inter Process Communication

- Proceso independiente vs cooperativo
- Motivacion
  - Compartir informacion
  - Acelerar computacion
  - Modularidad
  - Conveniencia
- 2 modelos fundamentales
  - Memoria compartida
  - Pasaje de mensajes


#importante[
  Utilizar procesos para modularizacion del codigo
]

#doubt[
  Tiene sentido crear un directorio en el que se tengan todos los
  datos compartidos? En Arqui nos dijeron que en estos casos a
  pesar de que el Kernel pueda compartir tipos de datos con
  aplicaciones tipo la Shell, da igual, tenes que tener todo
  repetido igualmente.
][
  Esta pesimo lo que nos dijeron en arqui. *estaba perfecta mi
  intuicion*, crear un directorio common es la forma correcta
]

#doubt[
  Ayer el profesor menciono que las syscalls generaban overhead al
  mencionar que malloc era costoso pero lo que habiamos visto en
  arq. era que es practicamente nulo el overhead de las syscalls
][
  *Las syscalls evidentemente generan overhead, Valles mintio*
]


=== Shared Memory

#importante[
  - Cuando se dice que se expone /game_state pedazo de memoria,
    aunque el nombre parezca insignificante, si es importante ya
    que de esa misma forma se va a reconocer esa zona de memoria
    desde cada proceso.

  - No tiene sentido usar read/write para escribir en shared memory
    Justamente la idea es *una vez se aloca esa memoria, no kernel
    intervension*.

  - La sincronizacion de procesos es manejada por los mismos, no se
    encarga el Kernel. Coherencia de cache es importante para la
    sincronizacion de procesos y es un costo real de la multiprog.
]

- Permite que procesos arbitrarios compartan memoria
- UNIX: shm_open(3) truncate(2) mmap(2)
- Intervencion del kernel para crearla
- Intervencion del kernel para usarla (R/W)?
- UNIX: Consultar shm_overview(7)

*ejemplo:*

```c

char buf[1024];
char *buf = malloc(1024);
char *buf = createSHM(..., 1024, ...);

sprintf(buff, "Hola mundo\n");

// === IMPORTANTE TPE 1 === //
connectSHM(/game_state);

```

==== Punteros

Queremos estructurar la informacion dentro de la shared memory, por
ejemplo una lista.

#error[
  Hay que tener cuidado con guardar punteros en shared memory
  porque volves a tener el problema del mapeo de memoria distinto
  para cada proceso.
]

#tip[
  Para solucionar el problema de los punteros en memoria compartida, se suelen usar *punteros relativos* (offsets). En lugar de guardar una direccion absoluta, guardas la distancia desde el inicio del bloque de memoria compartida.
]

#importante[
  El struct usa un truquito de *flexible array member*, es un size
  de struct que se decide en tiempo de ejecucion.
  // runtime struct size
]

===== mmap()

Retorna una virutal address al comienzo del estado. En cada proceso
te da la direccion virutal que si la pasas a fisica te lleva al
mismo lugar.

=== Pasaje de mensajes

send y receive pueden ser bloqueantes o no bloqueantes

- send bloqueante: hasta que llega a la casilla / proceso
- send no bloqueante: resumen inmediatamente
- receive bloqueante: hasta que hay mensaje disponible
- receive no bloqueante: recibe mensaje o null

```c

int r = send(); // bloqueante

switch (r) {
  case -1: // error
  case 0: // success
}

```

```c

int r = send(O_NONBLOCK);

switch (r) {
  case -1: // error
  case 0: // success
  case ?: // WOULD_BLOCK
}

```

#nota[
  Siempre usar datos bloqueantes $=>$ es un buen principio a seguir
]


=== Buffering

Los mensajes residen en un buffer

- *Capacidad 0*: no buffering $->$ send debe bloquear
- *Capacidad acotada*: send debe bloquear si se agota el espacio
- *Capacidad no acotada*: send no bloquea


=== Pipes

- Com. unidireccional o bidireccional
- Si es bidireccional, es half duplex o full duplex? _Esto tiene
  que ver con que si es posible que los dos ends envien un mensaje
  a la vez o no_
- Debe existir relacion padre-hijo?


==== Pipes anonimos / ordinarios

- Permite comunicar 2 procesos emparentados
- UNIX: unidireccionales
- UNIX: se crean con pipe(2) y se heredan al hacer fork(2) y
  execve(2)
- identidad: ... $->$ file descriptors
- UNIX: consultar pipe(7)


#importante[
  En el directorio `/proc/` se expone la informacion de los file descriptors abiertos, ej:

  `/proc/<pid>/fd/`

  (Si es un Named Pipe, este vive en el sistema de archivos regular).
]


==== Named pipes

- Permite comunicar 2 procesos *arbitrarios*
- UNIX: FIFO
- UNIX: unidireccionales
- UNIX: se crean con mkfifo(3) y se abren con open(2)
- id ...-> path en el file system
- UNIX: consultar fifo


=== Files vs Pipes

#importante[
  Los pipes permiten ejecucion paralela ya que mientras un proceso
  escribe, el proceso en el otro extremo lee
]

= Race condition

#importante[
  Definicion:

  Una situacion en las que dos o mas procesos estan leyendo o
  escribiendo datos compartidos y el resultado final depende de
  quien corre en cada momento
]

== Semaforos

- El wakeup waiting bit se plantea como un entero representando la
  cantidad de wakeups disponibles $[0-n]$, el cual llamaremos
  semaforo

- Se proponen 2 operaciones

  - down -> sleep: atomicamente decrementa el semaforo o bloquea al
    caller si ya es 0

  - up -> wakeup: atomicamente incrementa el semaforo y desbloquea
    a algun bloqueado si existe

*ejemplo:*

```c

int saldo_en_cuenta;
semaphore mutex = 1;

void debitar(int *saldo, int debito) {
  down(mutex);

  if (*saldo >= debito)
    *saldo -= debito;

  up(mutex);
}

```

#error[
  No es necesario hacer codigo robusto contra deadlocks (*para esta materia*)
]

= Multi process programming

== Sync problems

=== SCSP

```c
static const uint8_t N = 100;
typedef int semaphore;
semaphore mutex = 1;
semaphore empty = N;
semaphore full = 0;

void producer(void) {
  int item;
  while (1) {
    item = produce_item();
    down(&empty); // Este mutex no te asegura que seas el unico insertando porque empieza en N
    down(&mutex);

    insert_item(item);

    up(&mutex);
    up(&full);
  }
}

void consumer(void) {
  int item;
  while(1) {
    down(&full); // Lo mismo pasa aca
    down(&mutex);

    item = remove_item();

    up(&mutex);
    up(&empty);
    consume_item(item);
  }
}
```


=== Filosofos comensales

#nota[
  Tenes 5 comensales con un tenedor en cada uno de sus lados y para comer necesitan dos,
  entonces necesitas resolver la sync de estos
]

```c
static const uint8_t philosophers = 5;

void philosopher(uint8_t philosopher_idx) {
  while (1) {
    think();                                // philosopher thinking
    take_fork(philosopher_idx);             // take left fork
    take_fork((philosopher_idx + 1) % N);   // take right fork
    eat();                                  // yum yum
    put_fork();                             // put left fork back on the table
    put_fork((philosopher_idx + 1) % N);    // put right fork back on the table
  }
}
```


== Lectores y escritores


```c

typedef int semaphore;
semaphore mutex = 1;
semaphore db = 1;
int rc = 0;

void reader(void) {
  while (1) {
    down(&mutex);
    if (++rc == 1) {
      down(&db);
    }
    up(&mutex);
    read_data_base();
    down(&mutex);
    if (--rc == 0) {
      up(&db);
    }
    up(&mutex);
    use_data_read();
  }
}

void writer(void) {
  while (1) {
    think_up_data();
    down(&db);
    write_data_base();
    up(&db);
  }
}

```

#error[
  Esta solucion tiene un error y es que si tenes una lectura muy rapida, entonces nunca el writer va a poder tomar el mutex (Reader Preference).
]

#nota[
  Existe una variante de este problema que otorga *prioridad a los escritores* (Writer Preference) para evitar la inanicion de los mismos.
]


= Deadlock

== Definicion

Un conjunto de procesos estan bloqueados si cada proceso del conjunto esta
esperando un evento que solo puede causar otro proceso del conjunto.


= Master - Vista

```c

sem A = 0;
sem B = 0;

master {
  while(1) {
    // actualiza el estado
    up(A);
    down(B);
  }
}

vista {
  while(1) {
    down(A);

    // consultar estado
    // imprimir la vista

    up(B);
  }
}

```


= Threads

== Procesos vs Threads - Que necesitas para cada uno?

#importante[
  #align(
    center,
  )[
    #table(columns: 2)[*Per-process items*][*Per-thread items*][Address space][Program counter][Global variables][Registers][Open Files][Stack][Child processes][State][Pending alarms][][Signals and signal handlers][][Accounting information][]
  ]
]

== Para que queremos un proceso dentro de un proceso?

- Muchas actividades simultaneas, algunas bloqueantes
  - Desglosar la solucion en hilos secuenciales
    - Aumenta el uso de CPU
    - Simplifica la programacion
    - Aprovecha arquitecturas con multiples CPUs

- La misma nocion de modelo de procesos
  - Abstraer detalles y pensar en procesos secuenciales
  - Con el agregado de que comparten un espacio de direcciones

- Son mas "baratos" $->$ *Tiene mucho sentido porque no tenes que crear un nuevo espacio de direcciones como en los procesos*
  - Creacion y destruccion
  - Hasta 10-100 veces mas rapido que un proceso


#importante[
  Si todo el espacio de memoria es compartido, ya es una "pista" sobre tener que usar
  threads porque justamente ya tenes esa caracteristica de forma natural sin tener que
  crear memoria compartida.
]

== Ejemplo - Procesador de texto

- Corrector ortografico
- Auto guardado
- Procesar input
- Visualizar contenido


== Ejemplo - Web server

- Atender conexiones
- Enviar paginas en cache
- Buscar paginas en disco (bloqueante)

#nota[
  La estructura que se tiene aca es:

  - Dispatcher thread: Es unico y se encarga de redireccionarte a un worker thread
  - Worker threads: Se encarga de hacer el trabajo duro de procesamiento
]

=== Como seria el server sin threads?

_Y si no tengo threads y lo quiero mas eficiente?_

- Syscalls no bloqueantes $=>$ Podrias decirle al kernel que no te bloquee cuando haces las syscalls,
  necesitas si una variable que te avise si retornaste. (podrias retornar por no tener dato)

  ```c
    read(...O_NONBLOCK...); // Para que no sea bloqueante el read
  ```

- Almacenar el estado de cada pedido para retomarlo cuando llegue la pagina del disco
- Se pierde la nocion de computacion secuencial
- Estamos simulando threads "the hard way"


#table(columns: 2)[*Model*][*Characteristics*][Threads][Parallelism, blocking system calls][Single-threaded process][No parallelism, blocking systemcalls][Finite-state machine][Parallelism, nonblocking systemcalls, interrupts]


- Las syscalls bloqueantes facilitan la programacion
- El paralelismo aumenta el rendimiento


== POSIX Threads - API

- create
- exit
- join
- yield
- attr_init
- attr_destroy


== Threads - Implementacion user space

- Kernel desconoce de su existencia
- Desde la perspectiva del kernel son procesos con un unico thread
- Provee soporte para threads en caso de que el kernel no los provea
- Se implementan como una libreria

#nota[
  No va a distinguir threads el kernel.

  Si el kernel soporta threads, va a existir una tabla de procesos y
  una tabla de threads.

  Si el kernel no soporta threads, entonces no va a saber de la
  existencia pero si va a tener procesos.
]


#doubt[
  Por que decimos que la multiprogramacion no soporta paralelismo?
][
  Lo decimos para un solo core, aunque el switching lo hace parecer
  paralelo.

  En caso de que si tengas arquis SMP, ahi si tenes paralelismo real.
  Si ejecutas ChompChamps con los jugadores, es muy probable que
  tengas un proceso corriendo en paralelo.

  _Cuando se hace el time:_
  $"system" - "user" = "tiempo bloqueado"$
]

=== Implementacion en espacio de usuarios

- Cada proceso necesita su tabla de threads privadas $->$ analoga a la
  tabla de procesos del kernel

- Si un thread se bloquea localmente, se realiza el switch en espacio
  de usuario
  - Es un orden (o mas) de magnitud mas rapido que el switch usual con
    interrupciones y la intervencion del kernel
  - No es necesario flushear la cache

- Cada proceso puede tener su propio algoritmo de scheduling de
  threads

#importante[
  Los lenguajes de programacion estan completamente abstraidos de como
  se manejan los threads y donde se ejecuta cada uno, menajer eso es
  una responsabilidad del kernel.
]

==== Que pasaria con las syscalls bloqueantes?

Basicamente se va a bloquear todo el proceso a pesar de que tengas
"multiples threads". No tiene sentido usar mecanismos de sync de sem_t
para MT en espacio de usuario porque te va a bloquear todos los
threads que tengas en ese proceso.


#importante[
  Hay que usar mecanismos de sincronizacion de la libreria que
  implementa esos threads, *no tiene sentido usar los semaforos POSIX*
  ya que usa syscalls bloqueantes y te bloquea todo el proceso.
]

#nota[
  Las syscalls bloqueantes disminuyen la complejidad del codigo.

  ```c
  read(0, ..., O_NONBLOCK, ...);
  ```
]

#doubt[
  yield, lo libera solo para un thread de otro proceso?
][
  Depende si el yield esta implementado por la libreria de user space,
  en ese caso no le va a regalar eso a otro proceso.
]

#nota[
  Existe un yield para procesos, solo sirve para cooperar con otros
  procesos fundamentalmente.
]


#doubt[
  Librerias standard que usan?
][
  Suelen usar kernel por el problema de bloqueo. Pero podria ser que
  haya casos en los que necesites mucho switch y poco bloqueo entonces
  si tenga sentido usar threads de user space.
]

==== Page faults

#nota[
  Un thread causa un page fault $=>$ el kernel bloquea el proceso entero
  hasta que llega la pagina.

  Las librerias de threads tienen sus propios schedulers para threads.
]

#importante[
  Cuando un thread quiere acceder a una zona de memoria que no se usa hace
  mucho y el kernel tiene que traer esa pagina del disco.

  *Para evitar este problema, podrias leer cada tanto esa zona que sabes
  que vas a querer consultar pero notemos que no es lo mas lindo del mundo*
]

==== Inanicion

Un thread puede correr indefinidamente hasta que voluntariamente libere
el CPU

Se puede solicitar una signal $=>$ Ineficiente

Analogia timer (externo) - kernel / signal - libreria de threads

Uso de threads: Separar hilos que fundamentalmente se bloquean

=== Importante sobre user space threads

#importante[
  *Para user space threads:*

  _El objetivo principal de user space threads es separar tareas
  bloqueantes en distintos threads. Por ejemplo ir a buscar una pagina
  a disco - Agodio 2026_

  _For applications that are essentially entirely CPU bound and rarely
  block, what is the point of having threads at all? No one would
  seriously propose computing the first n prime numbers or playing
  chess using threads because there is nothing to be gained by doing
  it that way_

  User-space threads son utiles para syscalls bloqueantes *no porque
  las manejan mejor de forma magica*, el runtime lo que permite es
  tener *millones* de estos sin costo y gestionar el I/O async
  (syscalls bloqueantes que explicitamente le pedimos al kernel que
  no lo sean con O_NONBLOCK) de forma transparente al programador.
  Ademas "el sin costo" es aun mas grande en comparacion a procesos
  que literalmente tienen que *copiar TODO el stack del contexto
  actual* simplemente para crearse y luego cuando se hace el execve
  lo borran.

  *No podes tener paralelismo obviamente con user space threads* porque el
  kernel no tiene idea que tenes multiples threads porque justamente lo ve
  como un proceso mas, no entiende lo que estas haciendo adentro.
]

== Threads - Implementacion Kernel space

- No es necesario el run-time system ni tabla de threads (como en ust)
- Un thread se bloquea como es usual y el kernel elige otro thread
  (u otro proceso)
- Debido al mayor costo, se pueden *reutilizar los threads*

#nota[
  Que es lo costoso de los kernel space threads?

  Justamente que tenes que hacer todo el context switching para pasar
  a kernel space. Tanto permisos, backup de ip, sp, etc. entonces tener
  que hacer todo esto tantas veces es ineficiente en cantidad de
  instrucciones y por lo tanto tiempo de ejecucion
]

#error[
  Este es un problema bastante obvio pero te lo aclaran en el manual
  de read/write:

  *Never read/write only in single bytes at a time* unless you are
  really sure that you have a small amount of data to process. It is
  extremely inefficient not to read/write as much data as you can buffer
  each time.
]

#nota[
  *futex*: Fast Userspace mutex

  - Si es 0 $->$ bloquea $->$ Para consultar una variable no necesitas
    el kernel obviamente.

  - Sino $->$ decrementa $->$ Es solo decrementar una variable
    $->$ no necesitas el kernel

  *Todo lo que se puede resolver en espacio de usuario, es mejor hacerlo
  ahi*. Hay cosas que obviamente requieren privilegio como el control de
  los procesos porque perdes la capacidad de administrar recursos y eso
  es justamente una de las funciones del kernel
]


== Threads - Implementacion Hibrida

- El kernel solo es consciente del kernel-thread
- Por sobre cada kernel-thread puede haber multiples user-threads

#nota[
  Se puede pensar como una ramificacion. El kernel solo tiene conocimiento
  del/los kernel thread/s (de la rama principal), luego ese thread puede
  crear user space threads (ramas que salen de la rama principal) que
  el kernel no tiene idea que existen pero para poder tener mas threads 
  de forma eficiente es ideal esto porque el context switching entre 
  user space threads es muchisimo mas rapido.
]


=== Scheduler activation

- Threads en espacio de usuario con la funcionalidad de aquellos en 
  espacio de kernel

- Al bloquearse, se crea un nuevo thread y se notifica al run-time system
  (thread manager) - upcall - signal

- Viola la estructura de un sistema de capas $=>$ Porque hay un upcall, *pero*
  resuelve el problema de que los user space threads bloquean todo el proceso

#nota[
  La idea es poder darle al usuario del la api del kernel la posibilidad
  de tener un kernel thread que asista a los user space threads para
  impedir que el hecho de que se bloquee un user space thread no resulte
  bloqueando todo el proceso (todos los threads).
]

#doubt[
  Cual es la diferencia en terminos practicos de hacer scheduler activations
  y hacer O_NONBLOCK syscalls?
][

]


= Scheduling

- Ususalmente tenemos multiples procesos peleando por el CPU
- Que pasa si tenemos 2 o mas procesos en estado ready y al menos 1 CPU disponible?
- Proceso vs thread

#importante[
  Estados de un proceso:

  - Running
  - Blocked
  - Ready

  #nota[
    Cambios de estado:

    1. Process blocks for input
    2. Scheduler picks another process
    3. Scheduler picks this process
    4. Input becomes available

  ]
]

== Observaciones

- Antiguamente se podia atender de a 1 tarea a la vez $->$ 
  Probablemente era una priority queue o queue

- Con el advenimiento de la multiproogramacion se pueden tener muchos usuarios
  esperando su uso, con interfaces interactivas y poco poder de computo $->$ tiempo
  de CPU escaso

- Con las PCs
  - En general hay 1 tarea ppal $=>$ La que interactua con el usuario, las demas estan
    en segundo plano.
  - El tiempo de CPU no es un recurso escaso $=>$ En general tenemos mucho recurso de
    CPU y lo subutilizamos

- Recursos disponibles en sistemas portables? $=>$ En estos casos es un poco mas
  escaso por cuestiones de energia, ahorro de energia y en consecuencia poder de 
  computo

- El switch de procesos es costoso (Estado del cPU, memory mapping, caches)


= TP 2 - Sistema Operativo con scheduling

#importante[
  Memory management es lo mas importante de todo porque no se puede avanzar sino
]


= Memory Management

== Introduccion

Kernel $=>$ consecuencia de la necesidad del SO de admin. recursos
$=>$ Abstracciones

- CPU $=>$ Procesos
- Memoria Fisica $=>$ Memoria Virtual
- Disco $=>$ File System

#nota[
  El kernel es el primero que llega / se ejecuta y por eso es el
  administrador
]


=== Memoria

- Fisica $=>$ Se organiza en *PAGE FRAMES*

- Virtual $=>$ Se organiza en *PAGES*


==== MM Layers

3. User-Space Allocator::Address space disponible
2. Virtual Memory Manager::Pages en Address Space
1. Physical Memory Manager / Page frame allocator::Page Frames de RAM


== Responsabilidades

- Asignacion exclusiva de memoria libre

- Liberacion de memoria previamente asignada

#nota[
  Tambien tenemos que poder consultar el estado de la memoria
]

=== Analogia Biblioteca

- Memoria $->$ Biblioteca
  - Estantes Libres/Ocupadas

- MM $->$ Bibliotecario

#nota[
  "Necesito espacio para guardar 5 libros" $->$ el bibliotecario va
  a elegir un estante que se adopte de la mejor forma posible
  a la cantidad de libros que hay que guardar

  *Ojo porque tambien necesita estantes para guardar las anotaciones
  sobre donde guardo cada libro*
]

=== Consideraciones para el TPE

- 1:1 Physical & Virtual Address Spaces
  - Vamos a construir un MM que trabaje con PAGE FRAMES $->$ Sin Virtual Memory

#importante[
  - El huevo y la gallina $->$ Memoria para el MM?
    *Guia de building hecha por Ariel Godio*:
    - *Manual de Pure64* + *Guia de building* $->$ a partir de donde
      hay memoria libre para administrar por el MM.

  #nota[
    Esto sirve para entender que hay abajo del capo y todo lo que
    no hicimos en arqui, como seria?
  ]
]

== Posibles implementaciones

=== Implementaciones de Physical Memory Allocators

- Bitmap
- Free Stack / List
- Buddy
- etc.


== Ejemplos

- Fragmentacion
  - Interna
  - Externa

#importante[
  RTOS tiene muy buena documentacion de la implementacion de su
  Memory Manager $=>$ *Quiero ver esto*:

  #align(center)[#link("https://www.freertos.org/Documentation/00-Overview")[Documentacion *RTOS*]]

  Otros ejemplos: #link("https://github.com/jubalh/awesome-os")[Awesome OS]
]

- Alineacion de memoria

#nota[
  Lo importante no es el algoritmo, lo importante / valorable es la
  integracion con nuestro sistema
]

#importante[
  Es muy importante que el memory manager este alineado a palabra,
  obviamente por una cuestion de eficiencia a nivel instrucciones de
  asm
]

= Scheduling

== Introducción
Proceso por el cual el *Scheduler* decide qué proceso en estado `READY` pasa a estado `RUNNING`. El objetivo es maximizar la eficiencia del sistema.

== Conceptos Clave
- *Preemptive (Apropiativo):* El Kernel puede quitarle el CPU a un proceso a la fuerza.
- *Non-Preemptive (No apropiativo):* El proceso tiene el CPU hasta que él mismo lo libera o se bloquea.
- *Quantum (o Time Slice):* El tiempo máximo que un proceso puede estar en el CPU antes de ser rotado.

== Métricas
- *Throughput:* Procesos terminados por unidad de tiempo.
- *Turnaround Time:* Tiempo total desde que el proceso llega hasta que termina.
- *Waiting Time:* Tiempo pasado en la cola de `READY`.
- *Response Time:* Tiempo desde el comando hasta la primera respuesta.

== Algoritmos Clásicos
1. *FCFS (First-Come, First-Served):* El primero en llegar es el primero en ser atendido. Simple pero sufre de *Efecto Convoy*.
2. *SJF (Shortest Job First):* El más corto primero. Óptimo para minimizar espera, pero difícil de predecir.
3. *Round Robin (RR):* FCFS con Quantum. Ideal para sistemas interactivos.
4. *Priority Scheduling:* Prioridades para cada proceso. Puede causar *Starvation* (solución: *Aging*).
5. *MLFQ (Multi-Level Feedback Queue):* Múltiples colas con distintas prioridades. Es el estándar en SO reales.

#tip[
  Prestá atención al tamaño del *Quantum*:
  - Muy chico: Mucho overhead por context switch.
  - Muy grande: Pobre tiempo de respuesta.
]





