package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.util.TypedValue;
import androidx.core.content.c.f;
/* loaded from: classes.dex */
public class q0 {

    /* renamed from: a  reason: collision with root package name */
    private final Context f750a;

    /* renamed from: b  reason: collision with root package name */
    private final TypedArray f751b;

    /* renamed from: c  reason: collision with root package name */
    private TypedValue f752c;

    private q0(Context context, TypedArray typedArray) {
        this.f750a = context;
        this.f751b = typedArray;
    }

    public static q0 r(Context context, int i, int[] iArr) {
        return new q0(context, context.obtainStyledAttributes(i, iArr));
    }

    public static q0 s(Context context, AttributeSet attributeSet, int[] iArr) {
        return new q0(context, context.obtainStyledAttributes(attributeSet, iArr));
    }

    public static q0 t(Context context, AttributeSet attributeSet, int[] iArr, int i, int i2) {
        return new q0(context, context.obtainStyledAttributes(attributeSet, iArr, i, i2));
    }

    public boolean a(int i, boolean z) {
        return this.f751b.getBoolean(i, z);
    }

    public int b(int i, int i2) {
        return this.f751b.getColor(i, i2);
    }

    public ColorStateList c(int i) {
        int resourceId;
        ColorStateList c2;
        return (!this.f751b.hasValue(i) || (resourceId = this.f751b.getResourceId(i, 0)) == 0 || (c2 = a.a.k.a.a.c(this.f750a, resourceId)) == null) ? this.f751b.getColorStateList(i) : c2;
    }

    public int d(int i, int i2) {
        return this.f751b.getDimensionPixelOffset(i, i2);
    }

    public int e(int i, int i2) {
        return this.f751b.getDimensionPixelSize(i, i2);
    }

    public Drawable f(int i) {
        int resourceId;
        return (!this.f751b.hasValue(i) || (resourceId = this.f751b.getResourceId(i, 0)) == 0) ? this.f751b.getDrawable(i) : a.a.k.a.a.d(this.f750a, resourceId);
    }

    public Drawable g(int i) {
        int resourceId;
        if (!this.f751b.hasValue(i) || (resourceId = this.f751b.getResourceId(i, 0)) == 0) {
            return null;
        }
        return h.n().q(this.f750a, resourceId, true);
    }

    public float h(int i, float f) {
        return this.f751b.getFloat(i, f);
    }

    public Typeface i(int i, int i2, f.a aVar) {
        int resourceId = this.f751b.getResourceId(i, 0);
        if (resourceId == 0) {
            return null;
        }
        if (this.f752c == null) {
            this.f752c = new TypedValue();
        }
        return androidx.core.content.c.f.b(this.f750a, resourceId, this.f752c, i2, aVar);
    }

    public int j(int i, int i2) {
        return this.f751b.getInt(i, i2);
    }

    public int k(int i, int i2) {
        return this.f751b.getInteger(i, i2);
    }

    public int l(int i, int i2) {
        return this.f751b.getLayoutDimension(i, i2);
    }

    public int m(int i, int i2) {
        return this.f751b.getResourceId(i, i2);
    }

    public String n(int i) {
        return this.f751b.getString(i);
    }

    public CharSequence o(int i) {
        return this.f751b.getText(i);
    }

    public CharSequence[] p(int i) {
        return this.f751b.getTextArray(i);
    }

    public boolean q(int i) {
        return this.f751b.hasValue(i);
    }

    public void u() {
        this.f751b.recycle();
    }
}
