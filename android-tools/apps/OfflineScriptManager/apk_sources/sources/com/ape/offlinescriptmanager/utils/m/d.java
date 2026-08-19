package com.ape.offlinescriptmanager.utils.m;

import me.zhanghai.android.materialprogressbar.BuildConfig;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
/* loaded from: classes.dex */
public class d extends com.ape.offlinescriptmanager.utils.m.a {

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.e.e f2118a = null;

    /* renamed from: b  reason: collision with root package name */
    private b.b.a.a.e.d f2119b = null;

    /* renamed from: c  reason: collision with root package name */
    private b.b.a.a.e.a f2120c = null;

    /* renamed from: d  reason: collision with root package name */
    private b.b.a.a.e.c f2121d = null;
    private b.b.a.a.e.b e = null;
    private String f = BuildConfig.FLAVOR;
    private String g = BuildConfig.FLAVOR;
    private String h = BuildConfig.FLAVOR;
    private String i = BuildConfig.FLAVOR;
    private String j = BuildConfig.FLAVOR;
    private String k = BuildConfig.FLAVOR;
    private String l = BuildConfig.FLAVOR;
    private String m = BuildConfig.FLAVOR;
    private String n = BuildConfig.FLAVOR;
    private String o = BuildConfig.FLAVOR;
    private String p = BuildConfig.FLAVOR;

    /* loaded from: classes.dex */
    private class b extends DefaultHandler {
        private b() {
        }

        private void a(Attributes attributes) {
            if (attributes != null) {
                d.this.f2118a.a(attributes.getQName(0), attributes.getValue(0));
            }
        }

        private void b(Attributes attributes) {
            d.this.f2120c = new b.b.a.a.e.a();
            if (attributes != null) {
                d.this.f2120c.d(attributes.getValue("name"));
            }
            if (d.this.f2119b != null) {
                d.this.f2119b.a(d.this.f2120c);
            }
        }

        private void c(Attributes attributes) {
            b.b.a.a.e.b bVar;
            String str;
            d.this.e = new b.b.a.a.e.b();
            if (attributes != null) {
                d.this.e.c(attributes.getValue("name"));
                String value = attributes.getValue("value");
                if (value.startsWith("@@")) {
                    if (value.equals("@@localnumber1")) {
                        bVar = d.this.e;
                        str = d.this.f;
                    } else if (value.equals("@@localnumber2")) {
                        bVar = d.this.e;
                        str = d.this.g;
                    } else if (value.equals("@@remotenumber1")) {
                        bVar = d.this.e;
                        str = d.this.j;
                    } else if (value.equals("@@devicebnumber1")) {
                        bVar = d.this.e;
                        str = d.this.h;
                    } else if (value.equals("@@devicebnumber2")) {
                        bVar = d.this.e;
                        str = d.this.i;
                    } else if (value.equals("@@EmailAccount")) {
                        bVar = d.this.e;
                        str = d.this.k;
                    } else if (value.equals("@@EmailPassword")) {
                        bVar = d.this.e;
                        str = d.this.l;
                    } else if (value.equals("@@GoogleAccount")) {
                        bVar = d.this.e;
                        str = d.this.m;
                    } else if (value.equals("@@GooglePassword")) {
                        bVar = d.this.e;
                        str = d.this.n;
                    } else if (value.equals("@@WifiAccount")) {
                        bVar = d.this.e;
                        str = d.this.o;
                    } else if (value.equals("@@WifiPassword")) {
                        bVar = d.this.e;
                        str = d.this.p;
                    }
                    bVar.d(str);
                } else {
                    d.this.e.d(value);
                }
            }
            if (d.this.f2121d != null) {
                d.this.f2121d.a(d.this.e);
            }
        }

        private void d(Attributes attributes) {
            d.this.f2121d = new b.b.a.a.e.c();
            if (attributes != null) {
                d.this.f2121d.d(attributes.getValue("name"));
            }
            if (d.this.f2120c != null) {
                d.this.f2120c.a(d.this.f2121d);
            }
        }

        private void e(Attributes attributes) {
            d.this.f2119b = new b.b.a.a.e.d();
            if (attributes != null) {
                d.this.f2119b.e(attributes.getValue("appPackageName"));
            }
            if (d.this.f2118a != null) {
                d.this.f2118a.b(d.this.f2119b);
            }
        }

        private void f(Attributes attributes) {
            d.this.f2118a = new b.b.a.a.e.e();
            if (attributes != null) {
                d.this.f2118a.g(attributes.getValue("name"));
                d.this.f2118a.h(attributes.getValue("TakeScreenshot"));
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void characters(char[] cArr, int i, int i2) {
            super.characters(cArr, i, i2);
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void endElement(String str, String str2, String str3) {
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void startElement(String str, String str2, String str3, Attributes attributes) {
            if ("TestSet".equals(str2)) {
                f(attributes);
            } else if ("TestPackage".equals(str2)) {
                e(attributes);
            } else if ("TestCase".equals(str2)) {
                b(attributes);
            } else if ("TestMethod".equals(str2)) {
                d(attributes);
            } else if ("TestData".equals(str2)) {
                c(attributes);
            } else if ("SIM".equals(str2)) {
                a(attributes);
            }
        }
    }

    @Override // com.ape.offlinescriptmanager.utils.m.a
    public DefaultHandler a() {
        return new b();
    }

    public b.b.a.a.e.e y() {
        return this.f2118a;
    }
}
