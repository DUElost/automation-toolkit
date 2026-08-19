package jxl.biff;

import java.util.ArrayList;
import java.util.Iterator;
import jxl.write.biff.File;
/* loaded from: classes.dex */
public class ConditionalFormat {
    private ArrayList conditions = new ArrayList();
    private ConditionalFormatRangeRecord range;

    public ConditionalFormat(ConditionalFormatRangeRecord conditionalFormatRangeRecord) {
        this.range = conditionalFormatRangeRecord;
    }

    public void addCondition(ConditionalFormatRecord conditionalFormatRecord) {
        this.conditions.add(conditionalFormatRecord);
    }

    public void insertColumn(int i) {
        this.range.insertColumn(i);
    }

    public void insertRow(int i) {
        this.range.insertRow(i);
    }

    public void removeColumn(int i) {
        this.range.removeColumn(i);
    }

    public void removeRow(int i) {
        this.range.removeRow(i);
    }

    public void write(File file) {
        file.write(this.range);
        Iterator it = this.conditions.iterator();
        while (it.hasNext()) {
            file.write((ConditionalFormatRecord) it.next());
        }
    }
}
