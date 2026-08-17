package a.f.l;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeProvider;
/* loaded from: classes.dex */
public class a {

    /* renamed from: b  reason: collision with root package name */
    private static final View.AccessibilityDelegate f171b = new View.AccessibilityDelegate();

    /* renamed from: a  reason: collision with root package name */
    private final View.AccessibilityDelegate f172a = new C0010a(this);

    /* renamed from: a.f.l.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private static final class C0010a extends View.AccessibilityDelegate {

        /* renamed from: a  reason: collision with root package name */
        private final a f173a;

        C0010a(a aVar) {
            this.f173a = aVar;
        }

        @Override // android.view.View.AccessibilityDelegate
        public boolean dispatchPopulateAccessibilityEvent(View view, AccessibilityEvent accessibilityEvent) {
            return this.f173a.a(view, accessibilityEvent);
        }

        @Override // android.view.View.AccessibilityDelegate
        public AccessibilityNodeProvider getAccessibilityNodeProvider(View view) {
            a.f.l.a0.d b2 = this.f173a.b(view);
            if (b2 != null) {
                return (AccessibilityNodeProvider) b2.a();
            }
            return null;
        }

        @Override // android.view.View.AccessibilityDelegate
        public void onInitializeAccessibilityEvent(View view, AccessibilityEvent accessibilityEvent) {
            this.f173a.d(view, accessibilityEvent);
        }

        @Override // android.view.View.AccessibilityDelegate
        public void onInitializeAccessibilityNodeInfo(View view, AccessibilityNodeInfo accessibilityNodeInfo) {
            this.f173a.e(view, a.f.l.a0.c.C(accessibilityNodeInfo));
        }

        @Override // android.view.View.AccessibilityDelegate
        public void onPopulateAccessibilityEvent(View view, AccessibilityEvent accessibilityEvent) {
            this.f173a.f(view, accessibilityEvent);
        }

        @Override // android.view.View.AccessibilityDelegate
        public boolean onRequestSendAccessibilityEvent(ViewGroup viewGroup, View view, AccessibilityEvent accessibilityEvent) {
            return this.f173a.g(viewGroup, view, accessibilityEvent);
        }

        @Override // android.view.View.AccessibilityDelegate
        public boolean performAccessibilityAction(View view, int i, Bundle bundle) {
            return this.f173a.h(view, i, bundle);
        }

        @Override // android.view.View.AccessibilityDelegate
        public void sendAccessibilityEvent(View view, int i) {
            this.f173a.i(view, i);
        }

        @Override // android.view.View.AccessibilityDelegate
        public void sendAccessibilityEventUnchecked(View view, AccessibilityEvent accessibilityEvent) {
            this.f173a.j(view, accessibilityEvent);
        }
    }

    public boolean a(View view, AccessibilityEvent accessibilityEvent) {
        return f171b.dispatchPopulateAccessibilityEvent(view, accessibilityEvent);
    }

    public a.f.l.a0.d b(View view) {
        AccessibilityNodeProvider accessibilityNodeProvider;
        if (Build.VERSION.SDK_INT < 16 || (accessibilityNodeProvider = f171b.getAccessibilityNodeProvider(view)) == null) {
            return null;
        }
        return new a.f.l.a0.d(accessibilityNodeProvider);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View.AccessibilityDelegate c() {
        return this.f172a;
    }

    public void d(View view, AccessibilityEvent accessibilityEvent) {
        f171b.onInitializeAccessibilityEvent(view, accessibilityEvent);
    }

    public void e(View view, a.f.l.a0.c cVar) {
        f171b.onInitializeAccessibilityNodeInfo(view, cVar.B());
    }

    public void f(View view, AccessibilityEvent accessibilityEvent) {
        f171b.onPopulateAccessibilityEvent(view, accessibilityEvent);
    }

    public boolean g(ViewGroup viewGroup, View view, AccessibilityEvent accessibilityEvent) {
        return f171b.onRequestSendAccessibilityEvent(viewGroup, view, accessibilityEvent);
    }

    public boolean h(View view, int i, Bundle bundle) {
        if (Build.VERSION.SDK_INT >= 16) {
            return f171b.performAccessibilityAction(view, i, bundle);
        }
        return false;
    }

    public void i(View view, int i) {
        f171b.sendAccessibilityEvent(view, i);
    }

    public void j(View view, AccessibilityEvent accessibilityEvent) {
        f171b.sendAccessibilityEventUnchecked(view, accessibilityEvent);
    }
}
