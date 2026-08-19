package com.ape.offlinescriptmanager.view.testpoint;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import b.b.a.a.d.h;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends com.jude.easyrecyclerview.d.a<h> implements View.OnClickListener {
    private TextView u;
    private TextView v;
    private TextView w;

    public b(View view) {
        super(view);
        this.u = (TextView) view.findViewById(R.id.testpoint_name);
        this.v = (TextView) view.findViewById(R.id.testpoint_times);
        this.w = (TextView) view.findViewById(R.id.testcase_summery);
    }

    @Override // com.jude.easyrecyclerview.d.a
    /* renamed from: O */
    public void N(h hVar) {
        View view;
        Context M;
        int i;
        super.N(hVar);
        this.u.setText(hVar.m());
        this.v.setText(String.valueOf(hVar.a()));
        this.w.setText(String.valueOf(hVar.n().size()));
        if (hVar.j()) {
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

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
    }
}
