package androidx.lifecycle;

import androidx.lifecycle.e;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class FullLifecycleObserverAdapter implements d {

    /* renamed from: a  reason: collision with root package name */
    private final b f1052a;

    /* loaded from: classes.dex */
    static /* synthetic */ class a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1053a;

        static {
            int[] iArr = new int[e.a.values().length];
            f1053a = iArr;
            try {
                iArr[e.a.ON_CREATE.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1053a[e.a.ON_START.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f1053a[e.a.ON_RESUME.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f1053a[e.a.ON_PAUSE.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                f1053a[e.a.ON_STOP.ordinal()] = 5;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                f1053a[e.a.ON_DESTROY.ordinal()] = 6;
            } catch (NoSuchFieldError unused6) {
            }
            try {
                f1053a[e.a.ON_ANY.ordinal()] = 7;
            } catch (NoSuchFieldError unused7) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public FullLifecycleObserverAdapter(b bVar) {
        this.f1052a = bVar;
    }

    @Override // androidx.lifecycle.d
    public void d(g gVar, e.a aVar) {
        switch (a.f1053a[aVar.ordinal()]) {
            case 1:
                this.f1052a.c(gVar);
                return;
            case 2:
                this.f1052a.g(gVar);
                return;
            case 3:
                this.f1052a.a(gVar);
                return;
            case 4:
                this.f1052a.e(gVar);
                return;
            case 5:
                this.f1052a.f(gVar);
                return;
            case 6:
                this.f1052a.b(gVar);
                return;
            case 7:
                throw new IllegalArgumentException("ON_ANY must not been send by anybody");
            default:
                return;
        }
    }
}
