package d.n.j.e;

import d.n.j.a;
import d.n.j.d;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.UnknownHostException;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a implements a.InterfaceC0113a {

    /* renamed from: a  reason: collision with root package name */
    private String f2644a;

    /* renamed from: b  reason: collision with root package name */
    private final InetSocketAddress f2645b;

    /* renamed from: c  reason: collision with root package name */
    private final SocketAddress f2646c;

    public a(String str) {
        String[] split = str.split(";");
        this.f2645b = d(split[0], false, false);
        this.f2646c = (split.length != 2 || BuildConfig.FLAVOR.equals(split[1])) ? null : d(split[1], false, false);
    }

    @Override // d.n.j.a.InterfaceC0113a
    public SocketAddress a() {
        return this.f2646c;
    }

    @Override // d.n.j.a.InterfaceC0113a
    public d.n.j.c b() {
        return d.INET;
    }

    @Override // d.n.j.a.InterfaceC0113a
    public SocketAddress c() {
        return this.f2645b;
    }

    public InetSocketAddress d(String str, boolean z, boolean z2) {
        this.f2644a = str;
        int hashCode = str.hashCode();
        if (hashCode < 0) {
            hashCode = -hashCode;
        }
        try {
            return new InetSocketAddress(InetAddress.getByName(null), (hashCode % 55536) + 10000);
        } catch (UnknownHostException e) {
            throw new IllegalArgumentException(e);
        }
    }

    @Override // d.n.j.a.InterfaceC0113a
    public String toString() {
        if (this.f2644a == null) {
            return BuildConfig.FLAVOR;
        }
        return "ipc://" + this.f2644a;
    }
}
