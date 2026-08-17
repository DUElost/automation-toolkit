package a.f.e;

import a.f.i.b;
import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.graphics.fonts.FontVariationAxis;
import android.net.Uri;
import android.os.CancellationSignal;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import androidx.core.content.c.c;
import java.io.IOException;
import java.lang.reflect.Array;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.util.Map;
/* loaded from: classes.dex */
public class f extends d {

    /* renamed from: a  reason: collision with root package name */
    protected final Class f115a;

    /* renamed from: b  reason: collision with root package name */
    protected final Constructor f116b;

    /* renamed from: c  reason: collision with root package name */
    protected final Method f117c;

    /* renamed from: d  reason: collision with root package name */
    protected final Method f118d;
    protected final Method e;
    protected final Method f;
    protected final Method g;

    public f() {
        Method method;
        Constructor constructor;
        Method method2;
        Method method3;
        Method method4;
        Method method5;
        Class cls = null;
        try {
            Class t = t();
            constructor = u(t);
            method2 = q(t);
            method3 = r(t);
            method4 = v(t);
            method5 = p(t);
            method = s(t);
            cls = t;
        } catch (ClassNotFoundException | NoSuchMethodException e) {
            Log.e("TypefaceCompatApi26Impl", "Unable to collect necessary methods for class " + e.getClass().getName(), e);
            method = null;
            constructor = null;
            method2 = null;
            method3 = null;
            method4 = null;
            method5 = null;
        }
        this.f115a = cls;
        this.f116b = constructor;
        this.f117c = method2;
        this.f118d = method3;
        this.e = method4;
        this.f = method5;
        this.g = method;
    }

    private void i(Object obj) {
        try {
            this.f.invoke(obj, new Object[0]);
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean j(Context context, Object obj, String str, int i, int i2, int i3, FontVariationAxis[] fontVariationAxisArr) {
        try {
            return ((Boolean) this.f117c.invoke(obj, context.getAssets(), str, 0, Boolean.FALSE, Integer.valueOf(i), Integer.valueOf(i2), Integer.valueOf(i3), fontVariationAxisArr)).booleanValue();
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean k(Object obj, ByteBuffer byteBuffer, int i, int i2, int i3) {
        try {
            return ((Boolean) this.f118d.invoke(obj, byteBuffer, Integer.valueOf(i), null, Integer.valueOf(i2), Integer.valueOf(i3))).booleanValue();
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean m(Object obj) {
        try {
            return ((Boolean) this.e.invoke(obj, new Object[0])).booleanValue();
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean n() {
        if (this.f117c == null) {
            Log.w("TypefaceCompatApi26Impl", "Unable to collect necessary private methods. Fallback to legacy implementation.");
        }
        return this.f117c != null;
    }

    private Object o() {
        try {
            return this.f116b.newInstance(new Object[0]);
        } catch (IllegalAccessException | InstantiationException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    @Override // a.f.e.h
    public Typeface a(Context context, c.b bVar, Resources resources, int i) {
        c.C0031c[] a2;
        if (n()) {
            Object o = o();
            for (c.C0031c c0031c : bVar.a()) {
                if (!j(context, o, c0031c.a(), c0031c.c(), c0031c.e(), c0031c.f() ? 1 : 0, FontVariationAxis.fromFontVariationSettings(c0031c.d()))) {
                    i(o);
                    return null;
                }
            }
            if (m(o)) {
                return l(o);
            }
            return null;
        }
        return super.a(context, bVar, resources, i);
    }

    @Override // a.f.e.d, a.f.e.h
    public Typeface b(Context context, CancellationSignal cancellationSignal, b.f[] fVarArr, int i) {
        if (fVarArr.length < 1) {
            return null;
        }
        if (!n()) {
            b.f g = g(fVarArr, i);
            try {
                ParcelFileDescriptor openFileDescriptor = context.getContentResolver().openFileDescriptor(g.c(), "r", cancellationSignal);
                if (openFileDescriptor == null) {
                    if (openFileDescriptor != null) {
                        openFileDescriptor.close();
                    }
                    return null;
                }
                Typeface build = new Typeface.Builder(openFileDescriptor.getFileDescriptor()).setWeight(g.d()).setItalic(g.e()).build();
                if (openFileDescriptor != null) {
                    openFileDescriptor.close();
                }
                return build;
            } catch (IOException unused) {
                return null;
            }
        }
        Map<Uri, ByteBuffer> i2 = a.f.i.b.i(context, fVarArr, cancellationSignal);
        Object o = o();
        boolean z = false;
        for (b.f fVar : fVarArr) {
            ByteBuffer byteBuffer = i2.get(fVar.c());
            if (byteBuffer != null) {
                if (!k(o, byteBuffer, fVar.b(), fVar.d(), fVar.e() ? 1 : 0)) {
                    i(o);
                    return null;
                }
                z = true;
            }
        }
        if (!z) {
            i(o);
            return null;
        } else if (m(o)) {
            return Typeface.create(l(o), i);
        } else {
            return null;
        }
    }

    @Override // a.f.e.h
    public Typeface d(Context context, Resources resources, int i, String str, int i2) {
        if (n()) {
            Object o = o();
            if (!j(context, o, str, 0, -1, -1, null)) {
                i(o);
                return null;
            } else if (m(o)) {
                return l(o);
            } else {
                return null;
            }
        }
        return super.d(context, resources, i, str, i2);
    }

    protected Typeface l(Object obj) {
        try {
            Object newInstance = Array.newInstance(this.f115a, 1);
            Array.set(newInstance, 0, obj);
            return (Typeface) this.g.invoke(null, newInstance, -1, -1);
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    protected Method p(Class cls) {
        return cls.getMethod("abortCreation", new Class[0]);
    }

    protected Method q(Class cls) {
        Class<?> cls2 = Integer.TYPE;
        return cls.getMethod("addFontFromAssetManager", AssetManager.class, String.class, cls2, Boolean.TYPE, cls2, cls2, cls2, FontVariationAxis[].class);
    }

    protected Method r(Class cls) {
        Class<?> cls2 = Integer.TYPE;
        return cls.getMethod("addFontFromBuffer", ByteBuffer.class, cls2, FontVariationAxis[].class, cls2, cls2);
    }

    protected Method s(Class cls) {
        Class cls2 = Integer.TYPE;
        Method declaredMethod = Typeface.class.getDeclaredMethod("createFromFamiliesWithDefault", Array.newInstance(cls, 1).getClass(), cls2, cls2);
        declaredMethod.setAccessible(true);
        return declaredMethod;
    }

    protected Class t() {
        return Class.forName("android.graphics.FontFamily");
    }

    protected Constructor u(Class cls) {
        return cls.getConstructor(new Class[0]);
    }

    protected Method v(Class cls) {
        return cls.getMethod("freeze", new Class[0]);
    }
}
