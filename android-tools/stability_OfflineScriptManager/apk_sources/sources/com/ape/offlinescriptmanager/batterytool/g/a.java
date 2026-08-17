package com.ape.offlinescriptmanager.batterytool.g;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.view.View;
import android.widget.Toast;
import com.ape.offlinescriptmanager.batterytool.g.c;
import com.ape.offlinescriptmanager.utils.g;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
import org.achartengine.h.d;
/* loaded from: classes.dex */
public abstract class a extends AsyncTask<Void, Void, Boolean> {

    /* renamed from: a  reason: collision with root package name */
    private Context f1914a;

    /* renamed from: b  reason: collision with root package name */
    private ProgressDialog f1915b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f1916c;

    /* renamed from: d  reason: collision with root package name */
    public String f1917d;
    private boolean e;
    public List<c.a> f = new ArrayList();
    public c.a g = null;

    /* renamed from: com.ape.offlinescriptmanager.batterytool.g.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0070a {

        /* renamed from: a  reason: collision with root package name */
        public double f1918a;

        /* renamed from: b  reason: collision with root package name */
        public double f1919b;

        public C0070a(a aVar) {
        }
    }

    public a(Context context, String str, boolean z, boolean z2) {
        this.f1914a = context;
        this.f1916c = z2;
        this.f1917d = str;
        this.e = z;
    }

    public void a(int i, int i2, String str) {
        c.a aVar = new c.a();
        this.g = aVar;
        aVar.f1926b = i;
        aVar.f1925a = i2;
        aVar.f1927c = str;
        this.f.add(aVar);
    }

    public void b(String str) {
        File[] listFiles;
        File file = new File(str);
        for (File file2 : file.listFiles()) {
            if (file2.getName().endsWith(".png") && file2.exists()) {
                file2.delete();
            }
        }
        file.delete();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* renamed from: c */
    public void onPostExecute(Boolean bool) {
        Toast makeText;
        ProgressDialog progressDialog;
        super.onPostExecute(bool);
        if (this.e && (progressDialog = this.f1915b) != null && progressDialog.isShowing()) {
            this.f1915b.dismiss();
        }
        SharedPreferences sharedPreferences = this.f1914a.getSharedPreferences("com.ape.offlinescriptmanager.pref", 0);
        if (bool.booleanValue()) {
            sharedPreferences.edit().putBoolean("export_data_no_empty", true).commit();
        }
        if (this.f1916c) {
            boolean z = sharedPreferences.getBoolean("export_data_no_empty", false);
            if (bool.booleanValue() || z) {
                Context context = this.f1914a;
                makeText = Toast.makeText(context, String.format(context.getString(R.string.export_over), g.l(this.f1917d, BuildConfig.FLAVOR)), 0);
            } else {
                makeText = Toast.makeText(this.f1914a, (int) R.string.save_report_alert_nodata, 0);
            }
            makeText.show();
        }
    }

    public void d(List<List<C0070a>> list, List<String> list2, d dVar, String str, String str2, String str3) {
        org.achartengine.g.d dVar2 = new org.achartengine.g.d();
        for (int i = 0; i < list.size(); i++) {
            org.achartengine.g.c cVar = new org.achartengine.g.c(list2.get(i));
            for (C0070a c0070a : list.get(i)) {
                cVar.a(c0070a.f1918a, c0070a.f1919b);
            }
            dVar2.a(cVar);
        }
        if (str.equals(BuildConfig.FLAVOR)) {
            org.achartengine.a.b(this.f1914a, dVar2, dVar, str);
        } else {
            org.achartengine.a.c(this.f1914a, dVar2, dVar, str);
        }
        org.achartengine.b c2 = org.achartengine.a.c(this.f1914a, dVar2, dVar, str);
        dVar.l1(10);
        dVar.t1(5);
        c2.setDrawingCacheEnabled(true);
        c2.measure(View.MeasureSpec.makeMeasureSpec(0, 0), View.MeasureSpec.makeMeasureSpec(0, 0));
        c2.layout(0, 0, 650, 600);
        c2.buildDrawingCache();
        Bitmap bitmap = null;
        try {
            bitmap = c2.getDrawingCache();
            if (bitmap != null) {
                e(str2, str3 + ".png", bitmap);
            }
        } finally {
            if (bitmap != null) {
                bitmap.recycle();
            }
        }
    }

    public void e(String str, String str2, Bitmap bitmap) {
        FileOutputStream fileOutputStream;
        Throwable th;
        IOException e;
        File file = new File(str + File.separator + str2);
        if (file.exists()) {
            file.delete();
        }
        try {
            try {
                file.createNewFile();
                fileOutputStream = new FileOutputStream(file);
                try {
                    try {
                        bitmap.compress(Bitmap.CompressFormat.PNG, 100, fileOutputStream);
                        fileOutputStream.flush();
                        fileOutputStream.close();
                    } catch (IOException e2) {
                        e = e2;
                        e.printStackTrace();
                        fileOutputStream.flush();
                        fileOutputStream.close();
                    }
                } catch (Throwable th2) {
                    th = th2;
                    try {
                        fileOutputStream.flush();
                        fileOutputStream.close();
                    } catch (IOException e3) {
                        e3.printStackTrace();
                    }
                    throw th;
                }
            } catch (IOException e4) {
                e4.printStackTrace();
            }
        } catch (IOException e5) {
            fileOutputStream = null;
            e = e5;
        } catch (Throwable th3) {
            fileOutputStream = null;
            th = th3;
            fileOutputStream.flush();
            fileOutputStream.close();
            throw th;
        }
    }

    @Override // android.os.AsyncTask
    protected void onPreExecute() {
        super.onPreExecute();
        if (this.e) {
            ProgressDialog progressDialog = new ProgressDialog(this.f1914a);
            this.f1915b = progressDialog;
            progressDialog.setIcon(17301543);
            this.f1915b.setMessage(this.f1914a.getString(R.string.exporting_message));
            this.f1915b.setCancelable(false);
            this.f1915b.show();
        }
    }
}
