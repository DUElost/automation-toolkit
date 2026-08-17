package com.ape.offlinescriptmanager.view.testcase;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class d extends com.jude.easyrecyclerview.d.d<b.b.a.a.d.c> {
    public d(Context context) {
        super(context);
    }

    @Override // com.jude.easyrecyclerview.d.d
    public com.jude.easyrecyclerview.d.a w(ViewGroup viewGroup, int i) {
        return new c(LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.item_testcase, viewGroup, false));
    }
}
