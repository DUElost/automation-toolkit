package d.s;

import java.lang.reflect.Array;
import java.nio.channels.SelectableChannel;
import java.nio.channels.SocketChannel;
import java.security.SecureRandom;
/* loaded from: classes.dex */
public class e {

    /* renamed from: a  reason: collision with root package name */
    private static final SecureRandom f2726a = new SecureRandom();

    public static d.n.j.a a(SocketChannel socketChannel) {
        return new d.n.j.a(socketChannel.socket().getRemoteSocketAddress());
    }

    public static byte[] b(int i) {
        byte[] bArr = new byte[i];
        f2726a.nextBytes(bArr);
        return bArr;
    }

    public static int c() {
        return f2726a.nextInt();
    }

    public static byte[] d(byte[] bArr, int i) {
        byte[] bArr2 = new byte[i];
        if (bArr != null) {
            System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        }
        return bArr2;
    }

    public static <T> T[] e(Class<T> cls, T[] tArr, int i, boolean z) {
        Object[] objArr;
        if (i > tArr.length) {
            objArr = (Object[]) Array.newInstance((Class<?>) cls, i);
            if (z) {
                System.arraycopy(tArr, 0, objArr, 0, tArr.length);
            } else {
                System.arraycopy(tArr, 0, objArr, i - tArr.length, tArr.length);
            }
        } else if (i >= tArr.length) {
            return tArr;
        } else {
            objArr = (Object[]) Array.newInstance((Class<?>) cls, i);
            if (z) {
                System.arraycopy(tArr, tArr.length - i, objArr, 0, i);
            } else {
                System.arraycopy(tArr, 0, objArr, 0, i);
            }
        }
        return (T[]) objArr;
    }

    public static void f(SelectableChannel... selectableChannelArr) {
        d.n.j.h.e.i(selectableChannelArr);
    }
}
