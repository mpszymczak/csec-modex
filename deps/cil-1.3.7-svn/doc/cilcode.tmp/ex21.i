# 1 "cilcode.tmp/ex21.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "cilcode.tmp/ex21.c"
int main(void) {
# 1 "cilcode.tmp/ex21.c"
   int x, y, z;
   return &(x ? y : z) - & (x ++, x);
}
