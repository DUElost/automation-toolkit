package androidx.appcompat.app;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.ContextThemeWrapper;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ListAdapter;
import androidx.appcompat.app.AlertController;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class b extends f implements DialogInterface {

    /* renamed from: d  reason: collision with root package name */
    final AlertController f480d;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private final AlertController.f f481a;

        /* renamed from: b  reason: collision with root package name */
        private final int f482b;

        public a(Context context) {
            this(context, b.e(context, 0));
        }

        public a(Context context, int i) {
            this.f481a = new AlertController.f(new ContextThemeWrapper(context, b.e(context, i)));
            this.f482b = i;
        }

        public b a() {
            b bVar = new b(this.f481a.f433a, this.f482b);
            this.f481a.a(bVar.f480d);
            bVar.setCancelable(this.f481a.r);
            if (this.f481a.r) {
                bVar.setCanceledOnTouchOutside(true);
            }
            bVar.setOnCancelListener(this.f481a.s);
            bVar.setOnDismissListener(this.f481a.t);
            DialogInterface.OnKeyListener onKeyListener = this.f481a.u;
            if (onKeyListener != null) {
                bVar.setOnKeyListener(onKeyListener);
            }
            return bVar;
        }

        public Context b() {
            return this.f481a.f433a;
        }

        public a c(ListAdapter listAdapter, DialogInterface.OnClickListener onClickListener) {
            AlertController.f fVar = this.f481a;
            fVar.w = listAdapter;
            fVar.x = onClickListener;
            return this;
        }

        public a d(View view) {
            this.f481a.g = view;
            return this;
        }

        public a e(Drawable drawable) {
            this.f481a.f436d = drawable;
            return this;
        }

        public a f(DialogInterface.OnKeyListener onKeyListener) {
            this.f481a.u = onKeyListener;
            return this;
        }

        public a g(CharSequence charSequence) {
            this.f481a.f = charSequence;
            return this;
        }
    }

    protected b(Context context, int i) {
        super(context, e(context, i));
        this.f480d = new AlertController(getContext(), this, getWindow());
    }

    static int e(Context context, int i) {
        if (((i >>> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) >= 1) {
            return i;
        }
        TypedValue typedValue = new TypedValue();
        context.getTheme().resolveAttribute(a.a.a.alertDialogTheme, typedValue, true);
        return typedValue.resourceId;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.f, android.app.Dialog
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.f480d.d();
    }

    @Override // android.app.Dialog, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (this.f480d.f(i, keyEvent)) {
            return true;
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // android.app.Dialog, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        if (this.f480d.g(i, keyEvent)) {
            return true;
        }
        return super.onKeyUp(i, keyEvent);
    }

    @Override // androidx.appcompat.app.f, android.app.Dialog
    public void setTitle(CharSequence charSequence) {
        super.setTitle(charSequence);
        this.f480d.p(charSequence);
    }
}
