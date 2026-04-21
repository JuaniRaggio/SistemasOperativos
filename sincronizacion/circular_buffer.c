#include <semaphore.h>

#define N 20

sem_t vacios = N;   // Espacios libres en el buffer
sem_t llenos = 0;   // Elementos listos para consumir
sem_t mutex = 1;    // Para proteger el idx del buffer

// @productor 
//          => Baja los vacios (espera hasta que haya)
//          => Sube los llenos
void productor() {
    sem_wait(&vacios); // Hay lugar?
    sem_wait(&mutex);
    // ... insertar dato ...
    sem_post(&mutex);
    sem_post(&llenos); // Avisar que hay algo nuevo
}

// @consumidor
//          => Baja los llenos (espera hasta que haya algo para leer)
//          => Sube los vacios (cuando haya leido)
void consumidor() {
    sem_wait(&llenos); // Hay algo para leer?
    sem_wait(&mutex);
    // ... extraer dato ...
    sem_post(&mutex);
    sem_post(&vacios); // Avisar que hay un lugar libre
}
