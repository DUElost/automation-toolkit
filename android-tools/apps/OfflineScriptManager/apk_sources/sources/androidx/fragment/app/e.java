package androidx.fragment.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import java.io.FileDescriptor;
import java.io.PrintWriter;
/* loaded from: classes.dex */
public abstract class e<E> extends c {

    /* renamed from: a  reason: collision with root package name */
    private final Activity f967a;

    /* renamed from: b  reason: collision with root package name */
    private final Context f968b;

    /* renamed from: c  reason: collision with root package name */
    private final Handler f969c;

    /* renamed from: d  reason: collision with root package name */
    final g f970d;

    e(Activity activity, Context context, Handler handler, int i) {
        this.f970d = new g();
        this.f967a = activity;
        a.f.k.g.c(context, "context == null");
        this.f968b = context;
        a.f.k.g.c(handler, "handler == null");
        this.f969c = handler;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public e(b bVar) {
        this(bVar, bVar, bVar.f960c, 0);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Activity d() {
        return this.f967a;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Context e() {
        return this.f968b;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public g f() {
        return this.f970d;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Handler g() {
        return this.f969c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract void h(Fragment fragment);

    public abstract void i(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr);

    public abstract LayoutInflater j();

    public abstract int k();

    public abstract boolean l();

    public abstract boolean m(Fragment fragment);

    public abstract void n(Fragment fragment, Intent intent, int i, Bundle bundle);

    public abstract void o();
}
