#include "string.h"

#include "types.h"

size_t str_len(const string str) {
  size_t len = 0;
  while (str[len] != NULL_TERMINATOR) {
    len++;
  }
  return len;
}

int str_cmp(string a, string b) {
  while (*a && (*a == *b)) {
    a++;
    b++;
  }
  return *(byte*)a - *(byte*)b;
}

int str_cmp_lmt(string a, string b, size_t lmt) {
  size_t i = 0;
  while (i < lmt) {
    if (a[i] != b[i]) {
      return (byte)a[i] - (byte)b[i];
    }
    if (a[i] == NULL_TERMINATOR || b[i] == '\0')
      break;
    i++;
  }
  return 0;
}

bool str_equals(string a, string b) {
  return str_cmp(a, b) == 0;
}

string str_cat(string src, string new) {
  string ptr = src;
  while (*ptr != NULL_TERMINATOR) {
    ptr++;
  }
  while (*new != NULL_TERMINATOR) {
    *ptr = *new;
    ptr++;
    new++;
  }
  *ptr = NULL_TERMINATOR;
  return src;
}

string str_copy(string dest, string src) {
  string og_d = dest;
  while (*src != NULL_TERMINATOR) {
    *dest = *src;
    dest++;
    src++;
  }
  *dest = NULL_TERMINATOR;
  return og_d;
}

string str_copy_lmt(string dest, string src, size_t lmt) {
  size_t i = 0;
  while (i < lmt && src[i] != NULL_TERMINATOR) {
    dest[i] = src[i];
    i++;
  }
  while (i < lmt) {
    dest[i] = NULL_TERMINATOR;
    i++;
  }
  return dest;
}