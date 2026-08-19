package c.c.a;

import c.c.a.k.i;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Iterator;
/* loaded from: classes.dex */
public class d {

    /* renamed from: a  reason: collision with root package name */
    protected final c.c.a.m.a f1729a;

    /* renamed from: b  reason: collision with root package name */
    private String f1730b;

    /* renamed from: c  reason: collision with root package name */
    protected c.c.a.l.c f1731c;

    /* renamed from: d  reason: collision with root package name */
    protected a f1732d;

    public d() {
        this(new c.c.a.e.c(), new b(), new c.c.a.l.c(), new a(), new c.c.a.m.a());
    }

    public d(c.c.a.e.b bVar, b bVar2, c.c.a.l.c cVar, a aVar, c.c.a.m.a aVar2) {
        if (!bVar.b()) {
            bVar.c(cVar.a());
        } else if (!cVar.b()) {
            cVar.k(bVar.a());
        }
        cVar.i(aVar.b());
        cVar.j(aVar.c());
        cVar.a().e(aVar.j());
        this.f1731c = cVar;
        this.f1732d = aVar;
        this.f1729a = aVar2;
        this.f1730b = "Yaml:" + System.identityHashCode(this);
    }

    private void d(Iterator<? extends Object> it, Writer writer, i iVar) {
        c.c.a.o.a aVar = new c.c.a.o.a(new c.c.a.f.b(writer, this.f1732d), this.f1729a, this.f1732d, iVar);
        try {
            aVar.d();
            while (it.hasNext()) {
                aVar.e(this.f1731c.c(it.next()));
            }
            aVar.b();
        } catch (IOException e) {
            throw new c.c.a.g.b(e);
        }
    }

    public String a(Object obj) {
        ArrayList arrayList = new ArrayList(1);
        arrayList.add(obj);
        return b(arrayList.iterator());
    }

    public String b(Iterator<? extends Object> it) {
        StringWriter stringWriter = new StringWriter();
        c(it, stringWriter);
        return stringWriter.toString();
    }

    public void c(Iterator<? extends Object> it, Writer writer) {
        d(it, writer, this.f1732d.d());
    }

    public String toString() {
        return this.f1730b;
    }
}
