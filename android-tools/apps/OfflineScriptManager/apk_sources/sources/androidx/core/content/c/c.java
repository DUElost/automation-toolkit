package androidx.core.content.c;

import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Build;
import android.util.Base64;
import android.util.TypedValue;
import android.util.Xml;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
/* loaded from: classes.dex */
public class c {

    /* loaded from: classes.dex */
    public interface a {
    }

    /* loaded from: classes.dex */
    public static final class b implements a {

        /* renamed from: a  reason: collision with root package name */
        private final C0031c[] f864a;

        public b(C0031c[] c0031cArr) {
            this.f864a = c0031cArr;
        }

        public C0031c[] a() {
            return this.f864a;
        }
    }

    /* renamed from: androidx.core.content.c.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static final class C0031c {

        /* renamed from: a  reason: collision with root package name */
        private final String f865a;

        /* renamed from: b  reason: collision with root package name */
        private int f866b;

        /* renamed from: c  reason: collision with root package name */
        private boolean f867c;

        /* renamed from: d  reason: collision with root package name */
        private String f868d;
        private int e;
        private int f;

        public C0031c(String str, int i, boolean z, String str2, int i2, int i3) {
            this.f865a = str;
            this.f866b = i;
            this.f867c = z;
            this.f868d = str2;
            this.e = i2;
            this.f = i3;
        }

        public String a() {
            return this.f865a;
        }

        public int b() {
            return this.f;
        }

        public int c() {
            return this.e;
        }

        public String d() {
            return this.f868d;
        }

        public int e() {
            return this.f866b;
        }

        public boolean f() {
            return this.f867c;
        }
    }

    /* loaded from: classes.dex */
    public static final class d implements a {

        /* renamed from: a  reason: collision with root package name */
        private final a.f.i.a f869a;

        /* renamed from: b  reason: collision with root package name */
        private final int f870b;

        /* renamed from: c  reason: collision with root package name */
        private final int f871c;

        public d(a.f.i.a aVar, int i, int i2) {
            this.f869a = aVar;
            this.f871c = i;
            this.f870b = i2;
        }

        public int a() {
            return this.f871c;
        }

        public a.f.i.a b() {
            return this.f869a;
        }

        public int c() {
            return this.f870b;
        }
    }

    private static int a(TypedArray typedArray, int i) {
        if (Build.VERSION.SDK_INT >= 21) {
            return typedArray.getType(i);
        }
        TypedValue typedValue = new TypedValue();
        typedArray.getValue(i, typedValue);
        return typedValue.type;
    }

    public static a b(XmlPullParser xmlPullParser, Resources resources) {
        int next;
        do {
            next = xmlPullParser.next();
            if (next == 2) {
                break;
            }
        } while (next != 1);
        if (next == 2) {
            return d(xmlPullParser, resources);
        }
        throw new org.xmlpull.v1.a("No start tag found");
    }

    public static List<List<byte[]>> c(Resources resources, int i) {
        if (i == 0) {
            return Collections.emptyList();
        }
        TypedArray obtainTypedArray = resources.obtainTypedArray(i);
        try {
            if (obtainTypedArray.length() == 0) {
                return Collections.emptyList();
            }
            ArrayList arrayList = new ArrayList();
            if (a(obtainTypedArray, 0) == 1) {
                for (int i2 = 0; i2 < obtainTypedArray.length(); i2++) {
                    int resourceId = obtainTypedArray.getResourceId(i2, 0);
                    if (resourceId != 0) {
                        arrayList.add(h(resources.getStringArray(resourceId)));
                    }
                }
            } else {
                arrayList.add(h(resources.getStringArray(i)));
            }
            return arrayList;
        } finally {
            obtainTypedArray.recycle();
        }
    }

    private static a d(XmlPullParser xmlPullParser, Resources resources) {
        xmlPullParser.require(2, null, "font-family");
        if (xmlPullParser.getName().equals("font-family")) {
            return e(xmlPullParser, resources);
        }
        g(xmlPullParser);
        return null;
    }

    private static a e(XmlPullParser xmlPullParser, Resources resources) {
        TypedArray obtainAttributes = resources.obtainAttributes(Xml.asAttributeSet(xmlPullParser), a.f.d.FontFamily);
        String string = obtainAttributes.getString(a.f.d.FontFamily_fontProviderAuthority);
        String string2 = obtainAttributes.getString(a.f.d.FontFamily_fontProviderPackage);
        String string3 = obtainAttributes.getString(a.f.d.FontFamily_fontProviderQuery);
        int resourceId = obtainAttributes.getResourceId(a.f.d.FontFamily_fontProviderCerts, 0);
        int integer = obtainAttributes.getInteger(a.f.d.FontFamily_fontProviderFetchStrategy, 1);
        int integer2 = obtainAttributes.getInteger(a.f.d.FontFamily_fontProviderFetchTimeout, 500);
        obtainAttributes.recycle();
        if (string != null && string2 != null && string3 != null) {
            while (xmlPullParser.next() != 3) {
                g(xmlPullParser);
            }
            return new d(new a.f.i.a(string, string2, string3, c(resources, resourceId)), integer, integer2);
        }
        ArrayList arrayList = new ArrayList();
        while (xmlPullParser.next() != 3) {
            if (xmlPullParser.getEventType() == 2) {
                if (xmlPullParser.getName().equals("font")) {
                    arrayList.add(f(xmlPullParser, resources));
                } else {
                    g(xmlPullParser);
                }
            }
        }
        if (arrayList.isEmpty()) {
            return null;
        }
        return new b((C0031c[]) arrayList.toArray(new C0031c[arrayList.size()]));
    }

    private static C0031c f(XmlPullParser xmlPullParser, Resources resources) {
        TypedArray obtainAttributes = resources.obtainAttributes(Xml.asAttributeSet(xmlPullParser), a.f.d.FontFamilyFont);
        int i = a.f.d.FontFamilyFont_fontWeight;
        if (!obtainAttributes.hasValue(i)) {
            i = a.f.d.FontFamilyFont_android_fontWeight;
        }
        int i2 = obtainAttributes.getInt(i, 400);
        int i3 = a.f.d.FontFamilyFont_fontStyle;
        if (!obtainAttributes.hasValue(i3)) {
            i3 = a.f.d.FontFamilyFont_android_fontStyle;
        }
        boolean z = 1 == obtainAttributes.getInt(i3, 0);
        int i4 = a.f.d.FontFamilyFont_ttcIndex;
        if (!obtainAttributes.hasValue(i4)) {
            i4 = a.f.d.FontFamilyFont_android_ttcIndex;
        }
        int i5 = a.f.d.FontFamilyFont_fontVariationSettings;
        if (!obtainAttributes.hasValue(i5)) {
            i5 = a.f.d.FontFamilyFont_android_fontVariationSettings;
        }
        String string = obtainAttributes.getString(i5);
        int i6 = obtainAttributes.getInt(i4, 0);
        int i7 = a.f.d.FontFamilyFont_font;
        if (!obtainAttributes.hasValue(i7)) {
            i7 = a.f.d.FontFamilyFont_android_font;
        }
        int resourceId = obtainAttributes.getResourceId(i7, 0);
        String string2 = obtainAttributes.getString(i7);
        obtainAttributes.recycle();
        while (xmlPullParser.next() != 3) {
            g(xmlPullParser);
        }
        return new C0031c(string2, i2, z, string, i6, resourceId);
    }

    private static void g(XmlPullParser xmlPullParser) {
        int i = 1;
        while (i > 0) {
            int next = xmlPullParser.next();
            if (next == 2) {
                i++;
            } else if (next == 3) {
                i--;
            }
        }
    }

    private static List<byte[]> h(String[] strArr) {
        ArrayList arrayList = new ArrayList();
        for (String str : strArr) {
            arrayList.add(Base64.decode(str, 0));
        }
        return arrayList;
    }
}
