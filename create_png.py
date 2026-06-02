import struct, zlib

def chunk(ct, d):
    c = ct + d
    return struct.pack('>I', len(d)) + c + struct.pack('>I', zlib.crc32(c) & 0xffffffff)

sig = b'\x89PNG\r\n\x1a\n'
ihdr = chunk(b'IHDR', struct.pack('>IIBBBBB', 10, 10, 8, 2, 0, 0, 0))
rd = b''
for y in range(10):
    rd += b'\x00'
    for x in range(10):
        rd += b'\xff\x00\x00'
idat = chunk(b'IDAT', zlib.compress(rd))
iend = chunk(b'IEND', b'')
with open('./valid10x10.png', 'wb') as f:
    f.write(sig + ihdr + idat + iend)
print(f'Created: {len(sig + ihdr + idat + iend)} bytes')