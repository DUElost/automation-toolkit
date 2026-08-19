package b.a.a;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.view.ViewGroup;
import com.afollestad.materialdialogs.internal.MDRootLayout;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class c extends Dialog implements DialogInterface.OnShowListener {

    /* renamed from: b  reason: collision with root package name */
    protected MDRootLayout f1308b;

    /* renamed from: c  reason: collision with root package name */
    private DialogInterface.OnShowListener f1309c;

    /* JADX INFO: Access modifiers changed from: package-private */
    public c(Context context, int i) {
        super(context, i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void b() {
        super.setOnShowListener(this);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void c(View view) {
        super.setContentView(view);
    }

    @Override // android.app.Dialog
    public View findViewById(int i) {
        return this.f1308b.findViewById(i);
    }

    @Override // android.content.DialogInterface.OnShowListener
    public void onShow(DialogInterface dialogInterface) {
        DialogInterface.OnShowListener onShowListener = this.f1309c;
        if (onShowListener != null) {
            onShowListener.onShow(dialogInterface);
        }
    }

    @Override // android.app.Dialog
    @Deprecated
    public void setContentView(int i) {
        throw new IllegalAccessError("setContentView() is not supported in MaterialDialog. Specify a custom view in the Builder instead.");
    }

    @Override // android.app.Dialog
    @Deprecated
    public void setContentView(View view) {
        throw new IllegalAccessError("setContentView() is not supported in MaterialDialog. Specify a custom view in the Builder instead.");
    }

    @Override // android.app.Dialog
    @Deprecated
    public void setContentView(View view, ViewGroup.LayoutParams layoutParams) {
        throw new IllegalAccessError("setContentView() is not supported in MaterialDialog. Specify a custom view in the Builder instead.");
    }

    @Override // android.app.Dialog
    public final void setOnShowListener(DialogInterface.OnShowListener onShowListener) {
        this.f1309c = onShowListener;
    }
}
