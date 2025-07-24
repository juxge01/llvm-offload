#include <stdio.h>
int calc(int a, int b) {
	return a + b;
}
int main() {
	int a = 1, b = 2;
	printf("%d", calc(a, b));
	return 0;
}
