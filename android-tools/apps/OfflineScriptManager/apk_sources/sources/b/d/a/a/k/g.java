package b.d.a.a.k;

import android.animation.TypeEvaluator;
import android.graphics.Matrix;
/* loaded from: classes.dex */
public class g implements TypeEvaluator<Matrix> {

    /* renamed from: a  reason: collision with root package name */
    private final float[] f1476a = new float[9];

    /* renamed from: b  reason: collision with root package name */
    private final float[] f1477b = new float[9];

    /* renamed from: c  reason: collision with root package name */
    private final Matrix f1478c = new Matrix();

    @Override // android.animation.TypeEvaluator
    /* renamed from: a */
    public Matrix evaluate(float f, Matrix matrix, Matrix matrix2) {
        matrix.getValues(this.f1476a);
        matrix2.getValues(this.f1477b);
        for (int i = 0; i < 9; i++) {
            float[] fArr = this.f1477b;
            float f2 = fArr[i];
            float[] fArr2 = this.f1476a;
            fArr[i] = fArr2[i] + ((f2 - fArr2[i]) * f);
        }
        this.f1478c.setValues(this.f1477b);
        return this.f1478c;
    }
}
