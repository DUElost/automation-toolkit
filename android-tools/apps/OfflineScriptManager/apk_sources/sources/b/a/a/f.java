package b.a.a;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import b.a.a.a;
import com.afollestad.materialdialogs.internal.MDButton;
import com.afollestad.materialdialogs.internal.MDRootLayout;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
/* loaded from: classes.dex */
public class f extends b.a.a.c implements View.OnClickListener, a.c {

    /* renamed from: d  reason: collision with root package name */
    protected final d f1314d;
    protected ImageView e;
    protected TextView f;
    protected TextView g;
    EditText h;
    RecyclerView i;
    View j;
    FrameLayout k;
    ProgressBar l;
    TextView m;
    TextView n;
    TextView o;
    CheckBox p;
    MDButton q;
    MDButton r;
    MDButton s;
    l t;
    List<Integer> u;

    /* loaded from: classes.dex */
    class a implements ViewTreeObserver.OnGlobalLayoutListener {

        /* renamed from: b.a.a.f$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        class RunnableC0043a implements Runnable {

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ int f1316b;

            RunnableC0043a(int i) {
                this.f1316b = i;
            }

            @Override // java.lang.Runnable
            public void run() {
                f.this.i.requestFocus();
                f.this.f1314d.Y.u1(this.f1316b);
            }
        }

        a() {
        }

        @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
        public void onGlobalLayout() {
            int intValue;
            if (Build.VERSION.SDK_INT < 16) {
                f.this.i.getViewTreeObserver().removeGlobalOnLayoutListener(this);
            } else {
                f.this.i.getViewTreeObserver().removeOnGlobalLayoutListener(this);
            }
            f fVar = f.this;
            l lVar = fVar.t;
            l lVar2 = l.SINGLE;
            if (lVar == lVar2 || lVar == l.MULTI) {
                if (lVar == lVar2) {
                    intValue = fVar.f1314d.O;
                    if (intValue < 0) {
                        return;
                    }
                } else {
                    List<Integer> list = fVar.u;
                    if (list == null || list.size() == 0) {
                        return;
                    }
                    Collections.sort(f.this.u);
                    intValue = f.this.u.get(0).intValue();
                }
                f.this.i.post(new RunnableC0043a(intValue));
            }
        }
    }

    /* loaded from: classes.dex */
    class b implements TextWatcher {
        b() {
        }

        @Override // android.text.TextWatcher
        public void afterTextChanged(Editable editable) {
        }

        @Override // android.text.TextWatcher
        public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        }

        @Override // android.text.TextWatcher
        public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            int length = charSequence.toString().length();
            f fVar = f.this;
            if (!fVar.f1314d.p0) {
                r0 = length == 0;
                fVar.e(b.a.a.b.POSITIVE).setEnabled(!r0);
            }
            f.this.k(length, r0);
            f fVar2 = f.this;
            d dVar = fVar2.f1314d;
            if (dVar.r0) {
                dVar.o0.a(fVar2, charSequence);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static /* synthetic */ class c {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1319a;

        /* renamed from: b  reason: collision with root package name */
        static final /* synthetic */ int[] f1320b;

        static {
            int[] iArr = new int[l.values().length];
            f1320b = iArr;
            try {
                iArr[l.REGULAR.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1320b[l.SINGLE.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f1320b[l.MULTI.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            int[] iArr2 = new int[b.a.a.b.values().length];
            f1319a = iArr2;
            try {
                iArr2[b.a.a.b.NEUTRAL.ordinal()] = 1;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                f1319a[b.a.a.b.NEGATIVE.ordinal()] = 2;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                f1319a[b.a.a.b.POSITIVE.ordinal()] = 3;
            } catch (NoSuchFieldError unused6) {
            }
        }
    }

    /* loaded from: classes.dex */
    public static class d {
        protected m A;
        protected NumberFormat A0;
        protected m B;
        protected boolean B0;
        protected m C;
        protected boolean C0;
        protected m D;
        protected boolean D0;
        protected h E;
        protected boolean E0;
        protected k F;
        protected boolean F0;
        protected j G;
        protected boolean G0;
        protected i H;
        protected boolean H0;
        protected boolean I;
        protected boolean I0;
        protected boolean J;
        protected boolean J0;
        protected p K;
        protected int K0;
        protected boolean L;
        protected int L0;
        protected boolean M;
        protected int M0;
        protected float N;
        protected int N0;
        protected int O;
        protected int O0;
        protected Integer[] P;
        protected Integer[] Q;
        protected boolean R;
        protected Typeface S;
        protected Typeface T;
        protected Drawable U;
        protected boolean V;
        protected int W;
        protected RecyclerView.g<?> X;
        protected RecyclerView.o Y;
        protected DialogInterface.OnDismissListener Z;

        /* renamed from: a  reason: collision with root package name */
        protected final Context f1321a;
        protected DialogInterface.OnCancelListener a0;

        /* renamed from: b  reason: collision with root package name */
        protected CharSequence f1322b;
        protected DialogInterface.OnKeyListener b0;

        /* renamed from: c  reason: collision with root package name */
        protected b.a.a.e f1323c;
        protected DialogInterface.OnShowListener c0;

        /* renamed from: d  reason: collision with root package name */
        protected b.a.a.e f1324d;
        protected o d0;
        protected b.a.a.e e;
        protected boolean e0;
        protected b.a.a.e f;
        protected int f0;
        protected b.a.a.e g;
        protected int g0;
        protected int h;
        protected int h0;
        protected int i;
        protected boolean i0;
        protected int j;
        protected boolean j0;
        protected CharSequence k;
        protected int k0;
        protected ArrayList<CharSequence> l;
        protected int l0;
        protected CharSequence m;
        protected CharSequence m0;
        protected CharSequence n;
        protected CharSequence n0;
        protected CharSequence o;
        protected g o0;
        protected boolean p;
        protected boolean p0;
        protected boolean q;
        protected int q0;
        protected boolean r;
        protected boolean r0;
        protected View s;
        protected int s0;
        protected int t;
        protected int t0;
        protected ColorStateList u;
        protected int u0;
        protected ColorStateList v;
        protected int[] v0;
        protected ColorStateList w;
        protected CharSequence w0;
        protected ColorStateList x;
        protected boolean x0;
        protected ColorStateList y;
        protected CompoundButton.OnCheckedChangeListener y0;
        protected e z;
        protected String z0;

        public d(Context context) {
            b.a.a.e eVar = b.a.a.e.START;
            this.f1323c = eVar;
            this.f1324d = eVar;
            this.e = b.a.a.e.END;
            this.f = eVar;
            this.g = eVar;
            this.h = 0;
            this.i = -1;
            this.j = -1;
            this.I = false;
            this.J = false;
            p pVar = p.LIGHT;
            this.K = pVar;
            this.L = true;
            this.M = true;
            this.N = 1.2f;
            this.O = -1;
            this.P = null;
            this.Q = null;
            this.R = true;
            this.W = -1;
            this.k0 = -2;
            this.l0 = 0;
            this.q0 = -1;
            this.s0 = -1;
            this.t0 = -1;
            this.u0 = 0;
            this.C0 = false;
            this.D0 = false;
            this.E0 = false;
            this.F0 = false;
            this.G0 = false;
            this.H0 = false;
            this.I0 = false;
            this.J0 = false;
            this.f1321a = context;
            int m = b.a.a.q.a.m(context, b.a.a.g.colorAccent, b.a.a.q.a.c(context, b.a.a.h.md_material_blue_600));
            this.t = m;
            int i = Build.VERSION.SDK_INT;
            if (i >= 21) {
                this.t = b.a.a.q.a.m(context, 16843829, m);
            }
            this.v = b.a.a.q.a.b(context, this.t);
            this.w = b.a.a.q.a.b(context, this.t);
            this.x = b.a.a.q.a.b(context, this.t);
            this.y = b.a.a.q.a.b(context, b.a.a.q.a.m(context, b.a.a.g.md_link_color, this.t));
            this.h = b.a.a.q.a.m(context, b.a.a.g.md_btn_ripple_color, b.a.a.q.a.m(context, b.a.a.g.colorControlHighlight, i >= 21 ? b.a.a.q.a.l(context, 16843820) : 0));
            this.A0 = NumberFormat.getPercentInstance();
            this.z0 = "%1d/%2d";
            this.K = b.a.a.q.a.g(b.a.a.q.a.l(context, 16842806)) ? pVar : p.DARK;
            c();
            this.f1323c = b.a.a.q.a.r(context, b.a.a.g.md_title_gravity, this.f1323c);
            this.f1324d = b.a.a.q.a.r(context, b.a.a.g.md_content_gravity, this.f1324d);
            this.e = b.a.a.q.a.r(context, b.a.a.g.md_btnstacked_gravity, this.e);
            this.f = b.a.a.q.a.r(context, b.a.a.g.md_items_gravity, this.f);
            this.g = b.a.a.q.a.r(context, b.a.a.g.md_buttons_gravity, this.g);
            try {
                o(b.a.a.q.a.s(context, b.a.a.g.md_medium_font), b.a.a.q.a.s(context, b.a.a.g.md_regular_font));
            } catch (Throwable unused) {
            }
            if (this.T == null) {
                try {
                    this.T = Build.VERSION.SDK_INT >= 21 ? Typeface.create("sans-serif-medium", 0) : Typeface.create("sans-serif", 1);
                } catch (Throwable unused2) {
                    this.T = Typeface.DEFAULT_BOLD;
                }
            }
            if (this.S == null) {
                try {
                    this.S = Typeface.create("sans-serif", 0);
                } catch (Throwable unused3) {
                    Typeface typeface = Typeface.SANS_SERIF;
                    this.S = typeface;
                    if (typeface == null) {
                        this.S = Typeface.DEFAULT;
                    }
                }
            }
        }

        private void c() {
            if (com.afollestad.materialdialogs.internal.d.b(false) == null) {
                return;
            }
            com.afollestad.materialdialogs.internal.d a2 = com.afollestad.materialdialogs.internal.d.a();
            if (a2.f1872a) {
                this.K = p.DARK;
            }
            int i = a2.f1873b;
            if (i != 0) {
                this.i = i;
            }
            int i2 = a2.f1874c;
            if (i2 != 0) {
                this.j = i2;
            }
            ColorStateList colorStateList = a2.f1875d;
            if (colorStateList != null) {
                this.v = colorStateList;
            }
            ColorStateList colorStateList2 = a2.e;
            if (colorStateList2 != null) {
                this.x = colorStateList2;
            }
            ColorStateList colorStateList3 = a2.f;
            if (colorStateList3 != null) {
                this.w = colorStateList3;
            }
            int i3 = a2.h;
            if (i3 != 0) {
                this.h0 = i3;
            }
            Drawable drawable = a2.i;
            if (drawable != null) {
                this.U = drawable;
            }
            int i4 = a2.j;
            if (i4 != 0) {
                this.g0 = i4;
            }
            int i5 = a2.k;
            if (i5 != 0) {
                this.f0 = i5;
            }
            int i6 = a2.n;
            if (i6 != 0) {
                this.L0 = i6;
            }
            int i7 = a2.m;
            if (i7 != 0) {
                this.K0 = i7;
            }
            int i8 = a2.o;
            if (i8 != 0) {
                this.M0 = i8;
            }
            int i9 = a2.p;
            if (i9 != 0) {
                this.N0 = i9;
            }
            int i10 = a2.q;
            if (i10 != 0) {
                this.O0 = i10;
            }
            int i11 = a2.g;
            if (i11 != 0) {
                this.t = i11;
            }
            ColorStateList colorStateList4 = a2.l;
            if (colorStateList4 != null) {
                this.y = colorStateList4;
            }
            this.f1323c = a2.r;
            this.f1324d = a2.s;
            this.e = a2.t;
            this.f = a2.u;
            this.g = a2.v;
        }

        public f a() {
            return new f(this);
        }

        public d b(e eVar) {
            this.z = eVar;
            return this;
        }

        public d d(View view, boolean z) {
            if (this.k == null) {
                if (this.l == null) {
                    if (this.o0 == null) {
                        if (this.k0 > -2 || this.i0) {
                            throw new IllegalStateException("You cannot use customView() with a progress dialog");
                        }
                        if (view.getParent() != null && (view.getParent() instanceof ViewGroup)) {
                            ((ViewGroup) view.getParent()).removeView(view);
                        }
                        this.s = view;
                        this.e0 = z;
                        return this;
                    }
                    throw new IllegalStateException("You cannot use customView() with an input dialog");
                }
                throw new IllegalStateException("You cannot use customView() when you have items set.");
            }
            throw new IllegalStateException("You cannot use customView() when you have content set.");
        }

        public final Context e() {
            return this.f1321a;
        }

        public d f(int i) {
            if (i == 0) {
                return this;
            }
            g(this.f1321a.getText(i));
            return this;
        }

        public d g(CharSequence charSequence) {
            this.o = charSequence;
            return this;
        }

        public d h(m mVar) {
            this.B = mVar;
            return this;
        }

        public d i(m mVar) {
            this.A = mVar;
            return this;
        }

        public d j(int i) {
            if (i == 0) {
                return this;
            }
            k(this.f1321a.getText(i));
            return this;
        }

        public d k(CharSequence charSequence) {
            this.m = charSequence;
            return this;
        }

        public d l(p pVar) {
            this.K = pVar;
            return this;
        }

        public d m(CharSequence charSequence) {
            this.f1322b = charSequence;
            return this;
        }

        public d n(int i) {
            this.i = i;
            this.C0 = true;
            return this;
        }

        public d o(String str, String str2) {
            if (str != null && !str.trim().isEmpty()) {
                Typeface a2 = b.a.a.q.c.a(this.f1321a, str);
                this.T = a2;
                if (a2 == null) {
                    throw new IllegalArgumentException("No font asset found for \"" + str + "\"");
                }
            }
            if (str2 != null && !str2.trim().isEmpty()) {
                Typeface a3 = b.a.a.q.c.a(this.f1321a, str2);
                this.S = a3;
                if (a3 == null) {
                    throw new IllegalArgumentException("No font asset found for \"" + str2 + "\"");
                }
            }
            return this;
        }
    }

    @Deprecated
    /* loaded from: classes.dex */
    public static abstract class e {
        @Deprecated
        public void a(f fVar) {
        }

        @Deprecated
        public void b(f fVar) {
        }

        @Deprecated
        public void c(f fVar) {
        }

        protected final Object clone() {
            return super.clone();
        }

        @Deprecated
        public void d(f fVar) {
        }

        public final boolean equals(Object obj) {
            return super.equals(obj);
        }

        protected final void finalize() {
            super.finalize();
        }

        public final int hashCode() {
            return super.hashCode();
        }

        public final String toString() {
            return super.toString();
        }
    }

    /* renamed from: b.a.a.f$f  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private static class C0044f extends WindowManager.BadTokenException {
        C0044f(String str) {
            super(str);
        }
    }

    /* loaded from: classes.dex */
    public interface g {
        void a(f fVar, CharSequence charSequence);
    }

    /* loaded from: classes.dex */
    public interface h {
        void a(f fVar, View view, int i, CharSequence charSequence);
    }

    /* loaded from: classes.dex */
    public interface i {
        boolean a(f fVar, Integer[] numArr, CharSequence[] charSequenceArr);
    }

    /* loaded from: classes.dex */
    public interface j {
        boolean a(f fVar, View view, int i, CharSequence charSequence);
    }

    /* loaded from: classes.dex */
    public interface k {
        boolean a(f fVar, View view, int i, CharSequence charSequence);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public enum l {
        REGULAR,
        SINGLE,
        MULTI;

        public static int a(l lVar) {
            int i = c.f1320b[lVar.ordinal()];
            if (i != 1) {
                if (i != 2) {
                    if (i == 3) {
                        return b.a.a.l.md_listitem_multichoice;
                    }
                    throw new IllegalArgumentException("Not a valid list type");
                }
                return b.a.a.l.md_listitem_singlechoice;
            }
            return b.a.a.l.md_listitem;
        }
    }

    /* loaded from: classes.dex */
    public interface m {
        void a(f fVar, b.a.a.b bVar);
    }

    @SuppressLint({"InflateParams"})
    protected f(d dVar) {
        super(dVar.f1321a, b.a.a.d.c(dVar));
        new Handler();
        this.f1314d = dVar;
        this.f1308b = (MDRootLayout) LayoutInflater.from(dVar.f1321a).inflate(b.a.a.d.b(dVar), (ViewGroup) null);
        b.a.a.d.d(this);
    }

    private boolean m() {
        if (this.f1314d.H == null) {
            return false;
        }
        Collections.sort(this.u);
        ArrayList arrayList = new ArrayList();
        for (Integer num : this.u) {
            if (num.intValue() >= 0 && num.intValue() <= this.f1314d.l.size() - 1) {
                arrayList.add(this.f1314d.l.get(num.intValue()));
            }
        }
        i iVar = this.f1314d.H;
        List<Integer> list = this.u;
        return iVar.a(this, (Integer[]) list.toArray(new Integer[list.size()]), (CharSequence[]) arrayList.toArray(new CharSequence[arrayList.size()]));
    }

    private boolean n(View view) {
        d dVar = this.f1314d;
        if (dVar.G == null) {
            return false;
        }
        CharSequence charSequence = null;
        int i2 = dVar.O;
        if (i2 >= 0 && i2 < dVar.l.size()) {
            d dVar2 = this.f1314d;
            charSequence = dVar2.l.get(dVar2.O);
        }
        d dVar3 = this.f1314d;
        return dVar3.G.a(this, view, dVar3.O, charSequence);
    }

    @Override // b.a.a.a.c
    public boolean a(f fVar, View view, int i2, CharSequence charSequence, boolean z) {
        d dVar;
        k kVar;
        d dVar2;
        h hVar;
        boolean z2 = false;
        if (view.isEnabled()) {
            l lVar = this.t;
            if (lVar == null || lVar == l.REGULAR) {
                if (this.f1314d.R) {
                    dismiss();
                }
                if (!z && (hVar = (dVar2 = this.f1314d).E) != null) {
                    hVar.a(this, view, i2, dVar2.l.get(i2));
                }
                if (z && (kVar = (dVar = this.f1314d).F) != null) {
                    return kVar.a(this, view, i2, dVar.l.get(i2));
                }
            } else if (lVar == l.MULTI) {
                CheckBox checkBox = (CheckBox) view.findViewById(b.a.a.k.md_control);
                if (!checkBox.isEnabled()) {
                    return false;
                }
                if (!this.u.contains(Integer.valueOf(i2))) {
                    this.u.add(Integer.valueOf(i2));
                    if (!this.f1314d.I || m()) {
                        checkBox.setChecked(true);
                    } else {
                        this.u.remove(Integer.valueOf(i2));
                    }
                } else {
                    this.u.remove(Integer.valueOf(i2));
                    if (!this.f1314d.I || m()) {
                        checkBox.setChecked(false);
                    } else {
                        this.u.add(Integer.valueOf(i2));
                    }
                }
            } else if (lVar == l.SINGLE) {
                RadioButton radioButton = (RadioButton) view.findViewById(b.a.a.k.md_control);
                if (!radioButton.isEnabled()) {
                    return false;
                }
                d dVar3 = this.f1314d;
                int i3 = dVar3.O;
                if (dVar3.R && dVar3.m == null) {
                    dismiss();
                    this.f1314d.O = i2;
                    n(view);
                } else if (dVar3.J) {
                    dVar3.O = i2;
                    z2 = n(view);
                    this.f1314d.O = i3;
                } else {
                    z2 = true;
                }
                if (z2) {
                    this.f1314d.O = i2;
                    radioButton.setChecked(true);
                    this.f1314d.X.h(i3);
                    this.f1314d.X.h(i2);
                }
            }
            return true;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void d() {
        RecyclerView recyclerView = this.i;
        if (recyclerView == null) {
            return;
        }
        recyclerView.getViewTreeObserver().addOnGlobalLayoutListener(new a());
    }

    @Override // android.app.Dialog, android.content.DialogInterface
    public void dismiss() {
        if (this.h != null) {
            b.a.a.q.a.f(this, this.f1314d);
        }
        super.dismiss();
    }

    public final MDButton e(b.a.a.b bVar) {
        int i2 = c.f1319a[bVar.ordinal()];
        return i2 != 1 ? i2 != 2 ? this.q : this.s : this.r;
    }

    public final d f() {
        return this.f1314d;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Drawable g(b.a.a.b bVar, boolean z) {
        if (z) {
            d dVar = this.f1314d;
            int i2 = dVar.L0;
            Context context = dVar.f1321a;
            if (i2 != 0) {
                return androidx.core.content.c.f.a(context.getResources(), this.f1314d.L0, null);
            }
            int i3 = b.a.a.g.md_btn_stacked_selector;
            Drawable p = b.a.a.q.a.p(context, i3);
            return p != null ? p : b.a.a.q.a.p(getContext(), i3);
        }
        int i4 = c.f1319a[bVar.ordinal()];
        if (i4 == 1) {
            d dVar2 = this.f1314d;
            int i5 = dVar2.N0;
            Context context2 = dVar2.f1321a;
            if (i5 != 0) {
                return androidx.core.content.c.f.a(context2.getResources(), this.f1314d.N0, null);
            }
            int i6 = b.a.a.g.md_btn_neutral_selector;
            Drawable p2 = b.a.a.q.a.p(context2, i6);
            if (p2 != null) {
                return p2;
            }
            Drawable p3 = b.a.a.q.a.p(getContext(), i6);
            if (Build.VERSION.SDK_INT >= 21) {
                b.a.a.q.b.a(p3, this.f1314d.h);
            }
            return p3;
        } else if (i4 != 2) {
            d dVar3 = this.f1314d;
            int i7 = dVar3.M0;
            Context context3 = dVar3.f1321a;
            if (i7 != 0) {
                return androidx.core.content.c.f.a(context3.getResources(), this.f1314d.M0, null);
            }
            int i8 = b.a.a.g.md_btn_positive_selector;
            Drawable p4 = b.a.a.q.a.p(context3, i8);
            if (p4 != null) {
                return p4;
            }
            Drawable p5 = b.a.a.q.a.p(getContext(), i8);
            if (Build.VERSION.SDK_INT >= 21) {
                b.a.a.q.b.a(p5, this.f1314d.h);
            }
            return p5;
        } else {
            d dVar4 = this.f1314d;
            int i9 = dVar4.O0;
            Context context4 = dVar4.f1321a;
            if (i9 != 0) {
                return androidx.core.content.c.f.a(context4.getResources(), this.f1314d.O0, null);
            }
            int i10 = b.a.a.g.md_btn_negative_selector;
            Drawable p6 = b.a.a.q.a.p(context4, i10);
            if (p6 != null) {
                return p6;
            }
            Drawable p7 = b.a.a.q.a.p(getContext(), i10);
            if (Build.VERSION.SDK_INT >= 21) {
                b.a.a.q.b.a(p7, this.f1314d.h);
            }
            return p7;
        }
    }

    public final EditText h() {
        return this.h;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final Drawable i() {
        d dVar = this.f1314d;
        int i2 = dVar.K0;
        Context context = dVar.f1321a;
        if (i2 != 0) {
            return androidx.core.content.c.f.a(context.getResources(), this.f1314d.K0, null);
        }
        int i3 = b.a.a.g.md_list_selector;
        Drawable p = b.a.a.q.a.p(context, i3);
        return p != null ? p : b.a.a.q.a.p(getContext(), i3);
    }

    public final View j() {
        return this.f1308b;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void k(int i2, boolean z) {
        d dVar;
        int i3;
        TextView textView = this.o;
        if (textView != null) {
            if (this.f1314d.t0 > 0) {
                textView.setText(String.format(Locale.getDefault(), "%d/%d", Integer.valueOf(i2), Integer.valueOf(this.f1314d.t0)));
                this.o.setVisibility(0);
            } else {
                textView.setVisibility(8);
            }
            boolean z2 = (z && i2 == 0) || ((i3 = (dVar = this.f1314d).t0) > 0 && i2 > i3) || i2 < dVar.s0;
            d dVar2 = this.f1314d;
            int i4 = z2 ? dVar2.u0 : dVar2.j;
            d dVar3 = this.f1314d;
            int i5 = z2 ? dVar3.u0 : dVar3.t;
            if (this.f1314d.t0 > 0) {
                this.o.setTextColor(i4);
            }
            com.afollestad.materialdialogs.internal.c.e(this.h, i5);
            e(b.a.a.b.POSITIVE).setEnabled(!z2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void l() {
        if (this.i == null) {
            return;
        }
        ArrayList<CharSequence> arrayList = this.f1314d.l;
        if ((arrayList == null || arrayList.size() == 0) && this.f1314d.X == null) {
            return;
        }
        d dVar = this.f1314d;
        if (dVar.Y == null) {
            dVar.Y = new LinearLayoutManager(getContext());
        }
        this.i.setLayoutManager(this.f1314d.Y);
        this.i.setAdapter(this.f1314d.X);
        if (this.t != null) {
            ((b.a.a.a) this.f1314d.X).A(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o() {
        EditText editText = this.h;
        if (editText == null) {
            return;
        }
        editText.addTextChangedListener(new b());
    }

    /* JADX WARN: Code restructure failed: missing block: B:29:0x005d, code lost:
        if (r3.f1314d.R != false) goto L28;
     */
    /* JADX WARN: Code restructure failed: missing block: B:47:0x00a0, code lost:
        if (r3.f1314d.R != false) goto L28;
     */
    /* JADX WARN: Code restructure failed: missing block: B:48:0x00a2, code lost:
        dismiss();
     */
    @Override // android.view.View.OnClickListener
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void onClick(android.view.View r4) {
        /*
            r3 = this;
            java.lang.Object r0 = r4.getTag()
            b.a.a.b r0 = (b.a.a.b) r0
            int[] r1 = b.a.a.f.c.f1319a
            int r2 = r0.ordinal()
            r1 = r1[r2]
            r2 = 1
            if (r1 == r2) goto L83
            r2 = 2
            if (r1 == r2) goto L60
            r2 = 3
            if (r1 == r2) goto L19
            goto La5
        L19:
            b.a.a.f$d r1 = r3.f1314d
            b.a.a.f$e r1 = r1.z
            if (r1 == 0) goto L29
            r1.a(r3)
            b.a.a.f$d r1 = r3.f1314d
            b.a.a.f$e r1 = r1.z
            r1.d(r3)
        L29:
            b.a.a.f$d r1 = r3.f1314d
            b.a.a.f$m r1 = r1.A
            if (r1 == 0) goto L32
            r1.a(r3, r0)
        L32:
            b.a.a.f$d r1 = r3.f1314d
            boolean r1 = r1.J
            if (r1 != 0) goto L3b
            r3.n(r4)
        L3b:
            b.a.a.f$d r4 = r3.f1314d
            boolean r4 = r4.I
            if (r4 != 0) goto L44
            r3.m()
        L44:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$g r1 = r4.o0
            if (r1 == 0) goto L59
            android.widget.EditText r2 = r3.h
            if (r2 == 0) goto L59
            boolean r4 = r4.r0
            if (r4 != 0) goto L59
            android.text.Editable r4 = r2.getText()
            r1.a(r3, r4)
        L59:
            b.a.a.f$d r4 = r3.f1314d
            boolean r4 = r4.R
            if (r4 == 0) goto La5
            goto La2
        L60:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$e r4 = r4.z
            if (r4 == 0) goto L70
            r4.a(r3)
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$e r4 = r4.z
            r4.b(r3)
        L70:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$m r4 = r4.B
            if (r4 == 0) goto L79
            r4.a(r3, r0)
        L79:
            b.a.a.f$d r4 = r3.f1314d
            boolean r4 = r4.R
            if (r4 == 0) goto La5
            r3.cancel()
            goto La5
        L83:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$e r4 = r4.z
            if (r4 == 0) goto L93
            r4.a(r3)
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$e r4 = r4.z
            r4.c(r3)
        L93:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$m r4 = r4.C
            if (r4 == 0) goto L9c
            r4.a(r3, r0)
        L9c:
            b.a.a.f$d r4 = r3.f1314d
            boolean r4 = r4.R
            if (r4 == 0) goto La5
        La2:
            r3.dismiss()
        La5:
            b.a.a.f$d r4 = r3.f1314d
            b.a.a.f$m r4 = r4.D
            if (r4 == 0) goto Lae
            r4.a(r3, r0)
        Lae:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: b.a.a.f.onClick(android.view.View):void");
    }

    @Override // b.a.a.c, android.content.DialogInterface.OnShowListener
    public final void onShow(DialogInterface dialogInterface) {
        if (this.h != null) {
            b.a.a.q.a.u(this, this.f1314d);
            if (this.h.getText().length() > 0) {
                EditText editText = this.h;
                editText.setSelection(editText.getText().length());
            }
        }
        super.onShow(dialogInterface);
    }

    public final void p(TextView textView, Typeface typeface) {
        if (typeface == null) {
            return;
        }
        textView.setPaintFlags(textView.getPaintFlags() | 128);
        textView.setTypeface(typeface);
    }

    @Override // android.app.Dialog
    public final void setTitle(int i2) {
        setTitle(this.f1314d.f1321a.getString(i2));
    }

    @Override // android.app.Dialog
    public final void setTitle(CharSequence charSequence) {
        this.f.setText(charSequence);
    }

    @Override // android.app.Dialog
    public void show() {
        try {
            super.show();
        } catch (WindowManager.BadTokenException unused) {
            throw new C0044f("Bad window token, you cannot show a dialog before an Activity is created or after it's hidden.");
        }
    }
}
