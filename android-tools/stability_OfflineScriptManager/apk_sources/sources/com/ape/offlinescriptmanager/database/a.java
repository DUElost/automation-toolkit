package com.ape.offlinescriptmanager.database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
/* loaded from: classes.dex */
public class a extends SQLiteOpenHelper {
    public a(Context context) {
        super(context, "battery_data.db", (SQLiteDatabase.CursorFactory) null, 2);
    }

    @Override // android.database.sqlite.SQLiteOpenHelper
    public void onCreate(SQLiteDatabase sQLiteDatabase) {
        sQLiteDatabase.execSQL("CREATE TABLE percentage (_id INTEGER PRIMARY KEY,time TEXT,percentage TEXT,temperature DOUBLE);");
        sQLiteDatabase.execSQL("CREATE TABLE voltage (_id INTEGER PRIMARY KEY,time TEXT,voltage TEXT,temperature DOUBLE);");
        sQLiteDatabase.execSQL("CREATE TABLE used (_id INTEGER PRIMARY KEY,range TEXT,used_time TEXT,time_range TEXT);");
        sQLiteDatabase.execSQL("CREATE TABLE used_one (_id INTEGER PRIMARY KEY,range TEXT,used_time TEXT,time_range TEXT);");
        sQLiteDatabase.execSQL("CREATE TABLE used_two (_id INTEGER PRIMARY KEY,range TEXT,used_time TEXT,time_range TEXT);");
        sQLiteDatabase.execSQL("CREATE TABLE hop_record (_id INTEGER PRIMARY KEY,hop_range TEXT,hop_time TEXT);");
        sQLiteDatabase.execSQL("CREATE TABLE test_point_result (_id INTEGER PRIMARY KEY,name TEXT,status TEXT,start_time LONG,stop_time LONG,start_battery_percentage INTEGER,stop_battery_percentage INTEGER,regression INTEGER);");
        sQLiteDatabase.execSQL("CREATE TABLE test_task (_id INTEGER PRIMARY KEY,task_name TEXT,task_result_time TEXT,result_is_upload INTEGER,task_creator TEXT);");
    }

    @Override // android.database.sqlite.SQLiteOpenHelper
    public void onUpgrade(SQLiteDatabase sQLiteDatabase, int i, int i2) {
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS percentage");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS voltage");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS used");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS used_one");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS used_two");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS hop_record");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS test_point_result");
        sQLiteDatabase.execSQL("DROP TABLE IF EXISTS test_task");
        onCreate(sQLiteDatabase);
    }
}
