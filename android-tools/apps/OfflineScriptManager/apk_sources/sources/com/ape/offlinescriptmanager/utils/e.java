package com.ape.offlinescriptmanager.utils;

import android.database.Cursor;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class e {
    public synchronized List<com.ape.offlinescriptmanager.batterytool.f.a> a(Cursor cursor) {
        ArrayList arrayList;
        arrayList = new ArrayList();
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndex("hop_range");
            int columnIndex2 = cursor.getColumnIndex("hop_time");
            do {
                arrayList.add(new com.ape.offlinescriptmanager.batterytool.f.a(cursor.getString(columnIndex), cursor.getString(columnIndex2)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
        } else if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return arrayList;
    }

    public synchronized List<com.ape.offlinescriptmanager.batterytool.f.b> b(Cursor cursor) {
        ArrayList arrayList;
        arrayList = new ArrayList();
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndex("time");
            int columnIndex2 = cursor.getColumnIndex("percentage");
            int columnIndex3 = cursor.getColumnIndex("temperature");
            do {
                arrayList.add(new com.ape.offlinescriptmanager.batterytool.f.b(cursor.getString(columnIndex), cursor.getString(columnIndex2), cursor.getDouble(columnIndex3)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
        } else if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return arrayList;
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x009b A[Catch: all -> 0x00a0, TRY_LEAVE, TryCatch #2 {, blocks: (B:3:0x0001, B:16:0x009b, B:5:0x0008, B:7:0x000e, B:8:0x0038), top: B:22:0x0001 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public synchronized java.util.List<b.b.a.a.b.h> c(android.database.Cursor r12) {
        /*
            r11 = this;
            monitor-enter(r11)
            java.util.ArrayList r0 = new java.util.ArrayList     // Catch: java.lang.Throwable -> La0
            r0.<init>()     // Catch: java.lang.Throwable -> La0
            if (r12 == 0) goto L99
            boolean r1 = r12.moveToFirst()     // Catch: java.lang.Throwable -> L92
            if (r1 == 0) goto L99
            java.lang.String r1 = "name"
            int r1 = r12.getColumnIndex(r1)     // Catch: java.lang.Throwable -> L92
            java.lang.String r2 = "status"
            int r2 = r12.getColumnIndex(r2)     // Catch: java.lang.Throwable -> L92
            java.lang.String r3 = "start_time"
            int r3 = r12.getColumnIndex(r3)     // Catch: java.lang.Throwable -> L92
            java.lang.String r4 = "stop_time"
            int r4 = r12.getColumnIndex(r4)     // Catch: java.lang.Throwable -> L92
            java.lang.String r5 = "start_battery_percentage"
            int r5 = r12.getColumnIndex(r5)     // Catch: java.lang.Throwable -> L92
            java.lang.String r6 = "stop_battery_percentage"
            int r6 = r12.getColumnIndex(r6)     // Catch: java.lang.Throwable -> L92
            java.lang.String r7 = "regression"
            int r7 = r12.getColumnIndex(r7)     // Catch: java.lang.Throwable -> L92
        L38:
            b.b.a.a.b.h r8 = new b.b.a.a.b.h     // Catch: java.lang.Throwable -> L92
            r8.<init>()     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = r12.getString(r1)     // Catch: java.lang.Throwable -> L92
            r8.m(r9)     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = r12.getString(r2)     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = r9.toUpperCase()     // Catch: java.lang.Throwable -> L92
            b.b.a.a.b.g r9 = b.b.a.a.b.g.valueOf(r9)     // Catch: java.lang.Throwable -> L92
            r8.o(r9)     // Catch: java.lang.Throwable -> L92
            long r9 = r12.getLong(r3)     // Catch: java.lang.Throwable -> L92
            r8.n(r9)     // Catch: java.lang.Throwable -> L92
            long r9 = r12.getLong(r4)     // Catch: java.lang.Throwable -> L92
            r8.l(r9)     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = "startbattery"
            int r10 = r12.getInt(r5)     // Catch: java.lang.Throwable -> L92
            java.lang.String r10 = java.lang.String.valueOf(r10)     // Catch: java.lang.Throwable -> L92
            r8.a(r9, r10)     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = "stopbattery"
            int r10 = r12.getInt(r6)     // Catch: java.lang.Throwable -> L92
            java.lang.String r10 = java.lang.String.valueOf(r10)     // Catch: java.lang.Throwable -> L92
            r8.a(r9, r10)     // Catch: java.lang.Throwable -> L92
            java.lang.String r9 = "regression"
            int r10 = r12.getInt(r7)     // Catch: java.lang.Throwable -> L92
            java.lang.String r10 = java.lang.String.valueOf(r10)     // Catch: java.lang.Throwable -> L92
            r8.a(r9, r10)     // Catch: java.lang.Throwable -> L92
            r0.add(r8)     // Catch: java.lang.Throwable -> L92
            boolean r8 = r12.moveToNext()     // Catch: java.lang.Throwable -> L92
            if (r8 != 0) goto L38
            goto L99
        L92:
            r0 = move-exception
            if (r12 == 0) goto L98
            r12.close()     // Catch: java.lang.Throwable -> La0
        L98:
            throw r0     // Catch: java.lang.Throwable -> La0
        L99:
            if (r12 == 0) goto L9e
            r12.close()     // Catch: java.lang.Throwable -> La0
        L9e:
            monitor-exit(r11)
            return r0
        La0:
            r12 = move-exception
            monitor-exit(r11)
            throw r12
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.utils.e.c(android.database.Cursor):java.util.List");
    }

    public synchronized List<com.ape.offlinescriptmanager.batterytool.f.c> d(Cursor cursor) {
        ArrayList arrayList;
        arrayList = new ArrayList();
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndex("range");
            int columnIndex2 = cursor.getColumnIndex("used_time");
            int columnIndex3 = cursor.getColumnIndex("time_range");
            do {
                arrayList.add(new com.ape.offlinescriptmanager.batterytool.f.c(cursor.getString(columnIndex), cursor.getString(columnIndex2), cursor.getString(columnIndex3)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
        } else if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return arrayList;
    }

    public synchronized List<com.ape.offlinescriptmanager.batterytool.f.c> e(Cursor cursor) {
        ArrayList arrayList;
        arrayList = new ArrayList();
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndex("range");
            int columnIndex2 = cursor.getColumnIndex("used_time");
            int columnIndex3 = cursor.getColumnIndex("time_range");
            do {
                arrayList.add(new com.ape.offlinescriptmanager.batterytool.f.c(cursor.getString(columnIndex), cursor.getString(columnIndex2), cursor.getString(columnIndex3)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
        } else if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return arrayList;
    }

    public synchronized List<com.ape.offlinescriptmanager.batterytool.f.d> f(Cursor cursor) {
        ArrayList arrayList;
        arrayList = new ArrayList();
        if (cursor != null && cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndex("time");
            int columnIndex2 = cursor.getColumnIndex("voltage");
            int columnIndex3 = cursor.getColumnIndex("temperature");
            do {
                arrayList.add(new com.ape.offlinescriptmanager.batterytool.f.d(cursor.getString(columnIndex), cursor.getString(columnIndex2), cursor.getDouble(columnIndex3)));
            } while (cursor.moveToNext());
            if (cursor != null) {
                cursor.close();
            }
        } else if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return arrayList;
    }
}
