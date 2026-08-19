package com.ape.offlinescriptmanager.view.b;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jude.easyrecyclerview.EasyRecyclerView;
import com.jude.easyrecyclerview.d.d;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends Fragment {
    EasyRecyclerView Z;
    com.ape.offlinescriptmanager.view.b.c a0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.b.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0084a implements View.OnClickListener {
        View$OnClickListenerC0084a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            a.this.n1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements d.f {
        b() {
        }

        @Override // com.jude.easyrecyclerview.d.d.f
        public void a() {
            a.this.n1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements View.OnClickListener {
        c() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            a.this.a0.O();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements d.InterfaceC0100d {
        d(a aVar) {
        }

        @Override // com.jude.easyrecyclerview.d.d.InterfaceC0100d
        public void a(int i) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements a.l.a.a {
        e() {
        }

        @Override // a.l.a.a
        public void a() {
            a.this.n1();
        }
    }

    public static a m1() {
        return new a();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void n1() {
    }

    private void o1() {
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
        inflate.findViewById(R.id.loading_error_btn_retry).setOnClickListener(new View$OnClickListenerC0084a());
        this.Z.setErrorView(inflate);
        this.Z.b(new androidx.recyclerview.widget.d(n(), 1));
        com.ape.offlinescriptmanager.view.b.c cVar = new com.ape.offlinescriptmanager.view.b.c(n());
        this.a0 = cVar;
        this.Z.setAdapterWithProgress(cVar);
        this.a0.Q(R.layout.layout_load_more, new b());
        this.a0.R(R.layout.layout_no_more);
        this.a0.P(R.layout.layout_load_error).setOnClickListener(new c());
        this.a0.S(new d(this));
        this.Z.setRefreshListener(new e());
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        p1(layoutInflater.inflate(R.layout.fragment_task, viewGroup, false));
        o1();
        return super.c0(layoutInflater, viewGroup, bundle);
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        super.d0();
    }
}
