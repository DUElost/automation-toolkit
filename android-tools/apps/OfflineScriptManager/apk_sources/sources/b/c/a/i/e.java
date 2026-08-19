package b.c.a.i;

import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import java.util.List;
/* loaded from: classes.dex */
public interface e {
    List<b> e();

    void h(WritableByteChannel writableByteChannel);

    <T extends b> List<T> q(Class<T> cls);

    ByteBuffer s(long j, long j2);
}
