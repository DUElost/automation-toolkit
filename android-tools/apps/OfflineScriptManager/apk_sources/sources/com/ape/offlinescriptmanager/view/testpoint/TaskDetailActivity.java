package com.ape.offlinescriptmanager.view.testpoint;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.fragment.app.j;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class TaskDetailActivity extends androidx.appcompat.app.c {
    String q;
    private a r;

    private void L(Bundle bundle) {
        setContentView(R.layout.activity_task_detail);
        this.r = a.n1();
        Bundle bundle2 = new Bundle();
        bundle2.putString("TASK", this.q);
        this.r.Z0(bundle2);
        j a2 = s().a();
        a2.i(R.id.task_detail_container, this.r, "TaskFragment");
        a2.e();
    }

    public static void M(Context context, String str) {
        Intent intent = new Intent(context, TaskDetailActivity.class);
        intent.putExtra("intent_key_task", str);
        context.startActivity(intent);
    }

    @Override // androidx.fragment.app.b, android.app.Activity
    public void onBackPressed() {
        if (s().e() <= 0) {
            finish();
        } else {
            s().h();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.q = getIntent().getStringExtra("intent_key_task");
        L(bundle);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, android.app.Activity
    public void onDestroy() {
        super.onDestroy();
    }
}
