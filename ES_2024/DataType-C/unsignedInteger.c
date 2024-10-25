#include <stdio.h>
#include <limits.h>

int main(){
    unsigned int minIntValue;
    unsigned int maxIntValue;

    maxIntValue = UINT_MAX;
    minIntValue = 0;

    printf("unsigned int range: %u ~ %u\n", minIntValue, maxIntValue);

    return 0;
    
}
