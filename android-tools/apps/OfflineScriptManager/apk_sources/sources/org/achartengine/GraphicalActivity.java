package org.achartengine;

import android.app.Activity;
import android.os.Bundle;
/* loaded from: classes.dex */
public class GraphicalActivity extends Activity {

    /* renamed from: b  reason: collision with root package name */
    private b f2764b;

    /* renamed from: c  reason: collision with root package name */
    private org.achartengine.f.a f2765c;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Bundle extras = getIntent().getExtras();
        this.f2765c = (org.achartengine.f.a) extras.getSerializable("chart");
        this.f2764b = new b(this, this.f2765c);
        String string = extras.getString("title");
        if (string == null) {
            requestWindowFeature(1);
        } else if (string.length() > 0) {
            setTitle(string);
        }
        setContentView(this.f2764b);
    }
}
