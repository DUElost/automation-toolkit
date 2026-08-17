package androidx.fragment.app;

import android.content.Context;
import android.content.res.Configuration;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
/* loaded from: classes.dex */
public class d {

    /* renamed from: a  reason: collision with root package name */
    private final e<?> f966a;

    private d(e<?> eVar) {
        this.f966a = eVar;
    }

    public static d b(e<?> eVar) {
        return new d(eVar);
    }

    public void a(Fragment fragment) {
        e<?> eVar = this.f966a;
        eVar.f970d.o(eVar, eVar, fragment);
    }

    public void c() {
        this.f966a.f970d.w();
    }

    public void d(Configuration configuration) {
        this.f966a.f970d.x(configuration);
    }

    public boolean e(MenuItem menuItem) {
        return this.f966a.f970d.y(menuItem);
    }

    public void f() {
        this.f966a.f970d.z();
    }

    public boolean g(Menu menu, MenuInflater menuInflater) {
        return this.f966a.f970d.A(menu, menuInflater);
    }

    public void h() {
        this.f966a.f970d.B();
    }

    public void i() {
        this.f966a.f970d.D();
    }

    public void j(boolean z) {
        this.f966a.f970d.E(z);
    }

    public boolean k(MenuItem menuItem) {
        return this.f966a.f970d.T(menuItem);
    }

    public void l(Menu menu) {
        this.f966a.f970d.U(menu);
    }

    public void m() {
        this.f966a.f970d.V();
    }

    public void n(boolean z) {
        this.f966a.f970d.W(z);
    }

    public boolean o(Menu menu) {
        return this.f966a.f970d.X(menu);
    }

    public void p() {
        this.f966a.f970d.Y();
    }

    public void q() {
        this.f966a.f970d.Z();
    }

    public void r() {
        this.f966a.f970d.b0();
    }

    public boolean s() {
        return this.f966a.f970d.h0();
    }

    public Fragment t(String str) {
        return this.f966a.f970d.n0(str);
    }

    public f u() {
        return this.f966a.f();
    }

    public void v() {
        this.f966a.f970d.K0();
    }

    public View w(View view, String str, Context context, AttributeSet attributeSet) {
        return this.f966a.f970d.onCreateView(view, str, context, attributeSet);
    }

    public void x(Parcelable parcelable, h hVar) {
        this.f966a.f970d.T0(parcelable, hVar);
    }

    public h y() {
        return this.f966a.f970d.U0();
    }

    public Parcelable z() {
        return this.f966a.f970d.W0();
    }
}
