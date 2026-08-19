package com.ape.offlinescriptmanager.utils.m;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
/* loaded from: classes.dex */
public class c extends com.ape.offlinescriptmanager.utils.m.a {

    /* renamed from: b  reason: collision with root package name */
    private Map<String, Object> f2112b;

    /* renamed from: c  reason: collision with root package name */
    private Map<String, Object> f2113c;

    /* renamed from: a  reason: collision with root package name */
    private Map<String, Object> f2111a = new HashMap();

    /* renamed from: d  reason: collision with root package name */
    private List<Map<String, Object>> f2114d = new ArrayList();
    private List<Map<String, Object>> e = null;
    private int f = 0;

    /* loaded from: classes.dex */
    private class b extends DefaultHandler {

        /* renamed from: a  reason: collision with root package name */
        private String f2115a;

        /* renamed from: b  reason: collision with root package name */
        private StringBuilder f2116b;

        private b() {
            this.f2115a = null;
        }

        private void a(Attributes attributes) {
            if (attributes != null) {
                String value = attributes.getValue("taskname");
                c.this.f2111a.put("task_name", value);
                PrintStream printStream = System.out;
                printStream.println("RunTestResultXmlLoader getTaskName is " + value);
            }
        }

        private void b(Attributes attributes) {
            if (attributes != null) {
                c.this.f2113c = new HashMap();
                c.this.f2113c.put("type", attributes.getValue("type"));
                c.this.f2113c.put("serial_number", attributes.getValue("serialnumber"));
                c.this.f2113c.put("cmd_script", attributes.getValue("command"));
                c.this.f2113c.put("class_name", attributes.getValue("classname"));
                c.this.f2113c.put("method_name", attributes.getValue("name"));
                String value = attributes.getValue("starttime");
                c.this.f2113c.put("start_time", Long.valueOf(Long.parseLong(value)));
                String value2 = attributes.getValue("endtime");
                c.this.f2113c.put("end_time", Long.valueOf(Long.parseLong(value2)));
                c.this.f2113c.put("elapsed_time", Long.valueOf(Long.parseLong(value2) - Long.parseLong(value)));
                attributes.getValue("package");
                c.this.f2113c.put("package_name", BuildConfig.FLAVOR);
                c.this.f2113c.put("test_status", "pass");
                c.this.f2113c.put("trace", BuildConfig.FLAVOR);
                c.this.f2113c.put("failure_type", BuildConfig.FLAVOR);
            }
            if (c.this.e != null) {
                c.this.e.add(c.this.f2113c);
            }
            if (c.this.f2112b != null) {
                c.this.f2112b.put("case_results", c.this.e);
            }
        }

        private void c(Attributes attributes) {
            c.this.f2112b = new HashMap();
            c.this.e = new ArrayList();
            if (attributes != null) {
                c.this.f2112b.put("testpoint_name", attributes.getValue("name"));
                c.this.f2112b.put("testpoint_status", d(attributes));
                c.this.f2112b.put("tests", attributes.getValue("tests"));
                String value = attributes.getValue("starttime");
                c.this.f2112b.put("testpoint_start_time", Long.valueOf(Long.parseLong(value)));
                String value2 = attributes.getValue("endtime");
                c.this.f2112b.put("testpoint_end_time", Long.valueOf(Long.parseLong(value2)));
                c.this.f2112b.put("testpoint_elapsed_time", Long.valueOf(Long.parseLong(value2) - Long.parseLong(value)));
                c.this.f2112b.put("key", Integer.valueOf(c.this.f));
            }
            if (c.this.f2114d != null) {
                c.this.f2114d.add(c.this.f2112b);
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void characters(char[] cArr, int i, int i2) {
            super.characters(cArr, i, i2);
            if (this.f2115a != null) {
                this.f2116b.append(new String(cArr, i, i2).trim());
                if (!"failure".equals(this.f2115a) || c.this.f2113c == null) {
                    return;
                }
                c.this.f2113c.put("trace", this.f2116b.toString());
                c.this.f2113c.put("test_status", "failure");
                System.out.println(this.f2116b.toString());
            }
        }

        public String d(Attributes attributes) {
            return (attributes == null || Integer.parseInt(attributes.getValue("failures").trim()) != 0) ? "failure" : "pass";
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void endElement(String str, String str2, String str3) {
            this.f2115a = null;
            if ("testpoint".equals(str2)) {
                c.this.f2112b = null;
                c.this.e = null;
            } else if ("testcase".equals(str2)) {
                c.this.f2113c = null;
            }
        }

        @Override // org.xml.sax.helpers.DefaultHandler, org.xml.sax.ContentHandler
        public void startElement(String str, String str2, String str3, Attributes attributes) {
            if ("testpoints".equals(str2)) {
                a(attributes);
            } else if ("testpoint".equals(str2)) {
                c.e(c.this);
                c(attributes);
            } else if ("testcase".equals(str2)) {
                b(attributes);
            }
            this.f2115a = str2;
            this.f2116b = new StringBuilder();
        }
    }

    static /* synthetic */ int e(c cVar) {
        int i = cVar.f;
        cVar.f = i + 1;
        return i;
    }

    @Override // com.ape.offlinescriptmanager.utils.m.a
    public DefaultHandler a() {
        return new b();
    }

    public Map<String, Object> n() {
        this.f2111a.put("test_points", this.f2114d);
        PrintStream printStream = System.out;
        printStream.println("test_result_map is " + this.f2111a);
        return this.f2111a;
    }
}
