#include<pthread.h>
#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<string.h>
#define max 10
int step = 0 ;
typedef struct mat{
	int a[max][max],b[max][max],res[max][max];
	int n1,n2,s1,s2;
};
     
void *calc(void *m)
{
	int n = step++;
	int sum =0;
	struct mat *m1 = (struct mat *)m;
	
	for(int i = n ; i < n+1 ; i++)
	{
		for(int j = 0 ; j < m1->s2 ; j++)
		{
			for(int k = 0 ; k < m1->n1 ; k++)
			{
				sum += m1->a[i][k] * m1->b[k][j]; 
			}
			m1->res[i][j] = sum;
			sum = 0;
		}
	}
}

int main() {
	struct mat M;
	struct mat *p;
	pthread_t a_thread[3];
	void *thread_result;
	
	printf("\nEnter size of matrix 1:");
	scanf("%d%d",&M.n1,&M.n2);
	
	
	printf("\nEnter size of matrix 2:");
	scanf("%d%d",&M.s1,&M.s2);
	
	printf("\nEnter elements of MAT 1:");
	for(int i=0;i<M.n1;i++)
	{
		for(int j=0;j<M.n2;j++)
		{
			scanf("%d",&M.a[i][j]);
		}
	}
	
	printf("\nEnter elements of MAT 2:");
	for(int i=0;i<M.s1;i++)
	{
		for(int j=0;j<M.s2;j++)
		{
			scanf("%d",&M.b[i][j]);
		}
	}
	
	printf("\nMatrix 1:\n");
	for(int i=0;i<M.n1;i++)
	{
		for(int j=0;j<M.n2;j++)
		{
			printf("%d\t",M.a[i][j]);
		}
		printf("\n");
	}
	
	printf("\nMatrix 2:\n");
	for(int i=0;i<M.s1;i++)
	{
		for(int j=0;j<M.s2;j++)
		{
			printf("%d\t",M.b[i][j]);
		}
		printf("\n");
	}
	
	p = &M;
	
	for(int i=0;i<3;i++)
	{
		pthread_create(&a_thread[i],NULL,calc,p);
	}
	
	for(int i=0;i<3;i++)
	{
		pthread_join(a_thread[i], NULL);
	}
	
	printf("\nResult:\n");
	for(int i=0;i<M.s1;i++)
	{
		for(int j=0;j<M.s2;j++)
		{
			printf("%d\t",M.res[i][j]);
		}
		printf("\n");
	}
	
	
	
	exit(EXIT_SUCCESS);
	return 0;
}

