package com.ape.offlinescriptmanager.database;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;
import android.text.TextUtils;
import java.util.HashMap;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class CommonProvider extends ContentProvider {

    /* renamed from: c  reason: collision with root package name */
    private static HashMap<String, String> f1970c;

    /* renamed from: d  reason: collision with root package name */
    private static final UriMatcher f1971d;

    /* renamed from: b  reason: collision with root package name */
    private a f1972b;

    static {
        UriMatcher uriMatcher = new UriMatcher(-1);
        f1971d = uriMatcher;
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "percentages", 1);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "percentages/#", 2);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "voltages", 3);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "voltages/#", 4);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used", 5);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used/#", 6);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used_one", 9);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used_one/#", 10);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used_two", 11);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "used_two/#", 12);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "hop", 7);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "hop/#", 8);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "test_point_result", 13);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "test_point_result/#", 14);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "test_task", 15);
        uriMatcher.addURI("com.ape.offlinescriptmanager.database", "test_task/#", 16);
        HashMap<String, String> hashMap = new HashMap<>();
        f1970c = hashMap;
        hashMap.put("_id", "_id");
        f1970c.put("time", "time");
        f1970c.put("percentage", "percentage");
        f1970c.put("temperature", "temperature");
        f1970c.put("_id", "_id");
        f1970c.put("time", "time");
        f1970c.put("voltage", "voltage");
        f1970c.put("temperature", "temperature");
        f1970c.put("_id", "_id");
        f1970c.put("range", "range");
        f1970c.put("used_time", "used_time");
        f1970c.put("time_range", "time_range");
        f1970c.put("_id", "_id");
        f1970c.put("range", "range");
        f1970c.put("used_time", "used_time");
        f1970c.put("time_range", "time_range");
        f1970c.put("_id", "_id");
        f1970c.put("range", "range");
        f1970c.put("used_time", "used_time");
        f1970c.put("time_range", "time_range");
        f1970c.put("_id", "_id");
        f1970c.put("hop_range", "hop_range");
        f1970c.put("hop_time", "hop_time");
        f1970c.put("_id", "_id");
        f1970c.put("name", "name");
        f1970c.put("status", "status");
        f1970c.put("start_time", "start_time");
        f1970c.put("stop_time", "stop_time");
        f1970c.put("start_battery_percentage", "start_battery_percentage");
        f1970c.put("stop_battery_percentage", "stop_battery_percentage");
        f1970c.put("regression", "regression");
        f1970c.put("_id", "_id");
        f1970c.put("task_name", "task_name");
        f1970c.put("task_result_time", "task_result_time");
        f1970c.put("result_is_upload", "result_is_upload");
        f1970c.put("task_creator", "task_creator");
    }

    @Override // android.content.ContentProvider
    public int delete(Uri uri, String str, String[] strArr) {
        int delete;
        String str2 = str;
        SQLiteDatabase writableDatabase = this.f1972b.getWritableDatabase();
        int match = f1971d.match(uri);
        String str3 = BuildConfig.FLAVOR;
        switch (match) {
            case 2:
                StringBuilder sb = new StringBuilder();
                sb.append("_id=");
                sb.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb.append(str3);
                str2 = sb.toString();
            case 1:
                delete = writableDatabase.delete("percentage", str2, strArr);
                break;
            case 4:
                StringBuilder sb2 = new StringBuilder();
                sb2.append("_id=");
                sb2.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb2.append(str3);
                str2 = sb2.toString();
            case 3:
                delete = writableDatabase.delete("voltage", str2, strArr);
                break;
            case 6:
                StringBuilder sb3 = new StringBuilder();
                sb3.append("_id=");
                sb3.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb3.append(str3);
                str2 = sb3.toString();
            case 5:
                delete = writableDatabase.delete("used", str2, strArr);
                break;
            case 8:
                StringBuilder sb4 = new StringBuilder();
                sb4.append("_id=");
                sb4.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb4.append(str3);
                str2 = sb4.toString();
            case 7:
                delete = writableDatabase.delete("hop_record", str2, strArr);
                break;
            case 10:
                StringBuilder sb5 = new StringBuilder();
                sb5.append("_id=");
                sb5.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb5.append(str3);
                str2 = sb5.toString();
            case 9:
                delete = writableDatabase.delete("used_one", str2, strArr);
                break;
            case 12:
                StringBuilder sb6 = new StringBuilder();
                sb6.append("_id=");
                sb6.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb6.append(str3);
                str2 = sb6.toString();
            case 11:
                delete = writableDatabase.delete("used_two", str2, strArr);
                break;
            case 14:
                StringBuilder sb7 = new StringBuilder();
                sb7.append("_id=");
                sb7.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb7.append(str3);
                str2 = sb7.toString();
            case 13:
                delete = writableDatabase.delete("test_point_result", str2, strArr);
                break;
            case 16:
                StringBuilder sb8 = new StringBuilder();
                sb8.append("_id=");
                sb8.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str3 = " AND (" + str2 + ')';
                }
                sb8.append(str3);
                str2 = sb8.toString();
            case 15:
                delete = writableDatabase.delete("test_task", str2, strArr);
                break;
            default:
                throw new IllegalArgumentException("Unknown URI " + uri);
        }
        getContext().getContentResolver().notifyChange(uri, null);
        return delete;
    }

    @Override // android.content.ContentProvider
    public String getType(Uri uri) {
        switch (f1971d.match(uri)) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 9:
            case 11:
            case 13:
            case 15:
                return "vnd.android.cursor.dir/vnd.ape.offlinescriptmanager.data";
            case 2:
            case 4:
            case 6:
            case 8:
            case 10:
            case 12:
            case 14:
            case 16:
                return "vnd.android.cursor.item/vnd.ape.offlinescriptmanager.data";
            default:
                throw new IllegalArgumentException("Unknown URI " + uri);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:120:0x01dc  */
    /* JADX WARN: Removed duplicated region for block: B:122:0x01ec  */
    @Override // android.content.ContentProvider
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.net.Uri insert(android.net.Uri r14, android.content.ContentValues r15) {
        /*
            Method dump skipped, instructions count: 515
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.database.CommonProvider.insert(android.net.Uri, android.content.ContentValues):android.net.Uri");
    }

    @Override // android.content.ContentProvider
    public boolean onCreate() {
        this.f1972b = new a(getContext());
        return true;
    }

    /* JADX WARN: Code restructure failed: missing block: B:10:0x003e, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:13:0x004a, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:16:0x0056, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:19:0x0062, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x006e, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x0070, code lost:
        r7 = "_id ASC";
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x007b, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L38;
     */
    /* JADX WARN: Code restructure failed: missing block: B:28:0x0087, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L38;
     */
    /* JADX WARN: Code restructure failed: missing block: B:29:0x0089, code lost:
        r7 = "time ASC";
     */
    /* JADX WARN: Code restructure failed: missing block: B:30:0x008b, code lost:
        r7 = r13;
     */
    /* JADX WARN: Code restructure failed: missing block: B:32:0x0093, code lost:
        switch(r1.match(r9)) {
            case 1: goto L24;
            case 2: goto L23;
            case 3: goto L24;
            case 4: goto L22;
            case 5: goto L24;
            case 6: goto L21;
            case 7: goto L24;
            case 8: goto L20;
            case 9: goto L24;
            case 10: goto L19;
            case 11: goto L24;
            case 12: goto L18;
            case 13: goto L24;
            case 14: goto L17;
            case 15: goto L24;
            case 16: goto L13;
            default: goto L11;
        };
     */
    /* JADX WARN: Code restructure failed: missing block: B:34:0x00aa, code lost:
        throw new java.lang.IllegalArgumentException("Unknown URI " + r9);
     */
    /* JADX WARN: Code restructure failed: missing block: B:35:0x00ab, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:36:0x00b6, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:37:0x00c1, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:38:0x00cc, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:39:0x00d7, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:40:0x00e2, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:41:0x00ed, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:42:0x00f8, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
        r13 = new java.lang.StringBuilder();
     */
    /* JADX WARN: Code restructure failed: missing block: B:43:0x0102, code lost:
        r13.append("_id=");
        r13.append(r9.getPathSegments().get(1));
        r0.appendWhere(r13.toString());
     */
    /* JADX WARN: Code restructure failed: missing block: B:44:0x011a, code lost:
        r0.setProjectionMap(com.ape.offlinescriptmanager.database.CommonProvider.f1970c);
     */
    /* JADX WARN: Code restructure failed: missing block: B:45:0x011f, code lost:
        r10 = r0.query(r8.f1972b.getReadableDatabase(), r10, r11, r12, null, null, r7);
        r10.setNotificationUri(getContext().getContentResolver(), r9);
     */
    /* JADX WARN: Code restructure failed: missing block: B:46:0x0139, code lost:
        return r10;
     */
    /* JADX WARN: Code restructure failed: missing block: B:7:0x0032, code lost:
        if (android.text.TextUtils.isEmpty(r13) != false) goto L25;
     */
    @Override // android.content.ContentProvider
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.database.Cursor query(android.net.Uri r9, java.lang.String[] r10, java.lang.String r11, java.lang.String[] r12, java.lang.String r13) {
        /*
            Method dump skipped, instructions count: 386
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.database.CommonProvider.query(android.net.Uri, java.lang.String[], java.lang.String, java.lang.String[], java.lang.String):android.database.Cursor");
    }

    @Override // android.content.ContentProvider
    public int update(Uri uri, ContentValues contentValues, String str, String[] strArr) {
        int update;
        SQLiteDatabase writableDatabase = this.f1972b.getWritableDatabase();
        int match = f1971d.match(uri);
        String str2 = BuildConfig.FLAVOR;
        switch (match) {
            case 1:
                update = writableDatabase.update("percentage", contentValues, str, strArr);
                break;
            case 2:
                StringBuilder sb = new StringBuilder();
                sb.append("_id=");
                sb.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb.append(str2);
                update = writableDatabase.update("percentage", contentValues, sb.toString(), strArr);
                break;
            case 3:
                update = writableDatabase.update("voltage", contentValues, str, strArr);
                break;
            case 4:
                StringBuilder sb2 = new StringBuilder();
                sb2.append("_id=");
                sb2.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb2.append(str2);
                update = writableDatabase.update("voltage", contentValues, sb2.toString(), strArr);
                break;
            case 5:
                update = writableDatabase.update("used", contentValues, str, strArr);
                break;
            case 6:
                StringBuilder sb3 = new StringBuilder();
                sb3.append("_id=");
                sb3.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb3.append(str2);
                update = writableDatabase.update("used", contentValues, sb3.toString(), strArr);
                break;
            case 7:
                update = writableDatabase.update("hop_record", contentValues, str, strArr);
                break;
            case 8:
                StringBuilder sb4 = new StringBuilder();
                sb4.append("_id=");
                sb4.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb4.append(str2);
                update = writableDatabase.update("hop_record", contentValues, sb4.toString(), strArr);
                break;
            case 9:
                update = writableDatabase.update("used_one", contentValues, str, strArr);
                break;
            case 10:
                StringBuilder sb5 = new StringBuilder();
                sb5.append("_id=");
                sb5.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb5.append(str2);
                update = writableDatabase.update("used_one", contentValues, sb5.toString(), strArr);
                break;
            case 11:
                update = writableDatabase.update("used_two", contentValues, str, strArr);
                break;
            case 12:
                StringBuilder sb6 = new StringBuilder();
                sb6.append("_id=");
                sb6.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb6.append(str2);
                update = writableDatabase.update("used_two", contentValues, sb6.toString(), strArr);
                break;
            case 13:
                update = writableDatabase.update("test_point_result", contentValues, str, strArr);
                break;
            case 14:
                StringBuilder sb7 = new StringBuilder();
                sb7.append("_id=");
                sb7.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb7.append(str2);
                update = writableDatabase.update("test_point_result", contentValues, sb7.toString(), strArr);
                break;
            case 15:
                update = writableDatabase.update("test_task", contentValues, str, strArr);
                break;
            case 16:
                StringBuilder sb8 = new StringBuilder();
                sb8.append("_id=");
                sb8.append(uri.getPathSegments().get(1));
                if (!TextUtils.isEmpty(str)) {
                    str2 = " AND (" + str + ')';
                }
                sb8.append(str2);
                update = writableDatabase.update("test_task", contentValues, sb8.toString(), strArr);
                break;
            default:
                throw new IllegalArgumentException("Unknown URI " + uri);
        }
        getContext().getContentResolver().notifyChange(uri, null);
        return update;
    }
}
