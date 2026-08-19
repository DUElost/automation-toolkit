package a.f.i;

import a.f.e.i;
import a.f.i.c;
import android.content.ContentUris;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.pm.ProviderInfo;
import android.content.pm.Signature;
import android.content.res.Resources;
import android.database.Cursor;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Build;
import android.os.CancellationSignal;
import android.os.Handler;
import androidx.core.content.c.f;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    static final a.d.e<String, Typeface> f123a = new a.d.e<>(16);

    /* renamed from: b  reason: collision with root package name */
    private static final a.f.i.c f124b = new a.f.i.c("fonts", 10, 10000);

    /* renamed from: c  reason: collision with root package name */
    static final Object f125c = new Object();

    /* renamed from: d  reason: collision with root package name */
    static final a.d.g<String, ArrayList<c.d<g>>> f126d = new a.d.g<>();
    private static final Comparator<byte[]> e = new d();

    /* loaded from: classes.dex */
    static class a implements Callable<g> {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Context f127a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ a.f.i.a f128b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f129c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ String f130d;

        a(Context context, a.f.i.a aVar, int i, String str) {
            this.f127a = context;
            this.f128b = aVar;
            this.f129c = i;
            this.f130d = str;
        }

        @Override // java.util.concurrent.Callable
        /* renamed from: a */
        public g call() {
            g f = b.f(this.f127a, this.f128b, this.f129c);
            Typeface typeface = f.f140a;
            if (typeface != null) {
                b.f123a.d(this.f130d, typeface);
            }
            return f;
        }
    }

    /* renamed from: a.f.i.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static class C0006b implements c.d<g> {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ f.a f131a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Handler f132b;

        C0006b(f.a aVar, Handler handler) {
            this.f131a = aVar;
            this.f132b = handler;
        }

        @Override // a.f.i.c.d
        /* renamed from: b */
        public void a(g gVar) {
            int i;
            f.a aVar;
            if (gVar == null) {
                aVar = this.f131a;
                i = 1;
            } else {
                i = gVar.f141b;
                if (i == 0) {
                    this.f131a.b(gVar.f140a, this.f132b);
                    return;
                }
                aVar = this.f131a;
            }
            aVar.a(i, this.f132b);
        }
    }

    /* loaded from: classes.dex */
    static class c implements c.d<g> {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ String f133a;

        c(String str) {
            this.f133a = str;
        }

        @Override // a.f.i.c.d
        /* renamed from: b */
        public void a(g gVar) {
            synchronized (b.f125c) {
                a.d.g<String, ArrayList<c.d<g>>> gVar2 = b.f126d;
                ArrayList<c.d<g>> arrayList = gVar2.get(this.f133a);
                if (arrayList == null) {
                    return;
                }
                gVar2.remove(this.f133a);
                for (int i = 0; i < arrayList.size(); i++) {
                    arrayList.get(i).a(gVar);
                }
            }
        }
    }

    /* loaded from: classes.dex */
    static class d implements Comparator<byte[]> {
        d() {
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(byte[] bArr, byte[] bArr2) {
            int i;
            int i2;
            if (bArr.length == bArr2.length) {
                for (int i3 = 0; i3 < bArr.length; i3++) {
                    if (bArr[i3] != bArr2[i3]) {
                        i = bArr[i3];
                        i2 = bArr2[i3];
                    }
                }
                return 0;
            }
            i = bArr.length;
            i2 = bArr2.length;
            return i - i2;
        }
    }

    /* loaded from: classes.dex */
    public static class e {

        /* renamed from: a  reason: collision with root package name */
        private final int f134a;

        /* renamed from: b  reason: collision with root package name */
        private final f[] f135b;

        public e(int i, f[] fVarArr) {
            this.f134a = i;
            this.f135b = fVarArr;
        }

        public f[] a() {
            return this.f135b;
        }

        public int b() {
            return this.f134a;
        }
    }

    /* loaded from: classes.dex */
    public static class f {

        /* renamed from: a  reason: collision with root package name */
        private final Uri f136a;

        /* renamed from: b  reason: collision with root package name */
        private final int f137b;

        /* renamed from: c  reason: collision with root package name */
        private final int f138c;

        /* renamed from: d  reason: collision with root package name */
        private final boolean f139d;
        private final int e;

        public f(Uri uri, int i, int i2, boolean z, int i3) {
            a.f.k.g.b(uri);
            this.f136a = uri;
            this.f137b = i;
            this.f138c = i2;
            this.f139d = z;
            this.e = i3;
        }

        public int a() {
            return this.e;
        }

        public int b() {
            return this.f137b;
        }

        public Uri c() {
            return this.f136a;
        }

        public int d() {
            return this.f138c;
        }

        public boolean e() {
            return this.f139d;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class g {

        /* renamed from: a  reason: collision with root package name */
        final Typeface f140a;

        /* renamed from: b  reason: collision with root package name */
        final int f141b;

        g(Typeface typeface, int i) {
            this.f140a = typeface;
            this.f141b = i;
        }
    }

    private static List<byte[]> a(Signature[] signatureArr) {
        ArrayList arrayList = new ArrayList();
        for (Signature signature : signatureArr) {
            arrayList.add(signature.toByteArray());
        }
        return arrayList;
    }

    private static boolean b(List<byte[]> list, List<byte[]> list2) {
        if (list.size() != list2.size()) {
            return false;
        }
        for (int i = 0; i < list.size(); i++) {
            if (!Arrays.equals(list.get(i), list2.get(i))) {
                return false;
            }
        }
        return true;
    }

    public static e c(Context context, CancellationSignal cancellationSignal, a.f.i.a aVar) {
        ProviderInfo h = h(context.getPackageManager(), aVar, context.getResources());
        return h == null ? new e(1, null) : new e(0, e(context, aVar, h.authority, cancellationSignal));
    }

    private static List<List<byte[]>> d(a.f.i.a aVar, Resources resources) {
        return aVar.a() != null ? aVar.a() : androidx.core.content.c.c.c(resources, aVar.b());
    }

    static f[] e(Context context, a.f.i.a aVar, String str, CancellationSignal cancellationSignal) {
        ArrayList arrayList = new ArrayList();
        Uri build = new Uri.Builder().scheme("content").authority(str).build();
        Uri build2 = new Uri.Builder().scheme("content").authority(str).appendPath("file").build();
        Cursor cursor = null;
        try {
            cursor = Build.VERSION.SDK_INT > 16 ? context.getContentResolver().query(build, new String[]{"_id", "file_id", "font_ttc_index", "font_variation_settings", "font_weight", "font_italic", "result_code"}, "query = ?", new String[]{aVar.f()}, null, cancellationSignal) : context.getContentResolver().query(build, new String[]{"_id", "file_id", "font_ttc_index", "font_variation_settings", "font_weight", "font_italic", "result_code"}, "query = ?", new String[]{aVar.f()}, null);
            if (cursor != null && cursor.getCount() > 0) {
                int columnIndex = cursor.getColumnIndex("result_code");
                ArrayList arrayList2 = new ArrayList();
                int columnIndex2 = cursor.getColumnIndex("_id");
                int columnIndex3 = cursor.getColumnIndex("file_id");
                int columnIndex4 = cursor.getColumnIndex("font_ttc_index");
                int columnIndex5 = cursor.getColumnIndex("font_weight");
                int columnIndex6 = cursor.getColumnIndex("font_italic");
                while (cursor.moveToNext()) {
                    int i = columnIndex != -1 ? cursor.getInt(columnIndex) : 0;
                    arrayList2.add(new f(columnIndex3 == -1 ? ContentUris.withAppendedId(build, cursor.getLong(columnIndex2)) : ContentUris.withAppendedId(build2, cursor.getLong(columnIndex3)), columnIndex4 != -1 ? cursor.getInt(columnIndex4) : 0, columnIndex5 != -1 ? cursor.getInt(columnIndex5) : 400, columnIndex6 != -1 && cursor.getInt(columnIndex6) == 1, i));
                }
                arrayList = arrayList2;
            }
            return (f[]) arrayList.toArray(new f[0]);
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    static g f(Context context, a.f.i.a aVar, int i) {
        try {
            e c2 = c(context, null, aVar);
            if (c2.b() != 0) {
                return new g(null, c2.b() == 1 ? -2 : -3);
            }
            Typeface a2 = a.f.e.c.a(context, null, c2.a(), i);
            return new g(a2, a2 != null ? 0 : -3);
        } catch (PackageManager.NameNotFoundException unused) {
            return new g(null, -1);
        }
    }

    public static Typeface g(Context context, a.f.i.a aVar, f.a aVar2, Handler handler, boolean z, int i, int i2) {
        String str = aVar.c() + "-" + i2;
        Typeface c2 = f123a.c(str);
        if (c2 != null) {
            if (aVar2 != null) {
                aVar2.d(c2);
            }
            return c2;
        } else if (z && i == -1) {
            g f2 = f(context, aVar, i2);
            if (aVar2 != null) {
                int i3 = f2.f141b;
                if (i3 == 0) {
                    aVar2.b(f2.f140a, handler);
                } else {
                    aVar2.a(i3, handler);
                }
            }
            return f2.f140a;
        } else {
            a aVar3 = new a(context, aVar, i2, str);
            if (z) {
                try {
                    return ((g) f124b.e(aVar3, i)).f140a;
                } catch (InterruptedException unused) {
                    return null;
                }
            }
            C0006b c0006b = aVar2 == null ? null : new C0006b(aVar2, handler);
            synchronized (f125c) {
                a.d.g<String, ArrayList<c.d<g>>> gVar = f126d;
                if (gVar.containsKey(str)) {
                    if (c0006b != null) {
                        gVar.get(str).add(c0006b);
                    }
                    return null;
                }
                if (c0006b != null) {
                    ArrayList<c.d<g>> arrayList = new ArrayList<>();
                    arrayList.add(c0006b);
                    gVar.put(str, arrayList);
                }
                f124b.d(aVar3, new c(str));
                return null;
            }
        }
    }

    public static ProviderInfo h(PackageManager packageManager, a.f.i.a aVar, Resources resources) {
        String d2 = aVar.d();
        ProviderInfo resolveContentProvider = packageManager.resolveContentProvider(d2, 0);
        if (resolveContentProvider == null) {
            throw new PackageManager.NameNotFoundException("No package found for authority: " + d2);
        } else if (!resolveContentProvider.packageName.equals(aVar.e())) {
            throw new PackageManager.NameNotFoundException("Found content provider " + d2 + ", but package was not " + aVar.e());
        } else {
            List<byte[]> a2 = a(packageManager.getPackageInfo(resolveContentProvider.packageName, 64).signatures);
            Collections.sort(a2, e);
            List<List<byte[]>> d3 = d(aVar, resources);
            for (int i = 0; i < d3.size(); i++) {
                ArrayList arrayList = new ArrayList(d3.get(i));
                Collections.sort(arrayList, e);
                if (b(a2, arrayList)) {
                    return resolveContentProvider;
                }
            }
            return null;
        }
    }

    public static Map<Uri, ByteBuffer> i(Context context, f[] fVarArr, CancellationSignal cancellationSignal) {
        HashMap hashMap = new HashMap();
        for (f fVar : fVarArr) {
            if (fVar.a() == 0) {
                Uri c2 = fVar.c();
                if (!hashMap.containsKey(c2)) {
                    hashMap.put(c2, i.f(context, cancellationSignal, c2));
                }
            }
        }
        return Collections.unmodifiableMap(hashMap);
    }
}
