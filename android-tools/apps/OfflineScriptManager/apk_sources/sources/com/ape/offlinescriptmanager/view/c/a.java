package com.ape.offlinescriptmanager.view.c;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Toast;
import androidx.fragment.app.Fragment;
import b.b.a.a.c.f;
import b.b.a.a.c.g;
import b.b.a.a.c.h;
import b.b.a.a.c.i;
import b.b.a.a.d.f;
import com.ape.offlinescriptmanager.view.RunTaskService;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import java.util.Iterator;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends Fragment {
    FloatingActionButton Z;
    EditText a0;
    String b0;
    List<h> c0;
    private SharedPreferences d0;
    private SharedPreferences.Editor e0;
    private RelativeLayout f0;
    private int g0;
    private b.h.a.a.d.a h0;
    private f i0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.c.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0085a implements View.OnClickListener {
        View$OnClickListenerC0085a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            androidx.fragment.app.b f;
            int i;
            Toast makeText;
            int i2 = 0;
            if (com.ape.offlinescriptmanager.utils.a.c(a.this.n()).d(RunTaskService.class)) {
                makeText = Toast.makeText(a.this.f(), "task service already running", 0);
            } else {
                if (g.a().d("/sdcard/runtask.xml")) {
                    i2 = 1;
                    if (!com.ape.offlinescriptmanager.utils.g.B(a.this.f())) {
                        f = a.this.f();
                        i = R.string.data_collect_off;
                    } else if (a.this.h0 == null || !com.ape.offlinescriptmanager.view.c.e.c.A()) {
                        if (TextUtils.isEmpty(a.this.a0.getText().toString())) {
                            a.this.t1();
                            return;
                        } else {
                            a.this.s1();
                            return;
                        }
                    } else {
                        f = a.this.f();
                        i = R.string.changes_have_not_save;
                    }
                } else {
                    f = a.this.f();
                    i = R.string.no_runtask_xml;
                }
                makeText = Toast.makeText(f, i, i2);
            }
            makeText.show();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements DialogInterface.OnClickListener {
        b() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            a.this.a0.setText("empty");
            a.this.s1();
        }
    }

    public static a o1() {
        return new a();
    }

    private f q1(String str) {
        if (g.a().d(str)) {
            f z = com.ape.offlinescriptmanager.view.c.e.c.z();
            return z != null ? z : g.a().b();
        }
        return null;
    }

    private void r1(View view) {
        this.a0 = (EditText) view.findViewById(R.id.tester_name);
        LinearLayout linearLayout = (LinearLayout) view.findViewById(R.id.ll_long_click_menu);
        this.f0 = (RelativeLayout) view.findViewById(R.id.rl_tree_container);
        FloatingActionButton floatingActionButton = (FloatingActionButton) view.findViewById(R.id.fab);
        this.Z = floatingActionButton;
        floatingActionButton.setOnClickListener(new View$OnClickListenerC0085a());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void s1() {
        Toast.makeText(f(), "task service starting", 0).show();
        RunTaskService.q(f());
        this.e0.putString("task_creator", this.a0.getText().toString().trim());
        this.e0.commit();
        Toast.makeText(f(), "Task started", 0).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void t1() {
        AlertDialog.Builder builder = new AlertDialog.Builder(n());
        builder.setTitle(R.string.str_running_notice_title).setMessage(R.string.no_tester_name);
        builder.setPositiveButton(17039370, new b());
        builder.setNegativeButton(17039360, (DialogInterface.OnClickListener) null);
        builder.create().show();
    }

    @Override // androidx.fragment.app.Fragment
    public void V(Context context) {
        super.V(context);
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        SharedPreferences sharedPreferences = n().getSharedPreferences("test_task_data", 0);
        this.d0 = sharedPreferences;
        this.e0 = sharedPreferences.edit();
        View inflate = layoutInflater.inflate(R.layout.fragment_task_tree, viewGroup, false);
        if (l() != null) {
            String string = l().getString("TASK");
            this.b0 = string;
            f q1 = q1(string);
            this.i0 = q1;
            if (q1 != null) {
                this.c0 = q1.h();
            }
        }
        r1(inflate);
        p1();
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        super.d0();
    }

    public void p1() {
        if (f() == null) {
            return;
        }
        if (this.g0 == 0) {
            this.g0 = this.f0.getGravity();
        }
        this.f0.setGravity(this.g0);
        if (this.c0 == null) {
            this.f0.addView(LayoutInflater.from(f()).inflate(R.layout.layout_load_error, (ViewGroup) null));
            this.f0.setGravity(17);
            return;
        }
        b.h.a.a.c.a p = b.h.a.a.c.a.p();
        this.h0 = new b.h.a.a.d.a(f(), p);
        b.h.a.a.c.a aVar = new b.h.a.a.c.a(new f.a(R.string.ic_menu, String.format("Task * %s", Integer.valueOf(this.i0.a()))));
        aVar.u(new com.ape.offlinescriptmanager.view.c.e.c(f()));
        for (h hVar : this.c0) {
            b.h.a.a.c.a aVar2 = new b.h.a.a.c.a(new f.a(R.string.ic_list, String.format("%s * %s", hVar.getName(), Integer.valueOf(hVar.a()))));
            aVar2.u(new com.ape.offlinescriptmanager.view.c.e.b(f()));
            Iterator<b.b.a.a.c.c> it = hVar.e().iterator();
            while (it.hasNext()) {
                b.h.a.a.c.a aVar3 = new b.h.a.a.c.a(((i) it.next()).l());
                aVar3.u(new com.ape.offlinescriptmanager.view.c.e.a(f()));
                aVar2.a(aVar3);
            }
            aVar.a(aVar2);
        }
        p.b(aVar);
        this.f0.addView(this.h0.m());
    }
}
