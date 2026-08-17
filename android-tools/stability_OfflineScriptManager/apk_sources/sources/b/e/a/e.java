package b.e.a;

import java.io.Closeable;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public interface e extends Closeable {
    @Override // java.io.Closeable, java.lang.AutoCloseable
    void close();

    ByteBuffer j(long j, long j2);

    long l();

    long size();

    void u(long j);

    int y(ByteBuffer byteBuffer);
}
