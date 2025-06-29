#include "kcstd/io.h"
#include "kcstd/memory.h"
#include "kcstd/types.h"

struct people {
  string name;
};

int main() {
  struct people* me = memory_alloc(sizeof(struct people));
  if (me == null) {
    printf("Failed to allocate memory for 'struct people me'\n");
    return 1;
  }
  me->name = "Aquiles Trindade";

  printf("My name is %s\n", me->name);

  memory_free(me);

  // str_len(src)
  printf("ola size: %d\n", str_len("Ola"));

  // str_copy_lmt(src, dest, lmt)
  string cc = "gcc";
  size_t tt = str_len(cc) + 1;
  string cp = memory_alloc(tt);
  str_copy_lmt(cp, cc, 2);

  printf("%s\n", cp);

  // str_cat(src, new)
  string text_a = "Hello, ";
  string text_b = "World!";
  string text = memory_alloc(str_len(text_a) + str_len(text_b));
  str_cat(text, text_a);
  str_cat(text, text_b);
  printf("%s\n", text);

  // str_equals(src, compare)
  bool ba = str_equals(text_a, "Hello, ");
  printf("text_a Equals \"Hello, \" ? : %s\n", ba ? "true" : "false");

  bool bb = str_equals(text_b, "Hello, ");
  printf("text_b Equals \"Hello, \" ? : %s\n", bb ? "true" : "false");

  memory_free(text);

  return 0;
}

void _start() {
  // used for inicialize pool memory
  // im not using it now.
  // memoryp_init();
  int result = main();
  exit(result);
}