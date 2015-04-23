from BitVector import * 
import hashlib
K = [0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2]
fi = open("sha.txt","w")
chunk = BitVector(textstring = "hello".encode())
size = BitVector(intVal = len(chunk),size = 64)
chunk = chunk + BitVector(intVal = 1,size = 1)
while(len(chunk) < 448):
    chunk = chunk + BitVector(intVal = 0,size = 1)
chunk = chunk + size
fi.write("Chunk: " + chunk.getHexStringFromBitVector() + '\n')
fi.write("MSA\n")
w = [0] * 64
w[0:16] = [chunk[x:x+32] for x in range(0, 512, 32)]
for i in range(16,64):
    s0 = (w[i-15].deep_copy() >> 7) ^ (w[i-15].deep_copy() >> 18) ^ (w[i-15].deep_copy().shift_right(3)) 
    s1 = (w[i-2].deep_copy() >> 17) ^ (w[i-2].deep_copy() >> 19) ^ (w[i-2].deep_copy().shift_right(10)) 
    w[i] = BitVector(intVal = ((int(w[i-16]) + int(s0) + int(w[i-7]) + int(s1)) % (2**32)),size = 32)
    fi.write("w[" + str(i) + "]: " + w[i].getHexStringFromBitVector())
a = BitVector(hexstring = '6a09e667')
b = BitVector(hexstring = 'bb67ae85')
c = BitVector(hexstring = '3c6ef372')
d = BitVector(hexstring = 'a54ff53a')
e = BitVector(hexstring = '510e527f')
f = BitVector(hexstring = '9b05688c')
g = BitVector(hexstring = '1f83d9ab')
h = BitVector(hexstring = '5be0cd19')
fi.write('Comp\n')
for i in range(64):
    ch = (e & f) ^ (~e & g)
    maj = (a & b) ^ (a & c) ^ (b & c)
    S0 = (a.deep_copy() >> 2) ^ (a.deep_copy() >> 13) ^ (a.deep_copy() >> 22)
    e_copy = e.deep_copy()
    S1 = (e.deep_copy() >> 6) ^ (e.deep_copy() >> 11) ^ (e.deep_copy() >> 25)
    T_1 = (int(h) + int(S1) + int(ch) + int(K[i]) + int(w[i])) % 2**32
    T_2 = (int(S0) + int(maj)) % 2**32
    h = g
    g = f
    f = e
    e = BitVector(intVal = (int(d) + int(T_1)) % (2**32), size = 32)
    d = c
    c = b
    b = a
    a = BitVector(intVal = ((int(T_1) + int(T_2)) % (2**32)), size = 32)
    fi.write('a(' + str(i) + '): ' + a.getHexStringFromBitVector() + '\n')
h0 = BitVector(intVal = ((int( BitVector(hexstring = '6a09e667')) + int(a)) % 2**32), size = 32)
h1 = BitVector(intVal = ((int( BitVector(hexstring = 'bb67ae85')) + int(b)) % 2**32), size = 32) 
h2 = BitVector(intVal = ((int( BitVector(hexstring = '3c6ef372')) + int(c)) % 2**32), size = 32) 
h3 = BitVector(intVal = ((int( BitVector(hexstring = 'a54ff53a')) + int(d)) % 2**32), size = 32) 
h4 = BitVector(intVal = ((int( BitVector(hexstring = '510e527f')) + int(e)) % 2**32), size = 32) 
h5 = BitVector(intVal = ((int( BitVector(hexstring = '9b05688c')) + int(f)) % 2**32), size = 32) 
h6 = BitVector(intVal = ((int( BitVector(hexstring = '1f83d9ab')) + int(g)) % 2**32), size = 32) 
h7 = BitVector(intVal = ((int( BitVector(hexstring = '5be0cd19')) + int(h)) % 2**32), size = 32) 
digest = h0 + h1 + h2 + h3 + h4 + h5 + h6 + h7
fi.write('digest: ' + digest.getHexStringFromBitVector() + '\n')
fi.close()
