package com.ape.offlinescriptmanager.batterytool;

import android.content.Context;
import android.content.CursorLoader;
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
import android.widget.LinearLayout;
import androidx.fragment.app.Fragment;
import com.ape.offlinescriptmanager.utils.e;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.i;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
import org.achartengine.g.d;
/* loaded from: classes.dex */
public class b extends Fragment {
    private org.achartengine.g.c Z;
    private d a0;
    private org.achartengine.b b0;
    private List<com.ape.offlinescriptmanager.batterytool.f.b> c0;
    private Cursor d0;
    private Context e0;
    private e f0;
    private CursorLoader g0;
    private Looper h0;
    private c i0;
    private ContentObserver j0 = new C0068b(new Handler());

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.b0.invalidate();
        }
    }

    /* renamed from: com.ape.offlinescriptmanager.batterytool.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private class C0068b extends ContentObserver {
        public C0068b(Handler handler) {
            super(handler);
        }

        @Override // android.database.ContentObserver
        public void onChange(boolean z) {
            i.b("Thread Tag onChange:--------------" + Thread.currentThread().getId());
            Message obtainMessage = b.this.i0.obtainMessage();
            obtainMessage.what = 6;
            b.this.i0.sendMessage(obtainMessage);
        }
    }

    /* loaded from: classes.dex */
    private final class c extends Handler {
        public c(Looper looper) {
            super(looper);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            i.b("Thread Tag handleMessage:---" + Thread.currentThread().getId());
            b.this.q1();
        }
    }

    private org.achartengine.h.d o1() {
        new org.achartengine.h.d();
        org.achartengine.h.d b2 = g.b(new int[]{-65281}, new org.achartengine.f.d[]{org.achartengine.f.d.CIRCLE}, -256, 2, -1, 1.0f);
        g.F(b2, D(R.string.temperature_chart_title), D(R.string.x_title), D(R.string.temperature_y_title), 0.0d, 0.0d, 0.0d, 100.0d, -16777216, -16777216);
        return b2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void q1() {
        try {
            p1();
            Cursor cursor = this.d0;
            if (cursor != null) {
                this.c0 = this.f0.b(cursor);
                this.a0.e(this.Z);
                this.Z.b();
                for (int i = 0; i < this.c0.size(); i++) {
                    this.Z.a(Long.parseLong(this.c0.get(i).c()), this.c0.get(i).b());
                }
                this.a0.a(this.Z);
                f().runOnUiThread(new a());
            }
        } finally {
            Cursor cursor2 = this.d0;
            if (cursor2 != null && !cursor2.isClosed()) {
                this.d0.close();
            }
        }
    }

    @Override // androidx.fragment.app.Fragment
    public void Y(Bundle bundle) {
        super.Y(bundle);
        androidx.fragment.app.b f = f();
        this.e0 = f;
        this.f0 = new e();
        f.getContentResolver().registerContentObserver(com.ape.offlinescriptmanager.database.c.f1975a, true, this.j0);
        HandlerThread handlerThread = new HandlerThread("temperature", 0);
        handlerThread.start();
        this.h0 = handlerThread.getLooper();
        this.i0 = new c(this.h0);
    }

    @Override // androidx.fragment.app.Fragment
    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.temperature_chart_layout, (ViewGroup) null, false);
        this.Z = new org.achartengine.g.c("Temperature Line");
        d dVar = new d();
        this.a0 = dVar;
        dVar.a(this.Z);
        this.b0 = org.achartengine.a.b(this.e0, this.a0, o1(), "H:mm");
        q1();
        ((LinearLayout) inflate.findViewById(R.id.temperature_linear_chart)).addView(this.b0, new ViewGroup.LayoutParams(-1, -1));
        return inflate;
    }

    @Override // androidx.fragment.app.Fragment
    public void d0() {
        CursorLoader cursorLoader = this.g0;
        if (cursorLoader != null) {
            cursorLoader.cancelLoad();
        }
        this.e0.getContentResolver().unregisterContentObserver(this.j0);
        super.d0();
    }

    public void p1() {
        if (f() == null) {
            i.a("getActivity is null.........");
            return;
        }
        CursorLoader cursorLoader = new CursorLoader(f(), com.ape.offlinescriptmanager.database.c.f1975a, com.ape.offlinescriptmanager.database.c.f1976b, null, null, "time ASC");
        this.g0 = cursorLoader;
        this.d0 = cursorLoader.loadInBackground();
    }

    @Override // androidx.fragment.app.Fragment
    public void s0() {
        super.s0();
    }
}
