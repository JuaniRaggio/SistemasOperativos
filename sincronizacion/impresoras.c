#include <semaphore.h>
#include <sys/_types/_pid_t.h>
#include <sys/semaphore.h>

#define total_printers 3
const int free_printer = -1;
int printers[total_printers] = {
    free_printer,
    free_printer,
    free_printer,
};

sem_t available_resources = total_printers;
sem_t printer_mutex = 1;

void Get_Printer(pid_t pid) {
  sem_wait(&available_resources);
  // if (free_printer_counter > 0) {
  // => Esto no cumple con que tiene que esperar hasta que haya una impresora
  // libre
  sem_wait(&printer_mutex);
  for (int i = 0; i < total_printers; ++i) {
    if (printers[i] == free_printer) {
      printers[i] = pid;
      break;
    }
  }
  sem_post(&printer_mutex);
  // }
}

// @IMPORTANT: Siempre que haces wait(A); wait(B); => Tenes que hacer el
// post de forma inversa osea wait(B) primero
void Release_Printer(pid_t pid) {
  sem_wait(&printer_mutex);
  for (int i = 0; i < total_printers; ++i) {
    if (printers[i] == pid) {
      printers[i] = free_printer;
      sem_post(&printer_mutex);
      sem_post(&available_resources);
      return;
    }
  }
  sem_post(&printer_mutex);
}
