package com.ape.offlinescriptmanager.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
/* loaded from: classes.dex */
public final class c {
    public static String a(String str, String str2) {
        StringBuilder sb = new StringBuilder();
        try {
            Process exec = Runtime.getRuntime().exec(str);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(exec.getInputStream()));
            while (true) {
                String readLine = bufferedReader.readLine();
                if (readLine == null) {
                    try {
                        exec.waitFor();
                        return sb.toString();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                        return null;
                    }
                }
                String trim = readLine.trim();
                if (!trim.isEmpty()) {
                    if (str2 == null) {
                        sb.append(trim);
                    } else if (trim.contains(str2)) {
                        sb.append(trim);
                    }
                    sb.append("\r\n");
                }
            }
        } catch (IOException e2) {
            e2.printStackTrace();
            return null;
        }
    }
}
