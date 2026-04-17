#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("%g/%g = %g\n", 0.0, 0.0, 0.0/0.0);
    printf("%g/%g = %g\n", 1.0, 0.0, 1.0/0.0);
    return 0;
}

