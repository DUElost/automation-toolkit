package com.ape.offlinescriptmanager.view.testcase;

import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends com.jude.easyrecyclerview.d.a<b.b.a.a.d.c> implements View.OnClickListener {
    private TextView A;
    private CheckBox B;
    private TextView u;
    private TextView v;
    private TextView w;
    private TextView x;
    private TextView y;
    private TextView z;

    public c(View view) {
        super(view);
        this.u = (TextView) view.findViewById(R.id.type_name);
        this.v = (TextView) view.findViewById(R.id.testcase_times);
        this.w = (TextView) view.findViewById(R.id.apk_name);
        this.x = (TextView) view.findViewById(R.id.pkg_name);
        this.y = (TextView) view.findViewById(R.id.class_name);
        this.z = (TextView) view.findViewById(R.id.method_name);
        this.A = (TextView) view.findViewById(R.id.description_name);
        this.B = (CheckBox) view.findViewById(R.id.testcase_selecter);
    }

    @Override // com.jude.easyrecyclerview.d.a
    /* renamed from: O */
    public void N(b.b.a.a.d.c cVar) {
        super.N(cVar);
        this.u.setText(cVar.getType());
        this.v.setText(String.valueOf(cVar.a()));
        this.w.setText(cVar.h());
        this.x.setText(cVar.k());
        this.y.setText(cVar.k());
        this.z.setText(cVar.b());
        this.A.setText(cVar.i());
        this.B.setChecked(cVar.j());
        this.B.setClickable(false);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
    }
}
