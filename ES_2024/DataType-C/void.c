#include <stdio.h>

void main(){
    int val = 30;
    void* ptr = &val;
    printf("%d", *(int*)ptr);
}