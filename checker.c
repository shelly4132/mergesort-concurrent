#include <stdio.h>
#include <string.h>

int main(int argc, char const *argv[])
{
    FILE *fp1;
    FILE *fp2;

    char answer[16];
    char output[16];

    fp1 = fopen("words.txt", "r");
    fp2 = fopen("output.txt", "r");

    while(fgets(answer, sizeof(answer), fp1) != NULL) {
        fgets(output, sizeof(output), fp2);
        if(strcmp(answer, output) != 0) {
            printf("Wrong Answer!\n");
            fclose(fp1);
            fclose(fp2);
            return 0;
        }
    }

    printf("Verified OK\n");

    fclose(fp1);
    fclose(fp2);

    return 0;
}