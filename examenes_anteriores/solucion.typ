= 1C2P2025 - 17/6/2025

== Ejercicio 1

Se le ha asignado la tarea de desarrollar un virtualizador como
QEMU y ha llegado el momento de discutir con el equipo si es
necesario emular la TLB

1. Indicar cual es su postura y justificar brevemente

    Definitivamente la implementaria ya que siendo que en un 
    virtualizador los recursos suelen ser limitados, la capacidad
    de optimizar las traducciones de tablas de paginas es una muy
    buena eleccion.

2. Asuma que por mayoria se decide emularla y debido a un bug en su
   implementacion cada interaccion con la misma produce un match
   con la primera entrada, independientemente de su contenido.
   Describa brevemente las consecuencias




== Ejercicio 2

Calcule el tamaño maximo de archivo dado un i-nodo que posee 7 
bloques directos, 2 simples indirectos y 1 doble indirecto, 
asumiendo un tamaño fisico de bloque de 4KB y direcciones de 4B


== Ejercicio 3

Indique 2 situaciones en las que puede producirse un page fault
sin requerir acceso al disco, y describa brevemente los pasos que
realiza el sistema operativo en cada caso

1. Si se desea acceder a una Tabla de Paginas que no esta aun 
   mapeada, para saber si esta mapeada o no, se chequea el bit
   de present. En caso de que NO lo este, se sube la misma a disco
   pero eso sucede despues de la page fault



== Ejercicio 4

Asumiendo un scheduler preemptivo y que los procesos corren por
muchas rondas:

1. Considerar un escenario en el que se debe elegir entre los 
   procesos $P_1$ y $P_2$ para ejecutar. Asuma que $P_1$ es 
   CPU-bound y $P_2$ es I/O-bound y que ambos tienen la misma 
   prioridad. Cual elegiria?

   Eligiria el $P_2$ para que de esta forma, en el momento en el
   que $P_2$ dispara la accion bloqueante, pasariamos a ejecutar
   al $P_1$ y de esta forma estariamos maximizando de forma 
   balanceada el uso de los recursos ya que por ejemplo si esa 
   accion bloqueante, requiere acceso a disco, lo que pasaria es
   que estariamos accediendo a disco y aprovechando ese tiempo para
   poder seguir usando el CPU

2. Describa brevemente un algoritmo que dinamicamente priorice la 
   clase de proceso (CPU- o I/O-bound) elegida en el punto A. Si la
   clase de un proceso cambia durante la ejecucion, el algoritmo 
   deberia responder de forma acorde

   Un algoritmo de este estilo podria ser el priority scheduling,
   usando como prioridad $1/f$, siendo $f$ la fraccion del quantum
   utilizado, de esta forma, el proceso I/O-bound deberia ser el
   que menos quantum use y en consecuencia tendria mayor prioridad

== Ejercicio 5



