#ifndef __STRING_H__
#define __STRING_H__

#include "types.h"

#define NULL_TERMINATOR '\0'

size_t str_len(const string str);

int str_cmp(string a, string b);
int str_cmp_lmt(string a, string b, size_t lmt);

bool str_equals(string a, string b);

string str_cat(string src, string new);

string str_copy(string dest, string src);
string str_copy_lmt(string dest, string src, size_t lmt);

#endif