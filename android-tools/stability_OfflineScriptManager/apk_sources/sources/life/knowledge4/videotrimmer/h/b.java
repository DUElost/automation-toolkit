package life.knowledge4.videotrimmer.h;

import android.net.Uri;
import android.util.Log;
import b.c.a.i.e;
import b.e.a.f;
import b.e.a.h.d;
import b.e.a.h.g;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    private static final String f2744a = "b";

    private static double a(g gVar, double d2, boolean z) {
        int length = gVar.f().length;
        double[] dArr = new double[length];
        int i = 0;
        double d3 = 0.0d;
        long j = 0;
        double d4 = 0.0d;
        for (int i2 = 0; i2 < gVar.w().length; i2++) {
            long j2 = gVar.w()[i2];
            j++;
            if (Arrays.binarySearch(gVar.f(), j) >= 0) {
                dArr[Arrays.binarySearch(gVar.f(), j)] = d4;
            }
            d4 += j2 / gVar.z().g();
        }
        while (i < length) {
            double d5 = dArr[i];
            if (d5 > d2) {
                return z ? d5 : d3;
            }
            i++;
            d3 = d5;
        }
        return dArr[length - 1];
    }

    private static void b(File file, File file2, long j, long j2, life.knowledge4.videotrimmer.g.c cVar) {
        d a2 = b.e.a.h.j.a.a.a(new f(file.getAbsolutePath()));
        List<g> g = a2.g();
        a2.i(new LinkedList());
        double d2 = j / 1000;
        double d3 = j2 / 1000;
        int i = 0;
        boolean z = false;
        for (g gVar : g) {
            if (gVar.f() != null && gVar.f().length > 0) {
                if (z) {
                    throw new RuntimeException("The startTime has already been corrected by another track with SyncSample. Not Supported.");
                }
                d2 = a(gVar, d2, false);
                d3 = a(gVar, d3, true);
                z = true;
            }
        }
        for (g gVar2 : g) {
            long j3 = 0;
            long j4 = -1;
            int i2 = i;
            double d4 = -1.0d;
            double d5 = 0.0d;
            long j5 = -1;
            while (i2 < gVar2.w().length) {
                long j6 = gVar2.w()[i2];
                int i3 = (d5 > d4 ? 1 : (d5 == d4 ? 0 : -1));
                if (i3 > 0 && d5 <= d2) {
                    j5 = j3;
                }
                if (i3 > 0 && d5 <= d3) {
                    j4 = j3;
                }
                i2++;
                d4 = d5;
                d5 += j6 / gVar2.z().g();
                j3++;
            }
            a2.a(new b.e.a.h.l.a(new b.e.a.h.l.c(gVar2, j5, j4)));
            i = 0;
        }
        file2.getParentFile().mkdirs();
        if (!file2.exists()) {
            file2.createNewFile();
        }
        e b2 = new b.e.a.h.i.b().b(a2);
        FileOutputStream fileOutputStream = new FileOutputStream(file2);
        FileChannel channel = fileOutputStream.getChannel();
        b2.h(channel);
        channel.close();
        fileOutputStream.close();
        cVar.m(Uri.parse(file2.toString()));
    }

    public static void c(File file, String str, long j, long j2, life.knowledge4.videotrimmer.g.c cVar) {
        String str2 = str + ("MP4_" + new SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(new Date()) + ".mp4");
        File file2 = new File(str2);
        file2.getParentFile().mkdirs();
        Log.d(f2744a, "Generated file path " + str2);
        b(file, file2, j, j2, cVar);
    }
}
