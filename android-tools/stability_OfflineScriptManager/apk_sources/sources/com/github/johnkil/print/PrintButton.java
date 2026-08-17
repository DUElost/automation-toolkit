package com.github.johnkil.print;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.widget.ImageButton;
/* loaded from: classes.dex */
public class PrintButton extends ImageButton {
    public PrintButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a(context, attributeSet);
    }

    private void a(Context context, AttributeSet attributeSet) {
        setImageDrawable(c.a(context, attributeSet, isInEditMode()));
    }

    public b getIcon() {
        return (b) getDrawable();
    }

    public final ColorStateList getIconColor() {
        return getIcon().a();
    }

    public Typeface getIconFont() {
        return getIcon().b();
    }

    public int getIconSize() {
        return getIcon().c();
    }

    public CharSequence getIconText() {
        return getIcon().d();
    }

    public void setIconColor(int i) {
        getIcon().f(i);
    }

    public void setIconColor(ColorStateList colorStateList) {
        getIcon().g(colorStateList);
    }

    public void setIconFont(Typeface typeface) {
        getIcon().h(typeface);
    }

    public void setIconFont(String str) {
        getIcon().i(str);
    }

    public void setIconSize(int i) {
        getIcon().j(i);
        setSelected(isSelected());
    }

    public void setIconText(int i) {
        getIcon().l(i);
    }

    public void setIconText(CharSequence charSequence) {
        getIcon().m(charSequence);
    }
}
