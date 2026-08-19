package d.o;

import d.e;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class b implements a {
    @Override // d.o.a
    public e a(int i) {
        return new e(ByteBuffer.allocateDirect(i));
    }
}
