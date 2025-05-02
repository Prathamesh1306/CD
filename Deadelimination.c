#include <stdio.h>
#include <string.h>

#define MAX 50

typedef struct {
    char op[3];
    char arg1[10];
    char arg2[10];
    char result[10];
} Quadruple;

Quadruple quads[MAX], optimized[MAX];
int n;

// Check if a variable is used later
int isUsedLater(int index) {
    for (int i = index + 1; i < n; i++) {
        if (strcmp(quads[index].result, quads[i].arg1) == 0 ||
            strcmp(quads[index].result, quads[i].arg2) == 0) {
            return 1; // used later
        }
    }
    return 0; // dead code
}

int main() {
    printf("Enter number of quadruples: ");
    scanf("%d", &n);

    printf("Enter quadruples in format: OP ARG1 ARG2 RESULT\n");
    for (int i = 0; i < n; i++) {
        scanf("%s %s %s %s", quads[i].op, quads[i].arg1, quads[i].arg2, quads[i].result);
    }

    int k = 0;
    for (int i = 0; i < n; i++) {
        if (strcmp(quads[i].op, "=") == 0 || isUsedLater(i)) {
            optimized[k++] = quads[i]; // keep useful or assignment ops
        }
    }

    printf("\nOriginal Quadruples:\n");
    printf("OP\tARG1\tARG2\tRESULT\n");
    for (int i = 0; i < n; i++) {
        printf("%s\t%s\t%s\t%s\n", quads[i].op, quads[i].arg1, quads[i].arg2, quads[i].result);
    }

    printf("\nOptimized Quadruples (Dead Code Removed):\n");
    printf("OP\tARG1\tARG2\tRESULT\n");
    for (int i = 0; i < k; i++) {
        printf("%s\t%s\t%s\t%s\n", optimized[i].op, optimized[i].arg1, optimized[i].arg2, optimized[i].result);
    }

    return 0;
}


// + a b t1
// * t1 c t2
// - d e t3
// = t2 x x