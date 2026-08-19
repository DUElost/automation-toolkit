package jxl.write.biff;

import java.io.OutputStream;
import java.io.RandomAccessFile;
import jxl.common.Logger;
/* loaded from: classes.dex */
class FileDataOutput implements ExcelDataOutput {
    static /* synthetic */ Class class$jxl$write$biff$FileDataOutput;
    private static Logger logger;
    private RandomAccessFile data;
    private java.io.File temporaryFile;

    static {
        Class cls = class$jxl$write$biff$FileDataOutput;
        if (cls == null) {
            cls = class$("jxl.write.biff.FileDataOutput");
            class$jxl$write$biff$FileDataOutput = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public FileDataOutput(java.io.File file) {
        java.io.File createTempFile = java.io.File.createTempFile("jxl", ".tmp", file);
        this.temporaryFile = createTempFile;
        createTempFile.deleteOnExit();
        this.data = new RandomAccessFile(this.temporaryFile, "rw");
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
        this.data.close();
        this.temporaryFile.delete();
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public int getPosition() {
        return (int) this.data.getFilePointer();
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void setData(byte[] bArr, int i) {
        long filePointer = this.data.getFilePointer();
        this.data.seek(i);
        this.data.write(bArr);
        this.data.seek(filePointer);
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void write(byte[] bArr) {
        this.data.write(bArr);
    }

    @Override // jxl.write.biff.ExcelDataOutput
    public void writeData(OutputStream outputStream) {
        byte[] bArr = new byte[1024];
        this.data.seek(0L);
        while (true) {
            int read = this.data.read(bArr);
            if (read == -1) {
                return;
            }
            outputStream.write(bArr, 0, read);
        }
    }
}
