package com.ape.offlinescriptmanager.batterytool;

import android.content.Context;
import android.content.CursorLoader;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.ContentObserver;
import android.database.Cursor;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.Switch;
import android.widget.Toast;
import androidx.fragment.app.Fragment;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.i;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends Fragment {
    private SharedPreferences Z;
    private SharedPreferences.Editor a0;
    private org.achartengine.g.c b0;
    private org.achartengine.g.d c0;
    private org.achartengine.b d0;
    private List<com.ape.offlinescriptmanager.batterytool.f.b> e0;
    public Cursor f0;
    public Cursor g0;
    private Context h0;
    private com.ape.offlinescriptmanager.utils.e i0;
    private ListView j0;
    private Switch k0;
    private CursorLoader l0;
    private CursorLoader m0;
    private Looper n0;
    private f o0;
    private ContentObserver p0 = new d(new Handler());
    private ContentObserver q0 = new e(new Handler());

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.batterytool.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0067a implements CompoundButton.OnCheckedChangeListener {
        C0067a() {
        }

        @Override // android.widget.CompoundButton.OnCheckedChangeListener
        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
            androidx.fragment.app.b f;
            int i;
            if (z) {
                a.this.a0.putBoolean("isUpdating", true).commit();
                a.this.f().startService(new Intent(a.this.f(), UpdateDataService.class));
                f = a.this.f();
                i = R.string.switch_on;
            } else {
                a.this.a0.putBoolean("isUpdating", false).commit();
                a.this.f().stopService(new Intent(a.this.f(), UpdateDataService.class));
                f = a.this.f();
                i = R.string.switch_off;
            }
            Toast.makeText(f, i, 0).show();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            a.this.d0.invalidate();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ com.ape.offlinescriptmanager.batterytool.d.b f1887b;

        c(com.ape.offlinescriptmanager.batterytool.d.b bVar) {
            this.f1887b = bVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            a.this.j0.setAdapter((ListAdapter) this.f1887b);
        }
    }

    /* loaded from: classes.dex */
    private class d extends ContentObserver {
        public d(Handler handler) {
            super(handler);
        }

        @Override // android.database.ContentObserver
        public void onChange(boolean z) {
            Message obtainMessage = a.this.o0.obtainMessage();
            obtainMessage.what = 1;
            a.this.o0.sendMessage(obtainMessage);
        }
    }

    /* loaded from: classes.dex */
    private class e extends ContentObserver {
        public e(Handler handler) {
            super(handler);
        }

        @Override // android.database.ContentObserver
        public void onChange(boolean z) {
            Message obtainMessage = a.this.o0.obtainMessage();
            obtainMessage.what = 3;
            a.this.o0.sendMessage(obtainMessage);
        }
    }

    /* loaded from: classes.dex */
    private final class f extends Handler {
        public f(Looper looper) {
            super(looper);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            int i = message.what;
            if (i == 1) {
                a.this.u1();
            } else if (i != 3) {
            } else {
                a.this.v1();
            }
        }
    }

    private org.achartengine.h.d q1() {
        new org.achartengine.h.d();
        org.achartengine.h.d b2 = g.b(new int[]{-65281}, new org.achartengine.f.d[]{org.achartengine.f.d.CIRCLE}, -16711936, 2, -1, 1.0f);
        g.F(b2, D(R.string.chart_title), D(R.string.x_title), D(R.string.y_title), 0.0d, 0.0d, 0.0d, 110.0d, -16777216, -16777216);
        return b2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void u1() {
        try {
            r1();
            Cursor cursor = this.f0;
            if (cursor != null) {
                this.e0 = this.i0.b(cursor);
                this.c0.e(this.b0);
                this.b0.b();
                for (int i = 0; i < this.e0.size(); i++) {
                    this.b0.a(Long.parseLong(this.e0.get(i).c()), Integer.parseInt(this.e0.get(i).a()));
                }
                this.c0.a(this.b0);
                f().runOnUiThread(new b());
            }
        } finally {
            Cursor cursor2 = this.f0;
            if (cursor2 != null && !cursor2.isClosed()) {
                this.f0.close();
            }
        }
    }

    @Override // androidx.fragment.app.Fragment
    public void Y(Bundle bundle) {
        System.out.println("viking flag ----------------enter percentage onCreate");
        super.Y(bundle);
        androidx.fragment.app.b f2 = f();
        this.h0 = f2;
        this.i0 = new com.ape.offlinescriptmanager.utils.e();
        SharedPreferences sharedPreferences = f2.getSharedPreferences("update_data", 0);
        this.Z = sharedPreferences;
        this.a0 = sharedPreferences.edit();
        this.h0.getContentResolver().registerContentObserver(com.ape.offlinescriptmanager.database.c.f1975a, true, this.p0);
        this.h0.getContentResolver().registerContentObserver(com.ape.offlinescriptmanager.database.f.f1981a, true, this.q0);
        HandlerThread handlerThread = new HandlerThread("percentage", 0);
        handlerThread.start();
        this.n0 = handlerThread.getLooper();
        this.o0 = new f(this.n0);
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        System.out.println("viking flag ----enter percentage onCreateView");
        View inflate = layoutInflater.inflate(R.layout.percentage_chart_layout, (ViewGroup) null, false);
        this.b0 = new org.achartengine.g.c("Battery Percentage");
        org.achartengine.g.d dVar = new org.achartengine.g.d();
        this.c0 = dVar;
        dVar.a(this.b0);
        this.d0 = org.achartengine.a.b(this.h0, this.c0, q1(), "H:mm");
        u1();
        ((LinearLayout) inflate.findViewById(R.id.linear_chart)).addView(this.d0, new ViewGroup.LayoutParams(-1, (f().getResources().getDisplayMetrics().heightPixels * 2) / 3));
        ListView listView = (ListView) inflate.findViewById(R.id.list_chart);
        this.j0 = listView;
        listView.setItemsCanFocus(true);
        this.j0.setVerticalScrollBarEnabled(false);
        v1();
        this.k0 = (Switch) inflate.findViewById(R.id.control_onoff);
        t1();
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        System.out.println("viking flag ----------------enter percentage onDestroy");
        CursorLoader cursorLoader = this.l0;
        if (cursorLoader != null) {
            cursorLoader.cancelLoad();
        }
        CursorLoader cursorLoader2 = this.m0;
        if (cursorLoader2 != null) {
            cursorLoader2.cancelLoad();
        }
        this.h0.getContentResolver().unregisterContentObserver(this.p0);
        this.h0.getContentResolver().unregisterContentObserver(this.q0);
        super.d0();
    }

    @Override // androidx.fragment.app.Fragment
    public void h1(boolean z) {
        super.h1(z);
    }

    public void r1() {
        if (f() == null) {
            i.a("getActivity is null.......................");
            return;
        }
        CursorLoader cursorLoader = new CursorLoader(f(), com.ape.offlinescriptmanager.database.c.f1975a, com.ape.offlinescriptmanager.database.c.f1976b, null, null, "time ASC");
        this.l0 = cursorLoader;
        this.f0 = cursorLoader.loadInBackground();
    }

    @Override // androidx.fragment.app.Fragment
    public void s0() {
        System.out.println("viking flag ----------------enter percentage onResume");
        super.s0();
    }

    public void s1() {
        if (f() == null) {
            i.a("getActivity is null.......................");
            return;
        }
        CursorLoader cursorLoader = new CursorLoader(f(), com.ape.offlinescriptmanager.database.f.f1981a, com.ape.offlinescriptmanager.database.f.f1982b, null, null, "_id ASC");
        this.m0 = cursorLoader;
        this.g0 = cursorLoader.loadInBackground();
    }

    public void t1() {
        if (this.Z.getBoolean("isUpdating", false)) {
            this.k0.setChecked(true);
        } else {
            this.k0.setChecked(false);
        }
        this.k0.setOnCheckedChangeListener(new C0067a());
    }

    protected void v1() {
        try {
            s1();
            if (this.g0 != null) {
                f().runOnUiThread(new c(new com.ape.offlinescriptmanager.batterytool.d.b(f(), this.i0.e(this.g0))));
            }
        } finally {
            Cursor cursor = this.g0;
            if (cursor != null && !cursor.isClosed()) {
                this.g0.close();
            }
        }
    }
}
