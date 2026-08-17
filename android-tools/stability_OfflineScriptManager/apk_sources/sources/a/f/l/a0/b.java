package a.f.l.a0;

import android.os.Build;
import android.view.accessibility.AccessibilityManager;
/* loaded from: classes.dex */
public final class b {

    /* loaded from: classes.dex */
    public interface a {
        void onTouchExplorationStateChanged(boolean z);
    }

    /* renamed from: a.f.l.a0.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private static class accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b implements AccessibilityManager.TouchExplorationStateChangeListener {

        /* renamed from: a  reason: collision with root package name */
        final a f174a;

        accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b(a aVar) {
            this.f174a = aVar;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b.class != obj.getClass()) {
                return false;
            }
            return this.f174a.equals(((accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b) obj).f174a);
        }

        public int hashCode() {
            return this.f174a.hashCode();
        }

        @Override // android.view.accessibility.AccessibilityManager.TouchExplorationStateChangeListener
        public void onTouchExplorationStateChanged(boolean z) {
            this.f174a.onTouchExplorationStateChanged(z);
        }
    }

    public static boolean a(AccessibilityManager accessibilityManager, a aVar) {
        if (Build.VERSION.SDK_INT < 19 || aVar == null) {
            return false;
        }
        return accessibilityManager.addTouchExplorationStateChangeListener(new accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b(aVar));
    }

    public static boolean b(AccessibilityManager accessibilityManager, a aVar) {
        if (Build.VERSION.SDK_INT < 19 || aVar == null) {
            return false;
        }
        return accessibilityManager.removeTouchExplorationStateChangeListener(new accessibility.AccessibilityManager$TouchExplorationStateChangeListenerC0011b(aVar));
    }
}
