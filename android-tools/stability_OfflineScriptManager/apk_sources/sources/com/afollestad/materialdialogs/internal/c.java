package com.afollestad.materialdialogs.internal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.Log;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.appcompat.widget.i;
import b.a.a.g;
import b.a.a.j;
import java.lang.reflect.Field;
@SuppressLint({"PrivateResource"})
/* loaded from: classes.dex */
public class c {
    private static ColorStateList a(Context context, int i) {
        int i2 = g.colorControlNormal;
        return new ColorStateList(new int[][]{new int[]{-16842910}, new int[]{-16842919, -16842908}, new int[0]}, new int[]{b.a.a.q.a.l(context, i2), b.a.a.q.a.l(context, i2), i});
    }

    private static void b(EditText editText, int i) {
        try {
            Field declaredField = TextView.class.getDeclaredField("mCursorDrawableRes");
            declaredField.setAccessible(true);
            int i2 = declaredField.getInt(editText);
            Field declaredField2 = TextView.class.getDeclaredField("mEditor");
            declaredField2.setAccessible(true);
            Object obj = declaredField2.get(editText);
            Field declaredField3 = obj.getClass().getDeclaredField("mCursorDrawable");
            declaredField3.setAccessible(true);
            Drawable[] drawableArr = {androidx.core.content.a.d(editText.getContext(), i2), androidx.core.content.a.d(editText.getContext(), i2)};
            drawableArr[0].setColorFilter(i, PorterDuff.Mode.SRC_IN);
            drawableArr[1].setColorFilter(i, PorterDuff.Mode.SRC_IN);
            declaredField3.set(obj, drawableArr);
        } catch (NoSuchFieldException e) {
            Log.d("MDTintHelper", "Device issue with cursor tinting: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }

    public static void c(CheckBox checkBox, int i) {
        int d2 = b.a.a.q.a.d(checkBox.getContext());
        d(checkBox, new ColorStateList(new int[][]{new int[]{16842910, -16842912}, new int[]{16842910, 16842912}, new int[]{-16842910, -16842912}, new int[]{-16842910, 16842912}}, new int[]{b.a.a.q.a.l(checkBox.getContext(), g.colorControlNormal), i, d2, d2}));
    }

    public static void d(CheckBox checkBox, ColorStateList colorStateList) {
        if (Build.VERSION.SDK_INT >= 21) {
            checkBox.setButtonTintList(colorStateList);
            return;
        }
        Drawable q = androidx.core.graphics.drawable.a.q(androidx.core.content.a.d(checkBox.getContext(), j.abc_btn_check_material));
        androidx.core.graphics.drawable.a.o(q, colorStateList);
        checkBox.setButtonDrawable(q);
    }

    public static void e(EditText editText, int i) {
        ColorStateList a2 = a(editText.getContext(), i);
        if (editText instanceof i) {
            ((i) editText).setSupportBackgroundTintList(a2);
        } else if (Build.VERSION.SDK_INT >= 21) {
            editText.setBackgroundTintList(a2);
        }
        b(editText, i);
    }

    public static void f(ProgressBar progressBar, int i) {
        g(progressBar, i, false);
    }

    private static void g(ProgressBar progressBar, int i, boolean z) {
        ColorStateList valueOf = ColorStateList.valueOf(i);
        int i2 = Build.VERSION.SDK_INT;
        if (i2 >= 21) {
            progressBar.setProgressTintList(valueOf);
            progressBar.setSecondaryProgressTintList(valueOf);
            if (z) {
                return;
            }
            progressBar.setIndeterminateTintList(valueOf);
            return;
        }
        PorterDuff.Mode mode = PorterDuff.Mode.SRC_IN;
        if (i2 <= 10) {
            mode = PorterDuff.Mode.MULTIPLY;
        }
        if (!z && progressBar.getIndeterminateDrawable() != null) {
            progressBar.getIndeterminateDrawable().setColorFilter(i, mode);
        }
        if (progressBar.getProgressDrawable() != null) {
            progressBar.getProgressDrawable().setColorFilter(i, mode);
        }
    }

    public static void h(RadioButton radioButton, int i) {
        int d2 = b.a.a.q.a.d(radioButton.getContext());
        i(radioButton, new ColorStateList(new int[][]{new int[]{16842910, -16842912}, new int[]{16842910, 16842912}, new int[]{-16842910, -16842912}, new int[]{-16842910, 16842912}}, new int[]{b.a.a.q.a.l(radioButton.getContext(), g.colorControlNormal), i, d2, d2}));
    }

    public static void i(RadioButton radioButton, ColorStateList colorStateList) {
        if (Build.VERSION.SDK_INT >= 21) {
            radioButton.setButtonTintList(colorStateList);
            return;
        }
        Drawable q = androidx.core.graphics.drawable.a.q(androidx.core.content.a.d(radioButton.getContext(), j.abc_btn_radio_material));
        androidx.core.graphics.drawable.a.o(q, colorStateList);
        radioButton.setButtonDrawable(q);
    }
}
