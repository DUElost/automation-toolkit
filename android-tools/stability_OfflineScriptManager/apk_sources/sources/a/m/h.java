package a.m;

import android.graphics.Path;
import android.graphics.PathMeasure;
import android.graphics.PointF;
import android.util.Property;
/* loaded from: classes.dex */
class h<T> extends Property<T, Float> {

    /* renamed from: a  reason: collision with root package name */
    private final Property<T, PointF> f274a;

    /* renamed from: b  reason: collision with root package name */
    private final PathMeasure f275b;

    /* renamed from: c  reason: collision with root package name */
    private final float f276c;

    /* renamed from: d  reason: collision with root package name */
    private final float[] f277d;
    private final PointF e;
    private float f;

    /* JADX INFO: Access modifiers changed from: package-private */
    public h(Property<T, PointF> property, Path path) {
        super(Float.class, property.getName());
        this.f277d = new float[2];
        this.e = new PointF();
        this.f274a = property;
        PathMeasure pathMeasure = new PathMeasure(path, false);
        this.f275b = pathMeasure;
        this.f276c = pathMeasure.getLength();
    }

    @Override // android.util.Property
    /* renamed from: a */
    public Float get(T t) {
        return Float.valueOf(this.f);
    }

    @Override // android.util.Property
    /* renamed from: b */
    public void set(T t, Float f) {
        this.f = f.floatValue();
        this.f275b.getPosTan(this.f276c * f.floatValue(), this.f277d, null);
        PointF pointF = this.e;
        float[] fArr = this.f277d;
        pointF.x = fArr[0];
        pointF.y = fArr[1];
        this.f274a.set(t, pointF);
    }
}
