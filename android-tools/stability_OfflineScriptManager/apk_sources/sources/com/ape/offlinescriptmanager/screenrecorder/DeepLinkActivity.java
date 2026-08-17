package com.ape.offlinescriptmanager.screenrecorder;

import android.content.Intent;
import android.os.Bundle;
/* loaded from: classes.dex */
public class DeepLinkActivity extends androidx.appcompat.app.c {
    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        startActivity(new Intent(this, ScreenRecorderActivity.class));
        finish();
    }
}
