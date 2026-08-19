package com.ape.offlinescriptmanager.utils.m;

import b.b.a.a.c.i;
import b.b.a.a.c.j;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
/* loaded from: classes.dex */
public class b extends com.ape.offlinescriptmanager.utils.m.a {

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.c.f f2105a = null;

    /* renamed from: b  reason: collision with root package name */
    private b.b.a.a.c.h f2106b = null;

    /* renamed from: c  reason: collision with root package name */
    private j f2107c = null;

    /* renamed from: d  reason: collision with root package name */
    private b.b.a.a.c.e f2108d = null;
    private b.b.a.a.c.d e = null;
    private i f = null;
    private boolean g = false;

    /* renamed from: com.ape.offlinescriptmanager.utils.m.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private class C0082b extends DefaultHandler {

        /* renamed from: a  reason: collision with root package name */
        private String f2109a;

        private C0082b() {
        }

        private void a(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.f2108d != null) {
                b.this.f2108d.j(value);
            } else if (b.this.f != null) {
                b.this.f.o(value);
            }
        }

        private void b(Attributes attributes) {
            if (b.this.g) {
                String value = attributes.getValue("name");
                String value2 = attributes.getValue("value");
                if (value.isEmpty()) {
                    return;
                }
                b.b.a.a.c.a aVar = new b.b.a.a.c.a(value, value2);
                if (b.this.f2107c != null) {
                    b.this.f2107c.h(aVar);
                } else if (b.this.e != null) {
                    b.this.e.h(aVar);
                } else if (b.this.f != null) {
                    b.this.f.h(aVar);
                }
            }
        }

        private void c(Attributes attributes) {
            String value = attributes.getValue("name");
            if (value != null) {
                String substring = value.substring(0, value.lastIndexOf("."));
                if (substring.length() < this.f2109a.length() || !substring.contains(this.f2109a)) {
                    if (b.this.f2108d != null) {
                        b.this.f2108d.l(this.f2109a);
                    } else if (b.this.f != null) {
                        b.this.f.q(this.f2109a);
                    }
                } else if (b.this.f2108d != null) {
                    b.this.f2108d.l(substring);
                } else if (b.this.f != null) {
                    b.this.f.q(substring);
                }
            }
            if (b.this.f2107c != null) {
                b.this.f2107c.o(value);
            } else if (b.this.f2108d != null) {
                b.this.f2108d.k(value);
            } else if (b.this.f != null) {
                b.this.f.p(value);
            }
        }

        private void d(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.e != null) {
                b.this.e.m(value);
            }
        }

        private void e(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.f2107c != null) {
                b.this.f2107c.p(value);
            } else if (b.this.f2108d != null) {
                b.this.f2108d.m(value);
            } else if (b.this.f != null) {
                b.this.f.r(value);
            }
        }

        private void f(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.f2107c != null) {
                b.this.f2107c.q(value);
            }
        }

        private void g(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.f2107c != null) {
                b.this.f2107c.r(value);
            } else if (b.this.f2108d != null) {
                b.this.f2108d.n(value);
            } else if (b.this.f != null) {
                b.this.f.s(value);
            }
        }

        private void h(Attributes attributes) {
            this.f2109a = attributes.getValue("name");
            if (b.this.f2108d != null) {
                b.this.f2108d.o(this.f2109a);
            } else if (b.this.f != null) {
                b.this.f.t(this.f2109a);
            }
        }

        private void i(Attributes attributes) {
            String value = attributes.getValue("name");
            if (b.this.f2107c != null) {
                b.this.f2107c.s(value);
            } else if (b.this.f2108d != null) {
                b.this.f2108d.p(value);
            } else if (b.this.f != null) {
                b.this.f.u(value);
            }
        }

        private void j(Attributes attributes) {
            b.b.a.a.c.f fVar;
            boolean z;
            b.this.f2105a = new b.b.a.a.c.f();
            if (attributes != null) {
                b.this.f2105a.k(attributes.getValue("name"));
                b.this.f2105a.b(Integer.parseInt(attributes.getValue("times")));
                String value = attributes.getValue("testTimeOut");
                if (value != null) {
                    b.this.f2105a.o(Integer.parseInt(value));
                }
                String value2 = attributes.getValue("testpointRegressionTimes");
                if (value2 != null) {
                    b.this.f2105a.n(Integer.parseInt(value2));
                }
                String value3 = attributes.getValue("taskRegressionType");
                if (value3 != null) {
                    b.this.f2105a.m(Integer.parseInt(value3));
                }
                String value4 = attributes.getValue("caseRegressionType");
                if (value4 != null) {
                    b.this.f2105a.j(Integer.parseInt(value4));
                }
                String value5 = attributes.getValue("stopWhenFail");
                if (value5 != null) {
                    if (value5.equalsIgnoreCase("false")) {
                        fVar = b.this.f2105a;
                        z = false;
                    } else if (!value5.equalsIgnoreCase("true")) {
                        return;
                    } else {
                        fVar = b.this.f2105a;
                        z = true;
                    }
                    fVar.l(z);
                }
            }
        }

        private void k(Attributes attributes) {
            b.b.a.a.c.c cVar;
            String value = attributes.getValue("type");
            int parseInt = Integer.parseInt(attributes.getValue("times"));
            b.this.f2107c = null;
            b.this.f2108d = null;
            b.this.e = null;
            b.this.f = null;
            if ("adb".equals(value)) {
                b.this.e = new b.b.a.a.c.d();
                b.this.e.n(parseInt);
                cVar = b.this.e;
            } else if ("uiautomator".equals(value)) {
                b.this.f2107c = new j();
                b.this.f2107c.u(parseInt);
                b.this.f2107c.t(b.this.f2105a.i());
                cVar = b.this.f2107c;
            } else if ("robotium".equals(value)) {
                b.this.f2108d = new b.b.a.a.c.e();
                b.this.f2108d.r(parseInt);
                b.this.f2108d.q(b.this.f2105a.i());
                cVar = b.this.f2108d;
            } else if (!"uiautomator2".equals(value)) {
                com.ape.offlinescriptmanager.utils.b.d("task xml have type = %s unknown", value);
                return;
            } else {
                b.this.f = new i();
                b.this.f.w(parseInt);
                b.this.f.v(b.this.f2105a.i());
                cVar = b.this.f;
            }
            if (b.this.f2106b != null) {
                b.this.f2106b.c(cVar);
            }
        }

        private void l(Attributes attributes) {
            b.this.f2106b = new b.b.a.a.c.h();
            if (attributes != null) {
                b.this.f2106b.h(attributes.getValue("name"));
                b.this.f2106b.b(Integer.parseInt(attributes.getValue("times")));
            }
            if (b.this.f2105a != null) {
                b.this.f2105a.c(b.this.f2106b);
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void characters(char[] cArr, int i, int i2) {
            super.characters(cArr, i, i2);
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void endElement(String str, String str2, String str3) {
            if ("attribute".equals(str2)) {
                b.this.g = false;
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void startElement(String str, String str2, String str3, Attributes attributes) {
            if ("runtask".equals(str2)) {
                j(attributes);
            } else if ("testpoint".equals(str2)) {
                l(attributes);
            } else if ("testcase".equals(str2)) {
                k(attributes);
            } else if ("device".equals(str2)) {
                e(attributes);
            } else if ("jar".equals(str2)) {
                f(attributes);
            } else if ("apk".equals(str2)) {
                a(attributes);
            } else if ("package".equals(str2)) {
                h(attributes);
            } else if ("class".equals(str2)) {
                c(attributes);
            } else if ("method".equals(str2)) {
                g(attributes);
            } else if ("runner".equals(str2)) {
                i(attributes);
            } else if ("arg".equals(str2)) {
                b(attributes);
            } else if ("attribute".equals(str2)) {
                b.this.g = true;
            } else if ("cmd".equals(str2)) {
                d(attributes);
            }
        }
    }

    @Override // com.ape.offlinescriptmanager.utils.m.a
    public DefaultHandler a() {
        return new C0082b();
    }

    public b.b.a.a.c.f r() {
        return this.f2105a;
    }
}
