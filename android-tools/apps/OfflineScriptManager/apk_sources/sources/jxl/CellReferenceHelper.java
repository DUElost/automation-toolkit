package jxl;

import jxl.biff.formula.ExternalSheet;
import jxl.write.WritableWorkbook;
/* loaded from: classes.dex */
public final class CellReferenceHelper {
    private CellReferenceHelper() {
    }

    public static String getCellReference(int i, int i2) {
        return jxl.biff.CellReferenceHelper.getCellReference(i, i2);
    }

    public static String getCellReference(int i, int i2, int i3, Workbook workbook) {
        return jxl.biff.CellReferenceHelper.getCellReference(i, i2, i3, (ExternalSheet) workbook);
    }

    public static String getCellReference(int i, int i2, int i3, WritableWorkbook writableWorkbook) {
        return jxl.biff.CellReferenceHelper.getCellReference(i, i2, i3, (ExternalSheet) writableWorkbook);
    }

    public static void getCellReference(int i, int i2, int i3, Workbook workbook, StringBuffer stringBuffer) {
        jxl.biff.CellReferenceHelper.getCellReference(i, i2, i3, (ExternalSheet) workbook, stringBuffer);
    }

    public static void getCellReference(int i, int i2, int i3, WritableWorkbook writableWorkbook, StringBuffer stringBuffer) {
        jxl.biff.CellReferenceHelper.getCellReference(i, i2, i3, (ExternalSheet) writableWorkbook, stringBuffer);
    }

    public static void getCellReference(int i, int i2, StringBuffer stringBuffer) {
        jxl.biff.CellReferenceHelper.getCellReference(i, i2, stringBuffer);
    }

    public static void getCellReference(int i, int i2, boolean z, int i3, boolean z2, Workbook workbook, StringBuffer stringBuffer) {
        jxl.biff.CellReferenceHelper.getCellReference(i, i2, z, i3, z2, (ExternalSheet) workbook, stringBuffer);
    }

    public static void getCellReference(int i, boolean z, int i2, boolean z2, StringBuffer stringBuffer) {
        jxl.biff.CellReferenceHelper.getCellReference(i, z, i2, z2, stringBuffer);
    }

    public static int getColumn(String str) {
        return jxl.biff.CellReferenceHelper.getColumn(str);
    }

    public static String getColumnReference(int i) {
        return jxl.biff.CellReferenceHelper.getColumnReference(i);
    }

    public static int getRow(String str) {
        return jxl.biff.CellReferenceHelper.getRow(str);
    }

    public static String getSheet(String str) {
        return jxl.biff.CellReferenceHelper.getSheet(str);
    }

    public static boolean isColumnRelative(String str) {
        return jxl.biff.CellReferenceHelper.isColumnRelative(str);
    }

    public static boolean isRowRelative(String str) {
        return jxl.biff.CellReferenceHelper.isRowRelative(str);
    }
}
