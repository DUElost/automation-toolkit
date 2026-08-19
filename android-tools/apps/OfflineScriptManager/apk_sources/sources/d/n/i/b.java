package d.n.i;

import d.l;
import d.n.f;
import java.nio.ByteBuffer;
import java.util.Arrays;
/* loaded from: classes.dex */
public enum b {
    NULL { // from class: d.n.i.b.a
        @Override // d.n.i.b
        public d.n.i.a a(f fVar, d.n.j.a aVar, d.f fVar2) {
            return new d.n.i.c(fVar, aVar, fVar2);
        }
    },
    PLAIN { // from class: d.n.i.b.b
        @Override // d.n.i.b
        public d.n.i.a a(f fVar, d.n.j.a aVar, d.f fVar2) {
            return fVar2.C ? new d.n.i.f.b(fVar, aVar, fVar2) : new d.n.i.f.a(fVar2);
        }
    },
    CURVE { // from class: d.n.i.b.c
        @Override // d.n.i.b
        public d.n.i.a a(f fVar, d.n.j.a aVar, d.f fVar2) {
            return fVar2.C ? new d.n.i.d.c(fVar, aVar, fVar2) : new d.n.i.d.b(fVar2);
        }
    },
    GSSAPI { // from class: d.n.i.b.d
        @Override // d.n.i.b
        public d.n.i.a a(f fVar, d.n.j.a aVar, d.f fVar2) {
            if (fVar2.C) {
                new d.n.i.e.b(fVar, aVar, fVar2);
                throw null;
            }
            new d.n.i.e.a(fVar2);
            throw null;
        }
    };

    /* synthetic */ b(b bVar) {
        this();
    }

    /* renamed from: values  reason: to resolve conflict with enum method */
    public static b[] valuesCustom() {
        b[] valuesCustom = values();
        int length = valuesCustom.length;
        b[] bVarArr = new b[length];
        System.arraycopy(valuesCustom, 0, bVarArr, 0, length);
        return bVarArr;
    }

    public abstract d.n.i.a a(f fVar, d.n.j.a aVar, d.f fVar2);

    public boolean b(ByteBuffer byteBuffer) {
        byte[] bArr = new byte[20];
        byteBuffer.get(bArr, 0, 20);
        return Arrays.equals(bArr, Arrays.copyOf(name().getBytes(l.f2560c), 20));
    }
}
