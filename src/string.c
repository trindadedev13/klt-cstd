#include "string.h"

#include "types.h"

size_t str_len(const string str) {
  size_t len = 0;
  while (str[len] != NULL_TERMINATOR) {
    len++;
  }
  return len;
}