# LAPACK optimization strategy for LU factorization.

from chill import *

source('lu.c')
procedure('lu')
loop(0)

TJ = 64
original()
tile(1, 3, TJ, 1)
split(1, 2, 'L1-L2>=2') #t2-t4>=2
permute(3, 2, [2,4,3]) # mini-LU
permute(1, 2, [3,4,2]) # other than mini-LU
split(1, 2, 'L2>=L1-1') # seperate MM by t4 >= t2-1

# now optimize for TRSM
TK1 = 256
TI1 = 256
TJ1 = 8
UI1 = 1
UJ1 = 1
tile(4, 2, TI1, 2)
split(4, 3, 'L5<=L2-1') #split t10 <= t4-1
tile(4, 5, TK1, 3)
tile(4, 5, TJ1, 4)
datacopy([[4,1]], 4, false, 1)
datacopy([[4,2]], 5)
unroll(4, 5, UI1)
unroll(4, 6, UJ1)
datacopy([[5,1]], 3, false, 1)

# now optimize for MM       
TK2 = 256
TI2 = 256
TJ2 = 8
UI2 = 1
UJ2 = 1      
tile(1, 4, TK2, 2)
tile(1, 3, TI2, 3)
tile(1, 5, TJ2, 4)
datacopy([[1,1]], 4, false, 1)
datacopy([[1,2]], 5)
unroll(1, 5, UI2)
unroll(1, 6, UJ2)

print_code()

