#include <pthread.h>
#include <unistd.h>
#include <stdio.h>


void printCharacters(const char *sPtr);
void f(const int *xPtr);

int main(void)
{

    char string[] = "print characters of a string";
    puts("The string is:");
    printCharacters(string);
    puts("");
    return 0;
}

void printCharacters(const char *sPtr)
{
     for (; *sPtr!='\0'; ++sPtr) {
         printf("%c", *sPtr);
     }
}

void f(const int *xPtr)
{
   //*xPtr = 100;
   printf("f %d\n", *xPtr);
}
