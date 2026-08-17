package android.support.v4.media.session;

import android.os.Bundle;
import android.os.RemoteException;
import android.os.ResultReceiver;
import android.support.v4.media.MediaMetadataCompat;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.media.session.b;
import android.support.v4.media.session.c;
import android.util.Log;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.List;
/* loaded from: classes.dex */
class MediaControllerCompat$MediaControllerImplApi21 {

    /* renamed from: a  reason: collision with root package name */
    final Object f382a;

    /* renamed from: b  reason: collision with root package name */
    private final List<c> f383b;

    /* renamed from: c  reason: collision with root package name */
    private HashMap<c, a> f384c;

    /* renamed from: d  reason: collision with root package name */
    final MediaSessionCompat.Token f385d;

    /* loaded from: classes.dex */
    private static class ExtraBinderRequestResultReceiver extends ResultReceiver {

        /* renamed from: b  reason: collision with root package name */
        private WeakReference<MediaControllerCompat$MediaControllerImplApi21> f386b;

        @Override // android.os.ResultReceiver
        protected void onReceiveResult(int i, Bundle bundle) {
            MediaControllerCompat$MediaControllerImplApi21 mediaControllerCompat$MediaControllerImplApi21 = this.f386b.get();
            if (mediaControllerCompat$MediaControllerImplApi21 == null || bundle == null) {
                return;
            }
            synchronized (mediaControllerCompat$MediaControllerImplApi21.f382a) {
                mediaControllerCompat$MediaControllerImplApi21.f385d.b(b.a.p(androidx.core.app.c.a(bundle, "android.support.v4.media.session.EXTRA_BINDER")));
                mediaControllerCompat$MediaControllerImplApi21.f385d.c(bundle.getBundle("android.support.v4.media.session.SESSION_TOKEN2_BUNDLE"));
                mediaControllerCompat$MediaControllerImplApi21.a();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class a extends c.BinderC0023c {
        a(c cVar) {
            super(cVar);
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void a(List<MediaSessionCompat.QueueItem> list) {
            throw new AssertionError();
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void b(CharSequence charSequence) {
            throw new AssertionError();
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void c() {
            throw new AssertionError();
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void d(Bundle bundle) {
            throw new AssertionError();
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void g(MediaMetadataCompat mediaMetadataCompat) {
            throw new AssertionError();
        }

        @Override // android.support.v4.media.session.c.BinderC0023c, android.support.v4.media.session.a
        public void o(ParcelableVolumeInfo parcelableVolumeInfo) {
            throw new AssertionError();
        }
    }

    void a() {
        if (this.f385d.a() == null) {
            return;
        }
        for (c cVar : this.f383b) {
            a aVar = new a(cVar);
            this.f384c.put(cVar, aVar);
            cVar.f405c = aVar;
            try {
                this.f385d.a().f(aVar);
                cVar.i(13, null, null);
            } catch (RemoteException e) {
                Log.e("MediaControllerCompat", "Dead object in registerCallback.", e);
            }
        }
        this.f383b.clear();
    }
}
