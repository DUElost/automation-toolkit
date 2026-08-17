package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.os.Build;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.util.Xml;
import java.lang.ref.WeakReference;
import java.util.WeakHashMap;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public final class h {
    private static h h;

    /* renamed from: a  reason: collision with root package name */
    private WeakHashMap<Context, a.d.h<ColorStateList>> f695a;

    /* renamed from: b  reason: collision with root package name */
    private a.d.a<String, d> f696b;

    /* renamed from: c  reason: collision with root package name */
    private a.d.h<String> f697c;

    /* renamed from: d  reason: collision with root package name */
    private final WeakHashMap<Context, a.d.d<WeakReference<Drawable.ConstantState>>> f698d = new WeakHashMap<>(0);
    private TypedValue e;
    private boolean f;
    private static final PorterDuff.Mode g = PorterDuff.Mode.SRC_IN;
    private static final c i = new c(6);
    private static final int[] j = {a.a.e.abc_textfield_search_default_mtrl_alpha, a.a.e.abc_textfield_default_mtrl_alpha, a.a.e.abc_ab_share_pack_mtrl_alpha};
    private static final int[] k = {a.a.e.abc_ic_commit_search_api_mtrl_alpha, a.a.e.abc_seekbar_tick_mark_material, a.a.e.abc_ic_menu_share_mtrl_alpha, a.a.e.abc_ic_menu_copy_mtrl_am_alpha, a.a.e.abc_ic_menu_cut_mtrl_alpha, a.a.e.abc_ic_menu_selectall_mtrl_alpha, a.a.e.abc_ic_menu_paste_mtrl_am_alpha};
    private static final int[] l = {a.a.e.abc_textfield_activated_mtrl_alpha, a.a.e.abc_textfield_search_activated_mtrl_alpha, a.a.e.abc_cab_background_top_mtrl_alpha, a.a.e.abc_text_cursor_material, a.a.e.abc_text_select_handle_left_mtrl_dark, a.a.e.abc_text_select_handle_middle_mtrl_dark, a.a.e.abc_text_select_handle_right_mtrl_dark, a.a.e.abc_text_select_handle_left_mtrl_light, a.a.e.abc_text_select_handle_middle_mtrl_light, a.a.e.abc_text_select_handle_right_mtrl_light};
    private static final int[] m = {a.a.e.abc_popup_background_mtrl_mult, a.a.e.abc_cab_background_internal_bg, a.a.e.abc_menu_hardkey_panel_mtrl_mult};
    private static final int[] n = {a.a.e.abc_tab_indicator_material, a.a.e.abc_textfield_search_material};
    private static final int[] o = {a.a.e.abc_btn_check_material, a.a.e.abc_btn_radio_material};

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a implements d {
        a() {
        }

        @Override // androidx.appcompat.widget.h.d
        public Drawable a(Context context, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
            try {
                return a.a.l.a.a.m(context, context.getResources(), xmlPullParser, attributeSet, theme);
            } catch (Exception e) {
                Log.e("AsldcInflateDelegate", "Exception while inflating <animated-selector>", e);
                return null;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b implements d {
        b() {
        }

        @Override // androidx.appcompat.widget.h.d
        public Drawable a(Context context, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
            try {
                return a.n.a.a.b.a(context, context.getResources(), xmlPullParser, attributeSet, theme);
            } catch (Exception e) {
                Log.e("AvdcInflateDelegate", "Exception while inflating <animated-vector>", e);
                return null;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class c extends a.d.e<Integer, PorterDuffColorFilter> {
        public c(int i) {
            super(i);
        }

        private static int h(int i, PorterDuff.Mode mode) {
            return ((i + 31) * 31) + mode.hashCode();
        }

        PorterDuffColorFilter i(int i, PorterDuff.Mode mode) {
            return c(Integer.valueOf(h(i, mode)));
        }

        PorterDuffColorFilter j(int i, PorterDuff.Mode mode, PorterDuffColorFilter porterDuffColorFilter) {
            return d(Integer.valueOf(h(i, mode)), porterDuffColorFilter);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public interface d {
        Drawable a(Context context, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class e implements d {
        e() {
        }

        @Override // androidx.appcompat.widget.h.d
        public Drawable a(Context context, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
            try {
                return a.n.a.a.h.c(context.getResources(), xmlPullParser, attributeSet, theme);
            } catch (Exception e) {
                Log.e("VdcInflateDelegate", "Exception while inflating <vector>", e);
                return null;
            }
        }
    }

    private static void A(Drawable drawable, int i2, PorterDuff.Mode mode) {
        if (z.a(drawable)) {
            drawable = drawable.mutate();
        }
        if (mode == null) {
            mode = g;
        }
        drawable.setColorFilter(r(i2, mode));
    }

    private Drawable B(Context context, int i2, boolean z, Drawable drawable) {
        ColorStateList s = s(context, i2);
        if (s != null) {
            if (z.a(drawable)) {
                drawable = drawable.mutate();
            }
            Drawable q = androidx.core.graphics.drawable.a.q(drawable);
            androidx.core.graphics.drawable.a.o(q, s);
            PorterDuff.Mode u = u(i2);
            if (u != null) {
                androidx.core.graphics.drawable.a.p(q, u);
                return q;
            }
            return q;
        } else if (i2 == a.a.e.abc_seekbar_track_material) {
            LayerDrawable layerDrawable = (LayerDrawable) drawable;
            Drawable findDrawableByLayerId = layerDrawable.findDrawableByLayerId(16908288);
            int i3 = a.a.a.colorControlNormal;
            int b2 = l0.b(context, i3);
            PorterDuff.Mode mode = g;
            A(findDrawableByLayerId, b2, mode);
            A(layerDrawable.findDrawableByLayerId(16908303), l0.b(context, i3), mode);
            A(layerDrawable.findDrawableByLayerId(16908301), l0.b(context, a.a.a.colorControlActivated), mode);
            return drawable;
        } else if (i2 != a.a.e.abc_ratingbar_material && i2 != a.a.e.abc_ratingbar_indicator_material && i2 != a.a.e.abc_ratingbar_small_material) {
            if (D(context, i2, drawable) || !z) {
                return drawable;
            }
            return null;
        } else {
            LayerDrawable layerDrawable2 = (LayerDrawable) drawable;
            Drawable findDrawableByLayerId2 = layerDrawable2.findDrawableByLayerId(16908288);
            int a2 = l0.a(context, a.a.a.colorControlNormal);
            PorterDuff.Mode mode2 = g;
            A(findDrawableByLayerId2, a2, mode2);
            Drawable findDrawableByLayerId3 = layerDrawable2.findDrawableByLayerId(16908303);
            int i4 = a.a.a.colorControlActivated;
            A(findDrawableByLayerId3, l0.b(context, i4), mode2);
            A(layerDrawable2.findDrawableByLayerId(16908301), l0.b(context, i4), mode2);
            return drawable;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void C(Drawable drawable, o0 o0Var, int[] iArr) {
        if (z.a(drawable) && drawable.mutate() != drawable) {
            Log.d("AppCompatDrawableManag", "Mutated drawable is not the same instance as the input.");
            return;
        }
        boolean z = o0Var.f744d;
        if (z || o0Var.f743c) {
            drawable.setColorFilter(m(z ? o0Var.f741a : null, o0Var.f743c ? o0Var.f742b : g, iArr));
        } else {
            drawable.clearColorFilter();
        }
        if (Build.VERSION.SDK_INT <= 23) {
            drawable.invalidateSelf();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0044  */
    /* JADX WARN: Removed duplicated region for block: B:28:0x005f A[RETURN] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static boolean D(android.content.Context r6, int r7, android.graphics.drawable.Drawable r8) {
        /*
            android.graphics.PorterDuff$Mode r0 = androidx.appcompat.widget.h.g
            int[] r1 = androidx.appcompat.widget.h.j
            boolean r1 = d(r1, r7)
            r2 = 16842801(0x1010031, float:2.3693695E-38)
            r3 = -1
            r4 = 0
            r5 = 1
            if (r1 == 0) goto L15
            int r2 = a.a.a.colorControlNormal
        L12:
            r7 = r3
        L13:
            r1 = r5
            goto L42
        L15:
            int[] r1 = androidx.appcompat.widget.h.l
            boolean r1 = d(r1, r7)
            if (r1 == 0) goto L20
            int r2 = a.a.a.colorControlActivated
            goto L12
        L20:
            int[] r1 = androidx.appcompat.widget.h.m
            boolean r1 = d(r1, r7)
            if (r1 == 0) goto L2b
            android.graphics.PorterDuff$Mode r0 = android.graphics.PorterDuff.Mode.MULTIPLY
            goto L12
        L2b:
            int r1 = a.a.e.abc_list_divider_mtrl_alpha
            if (r7 != r1) goto L3a
            r2 = 16842800(0x1010030, float:2.3693693E-38)
            r7 = 1109603123(0x42233333, float:40.8)
            int r7 = java.lang.Math.round(r7)
            goto L13
        L3a:
            int r1 = a.a.e.abc_dialog_material_background
            if (r7 != r1) goto L3f
            goto L12
        L3f:
            r7 = r3
            r1 = r4
            r2 = r1
        L42:
            if (r1 == 0) goto L5f
            boolean r1 = androidx.appcompat.widget.z.a(r8)
            if (r1 == 0) goto L4e
            android.graphics.drawable.Drawable r8 = r8.mutate()
        L4e:
            int r6 = androidx.appcompat.widget.l0.b(r6, r2)
            android.graphics.PorterDuffColorFilter r6 = r(r6, r0)
            r8.setColorFilter(r6)
            if (r7 == r3) goto L5e
            r8.setAlpha(r7)
        L5e:
            return r5
        L5f:
            return r4
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.h.D(android.content.Context, int, android.graphics.drawable.Drawable):boolean");
    }

    private void a(String str, d dVar) {
        if (this.f696b == null) {
            this.f696b = new a.d.a<>();
        }
        this.f696b.put(str, dVar);
    }

    private synchronized boolean b(Context context, long j2, Drawable drawable) {
        boolean z;
        Drawable.ConstantState constantState = drawable.getConstantState();
        if (constantState != null) {
            a.d.d<WeakReference<Drawable.ConstantState>> dVar = this.f698d.get(context);
            if (dVar == null) {
                dVar = new a.d.d<>();
                this.f698d.put(context, dVar);
            }
            dVar.j(j2, new WeakReference<>(constantState));
            z = true;
        } else {
            z = false;
        }
        return z;
    }

    private void c(Context context, int i2, ColorStateList colorStateList) {
        if (this.f695a == null) {
            this.f695a = new WeakHashMap<>();
        }
        a.d.h<ColorStateList> hVar = this.f695a.get(context);
        if (hVar == null) {
            hVar = new a.d.h<>();
            this.f695a.put(context, hVar);
        }
        hVar.a(i2, colorStateList);
    }

    private static boolean d(int[] iArr, int i2) {
        for (int i3 : iArr) {
            if (i3 == i2) {
                return true;
            }
        }
        return false;
    }

    private void e(Context context) {
        if (this.f) {
            return;
        }
        this.f = true;
        Drawable p = p(context, a.a.e.abc_vector_test);
        if (p == null || !w(p)) {
            this.f = false;
            throw new IllegalStateException("This app has been built with an incorrect configuration. Please configure your build for VectorDrawableCompat.");
        }
    }

    private ColorStateList f(Context context) {
        return g(context, 0);
    }

    private ColorStateList g(Context context, int i2) {
        int b2 = l0.b(context, a.a.a.colorControlHighlight);
        return new ColorStateList(new int[][]{l0.f727b, l0.f729d, l0.f728c, l0.f}, new int[]{l0.a(context, a.a.a.colorButtonNormal), a.f.e.a.b(b2, i2), a.f.e.a.b(b2, i2), i2});
    }

    private static long h(TypedValue typedValue) {
        return (typedValue.assetCookie << 32) | typedValue.data;
    }

    private ColorStateList i(Context context) {
        return g(context, l0.b(context, a.a.a.colorAccent));
    }

    private ColorStateList j(Context context) {
        return g(context, l0.b(context, a.a.a.colorButtonNormal));
    }

    private Drawable k(Context context, int i2) {
        if (this.e == null) {
            this.e = new TypedValue();
        }
        TypedValue typedValue = this.e;
        context.getResources().getValue(i2, typedValue, true);
        long h2 = h(typedValue);
        Drawable o2 = o(context, h2);
        if (o2 != null) {
            return o2;
        }
        if (i2 == a.a.e.abc_cab_background_top_material) {
            o2 = new LayerDrawable(new Drawable[]{p(context, a.a.e.abc_cab_background_internal_bg), p(context, a.a.e.abc_cab_background_top_mtrl_alpha)});
        }
        if (o2 != null) {
            o2.setChangingConfigurations(typedValue.changingConfigurations);
            b(context, h2, o2);
        }
        return o2;
    }

    private ColorStateList l(Context context) {
        int[][] iArr = new int[3];
        int[] iArr2 = new int[3];
        int i2 = a.a.a.colorSwitchThumbNormal;
        ColorStateList d2 = l0.d(context, i2);
        if (d2 == null || !d2.isStateful()) {
            iArr[0] = l0.f727b;
            iArr2[0] = l0.a(context, i2);
            iArr[1] = l0.e;
            iArr2[1] = l0.b(context, a.a.a.colorControlActivated);
            iArr[2] = l0.f;
            iArr2[2] = l0.b(context, i2);
        } else {
            iArr[0] = l0.f727b;
            iArr2[0] = d2.getColorForState(iArr[0], 0);
            iArr[1] = l0.e;
            iArr2[1] = l0.b(context, a.a.a.colorControlActivated);
            iArr[2] = l0.f;
            iArr2[2] = d2.getDefaultColor();
        }
        return new ColorStateList(iArr, iArr2);
    }

    private static PorterDuffColorFilter m(ColorStateList colorStateList, PorterDuff.Mode mode, int[] iArr) {
        if (colorStateList == null || mode == null) {
            return null;
        }
        return r(colorStateList.getColorForState(iArr, 0), mode);
    }

    public static synchronized h n() {
        h hVar;
        synchronized (h.class) {
            if (h == null) {
                h hVar2 = new h();
                h = hVar2;
                v(hVar2);
            }
            hVar = h;
        }
        return hVar;
    }

    private synchronized Drawable o(Context context, long j2) {
        a.d.d<WeakReference<Drawable.ConstantState>> dVar = this.f698d.get(context);
        if (dVar == null) {
            return null;
        }
        WeakReference<Drawable.ConstantState> f = dVar.f(j2);
        if (f != null) {
            Drawable.ConstantState constantState = f.get();
            if (constantState != null) {
                return constantState.newDrawable(context.getResources());
            }
            dVar.d(j2);
        }
        return null;
    }

    public static synchronized PorterDuffColorFilter r(int i2, PorterDuff.Mode mode) {
        PorterDuffColorFilter i3;
        synchronized (h.class) {
            c cVar = i;
            i3 = cVar.i(i2, mode);
            if (i3 == null) {
                i3 = new PorterDuffColorFilter(i2, mode);
                cVar.j(i2, mode, i3);
            }
        }
        return i3;
    }

    private ColorStateList t(Context context, int i2) {
        a.d.h<ColorStateList> hVar;
        WeakHashMap<Context, a.d.h<ColorStateList>> weakHashMap = this.f695a;
        if (weakHashMap == null || (hVar = weakHashMap.get(context)) == null) {
            return null;
        }
        return hVar.f(i2);
    }

    static PorterDuff.Mode u(int i2) {
        if (i2 == a.a.e.abc_switch_thumb_material) {
            return PorterDuff.Mode.MULTIPLY;
        }
        return null;
    }

    private static void v(h hVar) {
        if (Build.VERSION.SDK_INT < 24) {
            hVar.a("vector", new e());
            hVar.a("animated-vector", new b());
            hVar.a("animated-selector", new a());
        }
    }

    private static boolean w(Drawable drawable) {
        return (drawable instanceof a.n.a.a.h) || "android.graphics.drawable.VectorDrawable".equals(drawable.getClass().getName());
    }

    private Drawable x(Context context, int i2) {
        int next;
        a.d.a<String, d> aVar = this.f696b;
        if (aVar == null || aVar.isEmpty()) {
            return null;
        }
        a.d.h<String> hVar = this.f697c;
        if (hVar != null) {
            String f = hVar.f(i2);
            if ("appcompat_skip_skip".equals(f) || (f != null && this.f696b.get(f) == null)) {
                return null;
            }
        } else {
            this.f697c = new a.d.h<>();
        }
        if (this.e == null) {
            this.e = new TypedValue();
        }
        TypedValue typedValue = this.e;
        Resources resources = context.getResources();
        resources.getValue(i2, typedValue, true);
        long h2 = h(typedValue);
        Drawable o2 = o(context, h2);
        if (o2 != null) {
            return o2;
        }
        CharSequence charSequence = typedValue.string;
        if (charSequence != null && charSequence.toString().endsWith(".xml")) {
            try {
                XmlResourceParser xml = resources.getXml(i2);
                AttributeSet asAttributeSet = Xml.asAttributeSet(xml);
                while (true) {
                    next = xml.next();
                    if (next == 2 || next == 1) {
                        break;
                    }
                }
                if (next != 2) {
                    throw new org.xmlpull.v1.a("No start tag found");
                }
                String name = xml.getName();
                this.f697c.a(i2, name);
                d dVar = this.f696b.get(name);
                if (dVar != null) {
                    o2 = dVar.a(context, xml, asAttributeSet, context.getTheme());
                }
                if (o2 != null) {
                    o2.setChangingConfigurations(typedValue.changingConfigurations);
                    b(context, h2, o2);
                }
            } catch (Exception e2) {
                Log.e("AppCompatDrawableManag", "Exception while inflating drawable", e2);
            }
        }
        if (o2 == null) {
            this.f697c.a(i2, "appcompat_skip_skip");
        }
        return o2;
    }

    public synchronized Drawable p(Context context, int i2) {
        return q(context, i2, false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public synchronized Drawable q(Context context, int i2, boolean z) {
        Drawable x;
        e(context);
        x = x(context, i2);
        if (x == null) {
            x = k(context, i2);
        }
        if (x == null) {
            x = androidx.core.content.a.d(context, i2);
        }
        if (x != null) {
            x = B(context, i2, z, x);
        }
        if (x != null) {
            z.b(x);
        }
        return x;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Removed duplicated region for block: B:43:0x0078 A[Catch: all -> 0x007d, TRY_LEAVE, TryCatch #0 {, blocks: (B:3:0x0001, B:5:0x0007, B:7:0x000b, B:8:0x000d, B:43:0x0078, B:9:0x0013, B:11:0x0017, B:12:0x001a, B:14:0x001e, B:15:0x0023, B:17:0x0027, B:18:0x002c, B:20:0x0030, B:21:0x0035, B:23:0x0039, B:24:0x003e, B:26:0x0042, B:29:0x0047, B:31:0x004f, B:32:0x0056, B:34:0x005e, B:35:0x0061, B:37:0x0069, B:38:0x006c, B:40:0x0070, B:41:0x0073), top: B:49:0x0001 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public synchronized android.content.res.ColorStateList s(android.content.Context r3, int r4) {
        /*
            r2 = this;
            monitor-enter(r2)
            android.content.res.ColorStateList r0 = r2.t(r3, r4)     // Catch: java.lang.Throwable -> L7d
            if (r0 != 0) goto L7b
            int r1 = a.a.e.abc_edit_text_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L13
            int r0 = a.a.c.abc_tint_edittext     // Catch: java.lang.Throwable -> L7d
        Ld:
            android.content.res.ColorStateList r0 = a.a.k.a.a.c(r3, r0)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L13:
            int r1 = a.a.e.abc_switch_track_mtrl_alpha     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L1a
            int r0 = a.a.c.abc_tint_switch_track     // Catch: java.lang.Throwable -> L7d
            goto Ld
        L1a:
            int r1 = a.a.e.abc_switch_thumb_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L23
            android.content.res.ColorStateList r0 = r2.l(r3)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L23:
            int r1 = a.a.e.abc_btn_default_mtrl_shape     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L2c
            android.content.res.ColorStateList r0 = r2.j(r3)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L2c:
            int r1 = a.a.e.abc_btn_borderless_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L35
            android.content.res.ColorStateList r0 = r2.f(r3)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L35:
            int r1 = a.a.e.abc_btn_colored_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L3e
            android.content.res.ColorStateList r0 = r2.i(r3)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L3e:
            int r1 = a.a.e.abc_spinner_mtrl_am_alpha     // Catch: java.lang.Throwable -> L7d
            if (r4 == r1) goto L73
            int r1 = a.a.e.abc_spinner_textfield_background_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L47
            goto L73
        L47:
            int[] r1 = androidx.appcompat.widget.h.k     // Catch: java.lang.Throwable -> L7d
            boolean r1 = d(r1, r4)     // Catch: java.lang.Throwable -> L7d
            if (r1 == 0) goto L56
            int r0 = a.a.a.colorControlNormal     // Catch: java.lang.Throwable -> L7d
            android.content.res.ColorStateList r0 = androidx.appcompat.widget.l0.d(r3, r0)     // Catch: java.lang.Throwable -> L7d
            goto L76
        L56:
            int[] r1 = androidx.appcompat.widget.h.n     // Catch: java.lang.Throwable -> L7d
            boolean r1 = d(r1, r4)     // Catch: java.lang.Throwable -> L7d
            if (r1 == 0) goto L61
            int r0 = a.a.c.abc_tint_default     // Catch: java.lang.Throwable -> L7d
            goto Ld
        L61:
            int[] r1 = androidx.appcompat.widget.h.o     // Catch: java.lang.Throwable -> L7d
            boolean r1 = d(r1, r4)     // Catch: java.lang.Throwable -> L7d
            if (r1 == 0) goto L6c
            int r0 = a.a.c.abc_tint_btn_checkable     // Catch: java.lang.Throwable -> L7d
            goto Ld
        L6c:
            int r1 = a.a.e.abc_seekbar_thumb_material     // Catch: java.lang.Throwable -> L7d
            if (r4 != r1) goto L76
            int r0 = a.a.c.abc_tint_seek_thumb     // Catch: java.lang.Throwable -> L7d
            goto Ld
        L73:
            int r0 = a.a.c.abc_tint_spinner     // Catch: java.lang.Throwable -> L7d
            goto Ld
        L76:
            if (r0 == 0) goto L7b
            r2.c(r3, r4, r0)     // Catch: java.lang.Throwable -> L7d
        L7b:
            monitor-exit(r2)
            return r0
        L7d:
            r3 = move-exception
            monitor-exit(r2)
            throw r3
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.h.s(android.content.Context, int):android.content.res.ColorStateList");
    }

    public synchronized void y(Context context) {
        a.d.d<WeakReference<Drawable.ConstantState>> dVar = this.f698d.get(context);
        if (dVar != null) {
            dVar.b();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public synchronized Drawable z(Context context, v0 v0Var, int i2) {
        Drawable x = x(context, i2);
        if (x == null) {
            x = v0Var.c(i2);
        }
        if (x != null) {
            return B(context, i2, false, x);
        }
        return null;
    }
}
