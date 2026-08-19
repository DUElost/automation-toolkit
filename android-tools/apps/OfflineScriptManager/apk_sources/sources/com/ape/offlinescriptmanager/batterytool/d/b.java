package com.ape.offlinescriptmanager.batterytool.d;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.ape.offlinescriptmanager.batterytool.f.c;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends com.ape.offlinescriptmanager.batterytool.d.a<c> {

    /* renamed from: c  reason: collision with root package name */
    private Context f1899c;

    /* loaded from: classes.dex */
    public class a {

        /* renamed from: a  reason: collision with root package name */
        public TextView f1900a;

        /* renamed from: b  reason: collision with root package name */
        public TextView f1901b;

        /* renamed from: c  reason: collision with root package name */
        public TextView f1902c;

        public a(b bVar) {
        }
    }

    public b(Context context, List<c> list) {
        super(list);
        this.f1899c = context;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        View view2;
        a aVar;
        if (getCount() == 0 || i >= getCount()) {
            return null;
        }
        if (view == null) {
            aVar = new a(this);
            view2 = LayoutInflater.from(this.f1899c).inflate(R.layout.listview_item, (ViewGroup) null);
            aVar.f1900a = (TextView) view2.findViewById(R.id.list_count);
            aVar.f1901b = (TextView) view2.findViewById(R.id.list_percentage_range);
            aVar.f1902c = (TextView) view2.findViewById(R.id.list_uesed_time);
            view2.setTag(aVar);
        } else {
            view2 = view;
            aVar = (a) view.getTag();
        }
        c cVar = (c) getItem(i);
        TextView textView = aVar.f1900a;
        textView.setText((i + 1) + BuildConfig.FLAVOR);
        TextView textView2 = aVar.f1901b;
        textView2.setText(this.f1899c.getString(R.string.text_range) + cVar.a());
        TextView textView3 = aVar.f1902c;
        textView3.setText(this.f1899c.getString(R.string.text_time) + cVar.c());
        return view2;
    }
}
