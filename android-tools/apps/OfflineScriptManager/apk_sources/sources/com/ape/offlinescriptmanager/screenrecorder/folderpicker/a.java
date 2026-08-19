package com.ape.offlinescriptmanager.screenrecorder.folderpicker;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;
import java.io.File;
import java.util.ArrayList;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
class a extends RecyclerView.g<b> {

    /* renamed from: d  reason: collision with root package name */
    private static c f2053d;

    /* renamed from: c  reason: collision with root package name */
    private ArrayList<File> f2054c;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.screenrecorder.folderpicker.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class View$OnClickListenerC0080a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ b f2055b;

        View$OnClickListenerC0080a(b bVar) {
            this.f2055b = bVar;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            Log.d("SCREENRECORDER", "Item clicked: " + a.this.f2054c.get(this.f2055b.j()));
            a.f2053d.a((File) a.this.f2054c.get(this.f2055b.j()));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b extends RecyclerView.c0 {
        TextView u;

        public b(View view) {
            super(view);
            this.u = (TextView) view.findViewById(R.id.directory);
            LinearLayout linearLayout = (LinearLayout) view.findViewById(R.id.directory_view);
        }
    }

    /* loaded from: classes.dex */
    interface c {
        void a(File file);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(Context context, c cVar, ArrayList<File> arrayList) {
        f2053d = cVar;
        this.f2054c = arrayList;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public int c() {
        return this.f2054c.size();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: x */
    public void l(b bVar, int i) {
        bVar.u.setText(this.f2054c.get(i).getName());
        bVar.u.setOnClickListener(new View$OnClickListenerC0080a(bVar));
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: y */
    public b n(ViewGroup viewGroup, int i) {
        return new b(LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.content_directory_chooser, viewGroup, false));
    }
}
