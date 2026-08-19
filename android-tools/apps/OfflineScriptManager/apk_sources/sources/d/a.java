package d;

import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    final m f2516a;

    /* renamed from: b  reason: collision with root package name */
    final EnumC0103a f2517b;

    /* renamed from: c  reason: collision with root package name */
    final Object f2518c;

    /* renamed from: d.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0103a {
        STOP,
        PLUG,
        OWN,
        ATTACH,
        BIND,
        ACTIVATE_READ,
        ACTIVATE_WRITE,
        HICCUP,
        PIPE_TERM,
        PIPE_TERM_ACK,
        TERM_REQ,
        TERM,
        TERM_ACK,
        REAP,
        REAPED,
        INPROC_CONNECTED,
        DONE;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static EnumC0103a[] valuesCustom() {
            EnumC0103a[] valuesCustom = values();
            int length = valuesCustom.length;
            EnumC0103a[] enumC0103aArr = new EnumC0103a[length];
            System.arraycopy(valuesCustom, 0, enumC0103aArr, 0, length);
            return enumC0103aArr;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(m mVar, EnumC0103a enumC0103a) {
        this(mVar, enumC0103a, null);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(m mVar, EnumC0103a enumC0103a, Object obj) {
        this.f2516a = mVar;
        this.f2517b = enumC0103a;
        this.f2518c = obj;
    }

    public final void a() {
        this.f2516a.M(this);
    }

    public String toString() {
        m mVar;
        String str;
        String str2;
        StringBuilder sb = new StringBuilder("Cmd[");
        sb.append(this.f2516a);
        sb.append(", ");
        if (this.f2516a == null) {
            str = "Reaper";
        } else {
            str = String.valueOf(mVar.G()) + ", ";
        }
        sb.append(str);
        sb.append(this.f2517b);
        if (this.f2518c == null) {
            str2 = BuildConfig.FLAVOR;
        } else {
            str2 = ", " + this.f2518c;
        }
        sb.append(str2);
        sb.append("]");
        return sb.toString();
    }
}
