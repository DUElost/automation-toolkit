package a.a.m;

import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.PorterDuff;
import android.util.AttributeSet;
import android.util.Log;
import android.util.Xml;
import android.view.InflateException;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.SubMenu;
import android.view.View;
import androidx.appcompat.view.menu.j;
import androidx.appcompat.view.menu.k;
import androidx.appcompat.widget.z;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
/* loaded from: classes.dex */
public class g extends MenuInflater {
    static final Class<?>[] e;
    static final Class<?>[] f;

    /* renamed from: a  reason: collision with root package name */
    final Object[] f36a;

    /* renamed from: b  reason: collision with root package name */
    final Object[] f37b;

    /* renamed from: c  reason: collision with root package name */
    Context f38c;

    /* renamed from: d  reason: collision with root package name */
    private Object f39d;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class a implements MenuItem.OnMenuItemClickListener {

        /* renamed from: c  reason: collision with root package name */
        private static final Class<?>[] f40c = {MenuItem.class};

        /* renamed from: a  reason: collision with root package name */
        private Object f41a;

        /* renamed from: b  reason: collision with root package name */
        private Method f42b;

        public a(Object obj, String str) {
            this.f41a = obj;
            Class<?> cls = obj.getClass();
            try {
                this.f42b = cls.getMethod(str, f40c);
            } catch (Exception e) {
                InflateException inflateException = new InflateException("Couldn't resolve menu item onClick handler " + str + " in class " + cls.getName());
                inflateException.initCause(e);
                throw inflateException;
            }
        }

        @Override // android.view.MenuItem.OnMenuItemClickListener
        public boolean onMenuItemClick(MenuItem menuItem) {
            try {
                if (this.f42b.getReturnType() == Boolean.TYPE) {
                    return ((Boolean) this.f42b.invoke(this.f41a, menuItem)).booleanValue();
                }
                this.f42b.invoke(this.f41a, menuItem);
                return true;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class b {
        a.f.l.b A;
        private CharSequence B;
        private CharSequence C;
        private ColorStateList D = null;
        private PorterDuff.Mode E = null;

        /* renamed from: a  reason: collision with root package name */
        private Menu f43a;

        /* renamed from: b  reason: collision with root package name */
        private int f44b;

        /* renamed from: c  reason: collision with root package name */
        private int f45c;

        /* renamed from: d  reason: collision with root package name */
        private int f46d;
        private int e;
        private boolean f;
        private boolean g;
        private boolean h;
        private int i;
        private int j;
        private CharSequence k;
        private CharSequence l;
        private int m;
        private char n;
        private int o;
        private char p;
        private int q;
        private int r;
        private boolean s;
        private boolean t;
        private boolean u;
        private int v;
        private int w;
        private String x;
        private String y;
        private String z;

        public b(Menu menu) {
            this.f43a = menu;
            h();
        }

        private char c(String str) {
            if (str == null) {
                return (char) 0;
            }
            return str.charAt(0);
        }

        private <T> T e(String str, Class<?>[] clsArr, Object[] objArr) {
            try {
                Constructor<?> constructor = g.this.f38c.getClassLoader().loadClass(str).getConstructor(clsArr);
                constructor.setAccessible(true);
                return (T) constructor.newInstance(objArr);
            } catch (Exception e) {
                Log.w("SupportMenuInflater", "Cannot instantiate class: " + str, e);
                return null;
            }
        }

        private void i(MenuItem menuItem) {
            boolean z = false;
            menuItem.setChecked(this.s).setVisible(this.t).setEnabled(this.u).setCheckable(this.r >= 1).setTitleCondensed(this.l).setIcon(this.m);
            int i = this.v;
            if (i >= 0) {
                menuItem.setShowAsAction(i);
            }
            if (this.z != null) {
                if (g.this.f38c.isRestricted()) {
                    throw new IllegalStateException("The android:onClick attribute cannot be used within a restricted context");
                }
                menuItem.setOnMenuItemClickListener(new a(g.this.b(), this.z));
            }
            boolean z2 = menuItem instanceof j;
            if (z2) {
                j jVar = (j) menuItem;
            }
            if (this.r >= 2) {
                if (z2) {
                    ((j) menuItem).t(true);
                } else if (menuItem instanceof k) {
                    ((k) menuItem).i(true);
                }
            }
            String str = this.x;
            if (str != null) {
                menuItem.setActionView((View) e(str, g.e, g.this.f36a));
                z = true;
            }
            int i2 = this.w;
            if (i2 > 0) {
                if (z) {
                    Log.w("SupportMenuInflater", "Ignoring attribute 'itemActionViewLayout'. Action view already specified.");
                } else {
                    menuItem.setActionView(i2);
                }
            }
            a.f.l.b bVar = this.A;
            if (bVar != null) {
                a.f.l.g.a(menuItem, bVar);
            }
            a.f.l.g.c(menuItem, this.B);
            a.f.l.g.g(menuItem, this.C);
            a.f.l.g.b(menuItem, this.n, this.o);
            a.f.l.g.f(menuItem, this.p, this.q);
            PorterDuff.Mode mode = this.E;
            if (mode != null) {
                a.f.l.g.e(menuItem, mode);
            }
            ColorStateList colorStateList = this.D;
            if (colorStateList != null) {
                a.f.l.g.d(menuItem, colorStateList);
            }
        }

        public void a() {
            this.h = true;
            i(this.f43a.add(this.f44b, this.i, this.j, this.k));
        }

        public SubMenu b() {
            this.h = true;
            SubMenu addSubMenu = this.f43a.addSubMenu(this.f44b, this.i, this.j, this.k);
            i(addSubMenu.getItem());
            return addSubMenu;
        }

        public boolean d() {
            return this.h;
        }

        public void f(AttributeSet attributeSet) {
            TypedArray obtainStyledAttributes = g.this.f38c.obtainStyledAttributes(attributeSet, a.a.j.MenuGroup);
            this.f44b = obtainStyledAttributes.getResourceId(a.a.j.MenuGroup_android_id, 0);
            this.f45c = obtainStyledAttributes.getInt(a.a.j.MenuGroup_android_menuCategory, 0);
            this.f46d = obtainStyledAttributes.getInt(a.a.j.MenuGroup_android_orderInCategory, 0);
            this.e = obtainStyledAttributes.getInt(a.a.j.MenuGroup_android_checkableBehavior, 0);
            this.f = obtainStyledAttributes.getBoolean(a.a.j.MenuGroup_android_visible, true);
            this.g = obtainStyledAttributes.getBoolean(a.a.j.MenuGroup_android_enabled, true);
            obtainStyledAttributes.recycle();
        }

        /* JADX WARN: Multi-variable type inference failed */
        public void g(AttributeSet attributeSet) {
            TypedArray obtainStyledAttributes = g.this.f38c.obtainStyledAttributes(attributeSet, a.a.j.MenuItem);
            this.i = obtainStyledAttributes.getResourceId(a.a.j.MenuItem_android_id, 0);
            this.j = (obtainStyledAttributes.getInt(a.a.j.MenuItem_android_menuCategory, this.f45c) & (-65536)) | (obtainStyledAttributes.getInt(a.a.j.MenuItem_android_orderInCategory, this.f46d) & 65535);
            this.k = obtainStyledAttributes.getText(a.a.j.MenuItem_android_title);
            this.l = obtainStyledAttributes.getText(a.a.j.MenuItem_android_titleCondensed);
            this.m = obtainStyledAttributes.getResourceId(a.a.j.MenuItem_android_icon, 0);
            this.n = c(obtainStyledAttributes.getString(a.a.j.MenuItem_android_alphabeticShortcut));
            this.o = obtainStyledAttributes.getInt(a.a.j.MenuItem_alphabeticModifiers, 4096);
            this.p = c(obtainStyledAttributes.getString(a.a.j.MenuItem_android_numericShortcut));
            this.q = obtainStyledAttributes.getInt(a.a.j.MenuItem_numericModifiers, 4096);
            int i = a.a.j.MenuItem_android_checkable;
            this.r = obtainStyledAttributes.hasValue(i) ? obtainStyledAttributes.getBoolean(i, false) : this.e;
            this.s = obtainStyledAttributes.getBoolean(a.a.j.MenuItem_android_checked, false);
            this.t = obtainStyledAttributes.getBoolean(a.a.j.MenuItem_android_visible, this.f);
            this.u = obtainStyledAttributes.getBoolean(a.a.j.MenuItem_android_enabled, this.g);
            this.v = obtainStyledAttributes.getInt(a.a.j.MenuItem_showAsAction, -1);
            this.z = obtainStyledAttributes.getString(a.a.j.MenuItem_android_onClick);
            this.w = obtainStyledAttributes.getResourceId(a.a.j.MenuItem_actionLayout, 0);
            this.x = obtainStyledAttributes.getString(a.a.j.MenuItem_actionViewClass);
            String string = obtainStyledAttributes.getString(a.a.j.MenuItem_actionProviderClass);
            this.y = string;
            boolean z = string != null;
            if (z && this.w == 0 && this.x == null) {
                this.A = (a.f.l.b) e(string, g.f, g.this.f37b);
            } else {
                if (z) {
                    Log.w("SupportMenuInflater", "Ignoring attribute 'actionProviderClass'. Action view already specified.");
                }
                this.A = null;
            }
            this.B = obtainStyledAttributes.getText(a.a.j.MenuItem_contentDescription);
            this.C = obtainStyledAttributes.getText(a.a.j.MenuItem_tooltipText);
            int i2 = a.a.j.MenuItem_iconTintMode;
            if (obtainStyledAttributes.hasValue(i2)) {
                this.E = z.d(obtainStyledAttributes.getInt(i2, -1), this.E);
            } else {
                this.E = null;
            }
            int i3 = a.a.j.MenuItem_iconTint;
            if (obtainStyledAttributes.hasValue(i3)) {
                this.D = obtainStyledAttributes.getColorStateList(i3);
            } else {
                this.D = null;
            }
            obtainStyledAttributes.recycle();
            this.h = false;
        }

        public void h() {
            this.f44b = 0;
            this.f45c = 0;
            this.f46d = 0;
            this.e = 0;
            this.f = true;
            this.g = true;
        }
    }

    static {
        Class<?>[] clsArr = {Context.class};
        e = clsArr;
        f = clsArr;
    }

    public g(Context context) {
        super(context);
        this.f38c = context;
        Object[] objArr = {context};
        this.f36a = objArr;
        this.f37b = objArr;
    }

    private Object a(Object obj) {
        return (!(obj instanceof Activity) && (obj instanceof ContextWrapper)) ? a(((ContextWrapper) obj).getBaseContext()) : obj;
    }

    /* JADX WARN: Code restructure failed: missing block: B:12:0x003b, code lost:
        r8 = null;
        r6 = false;
        r7 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:13:0x0040, code lost:
        if (r6 != false) goto L64;
     */
    /* JADX WARN: Code restructure failed: missing block: B:14:0x0042, code lost:
        if (r15 == 1) goto L60;
     */
    /* JADX WARN: Code restructure failed: missing block: B:16:0x0048, code lost:
        if (r15 == 2) goto L44;
     */
    /* JADX WARN: Code restructure failed: missing block: B:18:0x004b, code lost:
        if (r15 == 3) goto L14;
     */
    /* JADX WARN: Code restructure failed: missing block: B:20:0x004f, code lost:
        r15 = r13.getName();
     */
    /* JADX WARN: Code restructure failed: missing block: B:21:0x0053, code lost:
        if (r7 == false) goto L21;
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x0059, code lost:
        if (r15.equals(r8) == false) goto L21;
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x005b, code lost:
        r8 = null;
        r7 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x0062, code lost:
        if (r15.equals("group") == false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x0064, code lost:
        r0.h();
     */
    /* JADX WARN: Code restructure failed: missing block: B:29:0x006c, code lost:
        if (r15.equals("item") == false) goto L38;
     */
    /* JADX WARN: Code restructure failed: missing block: B:31:0x0072, code lost:
        if (r0.d() != false) goto L37;
     */
    /* JADX WARN: Code restructure failed: missing block: B:32:0x0074, code lost:
        r15 = r0.A;
     */
    /* JADX WARN: Code restructure failed: missing block: B:33:0x0076, code lost:
        if (r15 == null) goto L35;
     */
    /* JADX WARN: Code restructure failed: missing block: B:35:0x007c, code lost:
        if (r15.a() == false) goto L35;
     */
    /* JADX WARN: Code restructure failed: missing block: B:36:0x007e, code lost:
        r0.b();
     */
    /* JADX WARN: Code restructure failed: missing block: B:37:0x0082, code lost:
        r0.a();
     */
    /* JADX WARN: Code restructure failed: missing block: B:39:0x008a, code lost:
        if (r15.equals("menu") == false) goto L42;
     */
    /* JADX WARN: Code restructure failed: missing block: B:40:0x008c, code lost:
        r6 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:41:0x008e, code lost:
        if (r7 == false) goto L45;
     */
    /* JADX WARN: Code restructure failed: missing block: B:43:0x0091, code lost:
        r15 = r13.getName();
     */
    /* JADX WARN: Code restructure failed: missing block: B:44:0x0099, code lost:
        if (r15.equals("group") == false) goto L49;
     */
    /* JADX WARN: Code restructure failed: missing block: B:45:0x009b, code lost:
        r0.f(r14);
     */
    /* JADX WARN: Code restructure failed: missing block: B:47:0x00a3, code lost:
        if (r15.equals("item") == false) goto L53;
     */
    /* JADX WARN: Code restructure failed: missing block: B:48:0x00a5, code lost:
        r0.g(r14);
     */
    /* JADX WARN: Code restructure failed: missing block: B:50:0x00ad, code lost:
        if (r15.equals("menu") == false) goto L57;
     */
    /* JADX WARN: Code restructure failed: missing block: B:51:0x00af, code lost:
        c(r13, r14, r0.b());
     */
    /* JADX WARN: Code restructure failed: missing block: B:52:0x00b7, code lost:
        r8 = r15;
        r7 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:53:0x00b9, code lost:
        r15 = r13.next();
     */
    /* JADX WARN: Code restructure failed: missing block: B:55:0x00c5, code lost:
        throw new java.lang.RuntimeException("Unexpected end of document");
     */
    /* JADX WARN: Code restructure failed: missing block: B:56:0x00c6, code lost:
        return;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void c(org.xmlpull.v1.XmlPullParser r13, android.util.AttributeSet r14, android.view.Menu r15) {
        /*
            r12 = this;
            a.a.m.g$b r0 = new a.a.m.g$b
            r0.<init>(r15)
            int r15 = r13.getEventType()
        L9:
            r1 = 2
            java.lang.String r2 = "menu"
            r3 = 1
            if (r15 != r1) goto L35
            java.lang.String r15 = r13.getName()
            boolean r4 = r15.equals(r2)
            if (r4 == 0) goto L1e
            int r15 = r13.next()
            goto L3b
        L1e:
            java.lang.RuntimeException r13 = new java.lang.RuntimeException
            java.lang.StringBuilder r14 = new java.lang.StringBuilder
            r14.<init>()
            java.lang.String r0 = "Expecting menu, got "
            r14.append(r0)
            r14.append(r15)
            java.lang.String r14 = r14.toString()
            r13.<init>(r14)
            throw r13
        L35:
            int r15 = r13.next()
            if (r15 != r3) goto L9
        L3b:
            r4 = 0
            r5 = 0
            r8 = r4
            r6 = r5
            r7 = r6
        L40:
            if (r6 != 0) goto Lc6
            if (r15 == r3) goto Lbe
            java.lang.String r9 = "item"
            java.lang.String r10 = "group"
            if (r15 == r1) goto L8e
            r11 = 3
            if (r15 == r11) goto L4f
            goto Lb9
        L4f:
            java.lang.String r15 = r13.getName()
            if (r7 == 0) goto L5e
            boolean r11 = r15.equals(r8)
            if (r11 == 0) goto L5e
            r8 = r4
            r7 = r5
            goto Lb9
        L5e:
            boolean r10 = r15.equals(r10)
            if (r10 == 0) goto L68
            r0.h()
            goto Lb9
        L68:
            boolean r9 = r15.equals(r9)
            if (r9 == 0) goto L86
            boolean r15 = r0.d()
            if (r15 != 0) goto Lb9
            a.f.l.b r15 = r0.A
            if (r15 == 0) goto L82
            boolean r15 = r15.a()
            if (r15 == 0) goto L82
            r0.b()
            goto Lb9
        L82:
            r0.a()
            goto Lb9
        L86:
            boolean r15 = r15.equals(r2)
            if (r15 == 0) goto Lb9
            r6 = r3
            goto Lb9
        L8e:
            if (r7 == 0) goto L91
            goto Lb9
        L91:
            java.lang.String r15 = r13.getName()
            boolean r10 = r15.equals(r10)
            if (r10 == 0) goto L9f
            r0.f(r14)
            goto Lb9
        L9f:
            boolean r9 = r15.equals(r9)
            if (r9 == 0) goto La9
            r0.g(r14)
            goto Lb9
        La9:
            boolean r9 = r15.equals(r2)
            if (r9 == 0) goto Lb7
            android.view.SubMenu r15 = r0.b()
            r12.c(r13, r14, r15)
            goto Lb9
        Lb7:
            r8 = r15
            r7 = r3
        Lb9:
            int r15 = r13.next()
            goto L40
        Lbe:
            java.lang.RuntimeException r13 = new java.lang.RuntimeException
            java.lang.String r14 = "Unexpected end of document"
            r13.<init>(r14)
            throw r13
        Lc6:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: a.a.m.g.c(org.xmlpull.v1.XmlPullParser, android.util.AttributeSet, android.view.Menu):void");
    }

    Object b() {
        if (this.f39d == null) {
            this.f39d = a(this.f38c);
        }
        return this.f39d;
    }

    @Override // android.view.MenuInflater
    public void inflate(int i, Menu menu) {
        if (!(menu instanceof a.f.f.a.a)) {
            super.inflate(i, menu);
            return;
        }
        XmlResourceParser xmlResourceParser = null;
        try {
            try {
                try {
                    xmlResourceParser = this.f38c.getResources().getLayout(i);
                    c(xmlResourceParser, Xml.asAttributeSet(xmlResourceParser), menu);
                } catch (org.xmlpull.v1.a e2) {
                    throw new InflateException("Error inflating menu XML", e2);
                }
            } catch (IOException e3) {
                throw new InflateException("Error inflating menu XML", e3);
            }
        } finally {
            if (xmlResourceParser != null) {
                xmlResourceParser.close();
            }
        }
    }
}
