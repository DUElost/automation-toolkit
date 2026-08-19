package com.ape.offlinescriptmanager.batterytool;

import android.app.ListActivity;
import android.content.CursorLoader;
import android.database.Cursor;
import android.os.Bundle;
import android.widget.SimpleCursorAdapter;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class HopDataShowActivity extends ListActivity {

    /* renamed from: b  reason: collision with root package name */
    Cursor f1882b;

    /* renamed from: c  reason: collision with root package name */
    CursorLoader f1883c;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.hopdata_layout);
        CursorLoader cursorLoader = new CursorLoader(this, com.ape.offlinescriptmanager.database.b.f1973a, com.ape.offlinescriptmanager.database.b.f1974b, null, null, "_id ASC");
        this.f1883c = cursorLoader;
        this.f1882b = cursorLoader.loadInBackground();
        setListAdapter(new SimpleCursorAdapter(this, 17367044, this.f1882b, new String[]{"hop_range", "hop_time"}, new int[]{16908308, 16908309}));
    }

    @Override // android.app.ListActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        Cursor cursor = this.f1882b;
        if (cursor != null) {
            cursor.close();
        }
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
    }
}
