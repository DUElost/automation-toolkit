package jxl.write.biff;

import jxl.Workbook;
import jxl.biff.StringHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class WriteAccessRecord extends WritableRecordData {
    private static final String authorString = "Java Excel API";
    private byte[] data;
    private String userName;

    public WriteAccessRecord(String str) {
        super(Type.WRITEACCESS);
        this.data = new byte[112];
        if (str == null) {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Java Excel API v");
            stringBuffer.append(Workbook.getVersion());
            str = stringBuffer.toString();
        }
        StringHelper.getBytes(str, this.data, 0);
        int length = str.length();
        while (true) {
            byte[] bArr = this.data;
            if (length >= bArr.length) {
                return;
            }
            bArr[length] = 32;
            length++;
        }
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
