package com.ape.offlinescriptmanager.view.a;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.EditText;
import b.a.a.f;
import b.a.a.p;
import b.b.a.a.d.f;
import com.ape.offlinescriptmanager.utils.m.g;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private Context f2146a;

    /* renamed from: b  reason: collision with root package name */
    private f f2147b;

    /* renamed from: com.ape.offlinescriptmanager.view.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class C0083a implements f.m {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ CheckBox f2148a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ EditText f2149b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ EditText f2150c;

        C0083a(CheckBox checkBox, EditText editText, EditText editText2) {
            this.f2148a = checkBox;
            this.f2149b = editText;
            this.f2150c = editText2;
        }

        @Override // b.a.a.f.m
        public void a(b.a.a.f fVar, b.a.a.b bVar) {
            a.this.f2147b.n(this.f2148a.isChecked());
            a.this.f2147b.o(this.f2149b.getText().toString());
            a.this.f2147b.w(Integer.valueOf(this.f2150c.getText().toString()).intValue());
            a aVar = a.this;
            aVar.c(aVar.f2147b);
        }
    }

    /* loaded from: classes.dex */
    class b implements f.m {
        b(a aVar) {
        }

        @Override // b.a.a.f.m
        public void a(b.a.a.f fVar, b.a.a.b bVar) {
        }
    }

    public a(Context context, b.b.a.a.d.f fVar) {
        this.f2146a = context;
        if (fVar == null) {
            this.f2147b = new b.b.a.a.d.f();
        } else {
            this.f2147b = fVar;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(b.b.a.a.d.f fVar) {
        new g(fVar).k();
    }

    public static b.a.a.f d(Context context, String str, View view, f.m mVar, f.m mVar2) {
        f.d dVar = new f.d(context);
        dVar.m(str);
        dVar.d(view, true);
        dVar.j(R.string.edit_dialog_positive);
        dVar.f(R.string.edit_dialog_negative);
        dVar.i(mVar);
        dVar.h(mVar2);
        dVar.l(p.LIGHT);
        dVar.n(androidx.core.content.a.b(context, R.color.md_black));
        return dVar.a();
    }

    public void e() {
        View inflate = LayoutInflater.from(this.f2146a).inflate(R.layout.dialog_task_edit, (ViewGroup) null);
        CheckBox checkBox = (CheckBox) inflate.findViewById(R.id.dialog_task_edit_selecter);
        EditText editText = (EditText) inflate.findViewById(R.id.dialog_task_edit_name_et);
        EditText editText2 = (EditText) inflate.findViewById(R.id.dialog_task_edit_times_et);
        if (this.f2147b.d() != null) {
            editText.setText(this.f2147b.d());
        }
        checkBox.setChecked(this.f2147b.c());
        editText2.setText(String.valueOf(this.f2147b.l()));
        Context context = this.f2146a;
        d(context, context.getString(R.string.edit_task), inflate, new C0083a(checkBox, editText, editText2), new b(this)).show();
    }
}
