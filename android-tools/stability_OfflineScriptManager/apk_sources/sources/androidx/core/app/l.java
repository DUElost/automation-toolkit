package androidx.core.app;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import java.util.ArrayList;
import java.util.Iterator;
/* loaded from: classes.dex */
public final class l implements Iterable<Intent> {

    /* renamed from: b  reason: collision with root package name */
    private final ArrayList<Intent> f852b = new ArrayList<>();

    /* renamed from: c  reason: collision with root package name */
    private final Context f853c;

    /* loaded from: classes.dex */
    public interface a {
        Intent h();
    }

    private l(Context context) {
        this.f853c = context;
    }

    public static l d(Context context) {
        return new l(context);
    }

    public l a(Intent intent) {
        this.f852b.add(intent);
        return this;
    }

    public l b(Activity activity) {
        Intent h = activity instanceof a ? ((a) activity).h() : null;
        if (h == null) {
            h = e.a(activity);
        }
        if (h != null) {
            ComponentName component = h.getComponent();
            if (component == null) {
                component = h.resolveActivity(this.f853c.getPackageManager());
            }
            c(component);
            a(h);
        }
        return this;
    }

    public l c(ComponentName componentName) {
        int size = this.f852b.size();
        try {
            Context context = this.f853c;
            while (true) {
                Intent b2 = e.b(context, componentName);
                if (b2 == null) {
                    return this;
                }
                this.f852b.add(size, b2);
                context = this.f853c;
                componentName = b2.getComponent();
            }
        } catch (PackageManager.NameNotFoundException e) {
            Log.e("TaskStackBuilder", "Bad ComponentName while traversing activity parent metadata");
            throw new IllegalArgumentException(e);
        }
    }

    public void e() {
        f(null);
    }

    public void f(Bundle bundle) {
        if (this.f852b.isEmpty()) {
            throw new IllegalStateException("No intents added to TaskStackBuilder; cannot startActivities");
        }
        ArrayList<Intent> arrayList = this.f852b;
        Intent[] intentArr = (Intent[]) arrayList.toArray(new Intent[arrayList.size()]);
        intentArr[0] = new Intent(intentArr[0]).addFlags(268484608);
        if (androidx.core.content.a.g(this.f853c, intentArr, bundle)) {
            return;
        }
        Intent intent = new Intent(intentArr[intentArr.length - 1]);
        intent.addFlags(268435456);
        this.f853c.startActivity(intent);
    }

    @Override // java.lang.Iterable
    @Deprecated
    public Iterator<Intent> iterator() {
        return this.f852b.iterator();
    }
}
