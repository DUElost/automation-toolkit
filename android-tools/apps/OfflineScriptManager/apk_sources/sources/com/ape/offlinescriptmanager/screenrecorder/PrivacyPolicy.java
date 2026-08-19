package com.ape.offlinescriptmanager.screenrecorder;

import android.os.Bundle;
import android.view.MenuItem;
import android.webkit.WebView;
import com.ape.offlinescriptmanager.utils.g;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class PrivacyPolicy extends androidx.appcompat.app.c {
    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        g.A();
        setContentView(R.layout.activity_privacy_policy);
        androidx.appcompat.app.a C = C();
        if (C != null) {
            C.s(true);
        }
        ((WebView) findViewById(R.id.wv_privacy_policy)).loadUrl("file:///android_asset/privacy_policy.html");
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        if (menuItem.getItemId() != 16908332) {
            return super.onOptionsItemSelected(menuItem);
        }
        finish();
        return true;
    }
}
