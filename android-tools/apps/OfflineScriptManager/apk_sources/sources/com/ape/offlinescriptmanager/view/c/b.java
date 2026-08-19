package com.ape.offlinescriptmanager.view.c;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import com.ape.offlinescriptmanager.view.testpoint.TaskDetailActivity;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jude.easyrecyclerview.EasyRecyclerView;
import com.jude.easyrecyclerview.d.d;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends Fragment {
    EasyRecyclerView Z;
    com.ape.offlinescriptmanager.view.c.d a0;
    Handler b0;
    List<b.b.a.a.d.f> c0;
    b.b.a.b.a d0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.this.n1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.c.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0086b implements View.OnClickListener {
        View$OnClickListenerC0086b() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.this.a0.O();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements a.l.a.a {
        c() {
        }

        @Override // a.l.a.a
        public void a() {
            b.this.n1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements d.InterfaceC0100d {
        d() {
        }

        @Override // com.jude.easyrecyclerview.d.d.InterfaceC0100d
        public void a(int i) {
            TaskDetailActivity.M(b.this.n(), b.this.c0.get(i).e());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements d.e {
        e() {
        }

        @Override // com.jude.easyrecyclerview.d.d.e
        public boolean a(int i) {
            new com.ape.offlinescriptmanager.view.a.a(b.this.n(), b.this.c0.get(i)).e();
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements Runnable {
        f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            List<b.b.a.a.d.f> f = b.b.a.b.b.b.d().f();
            b.this.a0.C();
            b.this.a0.A(f);
            b.this.a0.g();
        }
    }

    public static b m1() {
        return new b();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void n1() {
        if (this.a0.F() == 0) {
            this.Z.k();
            Log.v("TaskFragment", "mPageAdapter.getCount()==0");
        }
        if (b.b.a.b.b.b.d().f().size() == 0) {
            Log.v("TaskFragment", "load task xml file start");
            if (!b.b.a.b.b.b.d().b()) {
                Log.v("TaskFragment", "load task xml file fail");
            }
        }
        Log.v("TaskFragment", "load task xml file end");
        List<b.b.a.a.d.f> f2 = b.b.a.b.b.b.d().f();
        this.c0 = f2;
        if (f2 != null) {
            if (f() == null || f().isFinishing()) {
                return;
            }
            this.Z.l();
            this.b0.postDelayed(new f(), 500L);
        } else if (f() == null || f().isFinishing()) {
        } else {
            this.Z.setRefreshing(false);
            this.a0.M();
            if (this.a0.F() == 0) {
                this.Z.j();
            }
        }
    }

    private void o1() {
        this.b0 = new Handler(Looper.getMainLooper());
        n1();
    }

    private void p1(View view) {
        FloatingActionButton floatingActionButton = (FloatingActionButton) view.findViewById(R.id.fab);
        EasyRecyclerView easyRecyclerView = (EasyRecyclerView) view.findViewById(R.id.recyclerview);
        this.Z = easyRecyclerView;
        easyRecyclerView.h(R.color.colorPrimary, R.color.colorPrimary, R.color.colorPrimaryDark, R.color.accent);
        this.Z.setLayoutManager(new LinearLayoutManager(n(), 1, false));
        this.Z.setProgressView(R.layout.layout_loading);
        View inflate = LayoutInflater.from(n()).inflate(R.layout.layout_loading_error, (ViewGroup) this.Z, false);
        inflate.findViewById(R.id.loading_error_btn_retry).setOnClickListener(new a());
        this.Z.setErrorView(inflate);
        com.ape.offlinescriptmanager.view.c.d dVar = new com.ape.offlinescriptmanager.view.c.d(n());
        this.a0 = dVar;
        this.Z.setAdapterWithProgress(dVar);
        this.a0.P(R.layout.layout_load_error).setOnClickListener(new View$OnClickListenerC0086b());
        this.Z.setRefreshListener(new c());
        this.a0.S(new d());
        this.a0.T(new e());
    }

    @Override // androidx.fragment.app.Fragment
    public void V(Context context) {
        super.V(context);
        try {
            this.d0 = (b.b.a.b.a) context;
        } catch (ClassCastException unused) {
            throw new ClassCastException(context.toString() + " must implement OnHeadlineSelectedListener");
        }
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.fragment_task, viewGroup, false);
        p1(inflate);
        o1();
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        super.d0();
    }
}
