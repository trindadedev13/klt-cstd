#include "io.h"
#include "string.h"
#include "types.h"
#include "va_args.h"

void put_char(char c) {
  write(stdout, &c, 1);
}

void put_str(string s) {
  while (*s)
    put_char(*s++);
}

void print_int(int n) {
  char buf[12];
  int i = 0;
  bool negative = false;

  if (n == 0) {
    put_char('0');
    return;
  }

  if (n < 0) {
    negative = true;
    n = -n;
  }

  while (n > 0) {
    buf[i++] = (n % 10) + '0';
    n /= 10;
  }

  if (negative)
    put_char('-');
  while (i--) {
    put_char(buf[i]);
  }
}

void printf(string fmtr, ...) {
  string fmt = fmtr;
  va_list ap;
  va_start(ap, fmt);
  while (*fmt) {
    if (*fmt == '%') {
      fmt++;
      if (*fmt == 'd') {
        int val = va_arg(ap, int);
        print_int(val);
      } else if (*fmt == 'c') {
        char val = (char)va_arg(ap, int);
        put_char(val);
      } else if (*fmt == 's') {
        string val = va_arg(ap, string);
        put_str(val);
      } else if (*fmt == '%') {
        put_char('%');
      } else {
        put_char('%');
        put_char(*fmt);
      }
      fmt++;
    } else {
      put_char(*fmt++);
    }
  }
  va_end(ap);
}