package com.ape.offlinescriptmanager.batterytool.g;

import android.content.Context;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.i;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    public Workbook f1921a;

    /* renamed from: b  reason: collision with root package name */
    public WritableWorkbook f1922b;

    /* renamed from: c  reason: collision with root package name */
    public WritableSheet f1923c;

    /* renamed from: d  reason: collision with root package name */
    public WritableSheet f1924d;
    public WritableSheet e;
    public WritableSheet f;
    public WritableSheet g;
    public WritableSheet h;
    public WritableSheet i;
    private String j;
    private String k;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        public int f1925a;

        /* renamed from: b  reason: collision with root package name */
        public int f1926b;

        /* renamed from: c  reason: collision with root package name */
        public String f1927c;
    }

    public c(Context context, String str, String str2) {
        WritableSheet sheet;
        WritableSheet sheet2;
        this.f1921a = null;
        this.f1922b = null;
        this.f1923c = null;
        this.f1924d = null;
        this.e = null;
        this.f = null;
        this.g = null;
        this.h = null;
        this.i = null;
        this.j = str;
        this.k = str2;
        String str3 = str2.equals("battery") ? "battery_result_data.xls" : "null";
        try {
            InputStream open = context.getAssets().open(str3);
            if (open != null) {
                this.f1921a = Workbook.getWorkbook(open);
                File file = new File(new File(g.l(str, BuildConfig.FLAVOR), str3).getAbsolutePath());
                if (!file.getParentFile().exists()) {
                    file.mkdirs();
                }
                if (file.exists()) {
                    file.delete();
                }
                file.createNewFile();
                WritableWorkbook createWorkbook = Workbook.createWorkbook(file, this.f1921a);
                this.f1922b = createWorkbook;
                if (createWorkbook == null) {
                    throw new IllegalArgumentException("cann't create writableWorkbook ,please note!!!");
                }
                if (str2.equals("battery")) {
                    this.f1923c = this.f1922b.getSheet(1);
                    this.f1924d = this.f1922b.getSheet(2);
                    this.e = this.f1922b.getSheet(3);
                    this.f = this.f1922b.getSheet(4);
                    this.g = this.f1922b.getSheet(5);
                    this.h = this.f1922b.getSheet(6);
                    this.i = this.f1922b.getSheet(7);
                    return;
                }
                if (!str2.equals("signal")) {
                    if (str2.equals("scrutator")) {
                        this.f1923c = this.f1922b.getSheet(1);
                        return;
                    }
                    if (str2.equals("roadrecorder")) {
                        this.f1923c = this.f1922b.getSheet(1);
                        sheet = this.f1922b.getSheet(2);
                    } else if (str2.equals("externalmonitor")) {
                        this.f1923c = this.f1922b.getSheet(1);
                        this.f1924d = this.f1922b.getSheet(2);
                        this.e = this.f1922b.getSheet(3);
                        this.f = this.f1922b.getSheet(4);
                        return;
                    } else if (str2.equals("simSignal")) {
                        this.f1923c = this.f1922b.getSheet(1);
                        this.f1924d = this.f1922b.getSheet(2);
                        sheet2 = this.f1922b.getSheet(3);
                    } else if (!str2.equals("wifiSignal")) {
                        return;
                    } else {
                        this.f1923c = this.f1922b.getSheet(1);
                        sheet = this.f1922b.getSheet(2);
                    }
                    this.f1924d = sheet;
                    return;
                }
                this.f1923c = this.f1922b.getSheet(1);
                this.f1924d = this.f1922b.getSheet(2);
                sheet2 = this.f1922b.getSheet(3);
                this.e = sheet2;
            }
        } catch (IOException e) {
            i.a("IOException e : " + e.getMessage());
            e.printStackTrace();
        } catch (BiffException e2) {
            i.a("BiffException e : " + e2.getMessage());
            e2.printStackTrace();
        }
    }

    public void a() {
        try {
            this.f1922b.close();
            this.f1921a.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (WriteException e2) {
            e2.printStackTrace();
        }
    }

    public void b() {
        try {
            this.f1922b.write();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void c(WritableSheet writableSheet, double d2, double d3, double d4, double d5, String str) {
        File file = new File(g.l(this.j, this.k) + File.separator + str + ".png");
        if (file.exists()) {
            writableSheet.addImage(new WritableImage(d2, d3, d4, d5, file));
        }
    }

    public void d(WritableSheet writableSheet, List<a> list) {
        try {
            WritableCellFormat writableCellFormat = new WritableCellFormat(new WritableFont(WritableFont.ARIAL));
            writableCellFormat.setAlignment(Alignment.CENTRE);
            for (a aVar : list) {
                writableSheet.addCell(new Label(aVar.f1926b, aVar.f1925a, aVar.f1927c, writableCellFormat));
            }
        } catch (RowsExceededException | WriteException e) {
            e.printStackTrace();
        }
    }
}
