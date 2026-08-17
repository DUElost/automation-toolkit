package com.aurelhubert.ahbottomnavigation;

import a.f.l.r;
import android.animation.Animator;
import android.animation.TimeInterpolator;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewAnimationUtils;
import android.view.ViewGroup;
import android.view.ViewPropertyAnimator;
import android.view.WindowManager;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.OvershootInterpolator;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.aurelhubert.ahbottomnavigation.notification.AHNotification;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class AHBottomNavigation extends FrameLayout {
    private static String V = "AHBottomNavigation";
    private int A;
    private int B;
    private int C;
    private int D;
    private int E;
    private float F;
    private float G;
    private int H;
    private int I;
    private float J;
    private float K;
    private boolean L;
    private h M;
    private int N;
    private int O;
    private Drawable P;
    private Typeface Q;
    private int R;
    private int S;
    private int T;
    private int U;

    /* renamed from: b  reason: collision with root package name */
    private g f2215b;

    /* renamed from: c  reason: collision with root package name */
    private f f2216c;

    /* renamed from: d  reason: collision with root package name */
    private Context f2217d;
    private Resources e;
    private ArrayList<com.aurelhubert.ahbottomnavigation.a> f;
    private ArrayList<View> g;
    private AHBottomNavigationBehavior<AHBottomNavigation> h;
    private LinearLayout i;
    private View j;
    private Animator k;
    private boolean l;
    private boolean m;
    private boolean n;
    private List<AHNotification> o;
    private boolean p;
    private int q;
    private int r;
    private boolean s;
    private boolean t;
    private boolean u;
    private boolean v;
    private Typeface w;
    private int x;
    private int y;
    private int z;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            AHBottomNavigation.this.requestLayout();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f2219b;

        b(int i) {
            this.f2219b = i;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            AHBottomNavigation.this.n(this.f2219b, true);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f2221b;

        c(int i) {
            this.f2221b = i;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            AHBottomNavigation.this.p(this.f2221b, true);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements Animator.AnimatorListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ int f2223a;

        d(int i) {
            this.f2223a = i;
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            AHBottomNavigation aHBottomNavigation = AHBottomNavigation.this;
            aHBottomNavigation.setBackgroundColor(((com.aurelhubert.ahbottomnavigation.a) aHBottomNavigation.f.get(this.f2223a)).a(AHBottomNavigation.this.f2217d));
            AHBottomNavigation.this.j.setBackgroundColor(0);
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationRepeat(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            AHBottomNavigation.this.j.setBackgroundColor(((com.aurelhubert.ahbottomnavigation.a) AHBottomNavigation.this.f.get(this.f2223a)).a(AHBottomNavigation.this.f2217d));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements Animator.AnimatorListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ int f2225a;

        e(int i) {
            this.f2225a = i;
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            AHBottomNavigation aHBottomNavigation = AHBottomNavigation.this;
            aHBottomNavigation.setBackgroundColor(((com.aurelhubert.ahbottomnavigation.a) aHBottomNavigation.f.get(this.f2225a)).a(AHBottomNavigation.this.f2217d));
            AHBottomNavigation.this.j.setBackgroundColor(0);
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationRepeat(Animator animator) {
        }

        @Override // android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            AHBottomNavigation.this.j.setBackgroundColor(((com.aurelhubert.ahbottomnavigation.a) AHBottomNavigation.this.f.get(this.f2225a)).a(AHBottomNavigation.this.f2217d));
        }
    }

    /* loaded from: classes.dex */
    public interface f {
        void a(int i);
    }

    /* loaded from: classes.dex */
    public interface g {
        boolean a(int i, boolean z);
    }

    /* loaded from: classes.dex */
    public enum h {
        SHOW_WHEN_ACTIVE,
        ALWAYS_SHOW,
        ALWAYS_HIDE
    }

    public AHBottomNavigation(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f = new ArrayList<>();
        this.g = new ArrayList<>();
        this.l = false;
        this.m = false;
        this.o = AHNotification.a(5);
        this.p = false;
        this.q = 0;
        this.r = 0;
        this.s = true;
        this.t = false;
        this.u = false;
        this.v = true;
        this.x = -1;
        this.y = 0;
        this.I = 0;
        this.L = false;
        this.M = h.SHOW_WHEN_ACTIVE;
        l(context, attributeSet);
    }

    @SuppressLint({"NewApi"})
    @TargetApi(21)
    private int g(int i) {
        if (this.n) {
            int identifier = getResources().getIdentifier("navigation_bar_height", "dimen", "android");
            if (identifier > 0) {
                this.I = this.e.getDimensionPixelSize(identifier);
            }
            TypedArray obtainStyledAttributes = getContext().getTheme().obtainStyledAttributes(new int[]{16842973, 16843760});
            obtainStyledAttributes.getBoolean(0, false);
            boolean z = obtainStyledAttributes.getBoolean(1, true);
            if (k() && z) {
                i += this.I;
            }
            obtainStyledAttributes.recycle();
            return i;
        }
        return i;
    }

    /* JADX WARN: Removed duplicated region for block: B:32:0x00b6  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void h(android.widget.LinearLayout r19) {
        /*
            Method dump skipped, instructions count: 507
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.aurelhubert.ahbottomnavigation.AHBottomNavigation.h(android.widget.LinearLayout):void");
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x0040  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void i() {
        /*
            r5 = this;
            java.util.ArrayList<com.aurelhubert.ahbottomnavigation.a> r0 = r5.f
            int r0 = r0.size()
            r1 = 3
            if (r0 >= r1) goto L11
            java.lang.String r0 = com.aurelhubert.ahbottomnavigation.AHBottomNavigation.V
            java.lang.String r2 = "The items list should have at least 3 items"
        Ld:
            android.util.Log.w(r0, r2)
            goto L1f
        L11:
            java.util.ArrayList<com.aurelhubert.ahbottomnavigation.a> r0 = r5.f
            int r0 = r0.size()
            r2 = 5
            if (r0 <= r2) goto L1f
            java.lang.String r0 = com.aurelhubert.ahbottomnavigation.AHBottomNavigation.V
            java.lang.String r2 = "The items list should not have more than 5 items"
            goto Ld
        L1f:
            android.content.res.Resources r0 = r5.e
            int r2 = com.aurelhubert.ahbottomnavigation.d.bottom_navigation_height
            float r0 = r0.getDimension(r2)
            int r0 = (int) r0
            r5.removeAllViews()
            java.util.ArrayList<android.view.View> r2 = r5.g
            r2.clear()
            android.view.View r2 = new android.view.View
            android.content.Context r3 = r5.f2217d
            r2.<init>(r3)
            r5.j = r2
            int r2 = android.os.Build.VERSION.SDK_INT
            r3 = 21
            r4 = -1
            if (r2 < r3) goto L50
            android.widget.FrameLayout$LayoutParams r2 = new android.widget.FrameLayout$LayoutParams
            int r3 = r5.g(r0)
            r2.<init>(r4, r3)
            android.view.View r3 = r5.j
            r5.addView(r3, r2)
            r5.H = r0
        L50:
            android.widget.LinearLayout r2 = new android.widget.LinearLayout
            android.content.Context r3 = r5.f2217d
            r2.<init>(r3)
            r5.i = r2
            r3 = 0
            r2.setOrientation(r3)
            android.widget.LinearLayout r2 = r5.i
            r3 = 17
            r2.setGravity(r3)
            android.widget.FrameLayout$LayoutParams r2 = new android.widget.FrameLayout$LayoutParams
            r2.<init>(r4, r0)
            android.widget.LinearLayout r0 = r5.i
            r5.addView(r0, r2)
            com.aurelhubert.ahbottomnavigation.AHBottomNavigation$h r0 = r5.M
            com.aurelhubert.ahbottomnavigation.AHBottomNavigation$h r2 = com.aurelhubert.ahbottomnavigation.AHBottomNavigation.h.ALWAYS_HIDE
            if (r0 == r2) goto L88
            java.util.ArrayList<com.aurelhubert.ahbottomnavigation.a> r0 = r5.f
            int r0 = r0.size()
            if (r0 == r1) goto L82
            com.aurelhubert.ahbottomnavigation.AHBottomNavigation$h r0 = r5.M
            com.aurelhubert.ahbottomnavigation.AHBottomNavigation$h r1 = com.aurelhubert.ahbottomnavigation.AHBottomNavigation.h.ALWAYS_SHOW
            if (r0 != r1) goto L88
        L82:
            android.widget.LinearLayout r0 = r5.i
            r5.h(r0)
            goto L8d
        L88:
            android.widget.LinearLayout r0 = r5.i
            r5.j(r0)
        L8d:
            com.aurelhubert.ahbottomnavigation.AHBottomNavigation$a r0 = new com.aurelhubert.ahbottomnavigation.AHBottomNavigation$a
            r0.<init>()
            r5.post(r0)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.aurelhubert.ahbottomnavigation.AHBottomNavigation.i():void");
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v29 */
    /* JADX WARN: Type inference failed for: r5v7 */
    /* JADX WARN: Type inference failed for: r5v8, types: [int, boolean] */
    private void j(LinearLayout linearLayout) {
        LayoutInflater layoutInflater = (LayoutInflater) this.f2217d.getSystemService("layout_inflater");
        float dimension = this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_height);
        float dimension2 = this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_inactive_min_width);
        float dimension3 = this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_inactive_max_width);
        int width = getWidth();
        if (width == 0 || this.f.size() == 0) {
            return;
        }
        float size = width / this.f.size();
        if (size >= dimension2) {
            dimension2 = size > dimension3 ? dimension3 : size;
        }
        int dimension4 = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_margin_top_active);
        float dimension5 = this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_selected_width_difference);
        this.J = (this.f.size() * dimension5) + dimension2;
        float f2 = dimension2 - dimension5;
        this.K = f2;
        ?? r5 = 0;
        int i = 0;
        while (i < this.f.size()) {
            com.aurelhubert.ahbottomnavigation.a aVar = this.f.get(i);
            View inflate = layoutInflater.inflate(com.aurelhubert.ahbottomnavigation.g.bottom_navigation_small_item, this, (boolean) r5);
            ImageView imageView = (ImageView) inflate.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_icon);
            TextView textView = (TextView) inflate.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_title);
            TextView textView2 = (TextView) inflate.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_notification);
            imageView.setImageDrawable(aVar.b(this.f2217d));
            h hVar = this.M;
            h hVar2 = h.ALWAYS_HIDE;
            if (hVar != hVar2) {
                textView.setText(aVar.c(this.f2217d));
            }
            float f3 = this.F;
            if (f3 != 0.0f) {
                textView.setTextSize(r5, f3);
            }
            Typeface typeface = this.w;
            if (typeface != null) {
                textView.setTypeface(typeface);
            }
            if (i == this.q) {
                if (this.m) {
                    inflate.setSelected(true);
                }
                imageView.setSelected(true);
                if (this.M != hVar2 && (inflate.getLayoutParams() instanceof ViewGroup.MarginLayoutParams)) {
                    ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) imageView.getLayoutParams();
                    marginLayoutParams.setMargins(marginLayoutParams.leftMargin, dimension4, marginLayoutParams.rightMargin, marginLayoutParams.bottomMargin);
                    ViewGroup.MarginLayoutParams marginLayoutParams2 = (ViewGroup.MarginLayoutParams) textView2.getLayoutParams();
                    marginLayoutParams2.setMargins(this.R, this.T, marginLayoutParams2.rightMargin, marginLayoutParams2.bottomMargin);
                    inflate.requestLayout();
                }
            } else {
                imageView.setSelected(r5);
                ViewGroup.MarginLayoutParams marginLayoutParams3 = (ViewGroup.MarginLayoutParams) textView2.getLayoutParams();
                marginLayoutParams3.setMargins(this.S, this.U, marginLayoutParams3.rightMargin, marginLayoutParams3.bottomMargin);
            }
            if (!this.l) {
                int i2 = this.y;
                if (i2 != 0) {
                    setBackgroundResource(i2);
                } else {
                    setBackgroundColor(this.x);
                }
            } else if (i == this.q) {
                setBackgroundColor(aVar.a(this.f2217d));
                this.r = aVar.a(this.f2217d);
            }
            imageView.setImageDrawable(com.aurelhubert.ahbottomnavigation.b.a(this.f.get(i).b(this.f2217d), this.q == i ? this.z : this.A, this.L));
            textView.setTextColor(this.q == i ? this.z : this.A);
            textView.setAlpha(this.q == i ? 1.0f : 0.0f);
            inflate.setOnClickListener(new c(i));
            inflate.setSoundEffectsEnabled(this.v);
            int i3 = i == this.q ? (int) this.J : (int) f2;
            if (this.M == hVar2) {
                i3 = (int) (f2 * 1.16d);
            }
            linearLayout.addView(inflate, new FrameLayout.LayoutParams(i3, (int) dimension));
            this.g.add(inflate);
            i++;
            r5 = 0;
        }
        o(true, -1);
    }

    private void l(Context context, AttributeSet attributeSet) {
        this.f2217d = context;
        this.e = context.getResources();
        if (attributeSet != null) {
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, com.aurelhubert.ahbottomnavigation.h.AHBottomNavigationBehavior_Params, 0, 0);
            try {
                this.m = obtainStyledAttributes.getBoolean(com.aurelhubert.ahbottomnavigation.h.AHBottomNavigationBehavior_Params_selectedBackgroundVisible, false);
                this.n = obtainStyledAttributes.getBoolean(com.aurelhubert.ahbottomnavigation.h.AHBottomNavigationBehavior_Params_translucentNavigationEnabled, false);
            } finally {
                obtainStyledAttributes.recycle();
            }
        }
        this.N = androidx.core.content.a.b(context, 17170443);
        this.H = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_height);
        this.B = androidx.core.content.a.b(context, com.aurelhubert.ahbottomnavigation.c.colorBottomNavigationAccent);
        this.C = androidx.core.content.a.b(context, com.aurelhubert.ahbottomnavigation.c.colorBottomNavigationInactive);
        this.D = androidx.core.content.a.b(context, com.aurelhubert.ahbottomnavigation.c.colorBottomNavigationActiveColored);
        this.E = androidx.core.content.a.b(context, com.aurelhubert.ahbottomnavigation.c.colorBottomNavigationInactiveColored);
        this.z = this.B;
        this.A = this.C;
        this.R = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_notification_margin_left_active);
        this.S = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_notification_margin_left);
        this.T = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_notification_margin_top_active);
        this.U = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_notification_margin_top);
        r.V(this, this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_elevation));
        setClipToPadding(false);
        setLayoutParams(new ViewGroup.LayoutParams(-1, this.H));
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:28:0x007b  */
    /* JADX WARN: Removed duplicated region for block: B:64:0x01f3  */
    /* JADX WARN: Removed duplicated region for block: B:79:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void n(int r20, boolean r21) {
        /*
            Method dump skipped, instructions count: 518
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.aurelhubert.ahbottomnavigation.AHBottomNavigation.n(int, boolean):void");
    }

    private void o(boolean z, int i) {
        ViewPropertyAnimator alpha;
        TimeInterpolator overshootInterpolator;
        Drawable a2;
        for (int i2 = 0; i2 < this.g.size(); i2++) {
            if (i == -1 || i == i2) {
                AHNotification aHNotification = this.o.get(i2);
                int b2 = com.aurelhubert.ahbottomnavigation.notification.a.b(aHNotification, this.N);
                int a3 = com.aurelhubert.ahbottomnavigation.notification.a.a(aHNotification, this.O);
                TextView textView = (TextView) this.g.get(i2).findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_notification);
                boolean z2 = !textView.getText().toString().equals(String.valueOf(aHNotification.c()));
                if (z) {
                    textView.setTextColor(b2);
                    Typeface typeface = this.Q;
                    if (typeface != null) {
                        textView.setTypeface(typeface);
                    } else {
                        textView.setTypeface(null, 1);
                    }
                    Drawable drawable = this.P;
                    if (drawable != null) {
                        if (Build.VERSION.SDK_INT >= 16) {
                            a2 = drawable.getConstantState().newDrawable();
                            textView.setBackground(a2);
                        }
                        textView.setBackgroundDrawable(drawable);
                    } else if (a3 != 0) {
                        Drawable d2 = androidx.core.content.a.d(this.f2217d, com.aurelhubert.ahbottomnavigation.e.notification_background);
                        if (Build.VERSION.SDK_INT >= 16) {
                            a2 = com.aurelhubert.ahbottomnavigation.b.a(d2, a3, this.L);
                            textView.setBackground(a2);
                        } else {
                            drawable = com.aurelhubert.ahbottomnavigation.b.a(d2, a3, this.L);
                            textView.setBackgroundDrawable(drawable);
                        }
                    }
                }
                if (aHNotification.e() && textView.getText().length() > 0) {
                    textView.setText(BuildConfig.FLAVOR);
                    if (z2) {
                        alpha = textView.animate().scaleX(0.0f).scaleY(0.0f).alpha(0.0f);
                        overshootInterpolator = new AccelerateInterpolator();
                        alpha.setInterpolator(overshootInterpolator).setDuration(150L).start();
                    }
                } else if (!aHNotification.e()) {
                    textView.setText(String.valueOf(aHNotification.c()));
                    if (z2) {
                        textView.setScaleX(0.0f);
                        textView.setScaleY(0.0f);
                        alpha = textView.animate().scaleX(1.0f).scaleY(1.0f).alpha(1.0f);
                        overshootInterpolator = new OvershootInterpolator();
                        alpha.setInterpolator(overshootInterpolator).setDuration(150L).start();
                    }
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void p(int i, boolean z) {
        if (this.q == i) {
            g gVar = this.f2215b;
            if (gVar == null || !z) {
                return;
            }
            gVar.a(i, true);
            return;
        }
        g gVar2 = this.f2215b;
        if (gVar2 == null || !z || gVar2.a(i, false)) {
            int dimension = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_margin_top_active);
            int dimension2 = (int) this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_small_margin_top);
            int i2 = 0;
            while (i2 < this.g.size()) {
                View view = this.g.get(i2);
                if (this.m) {
                    view.setSelected(i2 == i);
                }
                if (i2 == i) {
                    FrameLayout frameLayout = (FrameLayout) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_container);
                    TextView textView = (TextView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_title);
                    ImageView imageView = (ImageView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_icon);
                    TextView textView2 = (TextView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_notification);
                    imageView.setSelected(true);
                    if (this.M != h.ALWAYS_HIDE) {
                        com.aurelhubert.ahbottomnavigation.b.g(imageView, dimension2, dimension);
                        com.aurelhubert.ahbottomnavigation.b.d(textView2, this.S, this.R);
                        com.aurelhubert.ahbottomnavigation.b.g(textView2, this.U, this.T);
                        com.aurelhubert.ahbottomnavigation.b.e(textView, this.A, this.z);
                        com.aurelhubert.ahbottomnavigation.b.i(frameLayout, this.K, this.J);
                    }
                    com.aurelhubert.ahbottomnavigation.b.b(textView, 0.0f, 1.0f);
                    com.aurelhubert.ahbottomnavigation.b.c(this.f2217d, this.f.get(i).b(this.f2217d), imageView, this.A, this.z, this.L);
                    if (Build.VERSION.SDK_INT >= 21 && this.l) {
                        int max = Math.max(getWidth(), getHeight());
                        int x = ((int) this.g.get(i).getX()) + (this.g.get(i).getWidth() / 2);
                        int height = this.g.get(i).getHeight() / 2;
                        Animator animator = this.k;
                        if (animator != null && animator.isRunning()) {
                            this.k.cancel();
                            setBackgroundColor(this.f.get(i).a(this.f2217d));
                            this.j.setBackgroundColor(0);
                        }
                        Animator createCircularReveal = ViewAnimationUtils.createCircularReveal(this.j, x, height, 0.0f, max);
                        this.k = createCircularReveal;
                        createCircularReveal.setStartDelay(5L);
                        this.k.addListener(new e(i));
                        this.k.start();
                    } else if (this.l) {
                        com.aurelhubert.ahbottomnavigation.b.h(this, this.r, this.f.get(i).a(this.f2217d));
                    } else {
                        int i3 = this.y;
                        if (i3 != 0) {
                            setBackgroundResource(i3);
                        } else {
                            setBackgroundColor(this.x);
                        }
                        this.j.setBackgroundColor(0);
                    }
                } else if (i2 == this.q) {
                    View findViewById = view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_container);
                    TextView textView3 = (TextView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_title);
                    ImageView imageView2 = (ImageView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_small_item_icon);
                    TextView textView4 = (TextView) view.findViewById(com.aurelhubert.ahbottomnavigation.f.bottom_navigation_notification);
                    imageView2.setSelected(false);
                    if (this.M != h.ALWAYS_HIDE) {
                        com.aurelhubert.ahbottomnavigation.b.g(imageView2, dimension, dimension2);
                        com.aurelhubert.ahbottomnavigation.b.d(textView4, this.R, this.S);
                        com.aurelhubert.ahbottomnavigation.b.g(textView4, this.T, this.U);
                        com.aurelhubert.ahbottomnavigation.b.e(textView3, this.z, this.A);
                        com.aurelhubert.ahbottomnavigation.b.i(findViewById, this.J, this.K);
                    }
                    com.aurelhubert.ahbottomnavigation.b.b(textView3, 1.0f, 0.0f);
                    com.aurelhubert.ahbottomnavigation.b.c(this.f2217d, this.f.get(this.q).b(this.f2217d), imageView2, this.z, this.A, this.L);
                }
                i2++;
            }
            this.q = i;
            if (i > 0 && i < this.f.size()) {
                this.r = this.f.get(this.q).a(this.f2217d);
            } else if (this.q == -1) {
                int i4 = this.y;
                if (i4 != 0) {
                    setBackgroundResource(i4);
                } else {
                    setBackgroundColor(this.x);
                }
                this.j.setBackgroundColor(0);
            }
        }
    }

    public void f(List<com.aurelhubert.ahbottomnavigation.a> list) {
        if (list.size() > 5 || this.f.size() + list.size() > 5) {
            Log.w(V, "The items list should not have more than 5 items");
        }
        this.f.addAll(list);
        i();
    }

    public int getAccentColor() {
        return this.z;
    }

    public int getCurrentItem() {
        return this.q;
    }

    public int getDefaultBackgroundColor() {
        return this.x;
    }

    public int getInactiveColor() {
        return this.A;
    }

    public int getItemsCount() {
        return this.f.size();
    }

    public h getTitleState() {
        return this.M;
    }

    @SuppressLint({"NewApi"})
    @TargetApi(21)
    public boolean k() {
        Display defaultDisplay = ((WindowManager) getContext().getSystemService("window")).getDefaultDisplay();
        DisplayMetrics displayMetrics = new DisplayMetrics();
        defaultDisplay.getRealMetrics(displayMetrics);
        int i = displayMetrics.heightPixels;
        int i2 = displayMetrics.widthPixels;
        DisplayMetrics displayMetrics2 = new DisplayMetrics();
        defaultDisplay.getMetrics(displayMetrics2);
        return i2 > displayMetrics2.widthPixels || i > displayMetrics2.heightPixels;
    }

    public void m(int i, boolean z) {
        if (i >= this.f.size()) {
            String str = V;
            Log.w(str, "The position is out of bounds of the items (" + this.f.size() + " elements)");
        } else if (this.M == h.ALWAYS_HIDE || !(this.f.size() == 3 || this.M == h.ALWAYS_SHOW)) {
            p(i, z);
        } else {
            n(i, z);
        }
    }

    @Override // android.widget.FrameLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        if (this.p) {
            return;
        }
        setBehaviorTranslationEnabled(this.s);
        this.p = true;
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        if (parcelable instanceof Bundle) {
            Bundle bundle = (Bundle) parcelable;
            this.q = bundle.getInt("current_item");
            this.o = bundle.getParcelableArrayList("notifications");
            parcelable = bundle.getParcelable("superState");
        }
        super.onRestoreInstanceState(parcelable);
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        Bundle bundle = new Bundle();
        bundle.putParcelable("superState", super.onSaveInstanceState());
        bundle.putInt("current_item", this.q);
        bundle.putParcelableArrayList("notifications", new ArrayList<>(this.o));
        return bundle;
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        i();
    }

    public void setAccentColor(int i) {
        this.B = i;
        this.z = i;
        i();
    }

    public void setBehaviorTranslationEnabled(boolean z) {
        this.s = z;
        if (getParent() instanceof CoordinatorLayout) {
            ViewGroup.LayoutParams layoutParams = getLayoutParams();
            AHBottomNavigationBehavior<AHBottomNavigation> aHBottomNavigationBehavior = this.h;
            if (aHBottomNavigationBehavior == null) {
                this.h = new AHBottomNavigationBehavior<>(z, this.I);
            } else {
                aHBottomNavigationBehavior.R(z, this.I);
            }
            f fVar = this.f2216c;
            if (fVar != null) {
                this.h.S(fVar);
            }
            ((CoordinatorLayout.f) layoutParams).o(this.h);
            if (this.t) {
                this.t = false;
                this.h.Q(this, this.H, this.u);
            }
        }
    }

    public void setColored(boolean z) {
        this.l = z;
        this.z = z ? this.D : this.B;
        this.A = z ? this.E : this.C;
        i();
    }

    public void setCurrentItem(int i) {
        m(i, true);
    }

    public void setDefaultBackgroundColor(int i) {
        this.x = i;
        i();
    }

    public void setDefaultBackgroundResource(int i) {
        this.y = i;
        i();
    }

    public void setForceTint(boolean z) {
        this.L = z;
        i();
    }

    public void setInactiveColor(int i) {
        this.C = i;
        this.A = i;
        i();
    }

    public void setNotificationBackground(Drawable drawable) {
        this.P = drawable;
        o(true, -1);
    }

    public void setNotificationBackgroundColor(int i) {
        this.O = i;
        o(true, -1);
    }

    public void setNotificationBackgroundColorResource(int i) {
        this.O = androidx.core.content.a.b(this.f2217d, i);
        o(true, -1);
    }

    public void setNotificationTextColor(int i) {
        this.N = i;
        o(true, -1);
    }

    public void setNotificationTextColorResource(int i) {
        this.N = androidx.core.content.a.b(this.f2217d, i);
        o(true, -1);
    }

    public void setNotificationTypeface(Typeface typeface) {
        this.Q = typeface;
        o(true, -1);
    }

    public void setOnNavigationPositionListener(f fVar) {
        this.f2216c = fVar;
        AHBottomNavigationBehavior<AHBottomNavigation> aHBottomNavigationBehavior = this.h;
        if (aHBottomNavigationBehavior != null) {
            aHBottomNavigationBehavior.S(fVar);
        }
    }

    public void setOnTabSelectedListener(g gVar) {
        this.f2215b = gVar;
    }

    public void setSelectedBackgroundVisible(boolean z) {
        this.m = z;
        i();
    }

    @Override // android.view.View
    public void setSoundEffectsEnabled(boolean z) {
        super.setSoundEffectsEnabled(z);
        this.v = z;
    }

    public void setTitleState(h hVar) {
        this.M = hVar;
        i();
    }

    public void setTitleTypeface(Typeface typeface) {
        this.w = typeface;
        i();
    }

    public void setTranslucentNavigationEnabled(boolean z) {
        this.n = z;
    }

    public void setUseElevation(boolean z) {
        r.V(this, z ? this.e.getDimension(com.aurelhubert.ahbottomnavigation.d.bottom_navigation_elevation) : 0.0f);
        setClipToPadding(false);
    }
}
