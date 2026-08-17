package d.n;

import d.q.b;
import java.nio.channels.SelectableChannel;
/* loaded from: classes.dex */
public class c implements d.q.a {

    /* renamed from: b  reason: collision with root package name */
    private final d.q.b f2569b;

    /* renamed from: c  reason: collision with root package name */
    private final d.q.a f2570c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2571d;

    public c(d dVar, d.q.a aVar) {
        this.f2570c = aVar;
        this.f2569b = dVar.z0();
    }

    public final b.a a(SelectableChannel selectableChannel) {
        return this.f2569b.h(selectableChannel, this);
    }

    @Override // d.q.a
    public final void b() {
        this.f2570c.b();
    }

    public final void c(long j, int i) {
        this.f2569b.a(j, this, i);
    }

    public final void d(int i) {
        this.f2569b.c(this, i);
    }

    @Override // d.q.a
    public final void e() {
        this.f2570c.e();
    }

    public final void f() {
        this.f2571d = true;
    }

    public final void g(b.a aVar) {
        this.f2569b.m(aVar);
    }

    @Override // d.q.a
    public final void h(int i) {
        this.f2570c.h(i);
    }

    public final void i(b.a aVar) {
        this.f2569b.n(aVar);
    }

    public final void j(b.a aVar) {
        this.f2569b.o(aVar);
    }

    public final void k(b.a aVar) {
        this.f2569b.p(aVar);
    }

    public final void l(b.a aVar) {
        this.f2569b.q(aVar);
    }

    public final void m(b.a aVar) {
        this.f2569b.r(aVar);
    }

    public final void n(b.a aVar) {
        this.f2569b.s(aVar);
    }

    public final void o() {
        this.f2571d = false;
    }

    @Override // d.q.a
    public final void q() {
        this.f2570c.q();
    }

    @Override // d.q.a
    public final void s() {
        this.f2570c.s();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.f2570c);
        return sb.toString();
    }
}
