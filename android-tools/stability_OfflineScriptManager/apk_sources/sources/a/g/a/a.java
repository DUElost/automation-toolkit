package a.g.a;

import a.g.a.b;
import android.content.Context;
import android.database.ContentObserver;
import android.database.Cursor;
import android.database.DataSetObserver;
import android.os.Handler;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
/* loaded from: classes.dex */
public abstract class a extends BaseAdapter implements Filterable, b.a {

    /* renamed from: b  reason: collision with root package name */
    protected boolean f215b;

    /* renamed from: c  reason: collision with root package name */
    protected boolean f216c;

    /* renamed from: d  reason: collision with root package name */
    protected Cursor f217d;
    protected Context e;
    protected int f;
    protected C0013a g;
    protected DataSetObserver h;
    protected a.g.a.b i;

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: a.g.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0013a extends ContentObserver {
        C0013a() {
            super(new Handler());
        }

        @Override // android.database.ContentObserver
        public boolean deliverSelfNotifications() {
            return true;
        }

        @Override // android.database.ContentObserver
        public void onChange(boolean z) {
            a.this.i();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class b extends DataSetObserver {
        b() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            a aVar = a.this;
            aVar.f215b = true;
            aVar.notifyDataSetChanged();
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            a aVar = a.this;
            aVar.f215b = false;
            aVar.notifyDataSetInvalidated();
        }
    }

    public a(Context context, Cursor cursor, boolean z) {
        f(context, cursor, z ? 1 : 2);
    }

    @Override // a.g.a.b.a
    public abstract CharSequence a(Cursor cursor);

    @Override // a.g.a.b.a
    public void b(Cursor cursor) {
        Cursor j = j(cursor);
        if (j != null) {
            j.close();
        }
    }

    @Override // a.g.a.b.a
    public Cursor c() {
        return this.f217d;
    }

    public abstract void e(View view, Context context, Cursor cursor);

    void f(Context context, Cursor cursor, int i) {
        b bVar;
        if ((i & 1) == 1) {
            i |= 2;
            this.f216c = true;
        } else {
            this.f216c = false;
        }
        boolean z = cursor != null;
        this.f217d = cursor;
        this.f215b = z;
        this.e = context;
        this.f = z ? cursor.getColumnIndexOrThrow("_id") : -1;
        if ((i & 2) == 2) {
            this.g = new C0013a();
            bVar = new b();
        } else {
            bVar = null;
            this.g = null;
        }
        this.h = bVar;
        if (z) {
            C0013a c0013a = this.g;
            if (c0013a != null) {
                cursor.registerContentObserver(c0013a);
            }
            DataSetObserver dataSetObserver = this.h;
            if (dataSetObserver != null) {
                cursor.registerDataSetObserver(dataSetObserver);
            }
        }
    }

    public abstract View g(Context context, Cursor cursor, ViewGroup viewGroup);

    @Override // android.widget.Adapter
    public int getCount() {
        Cursor cursor;
        if (!this.f215b || (cursor = this.f217d) == null) {
            return 0;
        }
        return cursor.getCount();
    }

    @Override // android.widget.BaseAdapter, android.widget.SpinnerAdapter
    public View getDropDownView(int i, View view, ViewGroup viewGroup) {
        if (this.f215b) {
            this.f217d.moveToPosition(i);
            if (view == null) {
                view = g(this.e, this.f217d, viewGroup);
            }
            e(view, this.e, this.f217d);
            return view;
        }
        return null;
    }

    @Override // android.widget.Filterable
    public Filter getFilter() {
        if (this.i == null) {
            this.i = new a.g.a.b(this);
        }
        return this.i;
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        Cursor cursor;
        if (!this.f215b || (cursor = this.f217d) == null) {
            return null;
        }
        cursor.moveToPosition(i);
        return this.f217d;
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        Cursor cursor;
        if (this.f215b && (cursor = this.f217d) != null && cursor.moveToPosition(i)) {
            return this.f217d.getLong(this.f);
        }
        return 0L;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        if (this.f215b) {
            if (this.f217d.moveToPosition(i)) {
                if (view == null) {
                    view = h(this.e, this.f217d, viewGroup);
                }
                e(view, this.e, this.f217d);
                return view;
            }
            throw new IllegalStateException("couldn't move cursor to position " + i);
        }
        throw new IllegalStateException("this should only be called when the cursor is valid");
    }

    public abstract View h(Context context, Cursor cursor, ViewGroup viewGroup);

    protected void i() {
        Cursor cursor;
        if (!this.f216c || (cursor = this.f217d) == null || cursor.isClosed()) {
            return;
        }
        this.f215b = this.f217d.requery();
    }

    public Cursor j(Cursor cursor) {
        Cursor cursor2 = this.f217d;
        if (cursor == cursor2) {
            return null;
        }
        if (cursor2 != null) {
            C0013a c0013a = this.g;
            if (c0013a != null) {
                cursor2.unregisterContentObserver(c0013a);
            }
            DataSetObserver dataSetObserver = this.h;
            if (dataSetObserver != null) {
                cursor2.unregisterDataSetObserver(dataSetObserver);
            }
        }
        this.f217d = cursor;
        if (cursor != null) {
            C0013a c0013a2 = this.g;
            if (c0013a2 != null) {
                cursor.registerContentObserver(c0013a2);
            }
            DataSetObserver dataSetObserver2 = this.h;
            if (dataSetObserver2 != null) {
                cursor.registerDataSetObserver(dataSetObserver2);
            }
            this.f = cursor.getColumnIndexOrThrow("_id");
            this.f215b = true;
            notifyDataSetChanged();
        } else {
            this.f = -1;
            this.f215b = false;
            notifyDataSetInvalidated();
        }
        return cursor2;
    }
}
