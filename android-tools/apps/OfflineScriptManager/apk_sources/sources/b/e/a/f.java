package b.e.a;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
/* loaded from: classes.dex */
public class f implements e {

    /* renamed from: b  reason: collision with root package name */
    FileChannel f1517b;

    /* renamed from: c  reason: collision with root package name */
    String f1518c;

    static {
        b.e.a.j.f.a(f.class);
    }

    public f(String str) {
        File file = new File(str);
        this.f1517b = new FileInputStream(file).getChannel();
        this.f1518c = file.getName();
    }

    @Override // b.e.a.e, java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        this.f1517b.close();
    }

    @Override // b.e.a.e
    public synchronized ByteBuffer j(long j, long j2) {
        ByteBuffer allocate;
        allocate = ByteBuffer.allocate(b.e.a.j.b.a(j2));
        this.f1517b.read(allocate, j);
        return (ByteBuffer) allocate.rewind();
    }

    @Override // b.e.a.e
    public synchronized long l() {
        return this.f1517b.position();
    }

    @Override // b.e.a.e
    public synchronized long size() {
        return this.f1517b.size();
    }

    public String toString() {
        return this.f1518c;
    }

    @Override // b.e.a.e
    public synchronized void u(long j) {
        this.f1517b.position(j);
    }

    @Override // b.e.a.e
    public synchronized int y(ByteBuffer byteBuffer) {
        return this.f1517b.read(byteBuffer);
    }
}
