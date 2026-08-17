package com.ape.offlinescriptmanager.view.testcase;

import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import b.a.a.f;
import b.a.a.p;
import b.b.a.a.d.j;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jude.easyrecyclerview.EasyRecyclerView;
import com.jude.easyrecyclerview.d.d;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends Fragment {
    EasyRecyclerView Z;
    com.ape.offlinescriptmanager.view.testcase.d a0;
    Handler b0;
    b.b.a.a.d.h c0;
    List<b.b.a.a.d.c> d0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.this.r1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.testcase.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0092b implements View.OnClickListener {
        View$OnClickListenerC0092b() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.this.a0.O();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements d.InterfaceC0100d {
        c() {
        }

        @Override // com.jude.easyrecyclerview.d.d.InterfaceC0100d
        public void a(int i) {
            TestCaseEditActivity.a0(b.this.n(), (b.b.a.a.d.g) b.this.d0.get(i));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements d.e {
        d() {
        }

        @Override // com.jude.easyrecyclerview.d.d.e
        public boolean a(int i) {
            b.this.y1(i);
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
            b.this.r1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements Runnable {
        f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.a0.C();
            b bVar = b.this;
            bVar.a0.A(bVar.c0.n());
            b.this.a0.g();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g implements AdapterView.OnItemSelectedListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayAdapter f2196b;

        g(ArrayAdapter arrayAdapter) {
            this.f2196b = arrayAdapter;
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
            this.f2196b.clear();
            this.f2196b.addAll(b.this.s1((String) ((Spinner) adapterView).getItemAtPosition(i)));
            this.f2196b.notifyDataSetChanged();
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h implements AdapterView.OnItemSelectedListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Spinner f2198b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ ArrayAdapter f2199c;

        h(Spinner spinner, ArrayAdapter arrayAdapter) {
            this.f2198b = spinner;
            this.f2199c = arrayAdapter;
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
            String str = (String) this.f2198b.getSelectedItem();
            this.f2199c.clear();
            this.f2199c.addAll(b.this.u1(str, (String) ((Spinner) adapterView).getItemAtPosition(i)));
            this.f2199c.notifyDataSetChanged();
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class i extends f.e {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Spinner f2201a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2202b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ CheckBox f2203c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ Spinner f2204d;
        final /* synthetic */ Spinner e;
        final /* synthetic */ Spinner f;
        final /* synthetic */ EditText g;
        final /* synthetic */ int h;

        i(Spinner spinner, EditText editText, CheckBox checkBox, Spinner spinner2, Spinner spinner3, Spinner spinner4, EditText editText2, int i) {
            this.f2201a = spinner;
            this.f2202b = editText;
            this.f2203c = checkBox;
            this.f2204d = spinner2;
            this.e = spinner3;
            this.f = spinner4;
            this.g = editText2;
            this.h = i;
        }

        @Override // b.a.a.f.e
        public void b(b.a.a.f fVar) {
            super.b(fVar);
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // b.a.a.f.e
        public void d(b.a.a.f fVar) {
            b.b.a.a.d.e eVar;
            b.b.a.a.d.e eVar2;
            b.b.a.a.d.i iVar;
            super.d(fVar);
            String obj = this.f2201a.getSelectedItem().toString();
            String obj2 = this.f2202b.getText().toString();
            boolean isChecked = this.f2203c.isChecked();
            String obj3 = this.f2204d.getSelectedItem().toString();
            String obj4 = this.e.getSelectedItem().toString();
            String obj5 = this.f.getSelectedItem().toString();
            String obj6 = this.g.getText().toString();
            if (obj.equals("uiautomator2")) {
                iVar = new b.b.a.a.d.i();
            } else if (obj.equals("uiautomator")) {
                j jVar = new j();
                jVar.m(Integer.valueOf(obj2).intValue());
                jVar.l(isChecked);
                jVar.p(obj3);
                jVar.o(obj4);
                jVar.q(obj5);
                eVar2 = jVar;
                eVar2.g(obj6);
                eVar = eVar2;
                b.this.d0.add(this.h, eVar);
                b.this.d0.remove(this.h + 1);
                b.this.d0.size();
            } else if (!obj.equals("robotium")) {
                eVar = null;
                b.this.d0.add(this.h, eVar);
                b.this.d0.remove(this.h + 1);
                b.this.d0.size();
            } else {
                iVar = new b.b.a.a.d.e();
            }
            iVar.m(Integer.valueOf(obj2).intValue());
            iVar.l(isChecked);
            iVar.p(obj3);
            iVar.r(b.this.t1(obj3).e);
            iVar.q(obj4);
            iVar.s(obj5);
            eVar2 = iVar;
            eVar2.g(obj6);
            eVar = eVar2;
            b.this.d0.add(this.h, eVar);
            b.this.d0.remove(this.h + 1);
            b.this.d0.size();
        }
    }

    public static b p1() {
        return new b();
    }

    private String[] q1() {
        ArrayList arrayList = new ArrayList();
        List<b.b.a.a.a.a> e2 = b.b.a.b.b.a.d().e();
        if (e2 != null) {
            for (b.b.a.a.a.a aVar : e2) {
                String str = aVar.f1340c;
                if (str != null && str.endsWith(".apk")) {
                    arrayList.add(aVar.f1340c);
                }
            }
        }
        return (String[]) arrayList.toArray(new String[arrayList.size()]);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void r1() {
        if (this.a0.F() == 0) {
            this.Z.k();
            Log.v("TestCaseFragment", "mPageAdapter.getCount()==0");
        }
        b.b.a.a.d.h hVar = this.c0;
        if (hVar == null) {
            Log.v("TestCaseFragment", "test point is null");
            return;
        }
        List<b.b.a.a.d.c> n = hVar.n();
        this.d0 = n;
        if (n != null) {
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

    /* JADX INFO: Access modifiers changed from: private */
    public List<String> s1(String str) {
        b.b.a.a.a.a t1 = t1(str);
        if (t1 == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        HashMap hashMap = new HashMap();
        for (b.b.a.a.a.b bVar : t1.g) {
            if (!hashMap.containsKey(bVar.a())) {
                hashMap.put(bVar.a(), bVar.a());
                arrayList.add(bVar.a());
            }
        }
        return arrayList;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public b.b.a.a.a.a t1(String str) {
        List<b.b.a.a.a.a> e2 = b.b.a.b.b.a.d().e();
        if (e2 != null) {
            for (b.b.a.a.a.a aVar : e2) {
                if (aVar.f1340c.equalsIgnoreCase(str)) {
                    return aVar;
                }
            }
            return null;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public List<String> u1(String str, String str2) {
        b.b.a.a.a.a t1 = t1(str);
        ArrayList arrayList = new ArrayList();
        if (t1 == null) {
            return null;
        }
        for (b.b.a.a.a.b bVar : t1.g) {
            if (bVar.a().equalsIgnoreCase(str2)) {
                arrayList.add(bVar.b());
            }
        }
        return arrayList;
    }

    private void w1(View view) {
        FloatingActionButton floatingActionButton = (FloatingActionButton) view.findViewById(R.id.fab);
        EasyRecyclerView easyRecyclerView = (EasyRecyclerView) view.findViewById(R.id.recyclerview);
        this.Z = easyRecyclerView;
        easyRecyclerView.h(R.color.colorPrimary, R.color.colorPrimary, R.color.colorPrimaryDark, R.color.accent);
        this.Z.setLayoutManager(new LinearLayoutManager(n(), 1, false));
        this.Z.setProgressView(R.layout.layout_loading);
        View inflate = LayoutInflater.from(n()).inflate(R.layout.layout_loading_error, (ViewGroup) this.Z, false);
        inflate.findViewById(R.id.loading_error_btn_retry).setOnClickListener(new a());
        this.Z.setErrorView(inflate);
        com.ape.offlinescriptmanager.view.testcase.d dVar = new com.ape.offlinescriptmanager.view.testcase.d(n());
        this.a0 = dVar;
        this.Z.setAdapterWithProgress(dVar);
        this.a0.P(R.layout.layout_load_error).setOnClickListener(new View$OnClickListenerC0092b());
        this.a0.S(new c());
        this.a0.T(new d());
        this.Z.setRefreshListener(new e());
    }

    private b.a.a.f x1(String str, View view, f.e eVar) {
        f.d dVar = new f.d(n());
        dVar.d(view, true);
        dVar.j(R.string.edit_dialog_positive);
        dVar.f(R.string.edit_dialog_negative);
        dVar.b(eVar);
        dVar.l(p.LIGHT);
        return dVar.a();
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.fragment_task, viewGroup, false);
        if (l() != null) {
            this.c0 = (b.b.a.a.d.h) l().getSerializable("TEST_POINT");
        }
        w1(inflate);
        v1(this.c0);
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        super.d0();
    }

    public void v1(b.b.a.a.d.h hVar) {
        this.b0 = new Handler(Looper.getMainLooper());
        this.c0 = hVar;
        r1();
    }

    public void y1(int i2) {
        b.b.a.a.d.c cVar = this.d0.get(i2);
        View inflate = LayoutInflater.from(n()).inflate(R.layout.dialog_testcase_edit, (ViewGroup) null);
        Spinner spinner = (Spinner) inflate.findViewById(R.id.dialog_case_edit_type_sp);
        EditText editText = (EditText) inflate.findViewById(R.id.dialog_case_edit_times_et);
        CheckBox checkBox = (CheckBox) inflate.findViewById(R.id.dialog_case_edit_selecter);
        Spinner spinner2 = (Spinner) inflate.findViewById(R.id.dialog_case_edit_apk_sp);
        Spinner spinner3 = (Spinner) inflate.findViewById(R.id.dialog_case_edit_class_sp);
        Spinner spinner4 = (Spinner) inflate.findViewById(R.id.dialog_case_edit_method_sp);
        EditText editText2 = (EditText) inflate.findViewById(R.id.dialog_case_edit_desc_et);
        spinner.setAdapter((SpinnerAdapter) new ArrayAdapter(n(), (int) R.layout.spinner_item, new String[]{"uiautomator2", "uiautomator", "robotium"}));
        ArrayAdapter arrayAdapter = new ArrayAdapter(n(), (int) R.layout.spinner_item, q1());
        spinner2.setAdapter((SpinnerAdapter) arrayAdapter);
        ArrayAdapter arrayAdapter2 = new ArrayAdapter(n(), R.layout.spinner_item);
        spinner3.setAdapter((SpinnerAdapter) arrayAdapter2);
        ArrayAdapter arrayAdapter3 = new ArrayAdapter(n(), R.layout.spinner_item);
        spinner4.setAdapter((SpinnerAdapter) arrayAdapter3);
        spinner2.setOnItemSelectedListener(new g(arrayAdapter2));
        spinner3.setOnItemSelectedListener(new h(spinner2, arrayAdapter3));
        if (cVar.h() != null) {
            spinner2.setSelection(arrayAdapter.getPosition(cVar.h()));
            if (cVar.k() != null) {
                arrayAdapter2.clear();
                arrayAdapter2.addAll(s1(cVar.h()));
                spinner3.setSelection(arrayAdapter2.getPosition(cVar.k()));
                if (cVar.b() != null) {
                    arrayAdapter3.clear();
                    arrayAdapter3.addAll(u1(cVar.h(), cVar.k()));
                    spinner4.setSelection(arrayAdapter3.getPosition(cVar.b()));
                }
            }
        }
        editText.setText(String.valueOf(cVar.a()));
        checkBox.setChecked(cVar.j());
        if (cVar.i() != null) {
            editText2.setText(cVar.i());
        }
        x1(n().getString(R.string.edit_testcase), inflate, new i(spinner, editText, checkBox, spinner2, spinner3, spinner4, editText2, i2)).show();
    }
}
