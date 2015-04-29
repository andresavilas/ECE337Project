import hashlib
header_hex = "0100000081cd02ab7e569e8bcd9317e2fe99f2de44d49ab2b8851ba4a308000000000000e320b6c2fffc8d750423db8b1eb942ae710e951ed797f7affc8892b0f1fc122bc7f5d74df2b9441a00000000".decode('hex')
h = hashlib.sha256(hashlib.sha256(header_hex).digest()).digest()
print h[::-1].encode('hex_codec')
