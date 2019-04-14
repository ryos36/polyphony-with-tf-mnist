import polyphony
from polyphony import testbench
from polyphony.typing import List, bit16, bit9, bit8, bit
#from float2bfloat import float2bfloat 
#from float2bfloat import bfloat2float 

def mul(x:bit16, w:bit16):
    if x == 0:
        return 0
    if w == 0:
        return 0
    x_e = (x >> 7) & 0xFF 
    w_e = (w >> 7) & 0xFF
    e:bit8 = (x_e - 127) + (w_e - 127) + 127
    x_n = (x & 0x7F)
    w_n = (w & 0x7F)
    new_n:bit16 = ((x_n | 0x80) * (w_n | 0x80))
    if new_n & 0x8000:
        new_n >>= 8
        e += 1
    else:
        new_n >>= 7
    #print(x_n, w_n, new_n)
    new_n &= 0x7F
    s = (x & 0x8000) ^ (w & 0x8000)
    #print('s', s, e, new_n)
    
    x_w = s | (e << 7) | (new_n)
    #print(f'result:{x_w:2x}, {w_n} {x_n} {new_n}')
    return x_w

def sub_add(x_sign:bit, x:bit8, b_sign:bit, b:bit8, e:bit8):
    #print(f'sub_add {x_sign} {x:08b}, {b_sign} {b:08b}')
    #print('sub_add', x_sign, x, b_sign, b, e)

    if (x_sign == 0 and b_sign == 0) or (x_sign == 1 and b_sign == 1):
        rv_n:bit9 = (x + b)
        add_e = 1 if rv_n & 0x100 else 0
        if add_e:
            rv_n >>= 1

        return (0x8000 if x_sign else 0x0000) | ((e + add_e) << 7) | (rv_n & 0x7F)
    else:
        if x < b:
            x_sign, b_sign = b_sign, x_sign
            x, b = b, x

        #print('sub_add', x_sign, x, b_sign, b, e, x - b)

        rv_n = x - b
        rv_sign = x_sign
        for i in range(0, 7): 
            #print(i, rv_n)
            if rv_n & 0x80:
                return (0x8000 if rv_sign else 0x0000) | ((e - i) << 7) | (rv_n & 0x7F)
            rv_n <<= 1

        return 0

def add(x:bit16, b:bit16):
    if x == 0:
        return b
    if b == 0:
        return x
    x_sign = 1 if x & 0x8000 else 0
    b_sign = 1 if b & 0x8000 else 0
    x_e = (x >> 7) & 0xFF 
    b_e = (b >> 7) & 0xFF

    if x_e < b_e:
        x, b = b, x
        x_e, b_e = b_e, x_e
        x_sign, b_sign = b_sign, x_sign

    x_n = (x & 0x7F)
    b_n = (b & 0x7F)

    d = x_e - b_e
    e = x_e
    if d > 8:
        return x

    new_n:bit8 = 0
    if d == 0:
        rv = sub_add(x_sign, 0x80 | x_n, b_sign, 0x80 | b_n, e)
    else:
        new_b_n = ((0x80 | b_n) >> d) + ((b_n >> (d-1)) & 1)
        #print('d:', d, 'b_n:', f'{b_n:8b} {new_b_n:8b}')
        if new_b_n == 0:
            return x

        rv = sub_add(x_sign, (0x80 | x_n), b_sign, new_b_n, e)

    return rv

def mul_add(x:bit16, w:bit16, b:bit16):
    return add(mul(x, w), b)

#def do_f(f, a, b):
#    rv = f(float2bfloat(a), float2bfloat(b))
#    print(f'{a: .3f} ? {b: .3f} => {bfloat2float(rv): .3f}')
#    print(f'{float2bfloat(a):08b} ? {float2bfloat(b):08b} => {rv:08b}')
#    return rv

@testbench
def test():
#    x = 16209
#    w = 48824
#    b = 16036
#    rv = mul(x, w)
#    rv2 = add(rv, b)
#    print(rv2, rv, '<=', x, '*',w, '+', b)

    a = 48790
    c = 16036 
    rv3 = add(a, c)
    print(rv3, '<=', a, '+',c)

    #print('{0}({4:04x}) <= {1}({5:04x}) * {2}({6:04x}) + {3}({7:04x})'.format(bfloat2float(rv), bfloat2float(x), bfloat2float(w), bfloat2float(b), rv, x, w, b))

#    rv = add(mul(x, w), b)
    #print('{0}({4:04x}) <= {1}({5:04x}) * {2}({6:04x}) + {3}({7:04x})'.format(bfloat2float(rv), bfloat2float(x), bfloat2float(w), bfloat2float(b), rv, x, w, b))
    #print(float2bfloat(0.02663525391))
    #print(0x3eac, bfloat2float(0x3eac))

#    x = 16457
#    w = 16042
#    rv = mul(x, w)
#    print(rv)
#    rv = add(x, w)
#    print(rv)
    #print(f'{float2bfloat(w):4x}')
    #rv = mul(float2bfloat(x), float2bfloat(w))
    #print(bfloat2float(0x007F))

    #print(f'{x} * {w} => {bfloat2float(rv)} : {x*w}')
#    x = 1.445
#    w = 0.183 
#    w = -0.332 
#    x = 3.375
#    x = -0.007 
#    w = 2.938
#    x = 1.000 
#    x = 0.618
#    x = 0.66796875
#    w = 1.672
#    x = 0.99609375
#    w = 1.000
#    x = -1.3671875 
#    w = -1.336
#    x = -0.0546875 
#    w = -0.555
##    print(float2bfloat(w))
##    print(f'{float2bfloat(x+w):4x}')
#
#    do_f(add, x, w)
    print('finished')
#    do_f(add, -x, w + 0.011)
#    do_f(add, x, -w)
#    do_f(add, -x, -w)

#    rv = mul(0x3fff, 0x3fff)
#    print(rv)

#    rv = mul_add(0x3fff, 0x3fff, 0x3fff)
#    print(rv)

    #for i in range(14,15):
    #    x = 1.9921875
    #    b = 1.9921875/(i+1)
    #    print(f'{float2bfloat(x):x}, {float2bfloat(b):x}')
    #    print(f'{bfloat2float(float2bfloat(b))}, {float2bfloat(2.125):x}')
    #    rv = add(float2bfloat(x), float2bfloat(b))
    #    print(f'{x} + {b} => {bfloat2float(rv)}({rv:4x}) : {x+b}({float2bfloat(x+b):4x})')
    
if __name__ == "__main__":
    test()

