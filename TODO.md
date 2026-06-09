# TP2 - Plan de trabajo (deadline: 15/5)

## Requisitos eliminatorios

- [ ] Entrega antes del 19/5 (deadline + 96h)
- [ ] README en la raiz del repositorio
- [ ] Compilar con -Wall sin warnings
- [ ] test_mm pasa como proceso de usuario (fg y bg)
- [ ] test_proc pasa como proceso de usuario (fg y bg)
- [ ] test_sync pasa como proceso de usuario (fg y bg)

## Bloque 1: Procesos + Context Switch (dias 3-5)

- [x] PCB struct (pid, nombre, prioridad, estado, rsp, foreground)
- [x] Tabla de procesos (array fijo, max 32)
- [x] Context switch en ASM (pushState/popState + swap RSP en timer ISR)
- [x] Timer handler dispara context switch (schedule() en _irq00Handler)
- [x] Scheduler round robin con prioridades (quantum basado en priority)
- [x] Proceso idle
- [x] Syscall: create_process (con struct pointer + function registry userland)
- [x] Syscall: exit (process_exit + halt_until_switched)
- [x] Syscall: getpid
- [x] Syscall: yield (scheduler_yield + _hlt)
- [x] Syscall: kill
- [x] Syscall: block / unblock
- [x] Syscall: nice (cambiar prioridad)
- [x] Syscall: waitpid
- [x] Syscall: list_processes (para ps)
- [x] Wrappers ASM (sys_wrappers.asm con macro SYSCALL_WRAPPER)
- [x] Tabla de syscalls actualizada (entradas 24-31)
- [x] Kernel init: process_init() + scheduler_init() en kernel.c
- [x] Userland: process_api con my_* + function registry
- [x] Userland: _process_exit_stub en ASM
- [x] Compilar y testear end-to-end

## Bloque 2: Memory syscalls + Semaforos (dias 6-7)

### Memory syscalls

- [x] Syscall: malloc
- [x] Syscall: free
- [x] Syscall: mem_stats

### Semaforos

- [ ] Struct semaforo (valor, cola de bloqueados, nombre)
- [ ] Atomicidad con xchg o lock cmpxchg
- [ ] Syscall: sem_open (crear o abrir por nombre)
- [ ] Syscall: sem_close
- [ ] Syscall: sem_wait (sin busy waiting)
- [ ] Syscall: sem_post

## Bloque 3: Pipes + Shell (dias 8-9)

### Pipes

- [x] Struct pipe (buffer circular, bloqueante en read/write)
- [x] Pipes con nombre (procesos no relacionados)
- [x] Redireccion transparente stdin/stdout por proceso
- [x] Syscall: pipe_open
- [x] Syscall: pipe_close
- [x] Syscall: pipe_read / pipe_write (transparente con read/write)

### Shell

- [ ] Parseo de | (conectar 2 procesos con pipe)
- [ ] Parseo de & (background)
- [ ] Ctrl+C (matar proceso en foreground)
- [ ] Ctrl+D (enviar EOF)

## Bloque 4: Apps + Tests (dias 10-11)

### Apps de usuario

- [ ] help (listar comandos + tests)
- [ ] mem (estado de memoria)
- [ ] ps (listar procesos)
- [ ] loop (imprimir pid periodicamente, espera activa)
- [ ] kill (matar proceso por pid)
- [ ] nice (cambiar prioridad por pid)
- [ ] block (toggle bloqueado/listo por pid)
- [ ] cat (imprimir stdin)
- [ ] wc (contar lineas de stdin)
- [ ] filter (filtrar vocales de stdin)
- [ ] mvar (lectores/escritores con semaforos)

### Tests de la catedra

- [ ] Integrar test_mm como proceso de usuario
- [ ] Integrar test_proc como proceso de usuario
- [ ] Integrar test_prio como proceso de usuario
- [ ] Integrar test_sync como proceso de usuario
- [ ] Verificar que corran en foreground
- [ ] Verificar que corran en background

## Bloque 5: Pulir + README (dias 12-13)

- [ ] Compilar con -Wall sin warnings (ambos memory managers)
- [ ] make (compila con first-fit)
- [ ] make buddy (compila con buddy)
- [ ] README: instrucciones de compilacion y ejecucion
- [ ] README: descripcion de cada comando y parametros
- [ ] README: caracteres especiales (|, &)
- [ ] README: atajos de teclado (Ctrl+C, Ctrl+D)
- [ ] README: ejemplos de uso
- [ ] README: requerimientos faltantes o parciales
- [ ] README: limitaciones
- [ ] README: citas de codigo / uso de IA

## Deuda tecnica

- [ ] Reemplazar busy_wait_ms en sound.c por sleep basado en ticks con _hlt o timer callback

## Dias 14-15: Buffer para bugs
