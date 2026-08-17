package b.f.a.g;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;
import b.f.a.f;
import java.io.File;
import java.io.FileFilter;
import java.util.List;
/* loaded from: classes.dex */
public class a extends RecyclerView.g<e> {

    /* renamed from: c  reason: collision with root package name */
    private List<File> f1613c;

    /* renamed from: d  reason: collision with root package name */
    private Context f1614d;
    public d e;
    private FileFilter f;
    private boolean[] g;
    private boolean h;
    private int i;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: b.f.a.g.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0053a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ File f1615b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ e f1616c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ int f1617d;

        View$OnClickListenerC0053a(File file, e eVar, int i) {
            this.f1615b = file;
            this.f1616c = eVar;
            this.f1617d = i;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            if (this.f1615b.isFile()) {
                this.f1616c.y.setChecked(!this.f1616c.y.isChecked());
            }
            a.this.e.a(this.f1617d);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f1618b;

        b(int i) {
            this.f1618b = i;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            a.this.e.a(this.f1618b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements CompoundButton.OnCheckedChangeListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ int f1620a;

        c(int i) {
            this.f1620a = i;
        }

        @Override // android.widget.CompoundButton.OnCheckedChangeListener
        public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
            a.this.g[this.f1620a] = z;
        }
    }

    /* loaded from: classes.dex */
    public interface d {
        void a(int i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e extends RecyclerView.c0 {
        private RelativeLayout u;
        private ImageView v;
        private TextView w;
        private TextView x;
        private CheckBox y;

        public e(a aVar, View view) {
            super(view);
            this.v = (ImageView) view.findViewById(b.f.a.b.iv_type);
            this.u = (RelativeLayout) view.findViewById(b.f.a.b.layout_item_root);
            this.w = (TextView) view.findViewById(b.f.a.b.tv_name);
            this.x = (TextView) view.findViewById(b.f.a.b.tv_detail);
            this.y = (CheckBox) view.findViewById(b.f.a.b.cb_choose);
        }
    }

    public a(List<File> list, Context context, FileFilter fileFilter, boolean z) {
        this.f1613c = list;
        this.f1614d = context;
        this.f = fileFilter;
        this.h = z;
        this.g = new boolean[list.size()];
    }

    private void C(ImageView imageView) {
        int i;
        int i2 = this.i;
        if (i2 == 0) {
            i = b.f.a.e.file_style_yellow;
        } else if (i2 == 1) {
            i = b.f.a.e.file_style_blue;
        } else if (i2 != 2) {
            return;
        } else {
            i = b.f.a.e.file_style_green;
        }
        imageView.setBackgroundResource(i);
    }

    private void D(ImageView imageView) {
        int i;
        int i2 = this.i;
        if (i2 == 0) {
            i = b.f.a.e.folder_style_yellow;
        } else if (i2 == 1) {
            i = b.f.a.e.folder_style_blue;
        } else if (i2 != 2) {
            return;
        } else {
            i = b.f.a.e.folder_style_green;
        }
        imageView.setBackgroundResource(i);
    }

    public void A(List<File> list) {
        this.f1613c = list;
        this.g = new boolean[list.size()];
    }

    public void B(boolean z) {
        int i = 0;
        while (true) {
            boolean[] zArr = this.g;
            if (i >= zArr.length) {
                g();
                return;
            } else {
                zArr[i] = z;
                i++;
            }
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int c() {
        return this.f1613c.size();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: w */
    public void l(e eVar, int i) {
        File file = this.f1613c.get(i);
        if (file.isFile()) {
            C(eVar.v);
            eVar.w.setText(file.getName());
            TextView textView = eVar.x;
            textView.setText(this.f1614d.getString(f.FileSize) + " " + b.f.a.j.c.b(file.length()));
            eVar.y.setVisibility(0);
        } else {
            D(eVar.v);
            eVar.w.setText(file.getName());
            File[] listFiles = file.listFiles(this.f);
            if (listFiles == null) {
                TextView textView2 = eVar.x;
                textView2.setText("0 " + this.f1614d.getString(f.LItem));
            } else {
                TextView textView3 = eVar.x;
                textView3.setText(listFiles.length + " " + this.f1614d.getString(f.LItem));
            }
            eVar.y.setVisibility(8);
        }
        if (!this.h) {
            eVar.y.setVisibility(8);
        }
        eVar.u.setOnClickListener(new View$OnClickListenerC0053a(file, eVar, i));
        eVar.y.setOnClickListener(new b(i));
        eVar.y.setOnCheckedChangeListener(null);
        eVar.y.setChecked(this.g[i]);
        eVar.y.setOnCheckedChangeListener(new c(i));
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: x */
    public e n(ViewGroup viewGroup, int i) {
        return new e(this, View.inflate(this.f1614d, b.f.a.c.listitem, null));
    }

    public void y(d dVar) {
        this.e = dVar;
    }

    public void z(int i) {
        this.i = i;
    }
}
