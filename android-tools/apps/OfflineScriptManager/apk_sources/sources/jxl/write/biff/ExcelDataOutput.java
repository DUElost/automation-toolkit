package jxl.write.biff;

import java.io.OutputStream;
/* loaded from: classes.dex */
interface ExcelDataOutput {
    void close();

    int getPosition();

    void setData(byte[] bArr, int i);

    void write(byte[] bArr);

    void writeData(OutputStream outputStream);
}
