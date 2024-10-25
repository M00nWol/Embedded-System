#include <stdio.h>
#include <limits.h>

int main(){
    int minIntValue;
    int maxIntValue;

    maxIntValue = INT_MAX;
    minIntValue = INT_MIN;

    printf("int range: %d ~ %d\n", minIntValue, maxIntValue);

    return 0;
}