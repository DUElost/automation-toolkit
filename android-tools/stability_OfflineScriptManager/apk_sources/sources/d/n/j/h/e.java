package d.n.j.h;

import d.k;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.nio.channels.Channel;
import java.nio.channels.SelectableChannel;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
/* loaded from: classes.dex */
public class e {

    /* loaded from: classes.dex */
    class a extends h {
        a() {
            super(null);
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setTcpNoDelay(true);
            return true;
        }
    }

    /* loaded from: classes.dex */
    class b extends h {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ boolean f2652a;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        b(boolean z) {
            super(null);
            this.f2652a = z;
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setKeepAlive(this.f2652a);
            return true;
        }
    }

    /* loaded from: classes.dex */
    class c implements g {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ int f2653a;

        c(int i) {
            this.f2653a = i;
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setReceiveBufferSize(this.f2653a);
            return true;
        }

        @Override // d.n.j.h.e.g
        public boolean b(ServerSocket serverSocket) {
            serverSocket.setReceiveBufferSize(this.f2653a);
            return true;
        }
    }

    /* loaded from: classes.dex */
    class d extends h {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ int f2654a;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        d(int i) {
            super(null);
            this.f2654a = i;
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setSendBufferSize(this.f2654a);
            return true;
        }
    }

    /* renamed from: d.n.j.h.e$e  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class C0115e extends h {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ int f2655a;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        C0115e(int i) {
            super(null);
            this.f2655a = i;
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setTrafficClass(this.f2655a);
            return true;
        }
    }

    /* loaded from: classes.dex */
    class f implements g {

        /* renamed from: a  reason: collision with root package name */
        private final /* synthetic */ boolean f2656a;

        f(boolean z) {
            this.f2656a = z;
        }

        @Override // d.n.j.h.e.g
        public boolean a(Socket socket) {
            socket.setReuseAddress(this.f2656a);
            return true;
        }

        @Override // d.n.j.h.e.g
        public boolean b(ServerSocket serverSocket) {
            serverSocket.setReuseAddress(this.f2656a);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public interface g {
        boolean a(Socket socket);

        boolean b(ServerSocket serverSocket);
    }

    /* loaded from: classes.dex */
    private static abstract class h implements g {
        private h() {
        }

        /* synthetic */ h(h hVar) {
            this();
        }

        @Override // d.n.j.h.e.g
        public boolean b(ServerSocket serverSocket) {
            return false;
        }
    }

    public static void a(SelectableChannel selectableChannel) {
    }

    public static boolean b(Channel channel, int i) {
        return c(channel, new C0115e(i));
    }

    private static boolean c(Channel channel, g gVar) {
        try {
            if (channel instanceof ServerSocketChannel) {
                return gVar.b(((ServerSocketChannel) channel).socket());
            }
            if (channel instanceof SocketChannel) {
                return gVar.a(((SocketChannel) channel).socket());
            }
            return false;
        } catch (SocketException e) {
            throw new k.b(e);
        }
    }

    public static boolean d(Channel channel, boolean z) {
        return c(channel, new f(z));
    }

    public static boolean e(Channel channel, int i) {
        return c(channel, new c(i));
    }

    public static boolean f(Channel channel, int i) {
        return c(channel, new d(i));
    }

    public static void g(SocketChannel socketChannel, int i, int i2, int i3, int i4) {
        c(socketChannel, new b(i == 1));
    }

    public static void h(SocketChannel socketChannel) {
        c(socketChannel, new a());
    }

    public static void i(SelectableChannel... selectableChannelArr) {
        for (SelectableChannel selectableChannel : selectableChannelArr) {
            selectableChannel.configureBlocking(false);
        }
    }
}
