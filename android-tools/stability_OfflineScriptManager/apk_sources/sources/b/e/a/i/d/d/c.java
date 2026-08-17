package b.e.a.i.d.d;

import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.List;
/* loaded from: classes.dex */
public class c extends b {

    /* renamed from: a  reason: collision with root package name */
    private short f1582a;

    /* renamed from: b  reason: collision with root package name */
    private short f1583b;

    /* renamed from: c  reason: collision with root package name */
    private List<a> f1584c = new LinkedList();

    /* renamed from: d  reason: collision with root package name */
    private int f1585d;
    private int e;
    private short f;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        int f1586a;

        /* renamed from: b  reason: collision with root package name */
        short f1587b;

        public a(int i, short s) {
            this.f1586a = i;
            this.f1587b = s;
        }

        public int a() {
            return this.f1586a;
        }

        public short b() {
            return this.f1587b;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || a.class != obj.getClass()) {
                return false;
            }
            a aVar = (a) obj;
            return this.f1586a == aVar.f1586a && this.f1587b == aVar.f1587b;
        }

        public int hashCode() {
            return (this.f1586a * 31) + this.f1587b;
        }

        public String toString() {
            return "{availableBitrate=" + this.f1586a + ", targetRateShare=" + ((int) this.f1587b) + '}';
        }
    }

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        short s = this.f1582a;
        ByteBuffer allocate = ByteBuffer.allocate(s == 1 ? 13 : (s * 6) + 11);
        allocate.putShort(this.f1582a);
        if (this.f1582a == 1) {
            allocate.putShort(this.f1583b);
        } else {
            for (a aVar : this.f1584c) {
                allocate.putInt(aVar.a());
                allocate.putShort(aVar.b());
            }
        }
        allocate.putInt(this.f1585d);
        allocate.putInt(this.e);
        b.c.a.f.j(allocate, this.f);
        allocate.rewind();
        return allocate;
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "rash";
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r1v1, types: [int] */
    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        short s = byteBuffer.getShort();
        this.f1582a = s;
        if (s == 1) {
            this.f1583b = byteBuffer.getShort();
        } else {
            while (true) {
                ?? r1 = s - 1;
                if (s <= 0) {
                    break;
                }
                this.f1584c.add(new a(b.e.a.j.b.a(b.c.a.e.k(byteBuffer)), byteBuffer.getShort()));
                s = r1;
            }
        }
        this.f1585d = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.e = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.f = (short) b.c.a.e.n(byteBuffer);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || c.class != obj.getClass()) {
            return false;
        }
        c cVar = (c) obj;
        if (this.f == cVar.f && this.f1585d == cVar.f1585d && this.e == cVar.e && this.f1582a == cVar.f1582a && this.f1583b == cVar.f1583b) {
            List<a> list = this.f1584c;
            List<a> list2 = cVar.f1584c;
            return list == null ? list2 == null : list.equals(list2);
        }
        return false;
    }

    public int hashCode() {
        int i = ((this.f1582a * 31) + this.f1583b) * 31;
        List<a> list = this.f1584c;
        return ((((((i + (list != null ? list.hashCode() : 0)) * 31) + this.f1585d) * 31) + this.e) * 31) + this.f;
    }
}
