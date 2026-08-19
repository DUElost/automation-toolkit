package androidx.lifecycle;

import android.util.Log;
import androidx.lifecycle.e;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
/* loaded from: classes.dex */
public class h extends e {

    /* renamed from: c  reason: collision with root package name */
    private final WeakReference<g> f1077c;

    /* renamed from: a  reason: collision with root package name */
    private a.b.a.b.a<f, b> f1075a = new a.b.a.b.a<>();

    /* renamed from: d  reason: collision with root package name */
    private int f1078d = 0;
    private boolean e = false;
    private boolean f = false;
    private ArrayList<e.b> g = new ArrayList<>();

    /* renamed from: b  reason: collision with root package name */
    private e.b f1076b = e.b.INITIALIZED;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static /* synthetic */ class a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1079a;

        /* renamed from: b  reason: collision with root package name */
        static final /* synthetic */ int[] f1080b;

        static {
            int[] iArr = new int[e.b.values().length];
            f1080b = iArr;
            try {
                iArr[e.b.INITIALIZED.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1080b[e.b.CREATED.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f1080b[e.b.STARTED.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f1080b[e.b.RESUMED.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                f1080b[e.b.DESTROYED.ordinal()] = 5;
            } catch (NoSuchFieldError unused5) {
            }
            int[] iArr2 = new int[e.a.values().length];
            f1079a = iArr2;
            try {
                iArr2[e.a.ON_CREATE.ordinal()] = 1;
            } catch (NoSuchFieldError unused6) {
            }
            try {
                f1079a[e.a.ON_STOP.ordinal()] = 2;
            } catch (NoSuchFieldError unused7) {
            }
            try {
                f1079a[e.a.ON_START.ordinal()] = 3;
            } catch (NoSuchFieldError unused8) {
            }
            try {
                f1079a[e.a.ON_PAUSE.ordinal()] = 4;
            } catch (NoSuchFieldError unused9) {
            }
            try {
                f1079a[e.a.ON_RESUME.ordinal()] = 5;
            } catch (NoSuchFieldError unused10) {
            }
            try {
                f1079a[e.a.ON_DESTROY.ordinal()] = 6;
            } catch (NoSuchFieldError unused11) {
            }
            try {
                f1079a[e.a.ON_ANY.ordinal()] = 7;
            } catch (NoSuchFieldError unused12) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        e.b f1081a;

        /* renamed from: b  reason: collision with root package name */
        d f1082b;

        b(f fVar, e.b bVar) {
            this.f1082b = j.d(fVar);
            this.f1081a = bVar;
        }

        void a(g gVar, e.a aVar) {
            e.b h = h.h(aVar);
            this.f1081a = h.l(this.f1081a, h);
            this.f1082b.d(gVar, aVar);
            this.f1081a = h;
        }
    }

    public h(g gVar) {
        this.f1077c = new WeakReference<>(gVar);
    }

    private void d(g gVar) {
        Iterator<Map.Entry<f, b>> a2 = this.f1075a.a();
        while (a2.hasNext() && !this.f) {
            Map.Entry<f, b> next = a2.next();
            b value = next.getValue();
            while (value.f1081a.compareTo(this.f1076b) > 0 && !this.f && this.f1075a.contains(next.getKey())) {
                e.a f = f(value.f1081a);
                o(h(f));
                value.a(gVar, f);
                n();
            }
        }
    }

    private e.b e(f fVar) {
        Map.Entry<f, b> i = this.f1075a.i(fVar);
        e.b bVar = null;
        e.b bVar2 = i != null ? i.getValue().f1081a : null;
        if (!this.g.isEmpty()) {
            ArrayList<e.b> arrayList = this.g;
            bVar = arrayList.get(arrayList.size() - 1);
        }
        return l(l(this.f1076b, bVar2), bVar);
    }

    private static e.a f(e.b bVar) {
        int i = a.f1080b[bVar.ordinal()];
        if (i != 1) {
            if (i != 2) {
                if (i != 3) {
                    if (i != 4) {
                        if (i != 5) {
                            throw new IllegalArgumentException("Unexpected state value " + bVar);
                        }
                        throw new IllegalArgumentException();
                    }
                    return e.a.ON_PAUSE;
                }
                return e.a.ON_STOP;
            }
            return e.a.ON_DESTROY;
        }
        throw new IllegalArgumentException();
    }

    /* JADX WARN: Multi-variable type inference failed */
    private void g(g gVar) {
        a.b.a.b.b<f, b>.d d2 = this.f1075a.d();
        while (d2.hasNext() && !this.f) {
            Map.Entry next = d2.next();
            b bVar = (b) next.getValue();
            while (bVar.f1081a.compareTo(this.f1076b) < 0 && !this.f && this.f1075a.contains(next.getKey())) {
                o(bVar.f1081a);
                bVar.a(gVar, q(bVar.f1081a));
                n();
            }
        }
    }

    static e.b h(e.a aVar) {
        switch (a.f1079a[aVar.ordinal()]) {
            case 1:
            case 2:
                return e.b.CREATED;
            case 3:
            case 4:
                return e.b.STARTED;
            case 5:
                return e.b.RESUMED;
            case 6:
                return e.b.DESTROYED;
            default:
                throw new IllegalArgumentException("Unexpected event value " + aVar);
        }
    }

    private boolean j() {
        if (this.f1075a.size() == 0) {
            return true;
        }
        e.b bVar = this.f1075a.b().getValue().f1081a;
        e.b bVar2 = this.f1075a.e().getValue().f1081a;
        return bVar == bVar2 && this.f1076b == bVar2;
    }

    static e.b l(e.b bVar, e.b bVar2) {
        return (bVar2 == null || bVar2.compareTo(bVar) >= 0) ? bVar : bVar2;
    }

    private void m(e.b bVar) {
        if (this.f1076b == bVar) {
            return;
        }
        this.f1076b = bVar;
        if (this.e || this.f1078d != 0) {
            this.f = true;
            return;
        }
        this.e = true;
        p();
        this.e = false;
    }

    private void n() {
        ArrayList<e.b> arrayList = this.g;
        arrayList.remove(arrayList.size() - 1);
    }

    private void o(e.b bVar) {
        this.g.add(bVar);
    }

    private void p() {
        g gVar = this.f1077c.get();
        if (gVar == null) {
            Log.w("LifecycleRegistry", "LifecycleOwner is garbage collected, you shouldn't try dispatch new events from it.");
            return;
        }
        while (true) {
            boolean j = j();
            this.f = false;
            if (j) {
                return;
            }
            if (this.f1076b.compareTo(this.f1075a.b().getValue().f1081a) < 0) {
                d(gVar);
            }
            Map.Entry<f, b> e = this.f1075a.e();
            if (!this.f && e != null && this.f1076b.compareTo(e.getValue().f1081a) > 0) {
                g(gVar);
            }
        }
    }

    private static e.a q(e.b bVar) {
        int i = a.f1080b[bVar.ordinal()];
        if (i != 1) {
            if (i == 2) {
                return e.a.ON_START;
            }
            if (i == 3) {
                return e.a.ON_RESUME;
            }
            if (i == 4) {
                throw new IllegalArgumentException();
            }
            if (i != 5) {
                throw new IllegalArgumentException("Unexpected state value " + bVar);
            }
        }
        return e.a.ON_CREATE;
    }

    @Override // androidx.lifecycle.e
    public void a(f fVar) {
        g gVar;
        e.b bVar = this.f1076b;
        e.b bVar2 = e.b.DESTROYED;
        if (bVar != bVar2) {
            bVar2 = e.b.INITIALIZED;
        }
        b bVar3 = new b(fVar, bVar2);
        if (this.f1075a.g(fVar, bVar3) == null && (gVar = this.f1077c.get()) != null) {
            boolean z = this.f1078d != 0 || this.e;
            e.b e = e(fVar);
            this.f1078d++;
            while (bVar3.f1081a.compareTo(e) < 0 && this.f1075a.contains(fVar)) {
                o(bVar3.f1081a);
                bVar3.a(gVar, q(bVar3.f1081a));
                n();
                e = e(fVar);
            }
            if (!z) {
                p();
            }
            this.f1078d--;
        }
    }

    @Override // androidx.lifecycle.e
    public e.b b() {
        return this.f1076b;
    }

    @Override // androidx.lifecycle.e
    public void c(f fVar) {
        this.f1075a.h(fVar);
    }

    public void i(e.a aVar) {
        m(h(aVar));
    }

    public void k(e.b bVar) {
        m(bVar);
    }
}
