package com.leon.lfilepickerlibrary.ui;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import b.f.a.e;
import b.f.a.f;
import b.f.a.g.a;
import com.leon.lfilepickerlibrary.widget.EmptyRecyclerView;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class LFilePickerActivity extends androidx.appcompat.app.c {
    private b.f.a.i.a A;
    private b.f.a.h.a B;
    private Menu D;
    private EmptyRecyclerView q;
    private View r;
    private TextView s;
    private TextView t;
    private Button u;
    private String v;
    private List<File> w;
    private b.f.a.g.a y;
    private Toolbar z;
    private ArrayList<String> x = new ArrayList<>();
    private boolean C = false;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            LFilePickerActivity.this.finish();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {
        b() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            String parent = new File(LFilePickerActivity.this.v).getParent();
            if (parent == null) {
                return;
            }
            LFilePickerActivity.this.v = parent;
            LFilePickerActivity lFilePickerActivity = LFilePickerActivity.this;
            lFilePickerActivity.w = lFilePickerActivity.c0(lFilePickerActivity.v);
            LFilePickerActivity.this.y.A(LFilePickerActivity.this.w);
            LFilePickerActivity.this.y.B(false);
            LFilePickerActivity.this.C = false;
            LFilePickerActivity.this.i0();
            Button button = LFilePickerActivity.this.u;
            LFilePickerActivity lFilePickerActivity2 = LFilePickerActivity.this;
            int i = f.Selected;
            button.setText(lFilePickerActivity2.getString(i));
            LFilePickerActivity.this.q.h1(0);
            LFilePickerActivity lFilePickerActivity3 = LFilePickerActivity.this;
            lFilePickerActivity3.g0(lFilePickerActivity3.v);
            LFilePickerActivity.this.x.clear();
            if (LFilePickerActivity.this.A.a() != null) {
                LFilePickerActivity.this.u.setText(LFilePickerActivity.this.A.a());
            } else {
                LFilePickerActivity.this.u.setText(i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements a.d {
        c() {
        }

        @Override // b.f.a.g.a.d
        public void a(int i) {
            Button button;
            StringBuilder sb;
            String string;
            if (!LFilePickerActivity.this.A.k()) {
                if (((File) LFilePickerActivity.this.w.get(i)).isDirectory()) {
                    LFilePickerActivity.this.a0(i);
                } else if (!LFilePickerActivity.this.A.j()) {
                    Toast.makeText(LFilePickerActivity.this, f.ChooseTip, 0).show();
                } else {
                    LFilePickerActivity.this.x.add(((File) LFilePickerActivity.this.w.get(i)).getAbsolutePath());
                    LFilePickerActivity.this.b0();
                }
            } else if (((File) LFilePickerActivity.this.w.get(i)).isDirectory()) {
                LFilePickerActivity.this.a0(i);
                LFilePickerActivity.this.y.B(false);
                LFilePickerActivity.this.C = false;
                LFilePickerActivity.this.i0();
                LFilePickerActivity.this.u.setText(LFilePickerActivity.this.getString(f.Selected));
            } else {
                if (LFilePickerActivity.this.x.contains(((File) LFilePickerActivity.this.w.get(i)).getAbsolutePath())) {
                    LFilePickerActivity.this.x.remove(((File) LFilePickerActivity.this.w.get(i)).getAbsolutePath());
                } else {
                    LFilePickerActivity.this.x.add(((File) LFilePickerActivity.this.w.get(i)).getAbsolutePath());
                }
                if (LFilePickerActivity.this.A.a() != null) {
                    button = LFilePickerActivity.this.u;
                    sb = new StringBuilder();
                    string = LFilePickerActivity.this.A.a();
                } else {
                    button = LFilePickerActivity.this.u;
                    sb = new StringBuilder();
                    string = LFilePickerActivity.this.getString(f.Selected);
                }
                sb.append(string);
                sb.append("( ");
                sb.append(LFilePickerActivity.this.x.size());
                sb.append(" )");
                button.setText(sb.toString());
                if (LFilePickerActivity.this.A.f() <= 0 || LFilePickerActivity.this.x.size() <= LFilePickerActivity.this.A.f()) {
                    return;
                }
                Toast.makeText(LFilePickerActivity.this, f.OutSize, 0).show();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements View.OnClickListener {
        d() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (!LFilePickerActivity.this.A.j() || LFilePickerActivity.this.x.size() >= 1) {
                LFilePickerActivity.this.b0();
                return;
            }
            String g = LFilePickerActivity.this.A.g();
            (TextUtils.isEmpty(g) ? Toast.makeText(LFilePickerActivity.this, f.NotFoundBooks, 0) : Toast.makeText(LFilePickerActivity.this, g, 0)).show();
        }
    }

    private boolean Z() {
        return Environment.getExternalStorageState().equals("mounted");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a0(int i) {
        String absolutePath = this.w.get(i).getAbsolutePath();
        this.v = absolutePath;
        g0(absolutePath);
        List<File> c0 = c0(this.v);
        this.w = c0;
        this.y.A(c0);
        this.y.g();
        this.q.h1(0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b0() {
        if (this.A.j() && this.A.f() > 0 && this.x.size() > this.A.f()) {
            Toast.makeText(this, f.OutSize, 0).show();
            return;
        }
        Intent intent = new Intent();
        intent.putStringArrayListExtra("paths", this.x);
        intent.putExtra("path", this.s.getText().toString().trim());
        setResult(-1, intent);
        finish();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public List<File> c0(String str) {
        new File(str);
        return b.f.a.j.c.a(str, this.B);
    }

    private void d0() {
        this.t.setOnClickListener(new b());
        this.y.y(new c());
        this.u.setOnClickListener(new d());
    }

    private void e0() {
        Toolbar toolbar;
        int i;
        if (this.A.h() != null) {
            this.z.setTitle(this.A.h());
        }
        if (this.A.i() != null) {
            this.z.setTitleTextColor(Color.parseColor(this.A.i()));
        }
        if (this.A.c() != null) {
            this.z.setBackgroundColor(Color.parseColor(this.A.c()));
        }
        int b2 = this.A.b();
        if (b2 != 0) {
            if (b2 == 1) {
                toolbar = this.z;
                i = e.backincostyletwo;
            }
            this.z.setNavigationOnClickListener(new a());
        }
        toolbar = this.z;
        i = e.backincostyleone;
        toolbar.setNavigationIcon(i);
        this.z.setNavigationOnClickListener(new a());
    }

    private void f0() {
        this.q = (EmptyRecyclerView) findViewById(b.f.a.b.recylerview);
        this.s = (TextView) findViewById(b.f.a.b.tv_path);
        this.t = (TextView) findViewById(b.f.a.b.tv_back);
        this.u = (Button) findViewById(b.f.a.b.btn_addbook);
        this.r = findViewById(b.f.a.b.empty_view);
        this.z = (Toolbar) findViewById(b.f.a.b.toolbar);
        if (this.A.a() != null) {
            this.u.setText(this.A.a());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g0(String str) {
        this.s.setText(str);
    }

    private void h0() {
        if (!this.A.k()) {
            this.u.setVisibility(8);
        }
        if (this.A.j()) {
            return;
        }
        this.u.setVisibility(0);
        this.u.setText(getString(f.OK));
        this.A.s(false);
    }

    private void j0(Menu menu) {
        this.D.findItem(b.f.a.b.action_selecteall_cancel).setVisible(this.A.k());
    }

    public void i0() {
        MenuItem item;
        int i;
        if (this.C) {
            item = this.D.getItem(0);
            i = f.Cancel;
        } else {
            item = this.D.getItem(0);
            i = f.SelectAll;
        }
        item.setTitle(getString(i));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(b.f.a.c.activity_lfile_picker);
        this.A = (b.f.a.i.a) getIntent().getExtras().getSerializable("param");
        f0();
        I(this.z);
        C().t(true);
        C().s(true);
        e0();
        h0();
        if (!Z()) {
            Toast.makeText(this, f.NotFoundPath, 0).show();
            return;
        }
        String absolutePath = Environment.getExternalStorageDirectory().getAbsolutePath();
        this.v = absolutePath;
        this.s.setText(absolutePath);
        this.B = new b.f.a.h.a(this.A.d());
        List<File> c0 = c0(this.v);
        this.w = c0;
        this.y = new b.f.a.g.a(c0, this, this.B, this.A.k());
        this.q.setLayoutManager(new LinearLayoutManager(this, 1, false));
        this.y.z(this.A.e());
        this.q.setAdapter(this.y);
        this.q.setmEmptyView(this.r);
        d0();
    }

    @Override // android.app.Activity
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(b.f.a.d.menu_main_toolbar, menu);
        this.D = menu;
        j0(menu);
        return true;
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        Button button;
        StringBuilder sb;
        String string;
        if (menuItem.getItemId() == b.f.a.b.action_selecteall_cancel) {
            this.y.B(!this.C);
            boolean z = !this.C;
            this.C = z;
            if (z) {
                for (File file : this.w) {
                    if (!file.isDirectory() && !this.x.contains(file.getAbsolutePath())) {
                        this.x.add(file.getAbsolutePath());
                    }
                    if (this.A.a() != null) {
                        button = this.u;
                        sb = new StringBuilder();
                        string = this.A.a();
                    } else {
                        button = this.u;
                        sb = new StringBuilder();
                        string = getString(f.Selected);
                    }
                    sb.append(string);
                    sb.append("( ");
                    sb.append(this.x.size());
                    sb.append(" )");
                    button.setText(sb.toString());
                }
            } else {
                this.x.clear();
                this.u.setText(getString(f.Selected));
            }
            i0();
        }
        return true;
    }
}
