#include <pthread.h>
#include <stdio.h>
#include <unistd.h> //REMOVING IMPLICIT DECLARATION
#include <stdlib.h>

void *kidexe(void *p)
{	
	sleep(1);
	printf("[CHILD]   : %d\n",getpid());
	
	return NULL;
}

int main()
{
	pthread_t kid1;
	printf("\nBefore Thread");
	pthread_create(&kid1,NULL,kidexe,NULL);
	printf("\n[Parent]  : %d\n",getpid());
	pthread_join(kid1,NULL);
	printf("NO MORE EXECUTION\n");	
	return 0;
}
