package life.knowledge4.videotrimmer.h;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import java.util.HashMap;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public final class c {

    /* renamed from: a  reason: collision with root package name */
    private static final Handler f2745a = new a(Looper.getMainLooper());

    /* renamed from: b  reason: collision with root package name */
    private static final Map<String, b> f2746b = new HashMap();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a extends Handler {
        a(Looper looper) {
            super(looper);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            Runnable callback = message.getCallback();
            if (callback == null) {
                super.handleMessage(message);
                return;
            }
            callback.run();
            c.b((b) message.obj);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class b {

        /* renamed from: a  reason: collision with root package name */
        int f2747a;

        /* renamed from: b  reason: collision with root package name */
        final String f2748b;

        private b(String str) {
            this.f2747a = 0;
            this.f2748b = str;
        }

        /* synthetic */ b(String str, a aVar) {
            this(str);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void b(b bVar) {
        String str;
        b remove;
        Map<String, b> map = f2746b;
        synchronized (map) {
            int i = bVar.f2747a - 1;
            bVar.f2747a = i;
            if (i == 0 && (remove = map.remove((str = bVar.f2748b))) != bVar) {
                map.put(str, remove);
            }
        }
    }

    private static b c(String str) {
        b bVar;
        Map<String, b> map = f2746b;
        synchronized (map) {
            bVar = map.get(str);
            if (bVar == null) {
                bVar = new b(str, null);
                map.put(str, bVar);
            }
            bVar.f2747a++;
        }
        return bVar;
    }

    public static void d(String str, Runnable runnable, long j) {
        if (BuildConfig.FLAVOR.equals(str)) {
            f2745a.postDelayed(runnable, j);
            return;
        }
        f2745a.postAtTime(runnable, c(str), SystemClock.uptimeMillis() + j);
    }
}
