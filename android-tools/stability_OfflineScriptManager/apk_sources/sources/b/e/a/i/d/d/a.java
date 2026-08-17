package b.e.a.i.d.d;

import b.e.a.j.k;
import java.nio.ByteBuffer;
import java.util.UUID;
/* loaded from: classes.dex */
public class a extends b {

    /* renamed from: a  reason: collision with root package name */
    private boolean f1579a;

    /* renamed from: b  reason: collision with root package name */
    private byte f1580b;

    /* renamed from: c  reason: collision with root package name */
    private UUID f1581c;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(20);
        b.c.a.f.f(allocate, this.f1579a ? 1 : 0);
        if (this.f1579a) {
            b.c.a.f.j(allocate, this.f1580b);
            allocate.put(k.b(this.f1581c));
        } else {
            allocate.put(new byte[17]);
        }
        allocate.rewind();
        return allocate;
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "seig";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        this.f1579a = b.c.a.e.j(byteBuffer) == 1;
        this.f1580b = (byte) b.c.a.e.n(byteBuffer);
        byte[] bArr = new byte[16];
        byteBuffer.get(bArr);
        this.f1581c = k.a(bArr);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || a.class != obj.getClass()) {
            return false;
        }
        a aVar = (a) obj;
        if (this.f1579a == aVar.f1579a && this.f1580b == aVar.f1580b) {
            UUID uuid = this.f1581c;
            UUID uuid2 = aVar.f1581c;
            return uuid == null ? uuid2 == null : uuid.equals(uuid2);
        }
        return false;
    }

    public int hashCode() {
        int i = (((this.f1579a ? 7 : 19) * 31) + this.f1580b) * 31;
        UUID uuid = this.f1581c;
        return i + (uuid != null ? uuid.hashCode() : 0);
    }

    public String toString() {
        return "CencSampleEncryptionInformationGroupEntry{isEncrypted=" + this.f1579a + ", ivSize=" + ((int) this.f1580b) + ", kid=" + this.f1581c + '}';
    }
}
