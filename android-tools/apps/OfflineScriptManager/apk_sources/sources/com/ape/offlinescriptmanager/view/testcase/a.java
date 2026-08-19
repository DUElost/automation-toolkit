package com.ape.offlinescriptmanager.view.testcase;

import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a extends com.jude.easyrecyclerview.d.d<b.b.a.a.d.b> {
    private Context l;

    /* renamed from: com.ape.offlinescriptmanager.view.testcase.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0089a {
        void e(int i, String str, String str2);

        void l(int i);
    }

    /* loaded from: classes.dex */
    public class b extends com.jude.easyrecyclerview.d.a<b.b.a.a.d.b> {
        private final EditText u;
        private final EditText v;
        private final ImageButton w;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: com.ape.offlinescriptmanager.view.testcase.a$b$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public class View$OnClickListenerC0090a implements View.OnClickListener {
            View$OnClickListenerC0090a() {
            }

            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                InterfaceC0089a interfaceC0089a = (InterfaceC0089a) a.this.l;
                if (view != null) {
                    interfaceC0089a.l(Integer.parseInt(b.this.w.getTag().toString()));
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: com.ape.offlinescriptmanager.view.testcase.a$b$b  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public class C0091b implements TextWatcher {

            /* renamed from: b  reason: collision with root package name */
            private b f2188b;

            public C0091b(b bVar) {
                this.f2188b = bVar;
            }

            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                InterfaceC0089a interfaceC0089a = (InterfaceC0089a) a.this.l;
                if (editable != null) {
                    interfaceC0089a.e(Integer.parseInt(this.f2188b.u.getTag().toString()), this.f2188b.u.getText().toString(), this.f2188b.v.getText().toString());
                }
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }
        }

        public b(View view) {
            super(view);
            this.u = (EditText) view.findViewById(R.id.arg_name_et);
            this.v = (EditText) view.findViewById(R.id.arg_value_et);
            this.w = (ImageButton) view.findViewById(R.id.arg_item_delete_btn);
        }

        @Override // com.jude.easyrecyclerview.d.a
        /* renamed from: R */
        public void N(b.b.a.a.d.b bVar) {
            super.N(bVar);
            this.u.setText(bVar.f1396b);
            this.v.setText(String.valueOf(bVar.f1397c));
            this.u.addTextChangedListener(new C0091b(this));
            this.u.setTag(Integer.valueOf(o()));
            this.v.addTextChangedListener(new C0091b(this));
            this.v.setTag(Integer.valueOf(o()));
            this.w.setTag(Integer.valueOf(o()));
            this.w.setOnClickListener(new View$OnClickListenerC0090a());
        }
    }

    public a(Context context) {
        super(context);
        this.l = context;
    }

    @Override // com.jude.easyrecyclerview.d.d
    public com.jude.easyrecyclerview.d.a w(ViewGroup viewGroup, int i) {
        return new b(LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.item_case_arg, viewGroup, false));
    }
}
