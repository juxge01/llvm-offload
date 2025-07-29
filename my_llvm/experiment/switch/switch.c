#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    switch(n) {
        case 0: printf("0");
        break;
        case 1: printf("1");
        break;
        case 2: printf("2");
        break;
        default:
        printf("default");
        break;        
    }
}
