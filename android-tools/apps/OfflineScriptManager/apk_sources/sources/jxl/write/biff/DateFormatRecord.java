package jxl.write.biff;

import jxl.biff.FormatRecord;
/* loaded from: classes.dex */
public class DateFormatRecord extends FormatRecord {
    /* JADX INFO: Access modifiers changed from: protected */
    public DateFormatRecord(String str) {
        setFormatString(replace(replace(str, "a", "AM/PM"), "S", "0"));
    }
}
