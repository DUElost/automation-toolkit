package c.b.a.b.b;

import c.b.a.a.a;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class c implements c.b.a.a.a {

    /* renamed from: a  reason: collision with root package name */
    Object f1694a;

    /* renamed from: b  reason: collision with root package name */
    Object f1695b;

    /* renamed from: c  reason: collision with root package name */
    Object[] f1696c;

    /* renamed from: d  reason: collision with root package name */
    a.InterfaceC0057a f1697d;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a implements a.InterfaceC0057a {

        /* renamed from: a  reason: collision with root package name */
        String f1698a;

        /* renamed from: b  reason: collision with root package name */
        c.b.a.a.c f1699b;

        public a(int i, String str, c.b.a.a.c cVar, c.b.a.a.d.b bVar) {
            this.f1698a = str;
            this.f1699b = cVar;
        }

        public String a() {
            return this.f1698a;
        }

        public c.b.a.a.c b() {
            return this.f1699b;
        }

        String c(h hVar) {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(hVar.d(a()));
            stringBuffer.append("(");
            stringBuffer.append(((f) b()).k(hVar));
            stringBuffer.append(")");
            return stringBuffer.toString();
        }

        @Override // c.b.a.a.a.InterfaceC0057a
        public final String toString() {
            return c(h.h);
        }
    }

    public c(a.InterfaceC0057a interfaceC0057a, Object obj, Object obj2, Object[] objArr) {
        this.f1697d = interfaceC0057a;
        this.f1694a = obj;
        this.f1695b = obj2;
        this.f1696c = objArr;
    }

    @Override // c.b.a.a.a
    public Object a() {
        return this.f1695b;
    }

    public final String toString() {
        return this.f1697d.toString();
    }
}
