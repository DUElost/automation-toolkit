package com.github.johnkil.print;

import android.content.res.AssetManager;
import android.graphics.Typeface;
import java.util.HashMap;
/* loaded from: classes.dex */
class e {

    /* renamed from: a  reason: collision with root package name */
    private static final HashMap<String, Typeface> f2266a = new HashMap<>();

    /* JADX INFO: Access modifiers changed from: package-private */
    public static Typeface a(AssetManager assetManager, String str) {
        Typeface createFromAsset;
        HashMap<String, Typeface> hashMap = f2266a;
        synchronized (hashMap) {
            if (hashMap.containsKey(str)) {
                createFromAsset = hashMap.get(str);
            } else {
                createFromAsset = Typeface.createFromAsset(assetManager, str);
                hashMap.put(str, createFromAsset);
            }
        }
        return createFromAsset;
    }
}
