package c.c.a.p;

import java.util.ArrayList;
/* loaded from: classes.dex */
public class a<T> {

    /* renamed from: a  reason: collision with root package name */
    private ArrayList<T> f1844a;

    public a(int i) {
        this.f1844a = new ArrayList<>(i);
    }

    public T a() {
        ArrayList<T> arrayList = this.f1844a;
        return arrayList.remove(arrayList.size() - 1);
    }

    public void b(T t) {
        this.f1844a.add(t);
    }
}
