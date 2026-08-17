package androidx.fragment.app;

import android.content.Context;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TabHost;
import android.widget.TabWidget;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class FragmentTabHost extends TabHost implements TabHost.OnTabChangeListener {

    /* renamed from: b  reason: collision with root package name */
    private final ArrayList<b> f943b;

    /* renamed from: c  reason: collision with root package name */
    private FrameLayout f944c;

    /* renamed from: d  reason: collision with root package name */
    private Context f945d;
    private f e;
    private int f;
    private TabHost.OnTabChangeListener g;
    private b h;
    private boolean i;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class SavedState extends View.BaseSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: b  reason: collision with root package name */
        String f946b;

        /* loaded from: classes.dex */
        static class a implements Parcelable.Creator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: b */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        SavedState(Parcel parcel) {
            super(parcel);
            this.f946b = parcel.readString();
        }

        SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        public String toString() {
            return "FragmentTabHost.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " curTab=" + this.f946b + "}";
        }

        @Override // android.view.View.BaseSavedState, android.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeString(this.f946b);
        }
    }

    /* loaded from: classes.dex */
    static class a implements TabHost.TabContentFactory {

        /* renamed from: a  reason: collision with root package name */
        private final Context f947a;

        public a(Context context) {
            this.f947a = context;
        }

        @Override // android.widget.TabHost.TabContentFactory
        public View createTabContent(String str) {
            View view = new View(this.f947a);
            view.setMinimumWidth(0);
            view.setMinimumHeight(0);
            return view;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static final class b {

        /* renamed from: a  reason: collision with root package name */
        final String f948a;

        /* renamed from: b  reason: collision with root package name */
        final Class<?> f949b;

        /* renamed from: c  reason: collision with root package name */
        final Bundle f950c;

        /* renamed from: d  reason: collision with root package name */
        Fragment f951d;

        b(String str, Class<?> cls, Bundle bundle) {
            this.f948a = str;
            this.f949b = cls;
            this.f950c = bundle;
        }
    }

    public FragmentTabHost(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f943b = new ArrayList<>();
        f(context, attributeSet);
    }

    private j b(String str, j jVar) {
        Fragment fragment;
        b e = e(str);
        if (this.h != e) {
            if (jVar == null) {
                jVar = this.e.a();
            }
            b bVar = this.h;
            if (bVar != null && (fragment = bVar.f951d) != null) {
                jVar.g(fragment);
            }
            if (e != null) {
                Fragment fragment2 = e.f951d;
                if (fragment2 == null) {
                    Fragment H = Fragment.H(this.f945d, e.f949b.getName(), e.f950c);
                    e.f951d = H;
                    jVar.b(this.f, H, e.f948a);
                } else {
                    jVar.d(fragment2);
                }
            }
            this.h = e;
        }
        return jVar;
    }

    private void c() {
        if (this.f944c == null) {
            FrameLayout frameLayout = (FrameLayout) findViewById(this.f);
            this.f944c = frameLayout;
            if (frameLayout != null) {
                return;
            }
            throw new IllegalStateException("No tab content FrameLayout found for id " + this.f);
        }
    }

    private void d(Context context) {
        if (findViewById(16908307) == null) {
            LinearLayout linearLayout = new LinearLayout(context);
            linearLayout.setOrientation(1);
            addView(linearLayout, new FrameLayout.LayoutParams(-1, -1));
            TabWidget tabWidget = new TabWidget(context);
            tabWidget.setId(16908307);
            tabWidget.setOrientation(0);
            linearLayout.addView(tabWidget, new LinearLayout.LayoutParams(-1, -2, 0.0f));
            FrameLayout frameLayout = new FrameLayout(context);
            frameLayout.setId(16908305);
            linearLayout.addView(frameLayout, new LinearLayout.LayoutParams(0, 0, 0.0f));
            FrameLayout frameLayout2 = new FrameLayout(context);
            this.f944c = frameLayout2;
            frameLayout2.setId(this.f);
            linearLayout.addView(frameLayout2, new LinearLayout.LayoutParams(-1, 0, 1.0f));
        }
    }

    private b e(String str) {
        int size = this.f943b.size();
        for (int i = 0; i < size; i++) {
            b bVar = this.f943b.get(i);
            if (bVar.f948a.equals(str)) {
                return bVar;
            }
        }
        return null;
    }

    private void f(Context context, AttributeSet attributeSet) {
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, new int[]{16842995}, 0, 0);
        this.f = obtainStyledAttributes.getResourceId(0, 0);
        obtainStyledAttributes.recycle();
        super.setOnTabChangedListener(this);
    }

    public void a(TabHost.TabSpec tabSpec, Class<?> cls, Bundle bundle) {
        tabSpec.setContent(new a(this.f945d));
        String tag = tabSpec.getTag();
        b bVar = new b(tag, cls, bundle);
        if (this.i) {
            Fragment d2 = this.e.d(tag);
            bVar.f951d = d2;
            if (d2 != null && !d2.K()) {
                j a2 = this.e.a();
                a2.g(bVar.f951d);
                a2.e();
            }
        }
        this.f943b.add(bVar);
        addTab(tabSpec);
    }

    public void g(Context context, f fVar, int i) {
        d(context);
        super.setup();
        this.f945d = context;
        this.e = fVar;
        this.f = i;
        c();
        this.f944c.setId(i);
        if (getId() == -1) {
            setId(16908306);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        String currentTabTag = getCurrentTabTag();
        int size = this.f943b.size();
        j jVar = null;
        for (int i = 0; i < size; i++) {
            b bVar = this.f943b.get(i);
            Fragment d2 = this.e.d(bVar.f948a);
            bVar.f951d = d2;
            if (d2 != null && !d2.K()) {
                if (bVar.f948a.equals(currentTabTag)) {
                    this.h = bVar;
                } else {
                    if (jVar == null) {
                        jVar = this.e.a();
                    }
                    jVar.g(bVar.f951d);
                }
            }
        }
        this.i = true;
        j b2 = b(currentTabTag, jVar);
        if (b2 != null) {
            b2.e();
            this.e.c();
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        this.i = false;
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        if (!(parcelable instanceof SavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.getSuperState());
        setCurrentTabByTag(savedState.f946b);
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.f946b = getCurrentTabTag();
        return savedState;
    }

    @Override // android.widget.TabHost.OnTabChangeListener
    public void onTabChanged(String str) {
        j b2;
        if (this.i && (b2 = b(str, null)) != null) {
            b2.e();
        }
        TabHost.OnTabChangeListener onTabChangeListener = this.g;
        if (onTabChangeListener != null) {
            onTabChangeListener.onTabChanged(str);
        }
    }

    @Override // android.widget.TabHost
    public void setOnTabChangedListener(TabHost.OnTabChangeListener onTabChangeListener) {
        this.g = onTabChangeListener;
    }

    @Override // android.widget.TabHost
    @Deprecated
    public void setup() {
        throw new IllegalStateException("Must call setup() that takes a Context and FragmentManager");
    }
}
