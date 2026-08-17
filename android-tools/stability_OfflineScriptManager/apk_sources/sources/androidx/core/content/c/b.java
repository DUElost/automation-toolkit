package androidx.core.content.c;

import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.graphics.Shader;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
/* loaded from: classes.dex */
public final class b {

    /* renamed from: a  reason: collision with root package name */
    private final Shader f861a;

    /* renamed from: b  reason: collision with root package name */
    private final ColorStateList f862b;

    /* renamed from: c  reason: collision with root package name */
    private int f863c;

    private b(Shader shader, ColorStateList colorStateList, int i) {
        this.f861a = shader;
        this.f862b = colorStateList;
        this.f863c = i;
    }

    private static b a(Resources resources, int i, Resources.Theme theme) {
        int next;
        XmlResourceParser xml = resources.getXml(i);
        AttributeSet asAttributeSet = Xml.asAttributeSet(xml);
        do {
            next = xml.next();
            if (next == 2) {
                break;
            }
        } while (next != 1);
        if (next == 2) {
            String name = xml.getName();
            name.hashCode();
            if (name.equals("gradient")) {
                return d(d.b(resources, xml, asAttributeSet, theme));
            }
            if (name.equals("selector")) {
                return c(a.b(resources, xml, asAttributeSet, theme));
            }
            throw new org.xmlpull.v1.a(xml.getPositionDescription() + ": unsupported complex color tag " + name);
        }
        throw new org.xmlpull.v1.a("No start tag found");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static b b(int i) {
        return new b(null, null, i);
    }

    static b c(ColorStateList colorStateList) {
        return new b(null, colorStateList, colorStateList.getDefaultColor());
    }

    static b d(Shader shader) {
        return new b(shader, null, 0);
    }

    public static b g(Resources resources, int i, Resources.Theme theme) {
        try {
            return a(resources, i, theme);
        } catch (Exception e) {
            Log.e("ComplexColorCompat", "Failed to inflate ComplexColor.", e);
            return null;
        }
    }

    public int e() {
        return this.f863c;
    }

    public Shader f() {
        return this.f861a;
    }

    public boolean h() {
        return this.f861a != null;
    }

    public boolean i() {
        ColorStateList colorStateList;
        return this.f861a == null && (colorStateList = this.f862b) != null && colorStateList.isStateful();
    }

    public boolean j(int[] iArr) {
        if (i()) {
            ColorStateList colorStateList = this.f862b;
            int colorForState = colorStateList.getColorForState(iArr, colorStateList.getDefaultColor());
            if (colorForState != this.f863c) {
                this.f863c = colorForState;
                return true;
            }
        }
        return false;
    }

    public void k(int i) {
        this.f863c = i;
    }

    public boolean l() {
        return h() || this.f863c != 0;
    }
}
