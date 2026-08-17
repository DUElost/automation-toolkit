package b.d.a.a.k;

import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.Property;
import java.util.WeakHashMap;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class e extends Property<Drawable, Integer> {

    /* renamed from: b  reason: collision with root package name */
    public static final Property<Drawable, Integer> f1473b = new e();

    /* renamed from: a  reason: collision with root package name */
    private final WeakHashMap<Drawable, Integer> f1474a;

    private e() {
        super(Integer.class, "drawableAlphaCompat");
        this.f1474a = new WeakHashMap<>();
    }

    @Override // android.util.Property
    /* renamed from: a */
    public Integer get(Drawable drawable) {
        return Build.VERSION.SDK_INT >= 19 ? Integer.valueOf(drawable.getAlpha()) : this.f1474a.containsKey(drawable) ? this.f1474a.get(drawable) : Integer.valueOf((int) SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
    }

    @Override // android.util.Property
    /* renamed from: b */
    public void set(Drawable drawable, Integer num) {
        if (Build.VERSION.SDK_INT < 19) {
            this.f1474a.put(drawable, num);
        }
        drawable.setAlpha(num.intValue());
    }
}
