#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char const *argv[])
{
    if (argc < 2) return -1;

    FILE* fp;

    fp = fopen("test_input.txt", "w");
    srand((long int)time(NULL));
    for(int i=0; i<atoi(argv[1]); i++) {
        fprintf(fp, "%d\n", (rand()%100000)+1);
    }
    fclose(fp);
}