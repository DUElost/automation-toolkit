package com.ape.offlinescriptmanager.screenrecorder;

import android.os.Environment;
import java.io.File;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    public static final String f2012a;

    /* renamed from: com.ape.offlinescriptmanager.screenrecorder.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0076a {
        RECORDING,
        PAUSED,
        STOPPED
    }

    static {
        StringBuilder sb = new StringBuilder();
        sb.append(Environment.getExternalStorageDirectory());
        String str = File.separator;
        sb.append(str);
        sb.append("offlinescriptmanager");
        sb.append(str);
        sb.append("screenrecorder");
        f2012a = sb.toString();
    }
}
