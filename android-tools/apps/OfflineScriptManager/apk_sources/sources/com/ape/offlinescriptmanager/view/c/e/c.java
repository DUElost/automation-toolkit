package com.ape.offlinescriptmanager.view.c.e;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import b.a.a.f;
import b.b.a.a.d.f;
import b.h.a.a.c.a;
import com.github.johnkil.print.PrintView;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends a.AbstractC0055a<f.a> implements com.ape.offlinescriptmanager.view.c.e.d {
    private static boolean k;
    private static b.b.a.a.c.f l;
    private static List<b.b.a.a.c.h> m;
    protected String f;
    protected LinearLayout g;
    private View h;
    private TextView i;
    private final h j;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements a.c {
        a() {
        }

        @Override // b.h.a.a.c.a.c
        public boolean a(b.h.a.a.c.a aVar, Object obj) {
            c.this.H(aVar, c.l);
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements a.c {
        b() {
        }

        @Override // b.h.a.a.c.a.c
        public boolean a(b.h.a.a.c.a aVar, Object obj) {
            b.h.a.a.d.a g = c.this.g();
            Log.i("HolderTask", "onLongClick: node id = " + aVar.f());
            if (g.p()) {
                c.this.H(aVar, (b.b.a.a.c.b) c.m.get(aVar.f() - 1));
            } else {
                g.u(true);
                c.this.G();
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.c.e.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0088c implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2170b;

        View$OnClickListenerC0088c(c cVar, EditText editText) {
            this.f2170b = editText;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            this.f2170b.setText(String.valueOf(Integer.parseInt(this.f2170b.getText().toString()) + 1));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2171b;

        d(c cVar, EditText editText) {
            this.f2171b = editText;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            this.f2171b.setText(String.valueOf(Math.max(Integer.parseInt(this.f2171b.getText().toString()) - 1, 1)));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements f.m {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ EditText f2172a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ b.b.a.a.c.b f2173b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ b.h.a.a.c.a f2174c;

        e(c cVar, EditText editText, b.b.a.a.c.b bVar, b.h.a.a.c.a aVar) {
            this.f2172a = editText;
            this.f2173b = bVar;
            this.f2174c = aVar;
        }

        @Override // b.a.a.f.m
        public void a(b.a.a.f fVar, b.a.a.b bVar) {
            String obj = this.f2172a.getText().toString();
            this.f2173b.b(Integer.parseInt(obj));
            com.ape.offlinescriptmanager.view.c.e.d dVar = (com.ape.offlinescriptmanager.view.c.e.d) this.f2174c.j();
            dVar.b(String.format("%s * %s", dVar.a().split(" ")[0], obj));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements f.m {
        f(c cVar) {
        }

        @Override // b.a.a.f.m
        public void a(b.a.a.f fVar, b.a.a.b bVar) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class g implements View.OnClickListener {

        /* loaded from: classes.dex */
        class a implements DialogInterface.OnClickListener {
            a() {
            }

            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                c.this.D();
                c.this.B();
            }
        }

        private g() {
        }

        /* synthetic */ g(c cVar, a aVar) {
            this();
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            b.h.a.a.d.a g = c.this.g();
            switch (view.getId()) {
                case R.id.btn_cancel /* 2131296323 */:
                    if (c.k) {
                        c.this.I(R.string.str_running_notice_title, R.string.str_cancel_without_save, new a(), null);
                        return;
                    } else {
                        c.this.B();
                        return;
                    }
                case R.id.btn_done_dialog /* 2131296324 */:
                case R.id.btn_end_test /* 2131296325 */:
                default:
                    return;
                case R.id.btn_save /* 2131296326 */:
                    c.this.E();
                    c.this.B();
                    Toast.makeText(((a.AbstractC0055a) c.this).e, (int) R.string.str_save_btn_msg, 0).show();
                    return;
                case R.id.btn_select_all /* 2131296327 */:
                    if (g.p()) {
                        g.j();
                        g.r(true);
                        return;
                    }
                    return;
                case R.id.btn_select_none /* 2131296328 */:
                    c.this.F();
                    return;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h extends Handler {
        h() {
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            super.handleMessage(message);
            int i = message.what;
            if (i == 0) {
                boolean unused = c.k = false;
                c.this.g.findViewById(R.id.btn_save).setVisibility(8);
            } else if (i == 1001 && c.this.g.getVisibility() == 0) {
                c.this.g.findViewById(R.id.btn_save).setVisibility(0);
                boolean unused2 = c.k = true;
            }
        }
    }

    public c(Context context) {
        super(context);
        this.f = BuildConfig.FLAVOR;
        this.j = new h();
        b.b.a.a.c.f b2 = b.b.a.a.c.g.a().b();
        l = b2;
        m = b2.h();
    }

    public static boolean A() {
        return k;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        b.h.a.a.d.a g2 = g();
        this.g.setVisibility(4);
        g2.u(false);
        g2.f();
        g2.k(this.f1664b);
    }

    private void C(View view) {
        view.findViewById(R.id.btn_select_all).setOnClickListener(new g(this, null));
        view.findViewById(R.id.btn_select_none).setOnClickListener(new g(this, null));
        view.findViewById(R.id.btn_cancel).setOnClickListener(new g(this, null));
        view.findViewById(R.id.btn_save).setOnClickListener(new g(this, null));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void E() {
        for (b.h.a.a.c.a aVar : this.f1664b.d()) {
            int f2 = aVar.f() - 1;
            m.get(f2).j(aVar.o());
            for (b.h.a.a.c.a aVar2 : aVar.d()) {
                m.get(f2).e().get(aVar2.f() - 1).d(aVar2.o());
            }
        }
        D();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F() {
        b.h.a.a.d.a g2 = g();
        g2.h();
        g2.f();
        g2.k(this.f1664b);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void G() {
        g().j();
        if (this.f1664b != null) {
            J();
        }
        g().f();
        g().k(this.f1664b);
        this.g.setVisibility(0);
        D();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void I(int i, int i2, DialogInterface.OnClickListener onClickListener, DialogInterface.OnClickListener onClickListener2) {
        new AlertDialog.Builder(this.e).setTitle(i).setMessage(i2).setPositiveButton("Yes", onClickListener).setNegativeButton("No", onClickListener2).create().show();
    }

    private void J() {
        b.h.a.a.c.a aVar = this.f1664b;
        if (aVar == null) {
            return;
        }
        for (b.h.a.a.c.a aVar2 : aVar.d()) {
            b.b.a.a.c.h hVar = m.get(aVar2.f() - 1);
            boolean g2 = hVar.g();
            aVar2.t(g2);
            aVar2.j().m(g2);
            List<b.h.a.a.c.a> d2 = aVar2.d();
            if (d2.size() != 0) {
                ArrayList<b.b.a.a.c.c> e2 = hVar.e();
                for (b.h.a.a.c.a aVar3 : d2) {
                    aVar3.t(e2.get(aVar3.f() - 1).f());
                }
            }
        }
    }

    public static b.b.a.a.c.f z() {
        return l;
    }

    public void D() {
        this.j.sendEmptyMessage(0);
    }

    public void H(b.h.a.a.c.a aVar, b.b.a.a.c.b bVar) {
        View inflate = LayoutInflater.from(this.e).inflate(R.layout.dialog_runtimes_edit, (ViewGroup) null);
        TextView textView = (TextView) inflate.findViewById(R.id.tv_dialog_test_point_name);
        if (bVar.getName() != null) {
            textView.setText(bVar.getName());
        }
        EditText editText = (EditText) inflate.findViewById(R.id.dialog_task_edit_times_et);
        editText.setText(String.valueOf(bVar.a()));
        inflate.findViewById(R.id.pb_times_up).setOnClickListener(new View$OnClickListenerC0088c(this, editText));
        inflate.findViewById(R.id.pb_times_down).setOnClickListener(new d(this, editText));
        Context context = this.e;
        com.ape.offlinescriptmanager.view.a.a.d(context, context.getString(R.string.edit_testpoint), inflate, new e(this, editText, bVar, aVar), new f(this)).show();
    }

    public String a() {
        return this.i.getText().toString();
    }

    public void b(String str) {
        this.i.setText(str);
    }

    @Override // b.h.a.a.c.a.AbstractC0055a
    /* renamed from: x */
    public View c(b.h.a.a.c.a aVar, f.a aVar2) {
        this.f = aVar2.f1403b;
        aVar.q(true);
        View inflate = LayoutInflater.from(this.e).inflate(R.layout.holder_task_node, (ViewGroup) null, false);
        this.h = inflate;
        this.i = (TextView) this.h.findViewById(R.id.node_text);
        this.g = (LinearLayout) this.h.findViewById(R.id.ll_long_click_menu);
        ((PrintView) inflate.findViewById(R.id.icon)).setIconText(this.e.getResources().getString(aVar2.f1402a));
        this.i.setText(aVar2.f1403b);
        C(this.h);
        aVar.r(new a());
        for (b.h.a.a.c.a aVar3 : aVar.d()) {
            aVar3.r(new b());
        }
        return this.h;
    }

    public h y() {
        return this.j;
    }
}
