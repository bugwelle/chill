#
# Test unroll
#

source('unroll2.c')
destination('unroll2cmodified.c')
procedure('foo')

# unroll a loop (5) with known iteration count of 15.
# should NOT have to create a second loop to handle the last remaining iterations
loop(0)
original()
unroll(0,1,5)
#print
#print space
