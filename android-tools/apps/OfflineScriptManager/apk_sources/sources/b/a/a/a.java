package b.a.a;

import android.annotation.TargetApi;
import android.content.res.ColorStateList;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;
import b.a.a.f;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class a extends RecyclerView.g<b> {

    /* renamed from: c  reason: collision with root package name */
    private final f f1302c;

    /* renamed from: d  reason: collision with root package name */
    private final int f1303d;
    private final e e;
    private c f;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: b.a.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static /* synthetic */ class C0042a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1304a;

        static {
            int[] iArr = new int[f.l.values().length];
            f1304a = iArr;
            try {
                iArr[f.l.SINGLE.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1304a[f.l.MULTI.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b extends RecyclerView.c0 implements View.OnClickListener, View.OnLongClickListener {
        final CompoundButton u;
        final TextView v;
        final a w;

        b(View view, a aVar) {
            super(view);
            this.u = (CompoundButton) view.findViewById(k.md_control);
            this.v = (TextView) view.findViewById(k.md_title);
            this.w = aVar;
            view.setOnClickListener(this);
            if (aVar.f1302c.f1314d.F != null) {
                view.setOnLongClickListener(this);
            }
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (this.w.f == null || j() == -1) {
                return;
            }
            CharSequence charSequence = null;
            if (this.w.f1302c.f1314d.l != null && j() < this.w.f1302c.f1314d.l.size()) {
                charSequence = this.w.f1302c.f1314d.l.get(j());
            }
            this.w.f.a(this.w.f1302c, view, j(), charSequence, false);
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            if (this.w.f == null || j() == -1) {
                return false;
            }
            CharSequence charSequence = null;
            if (this.w.f1302c.f1314d.l != null && j() < this.w.f1302c.f1314d.l.size()) {
                charSequence = this.w.f1302c.f1314d.l.get(j());
            }
            return this.w.f.a(this.w.f1302c, view, j(), charSequence, true);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface c {
        boolean a(f fVar, View view, int i, CharSequence charSequence, boolean z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(f fVar, int i) {
        this.f1302c = fVar;
        this.f1303d = i;
        this.e = fVar.f1314d.f;
    }

    @TargetApi(17)
    private void B(ViewGroup viewGroup) {
        ((LinearLayout) viewGroup).setGravity(this.e.a() | 16);
        if (viewGroup.getChildCount() == 2) {
            if (this.e == e.END && !x() && (viewGroup.getChildAt(0) instanceof CompoundButton)) {
                View view = (CompoundButton) viewGroup.getChildAt(0);
                viewGroup.removeView(view);
                TextView textView = (TextView) viewGroup.getChildAt(0);
                viewGroup.removeView(textView);
                textView.setPadding(textView.getPaddingRight(), textView.getPaddingTop(), textView.getPaddingLeft(), textView.getPaddingBottom());
                viewGroup.addView(textView);
                viewGroup.addView(view);
            } else if (this.e == e.START && x() && (viewGroup.getChildAt(1) instanceof CompoundButton)) {
                View view2 = (CompoundButton) viewGroup.getChildAt(1);
                viewGroup.removeView(view2);
                TextView textView2 = (TextView) viewGroup.getChildAt(0);
                viewGroup.removeView(textView2);
                textView2.setPadding(textView2.getPaddingRight(), textView2.getPaddingTop(), textView2.getPaddingRight(), textView2.getPaddingBottom());
                viewGroup.addView(view2);
                viewGroup.addView(textView2);
            }
        }
    }

    @TargetApi(17)
    private boolean x() {
        return Build.VERSION.SDK_INT >= 17 && this.f1302c.f().e().getResources().getConfiguration().getLayoutDirection() == 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void A(c cVar) {
        this.f = cVar;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int c() {
        ArrayList<CharSequence> arrayList = this.f1302c.f1314d.l;
        if (arrayList != null) {
            return arrayList.size();
        }
        return 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: y */
    public void l(b bVar, int i) {
        View childAt;
        View view = bVar.f1123b;
        boolean h = b.a.a.q.a.h(Integer.valueOf(i), this.f1302c.f1314d.Q);
        int i2 = this.f1302c.f1314d.h0;
        if (h) {
            i2 = b.a.a.q.a.a(i2, 0.4f);
        }
        bVar.f1123b.setEnabled(!h);
        int i3 = C0042a.f1304a[this.f1302c.t.ordinal()];
        if (i3 == 1) {
            RadioButton radioButton = (RadioButton) bVar.u;
            f.d dVar = this.f1302c.f1314d;
            boolean z = dVar.O == i;
            ColorStateList colorStateList = dVar.u;
            if (colorStateList != null) {
                com.afollestad.materialdialogs.internal.c.i(radioButton, colorStateList);
            } else {
                com.afollestad.materialdialogs.internal.c.h(radioButton, dVar.t);
            }
            radioButton.setChecked(z);
            radioButton.setEnabled(!h);
        } else if (i3 == 2) {
            CheckBox checkBox = (CheckBox) bVar.u;
            boolean contains = this.f1302c.u.contains(Integer.valueOf(i));
            f.d dVar2 = this.f1302c.f1314d;
            ColorStateList colorStateList2 = dVar2.u;
            if (colorStateList2 != null) {
                com.afollestad.materialdialogs.internal.c.d(checkBox, colorStateList2);
            } else {
                com.afollestad.materialdialogs.internal.c.c(checkBox, dVar2.t);
            }
            checkBox.setChecked(contains);
            checkBox.setEnabled(!h);
        }
        bVar.v.setText(this.f1302c.f1314d.l.get(i));
        bVar.v.setTextColor(i2);
        f fVar = this.f1302c;
        fVar.p(bVar.v, fVar.f1314d.S);
        ViewGroup viewGroup = (ViewGroup) view;
        B(viewGroup);
        int[] iArr = this.f1302c.f1314d.v0;
        if (iArr != null) {
            view.setId(i < iArr.length ? iArr[i] : -1);
        }
        if (Build.VERSION.SDK_INT < 21 || viewGroup.getChildCount() != 2) {
            return;
        }
        if (viewGroup.getChildAt(0) instanceof CompoundButton) {
            childAt = viewGroup.getChildAt(0);
        } else if (!(viewGroup.getChildAt(1) instanceof CompoundButton)) {
            return;
        } else {
            childAt = viewGroup.getChildAt(1);
        }
        childAt.setBackground(null);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: z */
    public b n(ViewGroup viewGroup, int i) {
        View inflate = LayoutInflater.from(viewGroup.getContext()).inflate(this.f1303d, viewGroup, false);
        b.a.a.q.a.t(inflate, this.f1302c.i());
        return new b(inflate, this);
    }
}
