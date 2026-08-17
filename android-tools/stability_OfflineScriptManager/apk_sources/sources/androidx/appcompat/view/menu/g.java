package androidx.appcompat.view.menu;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import androidx.appcompat.view.menu.p;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class g extends BaseAdapter {

    /* renamed from: b  reason: collision with root package name */
    h f554b;

    /* renamed from: c  reason: collision with root package name */
    private int f555c = -1;

    /* renamed from: d  reason: collision with root package name */
    private boolean f556d;
    private final boolean e;
    private final LayoutInflater f;
    private final int g;

    public g(h hVar, LayoutInflater layoutInflater, boolean z, int i) {
        this.e = z;
        this.f = layoutInflater;
        this.f554b = hVar;
        this.g = i;
        a();
    }

    void a() {
        j v = this.f554b.v();
        if (v != null) {
            ArrayList<j> z = this.f554b.z();
            int size = z.size();
            for (int i = 0; i < size; i++) {
                if (z.get(i) == v) {
                    this.f555c = i;
                    return;
                }
            }
        }
        this.f555c = -1;
    }

    public h b() {
        return this.f554b;
    }

    @Override // android.widget.Adapter
    /* renamed from: c */
    public j getItem(int i) {
        ArrayList<j> z = this.e ? this.f554b.z() : this.f554b.E();
        int i2 = this.f555c;
        if (i2 >= 0 && i >= i2) {
            i++;
        }
        return z.get(i);
    }

    public void d(boolean z) {
        this.f556d = z;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        ArrayList<j> z = this.e ? this.f554b.z() : this.f554b.E();
        int i = this.f555c;
        int size = z.size();
        return i < 0 ? size : size - 1;
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        if (view == null) {
            view = this.f.inflate(this.g, viewGroup, false);
        }
        int groupId = getItem(i).getGroupId();
        int i2 = i - 1;
        ListMenuItemView listMenuItemView = (ListMenuItemView) view;
        listMenuItemView.setGroupDividerEnabled(this.f554b.F() && groupId != (i2 >= 0 ? getItem(i2).getGroupId() : groupId));
        p.a aVar = (p.a) view;
        if (this.f556d) {
            listMenuItemView.setForceShowIcon(true);
        }
        aVar.e(getItem(i), 0);
        return view;
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        a();
        super.notifyDataSetChanged();
    }
}
