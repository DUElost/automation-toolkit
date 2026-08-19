package com.ape.offlinescriptmanager.view;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.c;
import java.io.File;
import java.io.PrintStream;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class UploadActivity extends c {
    private Button q;
    private Button r;
    private EditText s;
    private EditText t;
    private TextView u;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {
        a() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            UploadActivity.this.s.setText(BuildConfig.FLAVOR);
            UploadActivity.this.u.setVisibility(4);
            b.f.a.a aVar = new b.f.a.a();
            aVar.d(UploadActivity.this);
            aVar.g(1001);
            aVar.f(false);
            aVar.h("文件选择");
            aVar.e(new String[]{".xml"});
            aVar.c();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {
        b() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (TextUtils.isEmpty(UploadActivity.this.t.getText().toString())) {
                Toast.makeText(UploadActivity.this.getApplicationContext(), (int) R.string.no_uploader_name, 0).show();
            } else if (TextUtils.isEmpty(UploadActivity.this.s.getText().toString())) {
                Toast.makeText(UploadActivity.this.getApplicationContext(), (int) R.string.str_file_path_null, 0).show();
            } else if (!UploadActivity.R(UploadActivity.this)) {
                Toast.makeText(UploadActivity.this.getApplicationContext(), (int) R.string.str_wifi_off, 0).show();
            } else {
                UploadActivity.this.S();
                UploadActivity uploadActivity = UploadActivity.this;
                String O = uploadActivity.O(uploadActivity.s.getText().toString());
                RunTaskService runTaskService = new RunTaskService();
                if (runTaskService.n(runTaskService.k(O))) {
                    Map<String, Object> n = runTaskService.f2141d.n();
                    runTaskService.l(n, O, UploadActivity.this);
                    runTaskService.r(n);
                }
                UploadActivity.this.u.setVisibility(0);
                UploadActivity.this.s.setText(BuildConfig.FLAVOR);
            }
        }
    }

    private void P() {
        this.q.setOnClickListener(new a());
        this.r.setOnClickListener(new b());
    }

    private void Q() {
        this.q = (Button) findViewById(R.id.select_file);
        this.r = (Button) findViewById(R.id.upload);
        this.s = (EditText) findViewById(R.id.upload_file_path);
        this.t = (EditText) findViewById(R.id.tester_name);
        this.u = (TextView) findViewById(R.id.tv_upload_result);
    }

    public static boolean R(Context context) {
        NetworkInfo activeNetworkInfo = ((ConnectivityManager) context.getSystemService("connectivity")).getActiveNetworkInfo();
        return activeNetworkInfo != null && activeNetworkInfo.getType() == 1;
    }

    public String O(String str) {
        String str2;
        System.out.println("entry getTimestamp function");
        if (str != null) {
            String[] split = str.split(File.separator);
            if (split.length - 2 >= 0) {
                str2 = split[split.length - 2];
                PrintStream printStream = System.out;
                printStream.println("The timeStamp is : " + str2);
                return str2;
            }
        }
        str2 = BuildConfig.FLAVOR;
        PrintStream printStream2 = System.out;
        printStream2.println("The timeStamp is : " + str2);
        return str2;
    }

    public void S() {
        SharedPreferences.Editor edit = getSharedPreferences("test_task_data", 0).edit();
        edit.putString("task_creator", this.t.getText().toString().trim());
        edit.commit();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i2 == -1 && i == 1001) {
            for (String str : intent.getStringArrayListExtra(b.f.a.j.a.f1626a)) {
                if (str.contains("TESTS-RealResult-TestPoints")) {
                    this.s.setText(str);
                } else {
                    Toast.makeText(getApplicationContext(), (int) R.string.str_is_not_restult_file, 0).show();
                }
                PrintStream printStream = System.out;
                printStream.println("The file path is :" + str);
            }
        }
    }

    @Override // androidx.appcompat.app.c, androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.function_result_upload);
        Q();
        P();
    }
}
