package a.f.l.a0;

import android.graphics.Rect;
import android.os.Build;
import android.view.accessibility.AccessibilityNodeInfo;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    private final AccessibilityNodeInfo f175a;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        final Object f176a;

        a(Object obj) {
            this.f176a = obj;
        }

        public static a a(int i, int i2, boolean z, int i3) {
            int i4 = Build.VERSION.SDK_INT;
            return i4 >= 21 ? new a(AccessibilityNodeInfo.CollectionInfo.obtain(i, i2, z, i3)) : i4 >= 19 ? new a(AccessibilityNodeInfo.CollectionInfo.obtain(i, i2, z)) : new a(null);
        }
    }

    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        final Object f177a;

        b(Object obj) {
            this.f177a = obj;
        }

        public static b a(int i, int i2, int i3, int i4, boolean z, boolean z2) {
            int i5 = Build.VERSION.SDK_INT;
            return i5 >= 21 ? new b(AccessibilityNodeInfo.CollectionItemInfo.obtain(i, i2, i3, i4, z, z2)) : i5 >= 19 ? new b(AccessibilityNodeInfo.CollectionItemInfo.obtain(i, i2, i3, i4, z)) : new b(null);
        }
    }

    private c(AccessibilityNodeInfo accessibilityNodeInfo) {
        this.f175a = accessibilityNodeInfo;
    }

    public static c C(AccessibilityNodeInfo accessibilityNodeInfo) {
        return new c(accessibilityNodeInfo);
    }

    private static String b(int i) {
        if (i != 1) {
            if (i != 2) {
                switch (i) {
                    case 4:
                        return "ACTION_SELECT";
                    case 8:
                        return "ACTION_CLEAR_SELECTION";
                    case 16:
                        return "ACTION_CLICK";
                    case 32:
                        return "ACTION_LONG_CLICK";
                    case 64:
                        return "ACTION_ACCESSIBILITY_FOCUS";
                    case 128:
                        return "ACTION_CLEAR_ACCESSIBILITY_FOCUS";
                    case 256:
                        return "ACTION_NEXT_AT_MOVEMENT_GRANULARITY";
                    case 512:
                        return "ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY";
                    case 1024:
                        return "ACTION_NEXT_HTML_ELEMENT";
                    case 2048:
                        return "ACTION_PREVIOUS_HTML_ELEMENT";
                    case 4096:
                        return "ACTION_SCROLL_FORWARD";
                    case 8192:
                        return "ACTION_SCROLL_BACKWARD";
                    case 16384:
                        return "ACTION_COPY";
                    case 32768:
                        return "ACTION_PASTE";
                    case 65536:
                        return "ACTION_CUT";
                    case 131072:
                        return "ACTION_SET_SELECTION";
                    default:
                        return "ACTION_UNKNOWN";
                }
            }
            return "ACTION_CLEAR_FOCUS";
        }
        return "ACTION_FOCUS";
    }

    public void A(boolean z) {
        this.f175a.setScrollable(z);
    }

    public AccessibilityNodeInfo B() {
        return this.f175a;
    }

    public void a(int i) {
        this.f175a.addAction(i);
    }

    public int c() {
        return this.f175a.getActions();
    }

    public void d(Rect rect) {
        this.f175a.getBoundsInParent(rect);
    }

    public void e(Rect rect) {
        this.f175a.getBoundsInScreen(rect);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj != null && c.class == obj.getClass()) {
            AccessibilityNodeInfo accessibilityNodeInfo = this.f175a;
            AccessibilityNodeInfo accessibilityNodeInfo2 = ((c) obj).f175a;
            if (accessibilityNodeInfo == null) {
                if (accessibilityNodeInfo2 != null) {
                    return false;
                }
            } else if (!accessibilityNodeInfo.equals(accessibilityNodeInfo2)) {
                return false;
            }
            return true;
        }
        return false;
    }

    public CharSequence f() {
        return this.f175a.getClassName();
    }

    public CharSequence g() {
        return this.f175a.getContentDescription();
    }

    public CharSequence h() {
        return this.f175a.getPackageName();
    }

    public int hashCode() {
        AccessibilityNodeInfo accessibilityNodeInfo = this.f175a;
        if (accessibilityNodeInfo == null) {
            return 0;
        }
        return accessibilityNodeInfo.hashCode();
    }

    public CharSequence i() {
        return this.f175a.getText();
    }

    public String j() {
        if (Build.VERSION.SDK_INT >= 18) {
            return this.f175a.getViewIdResourceName();
        }
        return null;
    }

    public boolean k() {
        return this.f175a.isCheckable();
    }

    public boolean l() {
        return this.f175a.isChecked();
    }

    public boolean m() {
        return this.f175a.isClickable();
    }

    public boolean n() {
        return this.f175a.isEnabled();
    }

    public boolean o() {
        return this.f175a.isFocusable();
    }

    public boolean p() {
        return this.f175a.isFocused();
    }

    public boolean q() {
        return this.f175a.isLongClickable();
    }

    public boolean r() {
        return this.f175a.isPassword();
    }

    public boolean s() {
        return this.f175a.isScrollable();
    }

    public boolean t() {
        return this.f175a.isSelected();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString());
        Rect rect = new Rect();
        d(rect);
        sb.append("; boundsInParent: " + rect);
        e(rect);
        sb.append("; boundsInScreen: " + rect);
        sb.append("; packageName: ");
        sb.append(h());
        sb.append("; className: ");
        sb.append(f());
        sb.append("; text: ");
        sb.append(i());
        sb.append("; contentDescription: ");
        sb.append(g());
        sb.append("; viewId: ");
        sb.append(j());
        sb.append("; checkable: ");
        sb.append(k());
        sb.append("; checked: ");
        sb.append(l());
        sb.append("; focusable: ");
        sb.append(o());
        sb.append("; focused: ");
        sb.append(p());
        sb.append("; selected: ");
        sb.append(t());
        sb.append("; clickable: ");
        sb.append(m());
        sb.append("; longClickable: ");
        sb.append(q());
        sb.append("; enabled: ");
        sb.append(n());
        sb.append("; password: ");
        sb.append(r());
        sb.append("; scrollable: " + s());
        sb.append("; [");
        int c2 = c();
        while (c2 != 0) {
            int numberOfTrailingZeros = 1 << Integer.numberOfTrailingZeros(c2);
            c2 &= ~numberOfTrailingZeros;
            sb.append(b(numberOfTrailingZeros));
            if (c2 != 0) {
                sb.append(", ");
            }
        }
        sb.append("]");
        return sb.toString();
    }

    public void u(boolean z) {
        this.f175a.setCheckable(z);
    }

    public void v(boolean z) {
        this.f175a.setChecked(z);
    }

    public void w(CharSequence charSequence) {
        this.f175a.setClassName(charSequence);
    }

    public void x(Object obj) {
        if (Build.VERSION.SDK_INT >= 19) {
            this.f175a.setCollectionInfo(obj == null ? null : (AccessibilityNodeInfo.CollectionInfo) ((a) obj).f176a);
        }
    }

    public void y(Object obj) {
        if (Build.VERSION.SDK_INT >= 19) {
            this.f175a.setCollectionItemInfo(obj == null ? null : (AccessibilityNodeInfo.CollectionItemInfo) ((b) obj).f177a);
        }
    }

    public void z(boolean z) {
        if (Build.VERSION.SDK_INT >= 19) {
            this.f175a.setDismissable(z);
        }
    }
}
