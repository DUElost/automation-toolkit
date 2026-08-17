package jxl.write.biff;

import java.io.OutputStream;
import jxl.WorkbookSettings;
import jxl.biff.ByteData;
import jxl.common.Logger;
/* loaded from: classes.dex */
public final class File {
    static /* synthetic */ Class class$jxl$write$biff$File;
    private static Logger logger;
    private int arrayGrowSize;
    private ExcelDataOutput data;
    private int initialFileSize;
    private OutputStream outputStream;
    private int pos;
    jxl.read.biff.CompoundFile readCompoundFile;
    private WorkbookSettings workbookSettings;

    static {
        Class cls = class$jxl$write$biff$File;
        if (cls == null) {
            cls = class$("jxl.write.biff.File");
            class$jxl$write$biff$File = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public File(OutputStream outputStream, WorkbookSettings workbookSettings, jxl.read.biff.CompoundFile compoundFile) {
        this.outputStream = outputStream;
        this.workbookSettings = workbookSettings;
        this.readCompoundFile = compoundFile;
        createDataOutput();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void createDataOutput() {
        ExcelDataOutput memoryDataOutput;
        if (this.workbookSettings.getUseTemporaryFileDuringWrite()) {
            memoryDataOutput = new FileDataOutput(this.workbookSettings.getTemporaryFileDuringWriteDirectory());
        } else {
            this.initialFileSize = this.workbookSettings.getInitialFileSize();
            this.arrayGrowSize = this.workbookSettings.getArrayGrowSize();
            memoryDataOutput = new MemoryDataOutput(this.initialFileSize, this.arrayGrowSize);
        }
        this.data = memoryDataOutput;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void close(boolean z) {
        ExcelDataOutput excelDataOutput = this.data;
        new CompoundFile(excelDataOutput, excelDataOutput.getPosition(), this.outputStream, this.readCompoundFile).write();
        this.outputStream.flush();
        this.data.close();
        if (z) {
            this.outputStream.close();
        }
        this.data = null;
        if (this.workbookSettings.getGCDisabled()) {
            return;
        }
        System.gc();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getPos() {
        return this.data.getPosition();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setData(byte[] bArr, int i) {
        this.data.setData(bArr, i);
    }

    public void setOutputFile(OutputStream outputStream) {
        if (this.data != null) {
            logger.warn("Rewriting a workbook with non-empty data");
        }
        this.outputStream = outputStream;
        createDataOutput();
    }

    public void write(ByteData byteData) {
        this.data.write(byteData.getBytes());
    }
}
