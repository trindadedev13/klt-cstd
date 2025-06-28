#ifndef __EXTERN_H__
#define __EXTERN_H__

#include "core.h"

EXTERN LONG __ASM_WRITE__(INT fd, CONST BUFFER buffer, SIZE_T len);
EXTERN LONG __ASM_EXIT__(LONG status);

#endif