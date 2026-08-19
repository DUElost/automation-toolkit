package d.n.h;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public interface e {

    /* loaded from: classes.dex */
    public interface a {

        /* renamed from: d.n.h.e$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public enum EnumC0107a {
            MORE_DATA(0),
            DECODED(1),
            ERROR(-1);

            EnumC0107a(int i) {
            }

            /* renamed from: values  reason: to resolve conflict with enum method */
            public static EnumC0107a[] valuesCustom() {
                EnumC0107a[] valuesCustom = values();
                int length = valuesCustom.length;
                EnumC0107a[] enumC0107aArr = new EnumC0107a[length];
                System.arraycopy(valuesCustom, 0, enumC0107aArr, 0, length);
                return enumC0107aArr;
            }
        }

        EnumC0107a a();
    }

    void a();

    d.e b();

    a.EnumC0107a c(ByteBuffer byteBuffer, int i, d.s.f<Integer> fVar);

    ByteBuffer d();
}
