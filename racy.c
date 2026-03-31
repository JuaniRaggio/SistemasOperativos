#include <semaphore.h>
#include <sys/semaphore.h>

void decidir_movimiento(void);
void enviar_movimiento(void);
void leer_movimiento(void);
void escribir_movimiento(void);

#ifdef NO_MUTEX

void master(void) {
  leer_movimiento();
  escribir_movimiento();
}

void player(void) {
  decidir_movimiento();
  enviar_movimiento();
}

/**
 * PROBLEMA:
 * Race conditions, dos jugadores podrian enviar movimientos a la vez y
 * siempre va a pasar que la desicion se toma sin tener contexto del estado del
 * tablero, en conclusion dos jugadores podrian pisarse o el master podria
 * llegar a sobreescribir y en conclusion borrar el movimiento de uno de los
 * jugadores
 *
 * CONCLUSION:
 * Race Conditions
 *
 **/

#elif SIMPLE_MUTEX

sem_t mutex = 1;

void master(void) {
  leer_movimiento();

  sem_wait(&mutex);
  escribir_movimiento();
  sem_post(&mutex);
}

void player(void) {
  sem_wait(&mutex);
  decidir_movimiento();
  sem_post(&mutex);

  enviar_movimiento();
}

/**
 * PROBLEMA:
 * Solo podria leer el tablero un jugador a la vez, en consecuencia todos los
 * demas jugadores o incluso el master, no podria leer del tablero
 *
 * CONCLUSION:
 * Ineficiencia
 *
 **/

#ifdef COUNTER_MUTEX

sem_t mutex = 1;
sem_t reader_counter_mutex = 1;
int reader_counter = 0;

void master(void) {
  leer_movimiento();

  sem_wait(&mutex);
  escribir_movimiento();
  sem_post(&mutex);
}

void player(void) {
  reader_counter += reader_counter == 0 ? 1 : 0;
  sem_wait(&reader_counter_mutex);
  if (reader_counter++ == 0) {
      sem_wait(&mutex);
  }

  sem_post(&reader_counter_mutex);
  decidir_movimiento();

  if (reader_counter-- == 0) {
      sem_post(&mutex);
  }

  enviar_movimiento();
}

/**
 * PROBLEMA:
 *
 * CONCLUSION:
 *
 **/

#endif /* ifdef COUNTER_MUTEX */
