#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

struct Quad {
    char op[5], arg1[20], arg2[20], res[20];
};

int is_const(char *s) {
    if (s[0] == '-' || isdigit(s[0])) {
        for (int i = 1; s[i]!='\0'; i++)
            if (!isdigit(s[i])) return 0;
        return 1;
    }
    return 0;
}

int eval(char *op, int a, int b) {
    if (!strcmp(op, "+")) return a + b;
    if (!strcmp(op, "-")) return a - b;
    if (!strcmp(op, "*")) return a * b;
    if (!strcmp(op, "/")) return b ? a / b : 0;
    return 0;
}

int main() {
    struct Quad q[MAX];
    int n;

    printf("Enter number of quadruples: ");
    scanf("%d", &n);

    printf("Enter quadruples (OP ARG1 ARG2 RESULT):\n");
    for (int i = 0; i < n; i++)
        scanf("%s %s %s %s", q[i].op, q[i].arg1, q[i].arg2, q[i].res);

        printf("\nQuadruples:\n");
        printf("+-----+------------+------------+------------+\n");
        printf("| %-3s | %-10s | %-10s | %-10s |\n", "Op", "Arg1", "Arg2", "Result");
        printf("+-----+------------+------------+------------+\n");
        for (int i = 0; i < n; i++)
            printf("| %-3s | %-10s | %-10s | %-10s |\n", q[i].op, q[i].arg1, q[i].arg2, q[i].res);
        printf("+-----+------------+------------+------------+\n");

    for (int i = 0; i < n; i++) {
        if (is_const(q[i].arg1) && is_const(q[i].arg2)) {
            int r = eval(q[i].op, atoi(q[i].arg1), atoi(q[i].arg2));
            strcpy(q[i].op, "=");
            sprintf(q[i].arg1, "%d", r);
            strcpy(q[i].arg2, "-");
        }
    }

    printf("\nOptimized Quadruples:\n");
    printf("+-----+------------+------------+------------+\n");
    printf("| %-3s | %-10s | %-10s | %-10s |\n", "Op", "Arg1", "Arg2", "Result");
    printf("+-----+------------+------------+------------+\n");
    for (int i = 0; i < n; i++)
        printf("| %-3s | %-10s | %-10s | %-10s |\n", q[i].op, q[i].arg1, q[i].arg2, q[i].res);
    printf("+-----+------------+------------+------------+\n");

    return 0;
}