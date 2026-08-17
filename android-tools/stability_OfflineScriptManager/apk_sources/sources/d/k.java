package d;

import java.io.IOException;
import java.net.SocketException;
import java.nio.channels.ClosedChannelException;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class k {

    /* loaded from: classes.dex */
    public static class a extends RuntimeException {
    }

    /* loaded from: classes.dex */
    public static class b extends RuntimeException {
        public b(IOException iOException) {
            super(iOException);
        }
    }

    /* loaded from: classes.dex */
    public static class c extends RuntimeException {
    }

    public static int a(IOException iOException) {
        if (iOException instanceof SocketException) {
            return 156384818;
        }
        return iOException instanceof ClosedChannelException ? 57 : 156384817;
    }

    public static String b(int i) {
        if (i != 48) {
            switch (i) {
                case 156384763:
                    return "Operation cannot be accomplished in current state";
                case 156384764:
                    return "The protocol is not compatible with the socket type";
                case 156384765:
                    return "Context was terminated";
                case 156384766:
                    return "No thread available";
                default:
                    return BuildConfig.FLAVOR;
            }
        }
        return "Address already in use";
    }
}
