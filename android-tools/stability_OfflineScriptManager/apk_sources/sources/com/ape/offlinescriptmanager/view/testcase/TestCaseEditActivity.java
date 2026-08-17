package com.ape.offlinescriptmanager.view.testcase;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import b.b.a.a.d.i;
import b.b.a.a.d.j;
import com.ape.offlinescriptmanager.view.testcase.a;
import com.jude.easyrecyclerview.EasyRecyclerView;
import com.jude.easyrecyclerview.d.d;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class TestCaseEditActivity extends androidx.appcompat.app.c implements Toolbar.f, a.InterfaceC0089a {
    private EasyRecyclerView A;
    private com.ape.offlinescriptmanager.view.testcase.a B;
    Handler C;
    private b.b.a.a.d.g q;
    private Toolbar r;
    private Spinner s;
    private EditText t;
    private CheckBox u;
    private Spinner v;
    private Spinner w;
    private Spinner x;
    private EditText y;
    private ImageButton z;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.b.a.a.d.b bVar = new b.b.a.a.d.b(BuildConfig.FLAVOR, BuildConfig.FLAVOR);
            TestCaseEditActivity.this.q.e().add(bVar);
            TestCaseEditActivity.this.B.z(bVar);
            TestCaseEditActivity.this.B.g();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements AdapterView.OnItemSelectedListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayAdapter f2179b;

        b(ArrayAdapter arrayAdapter) {
            this.f2179b = arrayAdapter;
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
            this.f2179b.clear();
            this.f2179b.addAll(TestCaseEditActivity.this.T((String) ((Spinner) adapterView).getItemAtPosition(i)));
            this.f2179b.notifyDataSetChanged();
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements AdapterView.OnItemSelectedListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayAdapter f2181b;

        c(ArrayAdapter arrayAdapter) {
            this.f2181b = arrayAdapter;
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
            String str = (String) TestCaseEditActivity.this.v.getSelectedItem();
            this.f2181b.clear();
            this.f2181b.addAll(TestCaseEditActivity.this.V(str, (String) ((Spinner) adapterView).getItemAtPosition(i)));
            this.f2181b.notifyDataSetChanged();
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements View.OnClickListener {
        d() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            TestCaseEditActivity.this.S();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements View.OnClickListener {
        e() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            TestCaseEditActivity.this.B.O();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements d.InterfaceC0100d {
        f(TestCaseEditActivity testCaseEditActivity) {
        }

        @Override // com.jude.easyrecyclerview.d.d.InterfaceC0100d
        public void a(int i) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g implements a.l.a.a {
        g() {
        }

        @Override // a.l.a.a
        public void a() {
            TestCaseEditActivity.this.S();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h implements Runnable {
        h() {
        }

        @Override // java.lang.Runnable
        public void run() {
            TestCaseEditActivity.this.B.C();
            TestCaseEditActivity.this.B.A(TestCaseEditActivity.this.q.e());
            TestCaseEditActivity.this.B.g();
        }
    }

    private String[] R() {
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
    public void S() {
        if (this.B.F() == 0) {
            Log.v("TestCaseEditActivity", "mAdapter.getCount()==0");
        }
        if (this.q != null) {
            if (isFinishing()) {
                return;
            }
            this.A.l();
            this.C.postDelayed(new h(), 500L);
        } else if (isFinishing()) {
        } else {
            this.A.setRefreshing(false);
            this.B.M();
            if (this.B.F() == 0) {
                this.A.j();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public List<String> T(String str) {
        b.b.a.a.a.a U = U(str);
        if (U == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        HashMap hashMap = new HashMap();
        for (b.b.a.a.a.b bVar : U.g) {
            if (!hashMap.containsKey(bVar.a())) {
                hashMap.put(bVar.a(), bVar.a());
                arrayList.add(bVar.a());
            }
        }
        return arrayList;
    }

    private b.b.a.a.a.a U(String str) {
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
    public List<String> V(String str, String str2) {
        b.b.a.a.a.a U = U(str);
        ArrayList arrayList = new ArrayList();
        if (U == null) {
            return null;
        }
        for (b.b.a.a.a.b bVar : U.g) {
            if (bVar.a().equalsIgnoreCase(str2)) {
                arrayList.add(bVar.b());
            }
        }
        return arrayList;
    }

    private void W() {
        this.C = new Handler(Looper.getMainLooper());
        this.q = (b.b.a.a.d.g) getIntent().getSerializableExtra("intent_key_test_case");
    }

    private void X() {
        EasyRecyclerView easyRecyclerView = (EasyRecyclerView) findViewById(R.id.case_edit_args_list);
        this.A = easyRecyclerView;
        easyRecyclerView.h(R.color.colorPrimary, R.color.colorPrimary, R.color.colorPrimaryDark, R.color.accent);
        this.A.setLayoutManager(new LinearLayoutManager(this, 1, false));
        this.A.setProgressView(R.layout.layout_loading);
        View inflate = LayoutInflater.from(this).inflate(R.layout.layout_loading_error, (ViewGroup) this.A, false);
        inflate.findViewById(R.id.loading_error_btn_retry).setOnClickListener(new d());
        this.A.setErrorView(inflate);
        com.ape.offlinescriptmanager.view.testcase.a aVar = new com.ape.offlinescriptmanager.view.testcase.a(this);
        this.B = aVar;
        this.A.setAdapterWithProgress(aVar);
        this.B.P(R.layout.layout_load_error).setOnClickListener(new e());
        this.B.S(new f(this));
        this.A.setRefreshListener(new g());
        S();
    }

    private void Y() {
        setContentView(R.layout.activity_testcase_edit);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        this.r = toolbar;
        I(toolbar);
        this.r.setOnMenuItemClickListener(this);
        this.s = (Spinner) findViewById(R.id.case_edit_type_sp);
        this.t = (EditText) findViewById(R.id.case_edit_times_et);
        this.u = (CheckBox) findViewById(R.id.case_edit_selecter);
        this.v = (Spinner) findViewById(R.id.case_edit_apk_sp);
        this.w = (Spinner) findViewById(R.id.case_edit_class_sp);
        this.x = (Spinner) findViewById(R.id.case_edit_method_sp);
        this.y = (EditText) findViewById(R.id.case_edit_desc_et);
        ImageButton imageButton = (ImageButton) findViewById(R.id.case_edit_arg_plus_one_btn);
        this.z = imageButton;
        imageButton.setOnClickListener(new a());
        this.s.setAdapter((SpinnerAdapter) new ArrayAdapter(this, (int) R.layout.spinner_item, new String[]{"uiautomator2", "uiautomator", "robotium"}));
        ArrayAdapter arrayAdapter = new ArrayAdapter(this, (int) R.layout.spinner_item, R());
        this.v.setAdapter((SpinnerAdapter) arrayAdapter);
        ArrayAdapter arrayAdapter2 = new ArrayAdapter(this, R.layout.spinner_item);
        this.w.setAdapter((SpinnerAdapter) arrayAdapter2);
        ArrayAdapter arrayAdapter3 = new ArrayAdapter(this, R.layout.spinner_item);
        this.x.setAdapter((SpinnerAdapter) arrayAdapter3);
        this.v.setOnItemSelectedListener(new b(arrayAdapter2));
        this.w.setOnItemSelectedListener(new c(arrayAdapter3));
        if (this.q.h() != null) {
            this.v.setSelection(arrayAdapter.getPosition(this.q.h()));
            if (this.q.k() != null) {
                arrayAdapter2.clear();
                arrayAdapter2.addAll(T(this.q.h()));
                this.w.setSelection(arrayAdapter2.getPosition(this.q.k()));
                if (this.q.b() != null) {
                    arrayAdapter3.clear();
                    arrayAdapter3.addAll(V(this.q.h(), this.q.k()));
                    this.x.setSelection(arrayAdapter3.getPosition(this.q.b()));
                }
            }
        }
        this.t.setText(String.valueOf(this.q.a()));
        this.u.setChecked(this.q.j());
        if (this.q.i() != null) {
            this.y.setText(this.q.i());
        }
        X();
    }

    /* JADX WARN: Multi-variable type inference failed */
    private void Z() {
        b.b.a.a.d.e eVar;
        i iVar;
        String obj = this.s.getSelectedItem().toString();
        String obj2 = this.t.getText().toString();
        boolean isChecked = this.u.isChecked();
        String obj3 = this.v.getSelectedItem().toString();
        String obj4 = this.w.getSelectedItem().toString();
        String obj5 = this.x.getSelectedItem().toString();
        String obj6 = this.y.getText().toString();
        if (obj.equals("uiautomator2")) {
            iVar = new i();
        } else if (obj.equals("uiautomator")) {
            j jVar = new j();
            jVar.m(Integer.valueOf(obj2).intValue());
            jVar.l(isChecked);
            jVar.p(obj3);
            jVar.o(obj4);
            jVar.q(obj5);
            eVar = jVar;
            eVar.g(obj6);
            this.q = eVar;
        } else if (!obj.equals("robotium")) {
            return;
        } else {
            iVar = new b.b.a.a.d.e();
        }
        iVar.m(Integer.valueOf(obj2).intValue());
        iVar.l(isChecked);
        iVar.p(obj3);
        iVar.r(U(obj3).e);
        iVar.q(obj4);
        iVar.s(obj5);
        eVar = iVar;
        eVar.g(obj6);
        this.q = eVar;
    }

    public static void a0(Context context, b.b.a.a.d.g gVar) {
        Intent intent = new Intent(context, TestCaseEditActivity.class);
        intent.putExtra("intent_key_test_case", gVar);
        context.startActivity(intent);
    }

    @Override // com.ape.offlinescriptmanager.view.testcase.a.InterfaceC0089a
    public void e(int i, String str, String str2) {
        List<b.b.a.a.d.b> e2 = this.q.e();
        e2.add(i, new b.b.a.a.d.b(str, str2));
        if (i < e2.size() - 1) {
            e2.remove(i + 1);
        }
        this.q.n(e2);
    }

    @Override // com.ape.offlinescriptmanager.view.testcase.a.InterfaceC0089a
    public void l(int i) {
        List<b.b.a.a.d.b> e2 = this.q.e();
        e2.remove(i);
        this.q.n(e2);
        this.B.N(i);
        this.B.g();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        W();
        Y();
    }

    @Override // androidx.appcompat.widget.Toolbar.f
    public boolean onMenuItemClick(MenuItem menuItem) {
        int itemId = menuItem.getItemId();
        if (itemId != R.id.action_cancel) {
            if (itemId != R.id.action_save) {
                return true;
            }
            Z();
            Intent intent = new Intent();
            intent.putExtra("data_return", this.q);
            setResult(-1, intent);
        }
        finish();
        return true;
    }
}
