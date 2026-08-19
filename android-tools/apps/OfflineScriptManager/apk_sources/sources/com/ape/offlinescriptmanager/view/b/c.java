package com.ape.offlinescriptmanager.view.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import b.b.a.a.d.f;
import com.jude.easyrecyclerview.d.d;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class c extends d<f> {
    public c(Context context) {
        super(context);
    }

    @Override // com.jude.easyrecyclerview.d.d
    public com.jude.easyrecyclerview.d.a w(ViewGroup viewGroup, int i) {
        return new b(LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.item_task, viewGroup, false));
    }
}
