package a.n.a.a;

import android.animation.TypeEvaluator;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class e implements TypeEvaluator {

    /* renamed from: a  reason: collision with root package name */
    private static final e f342a = new e();

    public static e a() {
        return f342a;
    }

    @Override // android.animation.TypeEvaluator
    public Object evaluate(float f, Object obj, Object obj2) {
        int intValue = ((Integer) obj).intValue();
        float f2 = ((intValue >> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f;
        int intValue2 = ((Integer) obj2).intValue();
        float pow = (float) Math.pow(((intValue >> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d);
        float pow2 = (float) Math.pow(((intValue >> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d);
        float pow3 = (float) Math.pow((intValue & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d);
        float pow4 = (float) Math.pow(((intValue2 >> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d);
        float pow5 = pow3 + (f * (((float) Math.pow((intValue2 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d)) - pow3));
        return Integer.valueOf((Math.round(((float) Math.pow(pow + ((pow4 - pow) * f), 0.45454545454545453d)) * 255.0f) << 16) | (Math.round((f2 + (((((intValue2 >> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f) - f2) * f)) * 255.0f) << 24) | (Math.round(((float) Math.pow(pow2 + ((((float) Math.pow(((intValue2 >> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) / 255.0f, 2.2d)) - pow2) * f), 0.45454545454545453d)) * 255.0f) << 8) | Math.round(((float) Math.pow(pow5, 0.45454545454545453d)) * 255.0f));
    }
}
