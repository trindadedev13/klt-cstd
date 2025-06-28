#ifndef __STRING_H__
#define __STRING_H__

#include "core.h"

STATIC SIZE_T STRING_LENGTH(CONST STRING str) {
  SIZE_T len = 0;
  WHILE (str[len] != STRING_END) {
    len++;
  }
  RETURN len;
}

#endif