package com.ape.offlinescriptmanager.view.c.e;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;
import b.b.a.a.d.f;
import com.github.johnkil.print.PrintView;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends c {
    private TextView n;
    private PrintView o;
    private CheckBox p;
    private boolean q;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements CompoundButton.OnCheckedChangeListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ b.h.a.a.c.a f2166a;

        a(b.h.a.a.c.a aVar) {
            this.f2166a = aVar;
        }

        @Override // android.widget.CompoundButton.OnCheckedChangeListener
        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
            b.this.q = true;
            this.f2166a.t(z);
            for (b.h.a.a.c.a aVar : this.f2166a.d()) {
                b.this.g().s(aVar, z);
            }
        }
    }

    public b(Context context) {
        super(context);
    }

    public void L(boolean z) {
        ((c) this.f1664b.h().j()).y().sendEmptyMessage(1001);
    }

    @Override // com.ape.offlinescriptmanager.view.c.e.c, com.ape.offlinescriptmanager.view.c.e.d
    public String a() {
        return this.n.getText().toString();
    }

    @Override // com.ape.offlinescriptmanager.view.c.e.c, com.ape.offlinescriptmanager.view.c.e.d
    public void b(String str) {
        this.n.setText(str);
    }

    @Override // b.h.a.a.c.a.AbstractC0055a
    public void l(boolean z) {
        PrintView printView = this.o;
        if (printView == null) {
            return;
        }
        printView.setIconText(this.e.getResources().getString(z ? R.string.ic_keyboard_arrow_down : R.string.ic_keyboard_arrow_right));
        if (!z || g().p()) {
            return;
        }
        for (b.h.a.a.c.a aVar : this.f1664b.d()) {
            ((com.ape.offlinescriptmanager.view.c.e.a) aVar.j()).m(false);
        }
    }

    @Override // b.h.a.a.c.a.AbstractC0055a
    public void m(boolean z) {
        this.p.setVisibility(z ? 0 : 8);
        this.p.setChecked(this.f1664b.o());
    }

    @Override // com.ape.offlinescriptmanager.view.c.e.c, b.h.a.a.c.a.AbstractC0055a
    @SuppressLint({"DefaultLocale"})
    /* renamed from: x */
    public View c(b.h.a.a.c.a aVar, f.a aVar2) {
        this.f = aVar2.f1403b;
        View inflate = LayoutInflater.from(this.e).inflate(R.layout.holder_point_node, (ViewGroup) null, false);
        CheckBox checkBox = (CheckBox) inflate.findViewById(R.id.node_selector);
        this.p = checkBox;
        checkBox.setOnCheckedChangeListener(new a(aVar));
        this.p.setChecked(aVar.o());
        this.o = (PrintView) inflate.findViewById(R.id.arrow_icon);
        if (aVar.m()) {
            this.o.setVisibility(4);
        }
        ((PrintView) inflate.findViewById(R.id.icon)).setIconText(this.e.getResources().getString(aVar2.f1402a));
        ((TextView) inflate.findViewById(R.id.number)).setText(String.format("%02d.", Integer.valueOf(aVar.f())));
        TextView textView = (TextView) inflate.findViewById(R.id.node_text);
        this.n = textView;
        textView.setText(this.f);
        return inflate;
    }
}
