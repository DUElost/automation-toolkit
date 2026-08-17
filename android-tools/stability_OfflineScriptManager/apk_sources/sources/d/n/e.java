package d.n;

import d.l;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.util.Properties;
/* loaded from: classes.dex */
public class e {

    /* renamed from: a  reason: collision with root package name */
    private final Properties f2572a = new Properties();

    /* loaded from: classes.dex */
    public interface a {
        int a(String str, byte[] bArr, String str2);
    }

    private byte[] a(ByteBuffer byteBuffer, int i, int i2) {
        byte[] bArr = new byte[i2];
        int position = byteBuffer.position();
        byteBuffer.position(i);
        byteBuffer.get(bArr, 0, i2);
        byteBuffer.position(position);
        return bArr;
    }

    public final boolean b() {
        return this.f2572a.isEmpty();
    }

    public final int c(ByteBuffer byteBuffer, int i, a aVar) {
        int a2;
        ByteBuffer duplicate = byteBuffer.duplicate();
        duplicate.position(i);
        int remaining = duplicate.remaining();
        while (remaining > 1) {
            byte b2 = duplicate.get(i);
            int i2 = i + 1;
            remaining--;
            if (remaining < b2) {
                break;
            }
            byte[] a3 = a(duplicate, i2, b2);
            Charset charset = l.f2560c;
            String str = new String(a3, charset);
            int i3 = i2 + b2;
            remaining -= b2;
            if (remaining < 4) {
                break;
            }
            int a4 = d.s.g.a(duplicate, i3);
            int i4 = i3 + 4;
            remaining -= 4;
            if (remaining < a4) {
                break;
            }
            byte[] a5 = a(duplicate, i4, a4);
            String str2 = new String(a5, charset);
            i = i4 + a4;
            remaining -= a4;
            if (aVar != null && (a2 = aVar.a(str, a5, str2)) != 0) {
                return a2;
            }
            d(str, str2);
        }
        return remaining > 0 ? 156384820 : 0;
    }

    public final void d(String str, String str2) {
        this.f2572a.setProperty(str, str2);
    }

    public final void e(e eVar) {
        this.f2572a.putAll(eVar.f2572a);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj != null && (obj instanceof e)) {
            return this.f2572a.equals(((e) obj).f2572a);
        }
        return false;
    }

    public int hashCode() {
        return this.f2572a.hashCode();
    }

    public String toString() {
        return "Metadata=" + this.f2572a;
    }
}
