#include <semaphore.h>
#include <stdio.h>
#include <sys/semaphore.h>

// En un hotel hay vehículos automáticos pequeños y grandes, 
// cada uno de ellos representado por un proceso concurrente. 
// Estamos interesados en controlar la entrada de dichos vehículos 
// en un montacargas, en el que caben hasta 4 vehículos pequeños o 
// 2 pequeños y 1 grande. Resolver el problema usando semáforos.

int free_spaces = 4;
int esperando_grande = 0;
int esperando_chico = 0;

sem_t mutex = 1;
sem_t sem_grandes = 0;
sem_t sem_chicos = 0;

void entrar_grande() {
    sem_wait(&mutex); 
    
    // Si no hay espacio, esperamos fuera del mutex
    if (free_spaces < 2) {
        esperando_grande++;
        sem_post(&mutex);
        sem_wait(&sem_grandes);
    } else {
        free_spaces -= 2;
        sem_post(&mutex);
    }
}

void entrar_chico() {
    sem_wait(&mutex);
    
    if (free_spaces < 1) {
        esperando_chico++;
        sem_post(&mutex);
        sem_wait(&sem_chicos);
    } else {
        free_spaces -= 1;
        sem_post(&mutex);
    }
}
