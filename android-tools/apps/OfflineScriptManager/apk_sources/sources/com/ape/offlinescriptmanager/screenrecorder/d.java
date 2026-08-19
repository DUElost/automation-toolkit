package com.ape.offlinescriptmanager.screenrecorder;

import android.app.Fragment;
import android.app.ProgressDialog;
import android.content.ContentResolver;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.io.File;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class d extends Fragment implements com.ape.offlinescriptmanager.screenrecorder.b {

    /* renamed from: b  reason: collision with root package name */
    private RecyclerView f2022b;

    /* renamed from: c  reason: collision with root package name */
    private TextView f2023c;

    /* renamed from: d  reason: collision with root package name */
    private SharedPreferences f2024d;
    private ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> e = new ArrayList<>();

    /* loaded from: classes.dex */
    class a implements MenuItem.OnMenuItemClickListener {
        a() {
        }

        @Override // android.view.MenuItem.OnMenuItemClickListener
        public boolean onMenuItemClick(MenuItem menuItem) {
            d.this.e.clear();
            d.this.h();
            Log.d("SCREENRECORDER", "Refreshing");
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends GridLayoutManager.c {

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ com.ape.offlinescriptmanager.screenrecorder.e.b f2026c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ GridLayoutManager f2027d;

        b(d dVar, com.ape.offlinescriptmanager.screenrecorder.e.b bVar, GridLayoutManager gridLayoutManager) {
            this.f2026c = bVar;
            this.f2027d = gridLayoutManager;
        }

        @Override // androidx.recyclerview.widget.GridLayoutManager.c
        public int e(int i) {
            if (this.f2026c.C(i)) {
                return this.f2027d.O2();
            }
            return 1;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AsyncTask<File[], Integer, ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a>> {

        /* renamed from: a  reason: collision with root package name */
        ProgressDialog f2028a;

        /* renamed from: b  reason: collision with root package name */
        File[] f2029b;

        /* renamed from: c  reason: collision with root package name */
        ContentResolver f2030c;

        c() {
            this.f2030c = d.this.getActivity().getApplicationContext().getContentResolver();
        }

        private boolean a(Date date, Date date2) {
            Calendar g = g(date.getTime());
            int abs = (int) Math.abs((g(date2.getTime()).getTimeInMillis() - g.getTimeInMillis()) / 86400000);
            Log.d("SCREENRECORDER", "Date diff is: " + abs);
            return abs > 0;
        }

        private ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> b(ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> arrayList) {
            ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> arrayList2 = new ArrayList<>();
            Date date = new Date();
            Log.d("SCREENRECORDER", "Original Length: " + arrayList.size());
            for (int i = 0; i < arrayList.size(); i++) {
                com.ape.offlinescriptmanager.screenrecorder.e.a aVar = arrayList.get(i);
                if (i == 0) {
                    arrayList2.add(new com.ape.offlinescriptmanager.screenrecorder.e.a(true, aVar.d()));
                    arrayList2.add(aVar);
                    date = aVar.d();
                } else {
                    if (a(date, aVar.d())) {
                        arrayList2.add(new com.ape.offlinescriptmanager.screenrecorder.e.a(true, aVar.d()));
                        date = aVar.d();
                    }
                    arrayList2.add(aVar);
                }
            }
            Log.d("SCREENRECORDER", "Length with sections: " + arrayList2.size());
            return arrayList2;
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
        public ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> doInBackground(File[]... fileArr) {
            File[] fileArr2;
            this.f2029b = fileArr[0];
            this.f2028a.setMax(fileArr2.length - 2);
            int i = 0;
            while (true) {
                File[] fileArr3 = this.f2029b;
                if (i >= fileArr3.length) {
                    return d.this.e;
                }
                File file = fileArr3[i];
                if (!file.isDirectory() && d.j(file.getPath())) {
                    d.this.e.add(new com.ape.offlinescriptmanager.screenrecorder.e.a(file.getName(), Uri.fromFile(file), d(file), new Date(file.lastModified())));
                    publishProgress(Integer.valueOf(i));
                }
                i++;
            }
        }

        Bitmap d(File file) {
            Cursor query = this.f2030c.query(MediaStore.Video.Media.getContentUri("external"), new String[]{"_id", "bucket_id", "bucket_display_name", "_data"}, "_data=? ", new String[]{file.getPath()}, null);
            if (query == null || !query.moveToNext()) {
                return null;
            }
            Bitmap thumbnail = MediaStore.Video.Thumbnails.getThumbnail(this.f2030c, query.getInt(query.getColumnIndexOrThrow("_id")), 1, null);
            Log.d("SCREENRECORDER", "Retrieved thumbnail for file: " + file.getName());
            query.close();
            return thumbnail;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: e */
        public void onPostExecute(ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> arrayList) {
            if (arrayList.isEmpty()) {
                d.this.f2022b.setVisibility(8);
                d.this.f2023c.setVisibility(0);
            } else {
                Collections.sort(arrayList, Collections.reverseOrder());
                d.this.l(b(arrayList));
                d.this.f2022b.setVisibility(0);
                d.this.f2023c.setVisibility(8);
            }
            this.f2028a.cancel();
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: f */
        public void onProgressUpdate(Integer... numArr) {
            super.onProgressUpdate(numArr);
            this.f2028a.setProgress(numArr[0].intValue());
            Log.d("SCREENRECORDER", "Progress is :" + numArr[0]);
        }

        @Override // android.os.AsyncTask
        protected void onPreExecute() {
            super.onPreExecute();
            ProgressDialog progressDialog = new ProgressDialog(d.this.getActivity());
            this.f2028a = progressDialog;
            progressDialog.setTitle("Please wait");
            this.f2028a.setMessage("The videos are being loaded");
            this.f2028a.setCancelable(false);
            this.f2028a.setProgressStyle(1);
            this.f2028a.show();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        if (androidx.core.content.a.a(getActivity(), "android.permission.READ_EXTERNAL_STORAGE") != 0) {
            if (getActivity() instanceof ScreenRecorderActivity) {
                ((ScreenRecorderActivity) getActivity()).W(this);
                ((ScreenRecorderActivity) getActivity()).T();
            }
        } else if (this.e.isEmpty()) {
            File file = new File(this.f2024d.getString(getString(R.string.savelocation_key), com.ape.offlinescriptmanager.screenrecorder.a.f2012a));
            if (!file.exists()) {
                ScreenRecorderActivity.P();
                Log.d("SCREENRECORDER", "Directory missing! Creating dir");
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
    public static boolean j(String str) {
        String guessContentTypeFromName = URLConnection.guessContentTypeFromName(str);
        return guessContentTypeFromName != null && guessContentTypeFromName.startsWith("video");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void l(ArrayList<com.ape.offlinescriptmanager.screenrecorder.e.a> arrayList) {
        this.f2022b.setHasFixedSize(true);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getActivity(), 2);
        this.f2022b.setLayoutManager(gridLayoutManager);
        com.ape.offlinescriptmanager.screenrecorder.e.b bVar = new com.ape.offlinescriptmanager.screenrecorder.e.b(getActivity(), arrayList, this);
        this.f2022b.setAdapter(bVar);
        gridLayoutManager.W2(new b(this, bVar, gridLayoutManager));
    }

    @Override // com.ape.offlinescriptmanager.screenrecorder.b
    public void a(int i, String[] strArr, int[] iArr) {
        if (i != 1000) {
            return;
        }
        if (iArr.length > 0 && iArr[0] == 0) {
            Log.d("SCREENRECORDER", "Storage permission granted.");
            h();
            return;
        }
        Log.d("SCREENRECORDER", "Storage permission denied.");
        this.f2022b.setVisibility(8);
        this.f2023c.setText(R.string.video_list_permission_denied_message);
    }

    public void k() {
        this.e.clear();
        Log.d("SCREENRECORDER", "Reached video fragment");
    }

    @Override // android.app.Fragment
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        Log.d("SCREENRECORDER", "Refresh data after edit!");
        k();
        h();
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
        add.setOnMenuItemClickListener(new a());
    }

    @Override // android.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View inflate = layoutInflater.inflate(R.layout.fragment_videos, viewGroup, false);
        this.f2023c = (TextView) inflate.findViewById(R.id.message_tv);
        this.f2022b = (RecyclerView) inflate.findViewById(R.id.videos_rv);
        this.f2024d = PreferenceManager.getDefaultSharedPreferences(getActivity());
        return inflate;
    }

    @Override // android.app.Fragment
    public void setUserVisibleHint(boolean z) {
        super.setUserVisibleHint(z);
        if (z) {
            Log.d("SCREENRECORDER", "Videos fragment is visible load the videos");
            h();
        }
    }
}
