package androidx.legacy.app;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
@Deprecated
/* loaded from: classes.dex */
public abstract class b extends androidx.viewpager.widget.a {

    /* renamed from: b  reason: collision with root package name */
    private final FragmentManager f1048b;

    /* renamed from: c  reason: collision with root package name */
    private FragmentTransaction f1049c = null;

    /* renamed from: d  reason: collision with root package name */
    private ArrayList<Fragment.SavedState> f1050d = new ArrayList<>();
    private ArrayList<Fragment> e = new ArrayList<>();
    private Fragment f = null;

    @Deprecated
    public b(FragmentManager fragmentManager) {
        this.f1048b = fragmentManager;
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public void a(ViewGroup viewGroup, int i, Object obj) {
        Fragment fragment = (Fragment) obj;
        if (this.f1049c == null) {
            this.f1049c = this.f1048b.beginTransaction();
        }
        while (this.f1050d.size() <= i) {
            this.f1050d.add(null);
        }
        this.f1050d.set(i, fragment.isAdded() ? this.f1048b.saveFragmentInstanceState(fragment) : null);
        this.e.set(i, null);
        this.f1049c.remove(fragment);
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public void b(ViewGroup viewGroup) {
        FragmentTransaction fragmentTransaction = this.f1049c;
        if (fragmentTransaction != null) {
            fragmentTransaction.commitAllowingStateLoss();
            this.f1049c = null;
            this.f1048b.executePendingTransactions();
        }
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public Object g(ViewGroup viewGroup, int i) {
        Fragment.SavedState savedState;
        Fragment fragment;
        if (this.e.size() <= i || (fragment = this.e.get(i)) == null) {
            if (this.f1049c == null) {
                this.f1049c = this.f1048b.beginTransaction();
            }
            Fragment p = p(i);
            if (this.f1050d.size() > i && (savedState = this.f1050d.get(i)) != null) {
                p.setInitialSavedState(savedState);
            }
            while (this.e.size() <= i) {
                this.e.add(null);
            }
            p.setMenuVisibility(false);
            a.b(p, false);
            this.e.set(i, p);
            this.f1049c.add(viewGroup.getId(), p);
            return p;
        }
        return fragment;
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public boolean h(View view, Object obj) {
        return ((Fragment) obj).getView() == view;
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public void j(Parcelable parcelable, ClassLoader classLoader) {
        if (parcelable != null) {
            Bundle bundle = (Bundle) parcelable;
            bundle.setClassLoader(classLoader);
            Parcelable[] parcelableArray = bundle.getParcelableArray("states");
            this.f1050d.clear();
            this.e.clear();
            if (parcelableArray != null) {
                for (Parcelable parcelable2 : parcelableArray) {
                    this.f1050d.add((Fragment.SavedState) parcelable2);
                }
            }
            for (String str : bundle.keySet()) {
                if (str.startsWith("f")) {
                    int parseInt = Integer.parseInt(str.substring(1));
                    Fragment fragment = this.f1048b.getFragment(bundle, str);
                    if (fragment != null) {
                        while (this.e.size() <= parseInt) {
                            this.e.add(null);
                        }
                        a.a(fragment, false);
                        this.e.set(parseInt, fragment);
                    } else {
                        Log.w("FragStatePagerAdapter", "Bad fragment at key " + str);
                    }
                }
            }
        }
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public Parcelable k() {
        Bundle bundle;
        if (this.f1050d.size() > 0) {
            bundle = new Bundle();
            Fragment.SavedState[] savedStateArr = new Fragment.SavedState[this.f1050d.size()];
            this.f1050d.toArray(savedStateArr);
            bundle.putParcelableArray("states", savedStateArr);
        } else {
            bundle = null;
        }
        for (int i = 0; i < this.e.size(); i++) {
            Fragment fragment = this.e.get(i);
            if (fragment != null && fragment.isAdded()) {
                if (bundle == null) {
                    bundle = new Bundle();
                }
                this.f1048b.putFragment(bundle, "f" + i, fragment);
            }
        }
        return bundle;
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public void l(ViewGroup viewGroup, int i, Object obj) {
        Fragment fragment = (Fragment) obj;
        Fragment fragment2 = this.f;
        if (fragment != fragment2) {
            if (fragment2 != null) {
                fragment2.setMenuVisibility(false);
                a.b(this.f, false);
            }
            if (fragment != null) {
                fragment.setMenuVisibility(true);
                a.b(fragment, true);
            }
            this.f = fragment;
        }
    }

    @Override // androidx.viewpager.widget.a
    @Deprecated
    public void n(ViewGroup viewGroup) {
        if (viewGroup.getId() != -1) {
            return;
        }
        throw new IllegalStateException("ViewPager with adapter " + this + " requires a view id");
    }

    @Deprecated
    public abstract Fragment p(int i);
}
