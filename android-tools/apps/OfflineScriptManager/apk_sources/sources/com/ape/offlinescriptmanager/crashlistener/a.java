package com.ape.offlinescriptmanager.crashlistener;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.ape.offlinescriptmanager.utils.g;
import java.io.File;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends Fragment implements com.ape.offlinescriptmanager.screenrecorder.b {

    /* renamed from: b  reason: collision with root package name */
    private RecyclerView f1938b;

    /* renamed from: c  reason: collision with root package name */
    private TextView f1939c;

    /* renamed from: d  reason: collision with root package name */
    private SharedPreferences f1940d;
    private ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> e = new ArrayList<>();

    /* renamed from: com.ape.offlinescriptmanager.crashlistener.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class MenuItem$OnMenuItemClickListenerC0071a implements MenuItem.OnMenuItemClickListener {
        MenuItem$OnMenuItemClickListenerC0071a() {
        }

        @Override // android.view.MenuItem.OnMenuItemClickListener
        public boolean onMenuItemClick(MenuItem menuItem) {
            a.this.e.clear();
            a.this.h();
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends GridLayoutManager.c {

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ com.ape.offlinescriptmanager.crashlistener.d.b f1942c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ GridLayoutManager f1943d;

        b(a aVar, com.ape.offlinescriptmanager.crashlistener.d.b bVar, GridLayoutManager gridLayoutManager) {
            this.f1942c = bVar;
            this.f1943d = gridLayoutManager;
        }

        @Override // androidx.recyclerview.widget.GridLayoutManager.c
        public int e(int i) {
            if (this.f1942c.v(i)) {
                return this.f1943d.O2();
            }
            return 1;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AsyncTask<File[], Integer, ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a>> {

        /* renamed from: a  reason: collision with root package name */
        ProgressDialog f1944a;

        /* renamed from: b  reason: collision with root package name */
        File[] f1945b;

        c() {
            a.this.getActivity().getApplicationContext().getContentResolver();
        }

        private boolean a(Date date, Date date2) {
            return ((int) Math.abs((g(date2.getTime()).getTimeInMillis() - g(date.getTime()).getTimeInMillis()) / 86400000)) > 0;
        }

        private ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> b(ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> arrayList) {
            ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> arrayList2 = new ArrayList<>();
            Date date = new Date();
            for (int i = 0; i < arrayList.size(); i++) {
                com.ape.offlinescriptmanager.crashlistener.d.a aVar = arrayList.get(i);
                if (i == 0) {
                    arrayList2.add(new com.ape.offlinescriptmanager.crashlistener.d.a(true, aVar.e()));
                    arrayList2.add(aVar);
                    date = aVar.e();
                } else {
                    if (a(date, aVar.e())) {
                        arrayList2.add(new com.ape.offlinescriptmanager.crashlistener.d.a(true, aVar.e()));
                        date = aVar.e();
                    }
                    arrayList2.add(aVar);
                }
            }
            return arrayList2;
        }

        private Bitmap d(File file) {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inJustDecodeBounds = false;
            options.inSampleSize = 2;
            return BitmapFactory.decodeFile(file.getPath(), options);
        }

        private Calendar g(long j) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(j);
            calendar.set(11, 0);
            calendar.set(12, 0);
            calendar.set(13, 0);
            calendar.set(14, 0);
            return calendar;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: c */
        public ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> doInBackground(File[]... fileArr) {
            File[] fileArr2;
            this.f1945b = fileArr[0];
            this.f1944a.setMax(fileArr2.length - 2);
            int i = 0;
            while (true) {
                File[] fileArr3 = this.f1945b;
                if (i >= fileArr3.length) {
                    return a.this.e;
                }
                File file = fileArr3[i];
                if (!file.isDirectory() && a.this.j(file.getPath())) {
                    a.this.e.add(new com.ape.offlinescriptmanager.crashlistener.d.a(file.getName(), Uri.fromFile(file), d(file), new Date(file.lastModified())));
                    publishProgress(Integer.valueOf(i));
                }
                i++;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: e */
        public void onPostExecute(ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> arrayList) {
            if (arrayList.isEmpty()) {
                a.this.f1938b.setVisibility(8);
                a.this.f1939c.setVisibility(0);
            } else {
                Collections.sort(arrayList, Collections.reverseOrder());
                a.this.l(b(arrayList));
                a.this.f1938b.setVisibility(0);
                a.this.f1939c.setVisibility(8);
            }
            this.f1944a.cancel();
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: f */
        public void onProgressUpdate(Integer... numArr) {
            super.onProgressUpdate(numArr);
            this.f1944a.setProgress(numArr[0].intValue());
        }

        @Override // android.os.AsyncTask
        protected void onPreExecute() {
            super.onPreExecute();
            ProgressDialog progressDialog = new ProgressDialog(a.this.getActivity());
            this.f1944a = progressDialog;
            progressDialog.setTitle("Please wait");
            this.f1944a.setMessage("Loading picture...");
            this.f1944a.setCancelable(false);
            this.f1944a.setProgressStyle(1);
            this.f1944a.show();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        if (androidx.core.content.a.a(getActivity(), "android.permission.READ_EXTERNAL_STORAGE") != 0) {
            if (getActivity() instanceof CrashListenerActivity) {
                ((CrashListenerActivity) getActivity()).S(this);
                ((CrashListenerActivity) getActivity()).R();
            }
        } else if (this.e.isEmpty()) {
            File file = new File(this.f1940d.getString(getString(R.string.crash_save_location_key), g.t()));
            if (!file.exists()) {
                CrashListenerActivity.N(getActivity(), this.f1940d);
            }
            ArrayList arrayList = new ArrayList();
            if (file.isDirectory() && file.exists()) {
                arrayList.addAll(Arrays.asList(i(file.listFiles())));
            }
            new c().execute((File[]) arrayList.toArray(new File[arrayList.size()]));
        }
    }

    private File[] i(File[] fileArr) {
        ArrayList arrayList = new ArrayList();
        for (File file : fileArr) {
            if (!file.isDirectory() && j(file.getPath())) {
                arrayList.add(file);
            }
        }
        return (File[]) arrayList.toArray(new File[arrayList.size()]);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean j(String str) {
        String guessContentTypeFromName = URLConnection.guessContentTypeFromName(str);
        return guessContentTypeFromName != null && guessContentTypeFromName.startsWith("image");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void l(ArrayList<com.ape.offlinescriptmanager.crashlistener.d.a> arrayList) {
        this.f1938b.setHasFixedSize(true);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getActivity(), 2);
        this.f1938b.setLayoutManager(gridLayoutManager);
        com.ape.offlinescriptmanager.crashlistener.d.b bVar = new com.ape.offlinescriptmanager.crashlistener.d.b(getActivity(), arrayList, this);
        this.f1938b.setAdapter(bVar);
        gridLayoutManager.W2(new b(this, bVar, gridLayoutManager));
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.b
    public void a(int i, String[] strArr, int[] iArr) {
        if (i != 11000) {
            return;
        }
        if (iArr.length > 0 && iArr[0] == 0) {
            h();
            return;
        }
        this.f1938b.setVisibility(8);
        this.f1939c.setText(R.string.video_list_permission_denied_message);
    }

    public void k() {
        this.e.clear();
    }

    @Override // android.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(true);
    }

    @Override // android.app.Fragment
    public void onCreateOptionsMenu(Menu menu, MenuInflater menuInflater) {
        super.onCreateOptionsMenu(menu, menuInflater);
        MenuItem add = menu.add("Refresh");
        add.setIcon(R.drawable.ic_refresh_white_24dp);
        add.setShowAsActionFlags(2);
        add.setOnMenuItemClickListener(new MenuItem$OnMenuItemClickListenerC0071a());
    }

    @Override // android.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.fragment_pictures, viewGroup, false);
        this.f1938b = (RecyclerView) inflate.findViewById(R.id.pictures_rv);
        this.f1939c = (TextView) inflate.findViewById(R.id.message_tv);
        this.f1940d = PreferenceManager.getDefaultSharedPreferences(getActivity());
        return inflate;
    }

    @Override // android.app.Fragment
    public void setUserVisibleHint(boolean z) {
        super.setUserVisibleHint(z);
        if (z) {
            h();
        }
    }
}
