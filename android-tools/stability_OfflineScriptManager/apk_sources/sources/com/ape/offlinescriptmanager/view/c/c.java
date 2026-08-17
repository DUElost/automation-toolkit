package com.ape.offlinescriptmanager.view.c;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import b.b.a.a.d.f;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends com.jude.easyrecyclerview.d.a<f> {
    private TextView u;
    private TextView v;
    private f w;

    public c(View view) {
        super(view);
        this.u = (TextView) view.findViewById(R.id.task_name);
        this.v = (TextView) view.findViewById(R.id.task_times);
    }

    @Override // com.jude.easyrecyclerview.d.a
    /* renamed from: O */
    public void N(f fVar) {
        View view;
        Context M;
        int i;
        super.N(fVar);
        this.w = fVar;
        this.u.setText(fVar.d());
        this.v.setText(String.valueOf(fVar.l()));
        if (this.w.c()) {
            view = this.f1123b;
            M = M();
            i = R.color.md_light_green_500;
        } else {
            view = this.f1123b;
            M = M();
            i = R.color.md_blue_grey_500;
        }
        view.setBackgroundColor(androidx.core.content.a.b(M, i));
    }
}
