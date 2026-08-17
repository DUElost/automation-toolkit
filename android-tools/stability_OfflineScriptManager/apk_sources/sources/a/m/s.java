package a.m;

import android.view.View;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class s {

    /* renamed from: b  reason: collision with root package name */
    public View f316b;

    /* renamed from: a  reason: collision with root package name */
    public final Map<String, Object> f315a = new HashMap();

    /* renamed from: c  reason: collision with root package name */
    final ArrayList<m> f317c = new ArrayList<>();

    public boolean equals(Object obj) {
        if (obj instanceof s) {
            s sVar = (s) obj;
            return this.f316b == sVar.f316b && this.f315a.equals(sVar.f315a);
        }
        return false;
    }

    public int hashCode() {
        return (this.f316b.hashCode() * 31) + this.f315a.hashCode();
    }

    public String toString() {
        String str = (("TransitionValues@" + Integer.toHexString(hashCode()) + ":\n") + "    view = " + this.f316b + "\n") + "    values:";
        for (String str2 : this.f315a.keySet()) {
            str = str + "    " + str2 + ": " + this.f315a.get(str2) + "\n";
        }
        return str;
    }
}
