package b.a.a;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.os.Build;
/* loaded from: classes.dex */
public enum e {
    START,
    CENTER,
    END;
    
    private static final boolean e;

    /* loaded from: classes.dex */
    static /* synthetic */ class a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1313a;

        static {
            int[] iArr = new int[e.values().length];
            f1313a = iArr;
            try {
                iArr[e.START.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1313a[e.CENTER.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f1313a[e.END.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
        }
    }

    static {
        e = Build.VERSION.SDK_INT >= 17;
    }

    @SuppressLint({"RtlHardcoded"})
    public int a() {
        int i = a.f1313a[ordinal()];
        if (i == 1) {
            return e ? 8388611 : 3;
        } else if (i != 2) {
            if (i == 3) {
                return e ? 8388613 : 5;
            }
            throw new IllegalStateException("Invalid gravity constant");
        } else {
            return 1;
        }
    }

    @TargetApi(17)
    public int b() {
        int i = a.f1313a[ordinal()];
        if (i != 2) {
            return i != 3 ? 5 : 6;
        }
        return 4;
    }
}
