package d.n.j;

import java.net.InetSocketAddress;
import java.net.SocketAddress;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private final b f2635a;

    /* renamed from: b  reason: collision with root package name */
    private final String f2636b;

    /* renamed from: c  reason: collision with root package name */
    private InterfaceC0113a f2637c;

    /* renamed from: d.n.j.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0113a {
        SocketAddress a();

        c b();

        SocketAddress c();

        String toString();
    }

    public a(String str, String str2) {
        this.f2635a = b.b(str);
        this.f2636b = str2;
        this.f2637c = null;
    }

    public a(SocketAddress socketAddress) {
        InetSocketAddress inetSocketAddress = (InetSocketAddress) socketAddress;
        this.f2636b = String.valueOf(inetSocketAddress.getAddress().getHostAddress()) + ":" + inetSocketAddress.getPort();
        this.f2635a = b.f;
        this.f2637c = null;
    }

    public String a() {
        return this.f2636b;
    }

    public String b() {
        int lastIndexOf = this.f2636b.lastIndexOf(58);
        return lastIndexOf > 0 ? this.f2636b.substring(0, lastIndexOf) : this.f2636b;
    }

    public boolean c() {
        return this.f2637c != null;
    }

    public b d() {
        return this.f2635a;
    }

    public InterfaceC0113a e(boolean z) {
        if (b.f.equals(this.f2635a)) {
            d.n.j.h.b bVar = new d.n.j.h.b(this.f2636b, z);
            this.f2637c = bVar;
            return bVar;
        } else if (b.e.equals(this.f2635a)) {
            d.n.j.e.a aVar = new d.n.j.e.a(this.f2636b);
            this.f2637c = aVar;
            return aVar;
        } else {
            return null;
        }
    }

    public InterfaceC0113a f() {
        return this.f2637c;
    }

    public String toString() {
        if (b.f == this.f2635a && c()) {
            return this.f2637c.toString();
        }
        if (b.e == this.f2635a && c()) {
            return this.f2637c.toString();
        }
        if (this.f2635a == null || this.f2636b.isEmpty()) {
            return BuildConfig.FLAVOR;
        }
        return String.valueOf(this.f2635a.name()) + "://" + this.f2636b;
    }
}
