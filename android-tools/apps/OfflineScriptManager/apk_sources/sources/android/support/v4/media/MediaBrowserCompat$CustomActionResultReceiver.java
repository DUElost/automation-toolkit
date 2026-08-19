package android.support.v4.media;

import android.os.Bundle;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.os.ResultReceiver;
import android.util.Log;
/* loaded from: classes.dex */
class MediaBrowserCompat$CustomActionResultReceiver extends ResultReceiver {

    /* renamed from: d  reason: collision with root package name */
    private final String f365d;
    private final Bundle e;
    private final a f;

    @Override // android.support.v4.os.ResultReceiver
    protected void a(int i, Bundle bundle) {
        if (this.f == null) {
            return;
        }
        MediaSessionCompat.a(bundle);
        if (i == -1) {
            this.f.a(this.f365d, this.e, bundle);
        } else if (i == 0) {
            this.f.c(this.f365d, this.e, bundle);
        } else if (i == 1) {
            this.f.b(this.f365d, this.e, bundle);
        } else {
            Log.w("MediaBrowserCompat", "Unknown result code: " + i + " (extras=" + this.e + ", resultData=" + bundle + ")");
        }
    }
}
