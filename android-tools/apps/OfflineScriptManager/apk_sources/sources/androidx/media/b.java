package androidx.media;

import android.annotation.TargetApi;
import android.media.AudioAttributes;
@TargetApi(21)
/* loaded from: classes.dex */
class b implements a {

    /* renamed from: a  reason: collision with root package name */
    AudioAttributes f1091a;

    /* renamed from: b  reason: collision with root package name */
    int f1092b = -1;

    public boolean equals(Object obj) {
        if (obj instanceof b) {
            return this.f1091a.equals(((b) obj).f1091a);
        }
        return false;
    }

    public int hashCode() {
        return this.f1091a.hashCode();
    }

    public String toString() {
        return "AudioAttributesCompat: audioattributes=" + this.f1091a;
    }
}
