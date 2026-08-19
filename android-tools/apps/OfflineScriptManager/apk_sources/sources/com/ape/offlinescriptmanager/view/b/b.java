package com.ape.offlinescriptmanager.view.b;

import android.view.View;
import android.widget.TextView;
import b.b.a.a.d.f;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends com.jude.easyrecyclerview.d.a<f> implements View.OnClickListener {
    private TextView u;
    private TextView v;

    public b(View view) {
        super(view);
        this.u = (TextView) view.findViewById(R.id.task_name);
        this.v = (TextView) view.findViewById(R.id.task_times);
    }

    @Override // com.jude.easyrecyclerview.d.a
    /* renamed from: O */
    public void N(f fVar) {
        super.N(fVar);
        this.u.setText(fVar.d());
        this.v.setText(fVar.l());
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
    }
}
