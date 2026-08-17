package d.p;

import d.e;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
/* loaded from: classes.dex */
class a<T extends d.e> {

    /* renamed from: a  reason: collision with root package name */
    private T f2660a;

    /* renamed from: b  reason: collision with root package name */
    private final Lock f2661b = new ReentrantLock();

    /* renamed from: c  reason: collision with root package name */
    private boolean f2662c;

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean a() {
        this.f2661b.lock();
        try {
            return this.f2662c;
        } finally {
            this.f2661b.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public T b() {
        this.f2661b.lock();
        try {
            return this.f2660a;
        } finally {
            this.f2661b.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public T c() {
        this.f2661b.lock();
        try {
            if (this.f2662c) {
                this.f2662c = false;
                return this.f2660a;
            }
            this.f2661b.unlock();
            return null;
        } finally {
            this.f2661b.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void d(T t) {
        this.f2661b.lock();
        try {
            this.f2660a = t;
            this.f2662c = true;
        } finally {
            this.f2661b.unlock();
        }
    }
}
