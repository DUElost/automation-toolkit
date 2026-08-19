package b.e.a.j;

import java.util.logging.Level;
import java.util.logging.Logger;
/* loaded from: classes.dex */
public class d extends f {

    /* renamed from: a  reason: collision with root package name */
    Logger f1598a;

    public d(String str) {
        this.f1598a = Logger.getLogger(str);
    }

    @Override // b.e.a.j.f
    public void b(String str) {
        this.f1598a.log(Level.FINE, str);
    }

    @Override // b.e.a.j.f
    public void c(String str) {
        this.f1598a.log(Level.SEVERE, str);
    }

    @Override // b.e.a.j.f
    public void d(String str) {
        this.f1598a.log(Level.WARNING, str);
    }
}
