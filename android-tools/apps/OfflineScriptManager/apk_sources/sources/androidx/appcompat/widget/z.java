package androidx.appcompat.widget;

import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.DrawableContainer;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.InsetDrawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.ScaleDrawable;
import android.os.Build;
/* loaded from: classes.dex */
public class z {
    static {
        new Rect();
        if (Build.VERSION.SDK_INT >= 18) {
            try {
                Class.forName("android.graphics.Insets");
            } catch (ClassNotFoundException unused) {
            }
        }
    }

    public static boolean a(Drawable drawable) {
        Drawable drawable2;
        int i = Build.VERSION.SDK_INT;
        if (i >= 15 || !(drawable instanceof InsetDrawable)) {
            if (i >= 15 || !(drawable instanceof GradientDrawable)) {
                if (i >= 17 || !(drawable instanceof LayerDrawable)) {
                    if (!(drawable instanceof DrawableContainer)) {
                        if (drawable instanceof androidx.core.graphics.drawable.c) {
                            drawable2 = ((androidx.core.graphics.drawable.c) drawable).a();
                        } else if (drawable instanceof a.a.l.a.c) {
                            drawable2 = ((a.a.l.a.c) drawable).a();
                        } else if (!(drawable instanceof ScaleDrawable)) {
                            return true;
                        } else {
                            drawable2 = ((ScaleDrawable) drawable).getDrawable();
                        }
                        return a(drawable2);
                    }
                    Drawable.ConstantState constantState = drawable.getConstantState();
                    if (constantState instanceof DrawableContainer.DrawableContainerState) {
                        for (Drawable drawable3 : ((DrawableContainer.DrawableContainerState) constantState).getChildren()) {
                            if (!a(drawable3)) {
                                return false;
                            }
                        }
                        return true;
                    }
                    return true;
                }
                return false;
            }
            return false;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void b(Drawable drawable) {
        if (Build.VERSION.SDK_INT == 21 && "android.graphics.drawable.VectorDrawable".equals(drawable.getClass().getName())) {
            c(drawable);
        }
    }

    private static void c(Drawable drawable) {
        int[] state = drawable.getState();
        if (state == null || state.length == 0) {
            drawable.setState(l0.e);
        } else {
            drawable.setState(l0.f);
        }
        drawable.setState(state);
    }

    public static PorterDuff.Mode d(int i, PorterDuff.Mode mode) {
        if (i != 3) {
            if (i != 5) {
                if (i != 9) {
                    switch (i) {
                        case 14:
                            return PorterDuff.Mode.MULTIPLY;
                        case 15:
                            return PorterDuff.Mode.SCREEN;
                        case 16:
                            return PorterDuff.Mode.ADD;
                        default:
                            return mode;
                    }
                }
                return PorterDuff.Mode.SRC_ATOP;
            }
            return PorterDuff.Mode.SRC_IN;
        }
        return PorterDuff.Mode.SRC_OVER;
    }
}
