package b.c.a;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.util.Enumeration;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
public class g extends a {
    static String[] h = new String[0];

    /* renamed from: c  reason: collision with root package name */
    Properties f1433c;

    /* renamed from: d  reason: collision with root package name */
    Pattern f1434d = Pattern.compile("(.*)\\((.*?)\\)");
    StringBuilder e = new StringBuilder();
    ThreadLocal<String> f = new ThreadLocal<>();
    ThreadLocal<String[]> g = new ThreadLocal<>();

    public g(String... strArr) {
        InputStream resourceAsStream = g.class.getResourceAsStream("/isoparser-default.properties");
        try {
            Properties properties = new Properties();
            this.f1433c = properties;
            try {
                properties.load(resourceAsStream);
                ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
                Enumeration<URL> resources = (contextClassLoader == null ? ClassLoader.getSystemClassLoader() : contextClassLoader).getResources("isoparser-custom.properties");
                while (resources.hasMoreElements()) {
                    InputStream openStream = resources.nextElement().openStream();
                    try {
                        this.f1433c.load(openStream);
                        openStream.close();
                    } catch (Throwable th) {
                        openStream.close();
                        throw th;
                    }
                }
                for (String str : strArr) {
                    this.f1433c.load(getClass().getResourceAsStream(str));
                }
                try {
                    resourceAsStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } catch (IOException e2) {
                throw new RuntimeException(e2);
            }
        } catch (Throwable th2) {
            try {
                resourceAsStream.close();
            } catch (IOException e3) {
                e3.printStackTrace();
            }
            throw th2;
        }
    }

    @Override // b.c.a.a
    public b.c.a.i.b b(String str, byte[] bArr, String str2) {
        c(str, bArr, str2);
        String[] strArr = this.g.get();
        try {
            Class<?> cls = Class.forName(this.f.get());
            if (strArr.length > 0) {
                Class<?>[] clsArr = new Class[strArr.length];
                Object[] objArr = new Object[strArr.length];
                for (int i = 0; i < strArr.length; i++) {
                    if ("userType".equals(strArr[i])) {
                        objArr[i] = bArr;
                        clsArr[i] = byte[].class;
                    } else if ("type".equals(strArr[i])) {
                        objArr[i] = str;
                        clsArr[i] = String.class;
                    } else if (!"parent".equals(strArr[i])) {
                        throw new InternalError("No such param: " + strArr[i]);
                    } else {
                        objArr[i] = str2;
                        clsArr[i] = String.class;
                    }
                }
                return (b.c.a.i.b) cls.getConstructor(clsArr).newInstance(objArr);
            }
            return (b.c.a.i.b) cls.newInstance();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e2) {
            throw new RuntimeException(e2);
        } catch (InstantiationException e3) {
            throw new RuntimeException(e3);
        } catch (NoSuchMethodException e4) {
            throw new RuntimeException(e4);
        } catch (InvocationTargetException e5) {
            throw new RuntimeException(e5);
        }
    }

    public void c(String str, byte[] bArr, String str2) {
        String property;
        if (bArr == null) {
            property = this.f1433c.getProperty(str);
            if (property == null) {
                StringBuilder sb = this.e;
                sb.append(str2);
                sb.append('-');
                sb.append(str);
                String sb2 = sb.toString();
                this.e.setLength(0);
                property = this.f1433c.getProperty(sb2);
            }
        } else if (!"uuid".equals(str)) {
            throw new RuntimeException("we have a userType but no uuid box type. Something's wrong");
        } else {
            Properties properties = this.f1433c;
            property = properties.getProperty("uuid[" + c.a(bArr).toUpperCase() + "]");
            if (property == null) {
                Properties properties2 = this.f1433c;
                property = properties2.getProperty(String.valueOf(str2) + "-uuid[" + c.a(bArr).toUpperCase() + "]");
            }
            if (property == null) {
                property = this.f1433c.getProperty("uuid");
            }
        }
        if (property == null) {
            property = this.f1433c.getProperty("default");
        }
        if (property == null) {
            throw new RuntimeException("No box object found for " + str);
        } else if (!property.endsWith(")")) {
            this.g.set(h);
            this.f.set(property);
        } else {
            Matcher matcher = this.f1434d.matcher(property);
            if (!matcher.matches()) {
                throw new RuntimeException("Cannot work with that constructor: " + property);
            }
            this.f.set(matcher.group(1));
            if (matcher.group(2).length() == 0) {
                this.g.set(h);
            } else {
                this.g.set(matcher.group(2).length() > 0 ? matcher.group(2).split(",") : new String[0]);
            }
        }
    }
}
