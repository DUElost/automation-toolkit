package android.support.v4.media;

import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.os.ResultReceiver;
/* loaded from: classes.dex */
class MediaBrowserCompat$ItemReceiver extends ResultReceiver {

    /* renamed from: d  reason: collision with root package name */
    private final String f366d;
    private final b e;

    @Override // android.support.v4.os.ResultReceiver
    protected void a(int i, Bundle bundle) {
        MediaSessionCompat.a(bundle);
        if (i != 0 || bundle == null || !bundle.containsKey("media_item")) {
            this.e.a(this.f366d);
            return;
        }
        Parcelable parcelable = bundle.getParcelable("media_item");
        if (parcelable == null || (parcelable instanceof MediaBrowserCompat$MediaItem)) {
            this.e.b((MediaBrowserCompat$MediaItem) parcelable);
        } else {
            this.e.a(this.f366d);
        }
    }
}
