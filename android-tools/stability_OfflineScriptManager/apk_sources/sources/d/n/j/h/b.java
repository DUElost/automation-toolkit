package d.n.j.h;

import d.n.j.a;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.UnknownHostException;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class b implements a.InterfaceC0113a {

    /* renamed from: a  reason: collision with root package name */
    private final InetSocketAddress f2650a;

    /* renamed from: b  reason: collision with root package name */
    private final SocketAddress f2651b;

    /* loaded from: classes.dex */
    public static class a extends b {
        public a(String str, boolean z) {
            super(str, z);
        }

        public boolean e(SocketAddress socketAddress) {
            return c().equals(socketAddress);
        }
    }

    public b(String str, boolean z) {
        String[] split = str.split(";");
        this.f2650a = d(split[0], z, false);
        this.f2651b = (split.length != 2 || BuildConfig.FLAVOR.equals(split[1])) ? null : d(split[1], z, false);
    }

    @Override // d.n.j.a.InterfaceC0113a
    public SocketAddress a() {
        return this.f2651b;
    }

    @Override // d.n.j.a.InterfaceC0113a
    public d.n.j.c b() {
        return this.f2650a.getAddress() instanceof Inet6Address ? d.n.j.d.INET6 : d.n.j.d.INET;
    }

    @Override // d.n.j.a.InterfaceC0113a
    public SocketAddress c() {
        return this.f2650a;
    }

    public InetSocketAddress d(String str, boolean z, boolean z2) {
        int i;
        InetAddress[] allByName;
        int lastIndexOf = str.lastIndexOf(58);
        if (lastIndexOf >= 0) {
            String substring = str.substring(0, lastIndexOf);
            String substring2 = str.substring(lastIndexOf + 1);
            if (substring.length() >= 2 && substring.charAt(0) == '[' && substring.charAt(substring.length() - 1) == ']') {
                substring = substring.substring(1, substring.length() - 1);
            }
            if (substring2.equals("*") || substring2.equals("0")) {
                i = 0;
            } else {
                i = Integer.parseInt(substring2);
                if (i == 0) {
                    throw new IllegalArgumentException(str);
                }
            }
            InetAddress inetAddress = null;
            if (substring.equals("*")) {
                substring = "0.0.0.0";
            }
            try {
                for (InetAddress inetAddress2 : InetAddress.getAllByName(substring)) {
                    if (!z || (inetAddress2 instanceof Inet6Address)) {
                        inetAddress = inetAddress2;
                        break;
                    }
                }
                if (inetAddress != null) {
                    return new InetSocketAddress(inetAddress, i);
                }
                throw new IllegalArgumentException(str);
            } catch (UnknownHostException e) {
                throw new IllegalArgumentException(e);
            }
        }
        throw new IllegalArgumentException(str);
    }

    @Override // d.n.j.a.InterfaceC0113a
    public String toString() {
        StringBuilder sb;
        String str;
        InetSocketAddress inetSocketAddress = this.f2650a;
        if (inetSocketAddress == null) {
            return BuildConfig.FLAVOR;
        }
        if (inetSocketAddress.getAddress() instanceof Inet6Address) {
            sb = new StringBuilder("tcp://[");
            sb.append(this.f2650a.getAddress().getHostAddress());
            str = "]:";
        } else {
            sb = new StringBuilder("tcp://");
            sb.append(this.f2650a.getAddress().getHostAddress());
            str = ":";
        }
        sb.append(str);
        sb.append(this.f2650a.getPort());
        return sb.toString();
    }
}
