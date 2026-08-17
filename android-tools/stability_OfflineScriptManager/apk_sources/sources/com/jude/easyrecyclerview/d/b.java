package com.jude.easyrecyclerview.d;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import com.jude.easyrecyclerview.d.d;
/* loaded from: classes.dex */
public class b implements c {

    /* renamed from: a  reason: collision with root package name */
    private a f2467a;

    /* renamed from: b  reason: collision with root package name */
    private d.f f2468b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f2469c = false;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2470d = false;
    private boolean e = false;
    private int f = 291;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class a implements d.c {

        /* renamed from: a  reason: collision with root package name */
        private FrameLayout f2471a;

        /* renamed from: b  reason: collision with root package name */
        private View f2472b;

        /* renamed from: c  reason: collision with root package name */
        private View f2473c;

        /* renamed from: d  reason: collision with root package name */
        private View f2474d;
        private int e = 0;

        public a(Context context) {
            FrameLayout frameLayout = new FrameLayout(context);
            this.f2471a = frameLayout;
            frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
        }

        private void j(View view) {
            if (view == null) {
                this.f2471a.setVisibility(8);
                return;
            }
            if (this.f2471a.getVisibility() != 0) {
                this.f2471a.setVisibility(0);
            }
            if (view.getParent() == null) {
                this.f2471a.addView(view);
            }
            for (int i = 0; i < this.f2471a.getChildCount(); i++) {
                if (this.f2471a.getChildAt(i) == view) {
                    view.setVisibility(0);
                } else {
                    this.f2471a.getChildAt(i).setVisibility(8);
                }
            }
        }

        @Override // com.jude.easyrecyclerview.d.d.c
        public View a(ViewGroup viewGroup) {
            Log.i("recycler", "onCreateView");
            return this.f2471a;
        }

        @Override // com.jude.easyrecyclerview.d.d.c
        public void b(View view) {
            Log.i("recycler", "onBindView");
            int i = this.e;
            if (i == 1) {
                b.this.h();
            } else if (i != 2) {
            } else {
                b.this.g();
            }
        }

        public void c() {
            this.e = 0;
            this.f2471a.setVisibility(8);
        }

        public void d(View view) {
            this.f2474d = view;
        }

        public void e(View view) {
            this.f2472b = view;
        }

        public void f(View view) {
            this.f2473c = view;
        }

        public void g() {
            j(this.f2474d);
            this.e = 2;
        }

        public void h() {
            j(this.f2472b);
            this.e = 1;
        }

        public void i() {
            j(this.f2473c);
            this.e = 3;
        }
    }

    public b(d dVar) {
        a aVar = new a(dVar.E());
        this.f2467a = aVar;
        dVar.B(aVar);
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void a(int i) {
        int i2;
        Log.i("recycler", "addData" + i);
        boolean z = this.f2470d;
        if (z) {
            if (i == 0) {
                int i3 = this.f;
                if (i3 == 291 || i3 == 260) {
                    this.f2467a.i();
                }
            } else if (z && ((i2 = this.f) == 291 || i2 == 732)) {
                this.f2467a.h();
            }
        } else if (this.e) {
            this.f2467a.i();
            this.f = 408;
        }
        this.f2469c = false;
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void b(View view) {
        this.f2467a.f(view);
        this.e = true;
        Log.i("recycler", "setNoMore");
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void c(View view) {
        this.f2467a.d(view);
        Log.i("recycler", "setErrorMore");
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void clear() {
        Log.i("recycler", "clear");
        this.f = 291;
        this.f2467a.c();
        this.f2469c = false;
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void d() {
        this.f2469c = false;
        this.f2467a.h();
        h();
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void e() {
        Log.i("recycler", "pauseLoadMore");
        this.f2467a.g();
        this.f = 732;
        this.f2469c = false;
    }

    @Override // com.jude.easyrecyclerview.d.c
    public void f(View view, d.f fVar) {
        this.f2467a.e(view);
        this.f2468b = fVar;
        this.f2470d = true;
        Log.i("recycler", "setMore");
    }

    public void g() {
        d();
    }

    public void h() {
        d.f fVar;
        Log.i("recycler", "onMoreViewShowed");
        if (this.f2469c || (fVar = this.f2468b) == null) {
            return;
        }
        this.f2469c = true;
        fVar.a();
    }
}
