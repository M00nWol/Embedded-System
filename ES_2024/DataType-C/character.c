#include <stdio.h>

int main(){
    char var;
    printf("Enter a character: ");
    scanf("%c", &var);

    printf("The character is %c (%d, %u)\n", var, var, var);

    return 0;
}
