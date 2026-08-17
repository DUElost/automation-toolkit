package com.ape.offlinescriptmanager.screenrecorder;

import android.app.ProgressDialog;
import android.media.MediaMetadataRetriever;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import java.io.File;
import java.util.ArrayList;
import life.knowledge4.videotrimmer.K4LVideoTrimmer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class EditVideoActivity extends androidx.appcompat.app.c implements life.knowledge4.videotrimmer.g.c {
    private ProgressDialog q;

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            EditVideoActivity.this.q = new ProgressDialog(EditVideoActivity.this);
            EditVideoActivity.this.q.setMessage("Please wait while the video is being saved");
            EditVideoActivity.this.q.setTitle("Please wait");
            EditVideoActivity.this.q.setIndeterminate(true);
            EditVideoActivity.this.q.show();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements MediaScannerConnection.OnScanCompletedListener {
        b() {
        }

        @Override // android.media.MediaScannerConnection.OnScanCompletedListener
        public void onScanCompleted(String str, Uri uri) {
            Log.i("SCREENRECORDER", "SCAN COMPLETED: " + str);
            EditVideoActivity.this.q.cancel();
            EditVideoActivity.this.setResult(1005);
            EditVideoActivity.this.finish();
        }
    }

    private void N(String str) {
        ArrayList arrayList = new ArrayList();
        arrayList.add(str);
        MediaScannerConnection.scanFile(this, (String[]) arrayList.toArray(new String[arrayList.size()]), null, new b());
    }

    @Override // life.knowledge4.videotrimmer.g.c
    public void d() {
        finish();
    }

    @Override // life.knowledge4.videotrimmer.g.c
    public void m(Uri uri) {
        Log.d("SCREENRECORDER", uri.getPath());
        N(uri.getPath());
        runOnUiThread(new a());
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_edit_video);
        if (!getIntent().hasExtra("edit_video")) {
            Toast.makeText(this, "Picture not found. Please try again", 0).show();
            finish();
        }
        Uri parse = Uri.parse(getIntent().getStringExtra("edit_video"));
        K4LVideoTrimmer k4LVideoTrimmer = (K4LVideoTrimmer) findViewById(R.id.videoTimeLine);
        MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
        mediaMetadataRetriever.setDataSource(this, parse);
        int parseLong = (((int) Long.parseLong(mediaMetadataRetriever.extractMetadata(9))) / 1000) + 1000;
        Log.d("SCREENRECORDER", parseLong + BuildConfig.FLAVOR);
        File file = new File(parse.getPath());
        k4LVideoTrimmer.setOnTrimVideoListener(this);
        k4LVideoTrimmer.setVideoURI(parse);
        k4LVideoTrimmer.setMaxDuration(parseLong);
        Log.d("SCREENRECORDER", "Edited file save name: " + file.getAbsolutePath());
        k4LVideoTrimmer.setDestinationPath(file.getParent() + "/");
    }
}
