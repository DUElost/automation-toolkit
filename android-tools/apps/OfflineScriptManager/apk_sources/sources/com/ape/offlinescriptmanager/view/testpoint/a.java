package com.ape.offlinescriptmanager.view.testpoint;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.EditText;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.j;
import androidx.recyclerview.widget.LinearLayoutManager;
import b.a.a.f;
import b.a.a.p;
import b.b.a.a.d.h;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jude.easyrecyclerview.EasyRecyclerView;
import com.jude.easyrecyclerview.d.d;
import java.io.File;
import java.util.ArrayList;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends Fragment {
    EasyRecyclerView Z;
    com.ape.offlinescriptmanager.view.testpoint.c a0;
    Handler b0;
    b.b.a.a.d.f c0;
    String d0;
    ArrayList<h> e0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.testpoint.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0093a implements View.OnClickListener {
        View$OnClickListenerC0093a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            a.this.o1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {
        b() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            a.this.a0.O();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements d.InterfaceC0100d {
        c() {
        }

        @Override // com.jude.easyrecyclerview.d.d.InterfaceC0100d
        public void a(int i) {
            com.ape.offlinescriptmanager.view.testcase.b p1 = com.ape.offlinescriptmanager.view.testcase.b.p1();
            Bundle bundle = new Bundle();
            bundle.putSerializable("TEST_POINT", a.this.e0.get(i));
            p1.Z0(bundle);
            j a2 = a.this.s().a();
            a2.c(null);
            a2.h(R.id.task_detail_container, p1);
            a2.e();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements d.e {
        d() {
        }

        @Override // com.jude.easyrecyclerview.d.d.e
        public boolean a(int i) {
            a.this.u1(i);
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements a.l.a.a {
        e() {
        }

        @Override // a.l.a.a
        public void a() {
            a.this.o1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements Runnable {
        f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            a.this.a0.C();
            a aVar = a.this;
            aVar.a0.A(aVar.c0.i());
            a.this.a0.g();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g extends f.e {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ h f2211a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2212b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ EditText f2213c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ CheckBox f2214d;
        final /* synthetic */ int e;

        g(h hVar, EditText editText, EditText editText2, CheckBox checkBox, int i) {
            this.f2211a = hVar;
            this.f2212b = editText;
            this.f2213c = editText2;
            this.f2214d = checkBox;
            this.e = i;
        }

        @Override // b.a.a.f.e
        public void b(b.a.a.f fVar) {
            super.b(fVar);
        }

        @Override // b.a.a.f.e
        public void d(b.a.a.f fVar) {
            super.d(fVar);
            this.f2211a.p(this.f2212b.getText().toString());
            this.f2211a.q(Integer.valueOf(this.f2213c.getText().toString()).intValue());
            this.f2211a.o(this.f2214d.isChecked());
            a.this.e0.add(this.e, this.f2211a);
            a.this.e0.remove(this.e + 1);
            a aVar = a.this;
            aVar.c0.t(aVar.e0);
            a aVar2 = a.this;
            aVar2.s1(aVar2.c0);
        }
    }

    public static a n1() {
        return new a();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void o1() {
        if (this.a0.F() == 0) {
            this.Z.k();
            Log.v("TestCaseFragment", "mPageAdapter.getCount()==0");
        }
        b.b.a.a.d.f fVar = this.c0;
        if (fVar == null) {
            return;
        }
        ArrayList<h> i = fVar.i();
        this.e0 = i;
        if (i != null) {
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

    private void r1(View view) {
        FloatingActionButton floatingActionButton = (FloatingActionButton) view.findViewById(R.id.fab);
        EasyRecyclerView easyRecyclerView = (EasyRecyclerView) view.findViewById(R.id.recyclerview);
        this.Z = easyRecyclerView;
        easyRecyclerView.h(R.color.colorPrimary, R.color.colorPrimary, R.color.colorPrimaryDark, R.color.accent);
        this.Z.setLayoutManager(new LinearLayoutManager(n(), 1, false));
        this.Z.setProgressView(R.layout.layout_loading);
        View inflate = LayoutInflater.from(n()).inflate(R.layout.layout_loading_error, (ViewGroup) this.Z, false);
        inflate.findViewById(R.id.loading_error_btn_retry).setOnClickListener(new View$OnClickListenerC0093a());
        this.Z.setErrorView(inflate);
        com.ape.offlinescriptmanager.view.testpoint.c cVar = new com.ape.offlinescriptmanager.view.testpoint.c(n());
        this.a0 = cVar;
        this.Z.setAdapterWithProgress(cVar);
        this.a0.P(R.layout.layout_load_error).setOnClickListener(new b());
        this.a0.S(new c());
        this.a0.T(new d());
        this.Z.setRefreshListener(new e());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void s1(b.b.a.a.d.f fVar) {
        new com.ape.offlinescriptmanager.utils.m.g(fVar).k();
    }

    private b.a.a.f t1(String str, View view, f.e eVar) {
        f.d dVar = new f.d(n());
        dVar.d(view, true);
        dVar.j(R.string.edit_dialog_positive);
        dVar.f(R.string.edit_dialog_negative);
        dVar.b(eVar);
        dVar.l(p.LIGHT);
        return dVar.a();
    }

    @Override // androidx.fragment.app.Fragment
    public void V(Context context) {
        super.V(context);
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.fragment_testpoint, viewGroup, false);
        if (l() != null) {
            String string = l().getString("TASK");
            this.d0 = string;
            this.c0 = p1(string);
        }
        r1(inflate);
        q1(this.c0);
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        super.d0();
    }

    public b.b.a.a.d.f p1(String str) {
        File file = new File(str);
        if (file.exists()) {
            return b.b.a.b.b.b.d().e(file);
        }
        return null;
    }

    public void q1(b.b.a.a.d.f fVar) {
        this.c0 = fVar;
        this.b0 = new Handler(Looper.getMainLooper());
        o1();
    }

    public void u1(int i) {
        h hVar = this.e0.get(i);
        View inflate = LayoutInflater.from(n()).inflate(R.layout.dialog_task_edit, (ViewGroup) null);
        CheckBox checkBox = (CheckBox) inflate.findViewById(R.id.dialog_task_edit_selecter);
        EditText editText = (EditText) inflate.findViewById(R.id.dialog_task_edit_name_et);
        EditText editText2 = (EditText) inflate.findViewById(R.id.dialog_task_edit_times_et);
        if (hVar.m() != null) {
            editText.setText(hVar.m());
        }
        checkBox.setChecked(hVar.j());
        editText2.setText(String.valueOf(hVar.a()));
        t1(n().getString(R.string.edit_testpoint), inflate, new g(hVar, editText, editText2, checkBox, i)).show();
    }
}
