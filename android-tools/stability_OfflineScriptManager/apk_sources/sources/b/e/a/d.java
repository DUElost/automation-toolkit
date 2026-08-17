package b.e.a;

import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.EOFException;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.WritableByteChannel;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.NoSuchElementException;
/* loaded from: classes.dex */
public class d implements b.c.a.i.e, Iterator<b.c.a.i.b>, Closeable {
    private static final b.c.a.i.b i = new a("eof ");

    /* renamed from: b  reason: collision with root package name */
    protected b.c.a.b f1514b;

    /* renamed from: c  reason: collision with root package name */
    protected e f1515c;

    /* renamed from: d  reason: collision with root package name */
    b.c.a.i.b f1516d = null;
    long e = 0;
    long f = 0;
    long g = 0;
    private List<b.c.a.i.b> h = new ArrayList();

    /* loaded from: classes.dex */
    class a extends b.e.a.a {
        a(String str) {
            super(str);
        }

        @Override // b.e.a.a
        protected void c(ByteBuffer byteBuffer) {
        }

        @Override // b.e.a.a
        protected void d(ByteBuffer byteBuffer) {
        }

        @Override // b.e.a.a
        protected long e() {
            return 0L;
        }
    }

    static {
        b.e.a.j.f.a(d.class);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public long B() {
        long j = 0;
        for (int i2 = 0; i2 < e().size(); i2++) {
            j += this.h.get(i2).a();
        }
        return j;
    }

    public void C(e eVar, long j, b.c.a.b bVar) {
        this.f1515c = eVar;
        long l = eVar.l();
        this.f = l;
        this.e = l;
        eVar.u(eVar.l() + j);
        this.g = eVar.l();
        this.f1514b = bVar;
    }

    @Override // java.util.Iterator
    /* renamed from: D */
    public b.c.a.i.b next() {
        b.c.a.i.b a2;
        b.c.a.i.b bVar = this.f1516d;
        if (bVar != null && bVar != i) {
            this.f1516d = null;
            return bVar;
        }
        e eVar = this.f1515c;
        if (eVar == null || this.e >= this.g) {
            this.f1516d = i;
            throw new NoSuchElementException();
        }
        try {
            synchronized (eVar) {
                this.f1515c.u(this.e);
                a2 = this.f1514b.a(this.f1515c, this);
                this.e = this.f1515c.l();
            }
            return a2;
        } catch (EOFException unused) {
            throw new NoSuchElementException();
        } catch (IOException unused2) {
            throw new NoSuchElementException();
        }
    }

    public void E(List<b.c.a.i.b> list) {
        this.h = new ArrayList(list);
        this.f1516d = i;
        this.f1515c = null;
    }

    public void close() {
        this.f1515c.close();
    }

    @Override // b.c.a.i.e
    public List<b.c.a.i.b> e() {
        return (this.f1515c == null || this.f1516d == i) ? this.h : new b.e.a.j.e(this.h, this);
    }

    @Override // b.c.a.i.e
    public final void h(WritableByteChannel writableByteChannel) {
        for (b.c.a.i.b bVar : e()) {
            bVar.t(writableByteChannel);
        }
    }

    @Override // java.util.Iterator
    public boolean hasNext() {
        b.c.a.i.b bVar = this.f1516d;
        if (bVar == i) {
            return false;
        }
        if (bVar != null) {
            return true;
        }
        try {
            this.f1516d = next();
            return true;
        } catch (NoSuchElementException unused) {
            this.f1516d = i;
            return false;
        }
    }

    @Override // b.c.a.i.e
    public <T extends b.c.a.i.b> List<T> q(Class<T> cls) {
        List<b.c.a.i.b> e = e();
        ArrayList arrayList = null;
        b.c.a.i.b bVar = null;
        for (int i2 = 0; i2 < e.size(); i2++) {
            b.c.a.i.b bVar2 = e.get(i2);
            if (cls.isInstance(bVar2)) {
                if (bVar == null) {
                    bVar = bVar2;
                } else {
                    if (arrayList == null) {
                        arrayList = new ArrayList(2);
                        arrayList.add(bVar);
                    }
                    arrayList.add(bVar2);
                }
            }
        }
        return arrayList != null ? arrayList : bVar != null ? Collections.singletonList(bVar) : Collections.emptyList();
    }

    @Override // java.util.Iterator
    public void remove() {
        throw new UnsupportedOperationException();
    }

    @Override // b.c.a.i.e
    public ByteBuffer s(long j, long j2) {
        ByteBuffer j3;
        e eVar = this.f1515c;
        if (eVar != null) {
            synchronized (eVar) {
                j3 = this.f1515c.j(this.f + j, j2);
            }
            return j3;
        }
        ByteBuffer allocate = ByteBuffer.allocate(b.e.a.j.b.a(j2));
        long j4 = j + j2;
        long j5 = 0;
        for (b.c.a.i.b bVar : this.h) {
            long a2 = bVar.a() + j5;
            if (a2 > j && j5 < j4) {
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                WritableByteChannel newChannel = Channels.newChannel(byteArrayOutputStream);
                bVar.t(newChannel);
                newChannel.close();
                int i2 = (j5 > j ? 1 : (j5 == j ? 0 : -1));
                if (i2 >= 0 && a2 <= j4) {
                    allocate.put(byteArrayOutputStream.toByteArray());
                } else if (i2 < 0 && a2 > j4) {
                    long j6 = j - j5;
                    allocate.put(byteArrayOutputStream.toByteArray(), b.e.a.j.b.a(j6), b.e.a.j.b.a((bVar.a() - j6) - (a2 - j4)));
                } else if (i2 < 0 && a2 <= j4) {
                    long j7 = j - j5;
                    allocate.put(byteArrayOutputStream.toByteArray(), b.e.a.j.b.a(j7), b.e.a.j.b.a(bVar.a() - j7));
                } else if (i2 >= 0 && a2 > j4) {
                    allocate.put(byteArrayOutputStream.toByteArray(), 0, b.e.a.j.b.a(bVar.a() - (a2 - j4)));
                }
            }
            j5 = a2;
        }
        return (ByteBuffer) allocate.rewind();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append("[");
        for (int i2 = 0; i2 < this.h.size(); i2++) {
            if (i2 > 0) {
                sb.append(";");
            }
            sb.append(this.h.get(i2).toString());
        }
        sb.append("]");
        return sb.toString();
    }

    public void v(b.c.a.i.b bVar) {
        if (bVar != null) {
            this.h = new ArrayList(e());
            bVar.m(this);
            this.h.add(bVar);
        }
    }
}
