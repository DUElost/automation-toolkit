package jxl.write.biff;

import java.io.OutputStream;
import jxl.common.Logger;
/* loaded from: classes.dex */
class MemoryDataOutput implements ExcelDataOutput {
    static /* synthetic */ Class class$jxl$write$biff$MemoryDataOutput;
    private static Logger logger;
    private byte[] data;
    private int growSize;
    private int pos = 0;

    static {
        Class cls = class$jxl$write$biff$MemoryDataOutput;
        if (cls == null) {
            cls = class$("jxl.write.biff.MemoryDataOutput");
            class$jxl$write$biff$MemoryDataOutput = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public MemoryDataOutput(int i, int i2) {
        this.data = new byte[i];
        this.growSize = i2;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void close() {
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public int getPosition() {
        return this.pos;
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void setData(byte[] bArr, int i) {
        System.arraycopy(bArr, 0, this.data, i, bArr.length);
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void write(byte[] bArr) {
        while (true) {
            int i = this.pos;
            int length = bArr.length + i;
            byte[] bArr2 = this.data;
            if (length <= bArr2.length) {
                System.arraycopy(bArr, 0, bArr2, i, bArr.length);
                this.pos += bArr.length;
                return;
            }
            byte[] bArr3 = new byte[bArr2.length + this.growSize];
            System.arraycopy(bArr2, 0, bArr3, 0, i);
            this.data = bArr3;
        }
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void writeData(OutputStream outputStream) {
        outputStream.write(this.data, 0, this.pos);
    }
}
