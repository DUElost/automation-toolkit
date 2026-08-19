package b.d.a.a.m;

import android.animation.TypeEvaluator;
import android.graphics.drawable.Drawable;
import android.util.Property;
/* loaded from: classes.dex */
public interface d {

    /* loaded from: classes.dex */
    public static class b implements TypeEvaluator<e> {

        /* renamed from: b  reason: collision with root package name */
        public static final TypeEvaluator<e> f1495b = new b();

        /* renamed from: a  reason: collision with root package name */
        private final e f1496a = new e();

        @Override // android.animation.TypeEvaluator
        /* renamed from: a */
        public e evaluate(float f, e eVar, e eVar2) {
            this.f1496a.a(b.d.a.a.o.a.c(eVar.f1499a, eVar2.f1499a, f), b.d.a.a.o.a.c(eVar.f1500b, eVar2.f1500b, f), b.d.a.a.o.a.c(eVar.f1501c, eVar2.f1501c, f));
            return this.f1496a;
        }
    }

    /* loaded from: classes.dex */
    public static class c extends Property<d, e> {

        /* renamed from: a  reason: collision with root package name */
        public static final Property<d, e> f1497a = new c("circularReveal");

        private c(String str) {
            super(e.class, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public e get(d dVar) {
            return dVar.getRevealInfo();
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(d dVar, e eVar) {
            dVar.setRevealInfo(eVar);
        }
    }

    /* renamed from: b.d.a.a.m.d$d  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0049d extends Property<d, Integer> {

        /* renamed from: a  reason: collision with root package name */
        public static final Property<d, Integer> f1498a = new C0049d("circularRevealScrimColor");

        private C0049d(String str) {
            super(Integer.class, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public Integer get(d dVar) {
            return Integer.valueOf(dVar.getCircularRevealScrimColor());
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(d dVar, Integer num) {
            dVar.setCircularRevealScrimColor(num.intValue());
        }
    }

    /* loaded from: classes.dex */
    public static class e {

        /* renamed from: a  reason: collision with root package name */
        public float f1499a;

        /* renamed from: b  reason: collision with root package name */
        public float f1500b;

        /* renamed from: c  reason: collision with root package name */
        public float f1501c;

        private e() {
        }

        public e(float f, float f2, float f3) {
            this.f1499a = f;
            this.f1500b = f2;
            this.f1501c = f3;
        }

        public void a(float f, float f2, float f3) {
            this.f1499a = f;
            this.f1500b = f2;
            this.f1501c = f3;
        }
    }

    void a();

    void b();

    int getCircularRevealScrimColor();

    e getRevealInfo();

    void setCircularRevealOverlayDrawable(Drawable drawable);

    void setCircularRevealScrimColor(int i);

    void setRevealInfo(e eVar);
}
