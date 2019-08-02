#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
int sum = 0;

void *runner(void *p);

int main(int argc,char *argv[])
{
	pthread_t tid;
	//pthread_attr_t attr;
	
//	pthread_attr_init(&attr);
	pthread_create(&tid,NULL,runner,argv[1]);
	pthread_join(tid,NULL);
	printf("\nSUM = %d",sum);
}

void *runner(void *p)
{
	int *n;
	n = (int *)malloc(2*sizeof(int));
	n = (int *)p;
	sum = 
	
	pthread_exit(0);
}
