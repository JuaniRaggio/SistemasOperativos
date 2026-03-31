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

= Programacion de hardware

Si vos pretendes tener un monton de procesos corriendo, de alguna 
manera tenes que gestionar los recursos.

Pero si sos el unico proceso que va a correr en hardware, tiene 
sentido no gestionar esa creacion de procesos porque siempre se va
a ejecutar el mismo programa.


= C Tricks

== `nil` trick

Probar sentinelas para no tener que hacer NULL check y evitar tener
problemas de desreferenciar null, esto se lo llama `nil` trick y un ejemplo
podria ser:

```c
#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define MAX_ENTITIES 1024

typedef struct {
    int   x, y;
    int   health;
    int   active;
} Entity;

// Pool global - idx 0 es el SENTINEL (nunca se usa "de verdad")
static Entity entities[MAX_ENTITIES];
static int    next_free = 1; // Arranca en 1, el 0 está reservado

// "nil" es simplemente &entities[0], que siempre existe en memoria
// pero sus campos indican que está inactivo/vacío.

Entity *entity_nil(void) {
    return &entities[0];
}

int entity_is_nil(Entity *e) {
    return e == &entities[0];
}

Entity *entity_alloc(void) {
    if (next_free >= MAX_ENTITIES) {
        return entity_nil(); // "fallo" → devuelve nil, no NULL
    }
    Entity *e = &entities[next_free++];
    memset(e, 0, sizeof(*e));
    e->active = 1;
    return e;
}

Entity *entity_find_at(int x, int y) {
    for (int i = 1; i < next_free; i++) { // desde 1, nunca desde 0
        if (entities[i].active && entities[i].x == x && entities[i].y == y)
            return &entities[i];
    }
    return entity_nil(); // no encontrado -> nil, no NULL
}

int main(void) {
    // Inicializar sentinel explícitamente
    memset(&entities[0], 0, sizeof(Entity));

    Entity *hero = entity_alloc();
    hero->x = 10;
    hero->y = 5;
    hero->health = 100;

    Entity *enemy = entity_alloc();
    enemy->x = 3;
    enemy->y = 7;
    enemy->health = 40;

    // Buscar algo que existe
    Entity *found = entity_find_at(10, 5);
    if (!entity_is_nil(found)) {
        printf("Encontrado: health=%d\n", found->health); // -> 100
    }

    // Buscar algo que NO existe
    Entity *ghost = entity_find_at(99, 99);

    // NO crashea aunque no encontramos nada,
    // porque ghost apunta al sentinel, no a NULL.
    printf("Ghost health: %d\n", ghost->health); // → 0, sin segfault
    printf("Ghost activo: %d\n", ghost->active); // → 0
    return 0;
}
```

== Parametros opcionales

Consiste en aprovechar el uso de macros para poder simular parametros opcionales,
un ejemplo de uso:


```c

PushTransform(rect);                      // use all defaults
PushTransform(rect, .scale = Vec2Half);   // override scale
PushTransform(rect, .angle = 90.0f, .pivot = Center); // any order
_PushTransform(rect, params);

struct TransformParams {
  Vec2 pivot;
  Dim2 scale;
  f32 angle;
  b32 clip;
};

#define PushTransform(rect, ...)\
  _PushTransform((rect), (TransformParams){.scale = Vec2One, __VA_ARGS__})
void *_PushTrasnform(Rect, rect, TransformParams params) { /* Implementation */}


```

= Herramientas y tecnicas de troubleshooting


#importante[
  Primero hay que buscar cuales *NO son las causas* del problema
  que estamos intentando resolver. En consecuencia estamos descartando
  los potenciales motivos del problema.
]


== Como observar procesos

```sh
ps ajx
```
=== Estados de procesos

- Z $->$ zombie
- R $->$ running
- S $->$ sleeping

== Tipos de terminales

=== pts

pts: pseudo terminal service

#nota[
  Son las terminales a las que accedemos nosotros
]


=== tty

ttyX: Terminal de verdad que esta corriendo "de verdad"


#doubt[
  Cual es la diferencia entre tty y pts?
][
  - tty es el teclado fisico de la maquina, es una terminal en modo texto
  - pts es la terminal que se ejecuta en modo grafico (la de toda la vida)
]


= Comandos

== Como ver librerias dinamicas?


```sh
ldd
```

== Uptime

```sh
uptime
```

=== load average

load average: XX, YY, ZZ

Te dice:

- XX: promedio en el ultimo minuto
- YY: promedio en los ultimos 5 minutos
- ZZ: promedio en los ultimos 15 minutos

== Monitoreo de procesos

```
top
htop
```

#importante[
  wa: Es waiting for IO y es importante que sea los mas cercano a cero posible
  porque es el tiempo que se toma intercambiando cosas con el disco
]

// =========================================================================================================================

```sh
free -h
```

#nota[
  Memoria:

  - free: Memoria que no esta asignada
  - available: Memoria que esta disponible para usar
  - buff/cache: Memoria que se usa para cache, si hay mucha memoria que no se usa, esto tiende a crecer
]

// =========================================================================================================================

```sh
vmstat
```

#nota[
  - r: procesos ready to run
  - b: cantidad de procesos que estan bloqueados
  - swpd: no entras en memoria, te bajo a disco $=>$ *IMPORTANTE que esto tiene que valer 0 siempre*
  - si: swap in
  - so: swap out
]


#importante[

  Bajar malloc a disco (sin asociar a un archivo) $=>$ MALO

  Bajar archivo a disco $=>$ BUENO

]

// =========================================================================================================================

```sh
mpstat
```

#importante[
  Sirve para ver el consumo de CPUs separados por cada core
]

// =========================================================================================================================

= IMPORTANTISIMO VER ESTO PARA EL TPE

== Limpieza de recursos del sistema

```sh
lsof -n # list opened files
```

#error[
  Es muy comun no usar esto y es un problema importante y "facil" de resolver usando esta herramienta
]

#importante[
  Se pueden encontrar todos los pipes y tenemos que acordarnos de cerrar todos los pipes
]

// =========================================================================================================================

= bpftrace

#importante[
  Es una herramienta que permite detectar muchisimos problemas y puntos de instrumentacion
]


```sh
bpftrace -l | wc # => ~140946 puntos de instrumentacion

bpftrace -e 't:syscalls:sys_enter_execve /comm=="bash"' # muestra cuando un shell ejecuta

bpftrace -lv tracepoint:syscalls:sys_enter_open

bpftrace -l tracepoint:syscalls:* | grep enter_open     # si no te acordas el nombre de la syscall

# Esto tira error porque el puntero no tiene sentido en User space ya que viene del kernel el puntero
bpftrace -l tracepoint:syscalls:sys_enter_openat {printf("%s\n", args->filename)} 

# Entonces hacemos:
# la idea es ver los archivos que se estan modificando
bpftrace -l tracepoint:syscalls:sys_enter_openat {printf("%s\n", str(args->filename))}
```

#importante[
  Sirve para
  - Analisis de performance
  - Analisis forense
]




