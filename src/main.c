#include "io.h"
#include "memory.h"
#include "types.h"

struct people {
  string name;
};

int main() {
  struct people* me = memory_alloc(sizeof(struct people));
  if (me == null) {
    printf ("Failed to allocate memory for 'struct people me'\n");
    return 1;
  }
  me->name = "Aquiles Trindade";

  printf("My name is %s\n", me->name);

  memory_free(me);

  return 0;
}

void _start() {
  // used for inicialize pool memory
  // im not using it now.
  // memoryp_init();
  int result = main();
  exit(result);
}