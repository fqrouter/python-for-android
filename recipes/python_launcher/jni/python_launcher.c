/* Minimal main program -- everything is loaded from the library */

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

typedef int (*main_t)(int, char **);

#define LIBPYTHON_PATH_PATTERN "%s/lib/libpython2.7.so"

int main(int argc, char **argv)
{
    char *PYTHONHOME = getenv("PYTHONHOME");
    if (NULL == PYTHONHOME) {
         printf("PYTHONHOME not set\n");
         return 1;
    }
	char LIBPYTHON_PATH[strlen(PYTHONHOME) + strlen(LIBPYTHON_PATH_PATTERN)];
    sprintf(LIBPYTHON_PATH, LIBPYTHON_PATH_PATTERN, PYTHONHOME);
    void *fd = dlopen(LIBPYTHON_PATH, RTLD_LAZY);
    main_t Py_Main = (main_t) dlsym (fd, "Py_Main");
	int exitcode = Py_Main(argc, argv);
    dlclose(fd);
    return exitcode;
}
