package androidx.versionedparcelable;

import android.os.Parcelable;
import java.lang.reflect.InvocationTargetException;
/* loaded from: classes.dex */
public abstract class a {
    protected static <T extends c> void B(T t, a aVar) {
        try {
            c(t).getDeclaredMethod("write", t.getClass(), a.class).invoke(null, t, aVar);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("VersionedParcel encountered ClassNotFoundException", e);
        } catch (IllegalAccessException e2) {
            throw new RuntimeException("VersionedParcel encountered IllegalAccessException", e2);
        } catch (NoSuchMethodException e3) {
            throw new RuntimeException("VersionedParcel encountered NoSuchMethodException", e3);
        } catch (InvocationTargetException e4) {
            if (!(e4.getCause() instanceof RuntimeException)) {
                throw new RuntimeException("VersionedParcel encountered InvocationTargetException", e4);
            }
            throw ((RuntimeException) e4.getCause());
        }
    }

    private void E(c cVar) {
        try {
            z(d(cVar.getClass()).getName());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(cVar.getClass().getSimpleName() + " does not have a Parcelizer", e);
        }
    }

    private static <T extends c> Class c(T t) {
        return d(t.getClass());
    }

    private static Class d(Class<? extends c> cls) {
        return Class.forName(String.format("%s.%sParcelizer", cls.getPackage().getName(), cls.getSimpleName()), false, cls.getClassLoader());
    }

    protected static <T extends c> T i(String str, a aVar) {
        try {
            return (T) Class.forName(str, true, a.class.getClassLoader()).getDeclaredMethod("read", a.class).invoke(null, aVar);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("VersionedParcel encountered ClassNotFoundException", e);
        } catch (IllegalAccessException e2) {
            throw new RuntimeException("VersionedParcel encountered IllegalAccessException", e2);
        } catch (NoSuchMethodException e3) {
            throw new RuntimeException("VersionedParcel encountered NoSuchMethodException", e3);
        } catch (InvocationTargetException e4) {
            if (e4.getCause() instanceof RuntimeException) {
                throw ((RuntimeException) e4.getCause());
            }
            throw new RuntimeException("VersionedParcel encountered InvocationTargetException", e4);
        }
    }

    public void A(String str, int i) {
        r(i);
        z(str);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void C(c cVar) {
        if (cVar == null) {
            z(null);
            return;
        }
        E(cVar);
        a b2 = b();
        B(cVar, b2);
        b2.a();
    }

    public void D(c cVar, int i) {
        r(i);
        C(cVar);
    }

    protected abstract void a();

    protected abstract a b();

    public boolean e() {
        return false;
    }

    protected abstract byte[] f();

    public byte[] g(byte[] bArr, int i) {
        return !h(i) ? bArr : f();
    }

    protected abstract boolean h(int i);

    protected abstract int j();

    public int k(int i, int i2) {
        return !h(i2) ? i : j();
    }

    protected abstract <T extends Parcelable> T l();

    public <T extends Parcelable> T m(T t, int i) {
        return !h(i) ? t : (T) l();
    }

    protected abstract String n();

    public String o(String str, int i) {
        return !h(i) ? str : n();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public <T extends c> T p() {
        String n = n();
        if (n == null) {
            return null;
        }
        return (T) i(n, b());
    }

    public <T extends c> T q(T t, int i) {
        return !h(i) ? t : (T) p();
    }

    protected abstract void r(int i);

    public void s(boolean z, boolean z2) {
    }

    protected abstract void t(byte[] bArr);

    public void u(byte[] bArr, int i) {
        r(i);
        t(bArr);
    }

    protected abstract void v(int i);

    public void w(int i, int i2) {
        r(i2);
        v(i);
    }

    protected abstract void x(Parcelable parcelable);

    public void y(Parcelable parcelable, int i) {
        r(i);
        x(parcelable);
    }

    protected abstract void z(String str);
}
