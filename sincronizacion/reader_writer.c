#include <semaphore.h>

// Entonces en R+W, lo que tenemos:
// == Para ambos ==
//      => @fila sem_t
//              - lightswitch para los lectores_counter
//              + frena el "seguir sumando lectores_counter" por parte del escritor
//      => @recurso sem_t
//              - Los lectores bloquean al escritor a travez de esto
//              - El escritor se asegura que es el unico modificando
//
// == Para lectores ==
//      => @lectores_counter int
//              - Cuenta cuantos lectores a la vez tenes leyendo, si es 0 entonces
//                podes liberar el recurso, cada vez que termina un lector la idea
//                es que lo reduzca
//      => @mutex_lectores_counter sem_t
//              - Es exclusiva para los lectores, evita que dos lectores modifiquen
//                el contador de lectores a la vez

int lectores_counter = 0;
sem_t mutex_lectores_counter = 1; // Protege la variable 'lectores_counter'
sem_t recurso = 1;        // Protege el acceso al archivo/dato
sem_t fila = 1;           // Mantiene el orden y da prioridad

void lector() {
  sem_wait(&fila); // Hace cola (permite que escritores se cuelen)
  sem_post(&fila);
  sem_wait(&mutex_lectores_counter);
  if (++lectores_counter == 1) {
    // El primer lector bloquea al escritor
    sem_wait(&recurso);
  }
  sem_post(&mutex_lectores_counter);

  // ... LECTURA ...

  sem_wait(&mutex_lectores_counter);
  if (--lectores_counter == 0)
    sem_post(&recurso); // El ultimo libera al escritor
  sem_post(&mutex_lectores_counter);
}

void escritor() {
  sem_wait(&fila);    // Bloquea nuevos lectores_counter
  sem_wait(&recurso); // Espera a que terminen los lectores_counter actuales

  // ... ESCRITURA ...

  sem_post(&recurso);
  sem_post(&fila);
}
