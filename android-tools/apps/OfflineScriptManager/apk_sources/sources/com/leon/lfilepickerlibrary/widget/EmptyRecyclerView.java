package com.leon.lfilepickerlibrary.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import androidx.recyclerview.widget.RecyclerView;
/* loaded from: classes.dex */
public class EmptyRecyclerView extends RecyclerView {
    private View K0;
    RecyclerView.i L0;

    /* loaded from: classes.dex */
    class a extends RecyclerView.i {
        a() {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void a() {
            super.a();
            EmptyRecyclerView.this.v1();
        }
    }

    public EmptyRecyclerView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.L0 = new a();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void v1() {
        if (this.K0 == null && getAdapter() == null) {
            return;
        }
        this.K0.setVisibility(getAdapter().c() > 0 ? 8 : 0);
    }

    @Override // androidx.recyclerview.widget.RecyclerView
    public void setAdapter(RecyclerView.g gVar) {
        RecyclerView.g adapter = getAdapter();
        if (adapter != null) {
            adapter.u(this.L0);
        }
        super.setAdapter(gVar);
        if (gVar != null) {
            gVar.t(this.L0);
        }
    }

    public void setmEmptyView(View view) {
        this.K0 = view;
        v1();
    }
}
