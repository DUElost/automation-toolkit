package b.e.a.j;
/* loaded from: classes.dex */
public class g {
    public static long a(long j, long j2) {
        while (true) {
            long j3 = j;
            j = j2;
            if (j <= 0) {
                return j3;
            }
            j2 = j3 % j;
        }
    }

    public static long b(long j, long j2) {
        return j * (j2 / a(j, j2));
    }
}
