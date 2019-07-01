#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void *waiting(void *vargp)
{
   sleep(2);
   printf("Done.\n");
}

int main(void)
{
   
   pthread_t thread;
   int err;
   err = pthread_create(&thread, NULL, waiting, NULL);
   if (err)
   {
     printf("An error occured: %d", err);
     return 1;
   }
   printf("Waiting for the thread to end ...\n");
   pthread_join(thread, NULL);
   printf("Thread ended.\n");
   return 0;
}
