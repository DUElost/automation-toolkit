package com.ape.offlinescriptmanager.utils.m;

import b.b.a.a.d.i;
import b.b.a.a.d.j;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
/* loaded from: classes.dex */
public class f extends com.ape.offlinescriptmanager.utils.m.a {

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.d.f f2126a = null;

    /* renamed from: b  reason: collision with root package name */
    private b.b.a.a.d.h f2127b = null;

    /* renamed from: c  reason: collision with root package name */
    private b.b.a.a.d.h f2128c = null;

    /* renamed from: d  reason: collision with root package name */
    private b.b.a.a.d.a f2129d = null;
    private b.b.a.a.d.d e = null;
    private j f = null;
    private b.b.a.a.d.e g = null;
    private i h = null;
    private b.b.a.a.d.c i = null;
    private boolean j = false;
    private boolean k = false;
    private int l = 0;

    /* loaded from: classes.dex */
    private class b extends DefaultHandler {
        private b() {
        }

        private void a(Attributes attributes) {
            b.b.a.a.d.e eVar;
            String value = attributes.getValue("name");
            if (f.this.g != null) {
                eVar = f.this.g;
            } else if (f.this.h == null) {
                return;
            } else {
                eVar = f.this.h;
            }
            eVar.p(value);
        }

        private void b(Attributes attributes) {
            b.b.a.a.d.c cVar;
            if (f.this.k) {
                String value = attributes.getValue("name");
                String value2 = attributes.getValue("value");
                if (value.isEmpty()) {
                    return;
                }
                b.b.a.a.d.b bVar = new b.b.a.a.d.b(value, value2);
                if (f.this.i != null) {
                    f.this.i.f(bVar);
                    return;
                }
                if (f.this.f != null) {
                    cVar = f.this.f;
                } else if (f.this.g != null) {
                    cVar = f.this.g;
                } else if (f.this.h == null) {
                    return;
                } else {
                    cVar = f.this.h;
                }
                cVar.f(bVar);
            }
        }

        private void c(Attributes attributes) {
            b.b.a.a.d.e eVar;
            String value = attributes.getValue("name");
            if (f.this.f != null) {
                f.this.f.o(value);
                return;
            }
            if (f.this.g != null) {
                eVar = f.this.g;
            } else if (f.this.h == null) {
                return;
            } else {
                eVar = f.this.h;
            }
            eVar.q(value);
        }

        private void d(Attributes attributes) {
            String value = attributes.getValue("name");
            if (f.this.f2129d != null) {
                f.this.f2129d.o(value);
            }
        }

        private void e(Attributes attributes) {
            String value = attributes.getValue("name");
            if (f.this.e != null) {
                f.this.e.o(value);
            }
        }

        private void f(Attributes attributes) {
            b.b.a.a.d.h hVar;
            String value = attributes.getValue("content");
            if (1 == f.this.l) {
                hVar = f.this.f2127b;
            } else if (2 != f.this.l) {
                if (3 == f.this.l) {
                    f.this.i.g(value);
                    return;
                }
                return;
            } else {
                hVar = f.this.f2128c;
            }
            hVar.g(value);
        }

        private void g(Attributes attributes) {
            String value = attributes.getValue("name");
            if (f.this.i != null) {
                f.this.i.c(value);
            }
        }

        private void h(Attributes attributes) {
            String value = attributes.getValue("name");
            if (f.this.f != null) {
                f.this.f.p(value);
            }
        }

        private void i(Attributes attributes) {
            b.b.a.a.d.e eVar;
            String value = attributes.getValue("name");
            if (f.this.f != null) {
                f.this.f.q(value);
                return;
            }
            if (f.this.g != null) {
                eVar = f.this.g;
            } else if (f.this.h == null) {
                return;
            } else {
                eVar = f.this.h;
            }
            eVar.s(value);
        }

        private void j(Attributes attributes) {
            b.b.a.a.d.e eVar;
            String value = attributes.getValue("name");
            if (f.this.g != null) {
                eVar = f.this.g;
            } else if (f.this.h == null) {
                return;
            } else {
                eVar = f.this.h;
            }
            eVar.r(value);
        }

        private void k(Attributes attributes) {
            f.this.f2128c = new b.b.a.a.d.h();
            if (attributes != null) {
                f.this.f2128c.p(attributes.getValue("name"));
            }
            if (f.this.f2126a != null) {
                f.this.f2126a.q(f.this.f2128c);
            }
        }

        private void l(Attributes attributes) {
            b.b.a.a.d.f fVar;
            boolean z;
            f.this.f2126a = new b.b.a.a.d.f();
            if (attributes != null) {
                f.this.f2126a.o(attributes.getValue("name"));
                f.this.f2126a.w(Integer.parseInt(attributes.getValue("times")));
                String value = attributes.getValue("testpointRegressionTimes");
                if (value != null) {
                    f.this.f2126a.u(Integer.parseInt(value));
                }
                String value2 = attributes.getValue("taskRegressionType");
                if (value2 != null) {
                    f.this.f2126a.s(Integer.parseInt(value2));
                }
                String value3 = attributes.getValue("caseRegressionType");
                if (value3 != null) {
                    f.this.f2126a.m(Integer.parseInt(value3));
                }
                String value4 = attributes.getValue("takeScreenshot");
                if (value4 != null) {
                    if (value4.equalsIgnoreCase("false")) {
                        fVar = f.this.f2126a;
                        z = false;
                    } else if (value4.equalsIgnoreCase("true")) {
                        fVar = f.this.f2126a;
                        z = true;
                    }
                    fVar.r(z);
                }
                String value5 = attributes.getValue("testTimeOut");
                if (value5 != null) {
                    f.this.f2126a.v(Integer.parseInt(value5));
                }
            }
        }

        /* JADX WARN: Removed duplicated region for block: B:20:0x00dc A[RETURN] */
        /* JADX WARN: Removed duplicated region for block: B:21:0x00dd  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void m(org.xml.sax.Attributes r4) {
            /*
                Method dump skipped, instructions count: 268
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.utils.m.f.b.m(org.xml.sax.Attributes):void");
        }

        private void n(Attributes attributes) {
            f.this.f2127b = new b.b.a.a.d.h();
            if (attributes != null) {
                f.this.f2127b.p(attributes.getValue("name"));
                f.this.f2127b.q(Integer.parseInt(attributes.getValue("times")));
            }
            if (f.this.f2126a != null) {
                f.this.f2126a.a(f.this.f2127b);
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void characters(char[] cArr, int i, int i2) {
            super.characters(cArr, i, i2);
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void endElement(String str, String str2, String str3) {
            if ("proviouspoint".equals(str2)) {
                f.this.j = false;
            } else if ("attribute".equals(str2)) {
                f.this.k = false;
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void startElement(String str, String str2, String str3, Attributes attributes) {
            f fVar;
            int i;
            if ("task".equals(str2)) {
                l(attributes);
            } else if ("testpoint".equals(str2)) {
                n(attributes);
                f.this.l = 1;
            } else {
                if ("testcase".equals(str2)) {
                    m(attributes);
                    fVar = f.this;
                    i = 3;
                } else if ("description".equals(str2)) {
                    f(attributes);
                    return;
                } else if ("device".equals(str2)) {
                    g(attributes);
                    return;
                } else if ("jar".equals(str2)) {
                    h(attributes);
                    return;
                } else if ("apk".equals(str2)) {
                    a(attributes);
                    return;
                } else if ("package".equals(str2)) {
                    j(attributes);
                    return;
                } else if ("class".equals(str2)) {
                    c(attributes);
                    return;
                } else if ("method".equals(str2)) {
                    i(attributes);
                    return;
                } else if ("arg".equals(str2)) {
                    b(attributes);
                    return;
                } else if ("attribute".equals(str2)) {
                    f.this.k = true;
                    return;
                } else if ("cmd".equals(str2)) {
                    d(attributes);
                    return;
                } else if ("command".equals(str2)) {
                    e(attributes);
                    return;
                } else if (!"proviouspoint".equals(str2)) {
                    return;
                } else {
                    k(attributes);
                    f.this.j = true;
                    fVar = f.this;
                    i = 2;
                }
                fVar.l = i;
            }
        }
    }

    public b.b.a.a.d.f B() {
        return this.f2126a;
    }

    @Override // com.ape.offlinescriptmanager.utils.m.a
    public DefaultHandler a() {
        return new b();
    }
}
