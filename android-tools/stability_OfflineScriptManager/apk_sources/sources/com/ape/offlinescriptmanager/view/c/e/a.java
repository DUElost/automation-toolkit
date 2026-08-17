package com.ape.offlinescriptmanager.view.c.e;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;
import b.h.a.a.c.a;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends a.AbstractC0055a<String> {
    private final View f;
    private CheckBox g;
    private TextView h;
    private String i;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.view.c.e.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0087a implements CompoundButton.OnCheckedChangeListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ b.h.a.a.c.a f2164a;

        C0087a(b.h.a.a.c.a aVar) {
            this.f2164a = aVar;
        }

        @Override // android.widget.CompoundButton.OnCheckedChangeListener
        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
            this.f2164a.t(z);
            a.this.o(true);
        }
    }

    public a(Context context) {
        super(context);
        View inflate = LayoutInflater.from(context).inflate(R.layout.holder_case_node, (ViewGroup) null, false);
        this.f = inflate;
        this.g = (CheckBox) inflate.findViewById(R.id.node_selector);
        this.h = (TextView) inflate.findViewById(R.id.node_value);
    }

    @Override // b.h.a.a.c.a.AbstractC0055a
    public void m(boolean z) {
        this.g.setVisibility(z ? 0 : 4);
        this.g.setChecked(this.f1664b.o());
    }

    @Override // b.h.a.a.c.a.AbstractC0055a
    /* renamed from: n */
    public View c(b.h.a.a.c.a aVar, String str) {
        this.i = str;
        this.g.setOnCheckedChangeListener(new C0087a(aVar));
        if (aVar.l()) {
            this.f.findViewById(R.id.bot_line).setVisibility(4);
        }
        this.h.setText(this.i);
        return this.f;
    }

    public void o(boolean z) {
        ((b) this.f1664b.h().j()).L(z);
    }
}
