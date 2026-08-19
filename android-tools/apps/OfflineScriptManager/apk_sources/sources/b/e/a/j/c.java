package b.e.a.j;

import java.util.Date;
/* loaded from: classes.dex */
public class c {
    public static long a(Date date) {
        return (date.getTime() / 1000) + 2082844800;
    }

    public static Date b(long j) {
        return new Date((j - 2082844800) * 1000);
    }
}
