package androidx.core.app;

import android.app.RemoteInput;
import android.os.Bundle;
import java.util.Set;
/* loaded from: classes.dex */
public final class j {
    static RemoteInput a(j jVar) {
        return new RemoteInput.Builder(jVar.h()).setLabel(jVar.g()).setChoices(jVar.e()).setAllowFreeFormInput(jVar.c()).addExtras(jVar.f()).build();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static RemoteInput[] b(j[] jVarArr) {
        if (jVarArr == null) {
            return null;
        }
        RemoteInput[] remoteInputArr = new RemoteInput[jVarArr.length];
        for (int i = 0; i < jVarArr.length; i++) {
            remoteInputArr[i] = a(jVarArr[i]);
        }
        return remoteInputArr;
    }

    public boolean c() {
        throw null;
    }

    public Set<String> d() {
        throw null;
    }

    public CharSequence[] e() {
        throw null;
    }

    public Bundle f() {
        throw null;
    }

    public CharSequence g() {
        throw null;
    }

    public String h() {
        throw null;
    }
}
