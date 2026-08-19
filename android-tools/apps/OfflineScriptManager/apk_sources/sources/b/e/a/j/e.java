package b.e.a.j;

import java.util.AbstractList;
import java.util.Iterator;
import java.util.List;
import java.util.NoSuchElementException;
/* loaded from: classes.dex */
public class e<E> extends AbstractList<E> {

    /* renamed from: d  reason: collision with root package name */
    private static final f f1599d = f.a(e.class);

    /* renamed from: b  reason: collision with root package name */
    List<E> f1600b;

    /* renamed from: c  reason: collision with root package name */
    Iterator<E> f1601c;

    /* loaded from: classes.dex */
    class a implements Iterator<E> {

        /* renamed from: b  reason: collision with root package name */
        int f1602b = 0;

        a() {
        }

        @Override // java.util.Iterator
        public boolean hasNext() {
            return this.f1602b < e.this.f1600b.size() || e.this.f1601c.hasNext();
        }

        @Override // java.util.Iterator
        public E next() {
            if (this.f1602b >= e.this.f1600b.size()) {
                e eVar = e.this;
                eVar.f1600b.add(eVar.f1601c.next());
                return (E) next();
            }
            List<E> list = e.this.f1600b;
            int i = this.f1602b;
            this.f1602b = i + 1;
            return list.get(i);
        }

        @Override // java.util.Iterator
        public void remove() {
            throw new UnsupportedOperationException();
        }
    }

    public e(List<E> list, Iterator<E> it) {
        this.f1600b = list;
        this.f1601c = it;
    }

    private void a() {
        f1599d.b("blowup running");
        while (this.f1601c.hasNext()) {
            this.f1600b.add(this.f1601c.next());
        }
    }

    @Override // java.util.AbstractList, java.util.List
    public E get(int i) {
        if (this.f1600b.size() > i) {
            return this.f1600b.get(i);
        }
        if (this.f1601c.hasNext()) {
            this.f1600b.add(this.f1601c.next());
            return get(i);
        }
        throw new NoSuchElementException();
    }

    @Override // java.util.AbstractList, java.util.AbstractCollection, java.util.Collection, java.lang.Iterable, java.util.List
    public Iterator<E> iterator() {
        return new a();
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public int size() {
        f1599d.b("potentially expensive size() call");
        a();
        return this.f1600b.size();
    }
}
