package com.ape.offlinescriptmanager.utils.m;

import android.util.Log;
import java.util.Iterator;
import java.util.Stack;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
/* loaded from: classes.dex */
public class h extends com.ape.offlinescriptmanager.utils.m.a {

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.a.a f2134a = null;

    /* loaded from: classes.dex */
    private class b extends DefaultHandler {

        /* renamed from: a  reason: collision with root package name */
        private Stack<String> f2135a;

        private b() {
            this.f2135a = new Stack<>();
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void endElement(String str, String str2, String str3) {
            if ("TestSuite".equals(str2) || "TestCase".equals(str2)) {
                this.f2135a.pop();
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void startElement(String str, String str2, String str3, Attributes attributes) {
            String format;
            String value;
            String str4;
            if ("TestPackage".equals(str2)) {
                String value2 = attributes.getValue("jarPath");
                String str5 = null;
                if (value2 == null) {
                    value2 = attributes.getValue("apkPath");
                    str5 = attributes.getValue("appPackageName");
                    str4 = attributes.getValue("testType");
                } else {
                    str4 = null;
                }
                h.this.f2134a = new b.b.a.a.a.a();
                h.this.f2134a.f1340c = value2;
                h.this.f2134a.e = str5;
                h.this.f2134a.f1338a = str4;
                this.f2135a = new Stack<>();
            } else if ("TestSuite".equals(str2)) {
                value = attributes.getValue("name");
                if (value == null) {
                    format = String.format("Invalid XML: missing 'name' attribute for '%s'", "TestSuite");
                    Log.e("UiAutomatorXmlLoader", format);
                }
                this.f2135a.push(value);
            } else {
                if ("TestCase".equals(str2)) {
                    value = attributes.getValue("name");
                    if (value == null) {
                        format = String.format("Invalid XML: missing 'name' attribute for '%s'", "TestCase");
                    }
                    this.f2135a.push(value);
                } else if (!"Test".equals(str2)) {
                    return;
                } else {
                    String value3 = attributes.getValue("name");
                    if (h.this.f2134a == null) {
                        format = String.format("Invalid XML: encountered a '%s' tag not enclosed within a '%s' tag", "Test", "TestPackage");
                    } else if (value3 != null) {
                        StringBuilder sb = new StringBuilder();
                        Iterator<String> it = this.f2135a.iterator();
                        while (it.hasNext()) {
                            sb.append(it.next());
                            if (it.hasNext()) {
                                sb.append(".");
                            }
                        }
                        h.this.f2134a.g.add(new b.b.a.a.a.b(sb.toString(), value3));
                        return;
                    } else {
                        format = String.format("Invalid XML: missing 'name' attribute for '%s'", "Test");
                    }
                }
                Log.e("UiAutomatorXmlLoader", format);
            }
        }
    }

    @Override // com.ape.offlinescriptmanager.utils.m.a
    public DefaultHandler a() {
        return new b();
    }

    public b.b.a.a.a.a f() {
        return this.f2134a;
    }
}
