def bfloat2float(x):
    s = 1 if x & 0x8000 else 0
    e = (x >> 7) & 0xFF
    n = x & 0x7F
    fn = n / (2 ** 7) + 1
    fn_e = fn * (2 ** (e - 127))
    return fn_e if s == 0 else -fn_e

def float2bfloat(x):
    if x == 0:
        return 0
    else:
        s = 1 if x < 0 else 0
        n = abs(x)
        e = 0
        if n < 1.0:
            while True:
                n *= 2
                e -= 1
                if n > 1.0:
                    break
        elif n >= 2.0:
            while True:
                n /= 2
                e += 1
                if n < 2.0:
                    break
        else:
            pass

        i_n = int((n - 1) * ( 2 ** 7)) & 0x7F
#        print(s, e, i_n)
        return (s << 15) | ( (e + 127) << 7 ) | i_n
            
#print(bfloat2float(15832))
#print(bfloat2float(49253))
#print(bfloat2float(0x3f2b))
#print(bfloat2float(0xc03a))

#rv = float2bfloat(3.14159)
#print('{0:04x} {0:016b} => {1}'.format(rv, bfloat2float(rv)))
#rv = float2bfloat(1/3)
#print('{0:04x} {0:016b} => {1}'.format(rv, bfloat2float(rv)))
#rv = float2bfloat(1)
#print('{0:04x} {0:016b} => {1}'.format(rv, bfloat2float(rv)))
#rv = float2bfloat(-2)
#print('{0:04x} {0:016b} => {1}'.format(rv, bfloat2float(rv)))
#print('=====')
#
#for i in range(100):
#    n = 1 * (2 ** (i + 1))
#    rv = float2bfloat(n)
#    print('{0} => {1:04x} {1:016b} => {2}'.format(n, rv, bfloat2float(rv)))
