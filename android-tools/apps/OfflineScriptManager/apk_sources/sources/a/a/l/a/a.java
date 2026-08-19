package a.a.l.a;

import a.a.j;
import a.a.l.a.b;
import a.a.l.a.d;
import a.d.h;
import android.animation.ObjectAnimator;
import android.animation.TimeInterpolator;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.drawable.Animatable;
import android.graphics.drawable.AnimationDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.util.StateSet;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public class a extends a.a.l.a.d {
    private c p;
    private g q;
    private int r;
    private int s;
    private boolean t;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b extends g {

        /* renamed from: a  reason: collision with root package name */
        private final Animatable f5a;

        b(Animatable animatable) {
            super();
            this.f5a = animatable;
        }

        @Override // a.a.l.a.a.g
        public void c() {
            this.f5a.start();
        }

        @Override // a.a.l.a.a.g
        public void d() {
            this.f5a.stop();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c extends d.a {
        a.d.d<Long> K;
        h<Integer> L;

        c(c cVar, a aVar, Resources resources) {
            super(cVar, aVar, resources);
            h<Integer> hVar;
            if (cVar != null) {
                this.K = cVar.K;
                hVar = cVar.L;
            } else {
                this.K = new a.d.d<>();
                hVar = new h<>();
            }
            this.L = hVar;
        }

        private static long D(int i, int i2) {
            return i2 | (i << 32);
        }

        int B(int[] iArr, Drawable drawable, int i) {
            int z = super.z(iArr, drawable);
            this.L.j(z, Integer.valueOf(i));
            return z;
        }

        int C(int i, int i2, Drawable drawable, boolean z) {
            int a2 = super.a(drawable);
            long D = D(i, i2);
            long j = z ? 8589934592L : 0L;
            long j2 = a2;
            this.K.a(D, Long.valueOf(j2 | j));
            if (z) {
                this.K.a(D(i2, i), Long.valueOf(4294967296L | j2 | j));
            }
            return a2;
        }

        int E(int i) {
            if (i < 0) {
                return 0;
            }
            return this.L.g(i, 0).intValue();
        }

        int F(int[] iArr) {
            int A = super.A(iArr);
            return A >= 0 ? A : super.A(StateSet.WILD_CARD);
        }

        int G(int i, int i2) {
            return (int) this.K.g(D(i, i2), -1L).longValue();
        }

        boolean H(int i, int i2) {
            return (this.K.g(D(i, i2), -1L).longValue() & 4294967296L) != 0;
        }

        boolean I(int i, int i2) {
            return (this.K.g(D(i, i2), -1L).longValue() & 8589934592L) != 0;
        }

        @Override // a.a.l.a.d.a, android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            return new a(this, null);
        }

        @Override // a.a.l.a.d.a, android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable(Resources resources) {
            return new a(this, resources);
        }

        @Override // a.a.l.a.d.a, a.a.l.a.b.c
        void r() {
            this.K = this.K.clone();
            this.L = this.L.clone();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class d extends g {

        /* renamed from: a  reason: collision with root package name */
        private final a.n.a.a.b f6a;

        d(a.n.a.a.b bVar) {
            super();
            this.f6a = bVar;
        }

        @Override // a.a.l.a.a.g
        public void c() {
            this.f6a.start();
        }

        @Override // a.a.l.a.a.g
        public void d() {
            this.f6a.stop();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class e extends g {

        /* renamed from: a  reason: collision with root package name */
        private final ObjectAnimator f7a;

        /* renamed from: b  reason: collision with root package name */
        private final boolean f8b;

        e(AnimationDrawable animationDrawable, boolean z, boolean z2) {
            super();
            int numberOfFrames = animationDrawable.getNumberOfFrames();
            int i = z ? numberOfFrames - 1 : 0;
            int i2 = z ? 0 : numberOfFrames - 1;
            f fVar = new f(animationDrawable, z);
            ObjectAnimator ofInt = ObjectAnimator.ofInt(animationDrawable, "currentIndex", i, i2);
            if (Build.VERSION.SDK_INT >= 18) {
                ofInt.setAutoCancel(true);
            }
            ofInt.setDuration(fVar.a());
            ofInt.setInterpolator(fVar);
            this.f8b = z2;
            this.f7a = ofInt;
        }

        @Override // a.a.l.a.a.g
        public boolean a() {
            return this.f8b;
        }

        @Override // a.a.l.a.a.g
        public void b() {
            this.f7a.reverse();
        }

        @Override // a.a.l.a.a.g
        public void c() {
            this.f7a.start();
        }

        @Override // a.a.l.a.a.g
        public void d() {
            this.f7a.cancel();
        }
    }

    /* loaded from: classes.dex */
    private static class f implements TimeInterpolator {

        /* renamed from: a  reason: collision with root package name */
        private int[] f9a;

        /* renamed from: b  reason: collision with root package name */
        private int f10b;

        /* renamed from: c  reason: collision with root package name */
        private int f11c;

        f(AnimationDrawable animationDrawable, boolean z) {
            b(animationDrawable, z);
        }

        int a() {
            return this.f11c;
        }

        int b(AnimationDrawable animationDrawable, boolean z) {
            int numberOfFrames = animationDrawable.getNumberOfFrames();
            this.f10b = numberOfFrames;
            int[] iArr = this.f9a;
            if (iArr == null || iArr.length < numberOfFrames) {
                this.f9a = new int[numberOfFrames];
            }
            int[] iArr2 = this.f9a;
            int i = 0;
            for (int i2 = 0; i2 < numberOfFrames; i2++) {
                int duration = animationDrawable.getDuration(z ? (numberOfFrames - i2) - 1 : i2);
                iArr2[i2] = duration;
                i += duration;
            }
            this.f11c = i;
            return i;
        }

        @Override // android.animation.TimeInterpolator
        public float getInterpolation(float f) {
            int i = (int) ((f * this.f11c) + 0.5f);
            int i2 = this.f10b;
            int[] iArr = this.f9a;
            int i3 = 0;
            while (i3 < i2 && i >= iArr[i3]) {
                i -= iArr[i3];
                i3++;
            }
            return (i3 / i2) + (i3 < i2 ? i / this.f11c : 0.0f);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static abstract class g {
        private g() {
        }

        public boolean a() {
            return false;
        }

        public void b() {
        }

        public abstract void c();

        public abstract void d();
    }

    public a() {
        this(null, null);
    }

    a(c cVar, Resources resources) {
        super(null);
        this.r = -1;
        this.s = -1;
        h(new c(cVar, this, resources));
        onStateChange(getState());
        jumpToCurrentState();
    }

    public static a m(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        String name = xmlPullParser.getName();
        if (name.equals("animated-selector")) {
            a aVar = new a();
            aVar.n(context, resources, xmlPullParser, attributeSet, theme);
            return aVar;
        }
        throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": invalid animated-selector tag " + name);
    }

    private void o(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        int depth = xmlPullParser.getDepth() + 1;
        while (true) {
            int next = xmlPullParser.next();
            if (next == 1) {
                return;
            }
            int depth2 = xmlPullParser.getDepth();
            if (depth2 < depth && next == 3) {
                return;
            }
            if (next == 2 && depth2 <= depth) {
                if (xmlPullParser.getName().equals("item")) {
                    q(context, resources, xmlPullParser, attributeSet, theme);
                } else if (xmlPullParser.getName().equals("transition")) {
                    r(context, resources, xmlPullParser, attributeSet, theme);
                }
            }
        }
    }

    private void p() {
        onStateChange(getState());
    }

    private int q(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        int next;
        TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, j.AnimatedStateListDrawableItem);
        int resourceId = i.getResourceId(j.AnimatedStateListDrawableItem_android_id, 0);
        int resourceId2 = i.getResourceId(j.AnimatedStateListDrawableItem_android_drawable, -1);
        Drawable d2 = resourceId2 > 0 ? a.a.k.a.a.d(context, resourceId2) : null;
        i.recycle();
        int[] k = k(attributeSet);
        if (d2 == null) {
            do {
                next = xmlPullParser.next();
            } while (next == 4);
            if (next != 2) {
                throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": <item> tag requires a 'drawable' attribute or child tag defining a drawable");
            }
            d2 = xmlPullParser.getName().equals("vector") ? a.n.a.a.h.c(resources, xmlPullParser, attributeSet, theme) : Build.VERSION.SDK_INT >= 21 ? Drawable.createFromXmlInner(resources, xmlPullParser, attributeSet, theme) : Drawable.createFromXmlInner(resources, xmlPullParser, attributeSet);
        }
        if (d2 != null) {
            return this.p.B(k, d2, resourceId);
        }
        throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": <item> tag requires a 'drawable' attribute or child tag defining a drawable");
    }

    private int r(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        int next;
        TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, j.AnimatedStateListDrawableTransition);
        int resourceId = i.getResourceId(j.AnimatedStateListDrawableTransition_android_fromId, -1);
        int resourceId2 = i.getResourceId(j.AnimatedStateListDrawableTransition_android_toId, -1);
        int resourceId3 = i.getResourceId(j.AnimatedStateListDrawableTransition_android_drawable, -1);
        Drawable d2 = resourceId3 > 0 ? a.a.k.a.a.d(context, resourceId3) : null;
        boolean z = i.getBoolean(j.AnimatedStateListDrawableTransition_android_reversible, false);
        i.recycle();
        if (d2 == null) {
            do {
                next = xmlPullParser.next();
            } while (next == 4);
            if (next != 2) {
                throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": <transition> tag requires a 'drawable' attribute or child tag defining a drawable");
            }
            d2 = xmlPullParser.getName().equals("animated-vector") ? a.n.a.a.b.a(context, resources, xmlPullParser, attributeSet, theme) : Build.VERSION.SDK_INT >= 21 ? Drawable.createFromXmlInner(resources, xmlPullParser, attributeSet, theme) : Drawable.createFromXmlInner(resources, xmlPullParser, attributeSet);
        }
        if (d2 == null) {
            throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": <transition> tag requires a 'drawable' attribute or child tag defining a drawable");
        } else if (resourceId == -1 || resourceId2 == -1) {
            throw new org.xmlpull.v1.a(xmlPullParser.getPositionDescription() + ": <transition> tag requires 'fromId' & 'toId' attributes");
        } else {
            return this.p.C(resourceId, resourceId2, d2, z);
        }
    }

    private boolean s(int i) {
        int c2;
        int G;
        g bVar;
        g gVar = this.q;
        if (gVar == null) {
            c2 = c();
        } else if (i == this.r) {
            return true;
        } else {
            if (i == this.s && gVar.a()) {
                gVar.b();
                this.r = this.s;
                this.s = i;
                return true;
            }
            c2 = this.r;
            gVar.d();
        }
        this.q = null;
        this.s = -1;
        this.r = -1;
        c cVar = this.p;
        int E = cVar.E(c2);
        int E2 = cVar.E(i);
        if (E2 == 0 || E == 0 || (G = cVar.G(E, E2)) < 0) {
            return false;
        }
        boolean I = cVar.I(E, E2);
        g(G);
        Drawable current = getCurrent();
        if (current instanceof AnimationDrawable) {
            bVar = new e((AnimationDrawable) current, cVar.H(E, E2), I);
        } else if (!(current instanceof a.n.a.a.b)) {
            if (current instanceof Animatable) {
                bVar = new b((Animatable) current);
            }
            return false;
        } else {
            bVar = new d((a.n.a.a.b) current);
        }
        bVar.c();
        this.q = bVar;
        this.s = c2;
        this.r = i;
        return true;
    }

    private void t(TypedArray typedArray) {
        c cVar = this.p;
        if (Build.VERSION.SDK_INT >= 21) {
            cVar.f20d |= typedArray.getChangingConfigurations();
        }
        cVar.x(typedArray.getBoolean(j.AnimatedStateListDrawableCompat_android_variablePadding, cVar.i));
        cVar.t(typedArray.getBoolean(j.AnimatedStateListDrawableCompat_android_constantSize, cVar.l));
        cVar.u(typedArray.getInt(j.AnimatedStateListDrawableCompat_android_enterFadeDuration, cVar.A));
        cVar.v(typedArray.getInt(j.AnimatedStateListDrawableCompat_android_exitFadeDuration, cVar.B));
        setDither(typedArray.getBoolean(j.AnimatedStateListDrawableCompat_android_dither, cVar.x));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // a.a.l.a.d, a.a.l.a.b
    public void h(b.c cVar) {
        super.h(cVar);
        if (cVar instanceof c) {
            this.p = (c) cVar;
        }
    }

    @Override // a.a.l.a.d, android.graphics.drawable.Drawable
    public boolean isStateful() {
        return true;
    }

    @Override // a.a.l.a.b, android.graphics.drawable.Drawable
    public void jumpToCurrentState() {
        super.jumpToCurrentState();
        g gVar = this.q;
        if (gVar != null) {
            gVar.d();
            this.q = null;
            g(this.r);
            this.r = -1;
            this.s = -1;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // a.a.l.a.d
    /* renamed from: l */
    public c j() {
        return new c(this.p, this, null);
    }

    @Override // a.a.l.a.d, a.a.l.a.b, android.graphics.drawable.Drawable
    public Drawable mutate() {
        if (!this.t) {
            super.mutate();
            if (this == this) {
                this.p.r();
                this.t = true;
            }
        }
        return this;
    }

    public void n(Context context, Resources resources, XmlPullParser xmlPullParser, AttributeSet attributeSet, Resources.Theme theme) {
        TypedArray i = androidx.core.content.c.g.i(resources, theme, attributeSet, j.AnimatedStateListDrawableCompat);
        setVisible(i.getBoolean(j.AnimatedStateListDrawableCompat_android_visible, true), true);
        t(i);
        i(resources);
        i.recycle();
        o(context, resources, xmlPullParser, attributeSet, theme);
        p();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // a.a.l.a.d, a.a.l.a.b, android.graphics.drawable.Drawable
    public boolean onStateChange(int[] iArr) {
        int F = this.p.F(iArr);
        boolean z = F != c() && (s(F) || g(F));
        Drawable current = getCurrent();
        return current != null ? z | current.setState(iArr) : z;
    }

    @Override // a.a.l.a.b, android.graphics.drawable.Drawable
    public boolean setVisible(boolean z, boolean z2) {
        boolean visible = super.setVisible(z, z2);
        g gVar = this.q;
        if (gVar != null && (visible || z2)) {
            if (z) {
                gVar.c();
            } else {
                jumpToCurrentState();
            }
        }
        return visible;
    }
}
