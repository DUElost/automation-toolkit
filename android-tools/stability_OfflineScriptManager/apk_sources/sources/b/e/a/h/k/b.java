package b.e.a.h.k;

import b.c.a.d;
import b.c.a.i.e;
import b.c.a.i.f0;
import b.c.a.i.i0.g;
import b.e.a.h.f;
import b.e.a.j.j;
import java.io.IOException;
import java.lang.ref.SoftReference;
import java.lang.reflect.Array;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public class b extends AbstractList<f> {

    /* renamed from: b  reason: collision with root package name */
    e f1549b;

    /* renamed from: c  reason: collision with root package name */
    d[] f1550c;

    /* renamed from: d  reason: collision with root package name */
    f0 f1551d;
    b.c.a.i.i0.d e;
    private SoftReference<f>[] f;
    private List<b.c.a.i.i0.e> g;
    private int[] i;
    private Map<g, SoftReference<ByteBuffer>> h = new HashMap();
    private int j = -1;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements f {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ long f1552a;

        /* renamed from: b  reason: collision with root package name */
        private final /* synthetic */ ByteBuffer f1553b;

        /* renamed from: c  reason: collision with root package name */
        private final /* synthetic */ int f1554c;

        a(b bVar, long j, ByteBuffer byteBuffer, int i) {
            this.f1552a = j;
            this.f1553b = byteBuffer;
            this.f1554c = i;
        }

        @Override // b.e.a.h.f
        public long a() {
            return this.f1552a;
        }

        @Override // b.e.a.h.f
        public void b(WritableByteChannel writableByteChannel) {
            writableByteChannel.write(c());
        }

        public ByteBuffer c() {
            return (ByteBuffer) ((ByteBuffer) this.f1553b.position(this.f1554c)).slice().limit(b.e.a.j.b.a(this.f1552a));
        }
    }

    public b(long j, e eVar, d... dVarArr) {
        this.f1551d = null;
        this.e = null;
        this.f1549b = eVar;
        this.f1550c = dVarArr;
        for (f0 f0Var : j.d(eVar, "moov[0]/trak")) {
            if (f0Var.I().A() == j) {
                this.f1551d = f0Var;
            }
        }
        if (this.f1551d == null) {
            throw new RuntimeException("This MP4 does not contain track " + j);
        }
        for (b.c.a.i.i0.d dVar : j.d(eVar, "moov[0]/mvex[0]/trex")) {
            if (dVar.w() == this.f1551d.I().A()) {
                this.e = dVar;
            }
        }
        this.f = (SoftReference[]) Array.newInstance(SoftReference.class, size());
        c();
    }

    private int b(b.c.a.i.i0.e eVar) {
        List<b.c.a.i.b> e = eVar.e();
        int i = 0;
        for (int i2 = 0; i2 < e.size(); i2++) {
            b.c.a.i.b bVar = e.get(i2);
            if (bVar instanceof g) {
                i += b.e.a.j.b.a(((g) bVar).w());
            }
        }
        return i;
    }

    private List<b.c.a.i.i0.e> c() {
        List<b.c.a.i.i0.e> list = this.g;
        if (list != null) {
            return list;
        }
        ArrayList arrayList = new ArrayList();
        for (b.c.a.i.i0.b bVar : this.f1549b.q(b.c.a.i.i0.b.class)) {
            for (b.c.a.i.i0.e eVar : bVar.q(b.c.a.i.i0.e.class)) {
                if (eVar.G().y() == this.f1551d.I().A()) {
                    arrayList.add(eVar);
                }
            }
        }
        d[] dVarArr = this.f1550c;
        if (dVarArr != null) {
            for (d dVar : dVarArr) {
                for (b.c.a.i.i0.b bVar2 : dVar.q(b.c.a.i.i0.b.class)) {
                    for (b.c.a.i.i0.e eVar2 : bVar2.q(b.c.a.i.i0.e.class)) {
                        if (eVar2.G().y() == this.f1551d.I().A()) {
                            arrayList.add(eVar2);
                        }
                    }
                }
            }
        }
        this.g = arrayList;
        this.i = new int[arrayList.size()];
        int i = 1;
        for (int i2 = 0; i2 < this.g.size(); i2++) {
            this.i[i2] = i;
            i += b(this.g.get(i2));
        }
        return arrayList;
    }

    @Override // java.util.AbstractList, java.util.List
    /* renamed from: a */
    public f get(int i) {
        long j;
        ByteBuffer byteBuffer;
        long v;
        f fVar;
        SoftReference<f>[] softReferenceArr = this.f;
        if (softReferenceArr[i] == null || (fVar = softReferenceArr[i].get()) == null) {
            int i2 = i + 1;
            int length = this.i.length;
            while (true) {
                length--;
                if (i2 - this.i[length] >= 0) {
                    break;
                }
            }
            b.c.a.i.i0.e eVar = this.g.get(length);
            int i3 = i2 - this.i[length];
            b.c.a.i.i0.b bVar = (b.c.a.i.i0.b) eVar.getParent();
            int i4 = 0;
            for (b.c.a.i.b bVar2 : eVar.e()) {
                if (bVar2 instanceof g) {
                    g gVar = (g) bVar2;
                    int i5 = i3 - i4;
                    if (gVar.u().size() > i5) {
                        List<g.a> u = gVar.u();
                        b.c.a.i.i0.f G = eVar.G();
                        boolean C = gVar.C();
                        boolean C2 = G.C();
                        long j2 = 0;
                        if (C) {
                            j = 0;
                        } else {
                            if (C2) {
                                v = G.w();
                            } else {
                                b.c.a.i.i0.d dVar = this.e;
                                if (dVar == null) {
                                    throw new RuntimeException("File doesn't contain trex box but track fragments aren't fully self contained. Cannot determine sample size.");
                                }
                                v = dVar.v();
                            }
                            j = v;
                        }
                        SoftReference<ByteBuffer> softReference = this.h.get(gVar);
                        ByteBuffer byteBuffer2 = softReference != null ? softReference.get() : null;
                        if (byteBuffer2 == null) {
                            e eVar2 = bVar;
                            if (G.z()) {
                                j2 = 0 + G.s();
                                eVar2 = bVar.getParent();
                            }
                            if (gVar.x()) {
                                j2 += gVar.s();
                            }
                            int i6 = 0;
                            for (g.a aVar : u) {
                                i6 = C ? (int) (i6 + aVar.l()) : (int) (i6 + j);
                            }
                            try {
                                ByteBuffer s = eVar2.s(j2, i6);
                                this.h.put(gVar, new SoftReference<>(s));
                                byteBuffer = s;
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                        } else {
                            byteBuffer = byteBuffer2;
                        }
                        int i7 = 0;
                        for (int i8 = 0; i8 < i5; i8++) {
                            long j3 = i7;
                            i7 = (int) (C ? j3 + u.get(i8).l() : j3 + j);
                        }
                        a aVar2 = new a(this, C ? u.get(i5).l() : j, byteBuffer, i7);
                        this.f[i] = new SoftReference<>(aVar2);
                        return aVar2;
                    }
                    i4 += gVar.u().size();
                }
            }
            throw new RuntimeException("Couldn't find sample in the traf I was looking");
        }
        return fVar;
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public int size() {
        int i = this.j;
        if (i != -1) {
            return i;
        }
        int i2 = 0;
        for (b.c.a.i.i0.b bVar : this.f1549b.q(b.c.a.i.i0.b.class)) {
            for (b.c.a.i.i0.e eVar : bVar.q(b.c.a.i.i0.e.class)) {
                if (eVar.G().y() == this.f1551d.I().A()) {
                    for (g gVar : eVar.q(g.class)) {
                        i2 = (int) (i2 + gVar.w());
                    }
                }
            }
        }
        for (d dVar : this.f1550c) {
            for (b.c.a.i.i0.b bVar2 : dVar.q(b.c.a.i.i0.b.class)) {
                for (b.c.a.i.i0.e eVar2 : bVar2.q(b.c.a.i.i0.e.class)) {
                    if (eVar2.G().y() == this.f1551d.I().A()) {
                        for (g gVar2 : eVar2.q(g.class)) {
                            i2 = (int) (i2 + gVar2.w());
                        }
                    }
                }
            }
        }
        this.j = i2;
        return i2;
    }
}
