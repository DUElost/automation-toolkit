package jxl.biff.drawing;

import jxl.WorkbookSettings;
import jxl.biff.ByteData;
import jxl.biff.IndexMapping;
import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.read.biff.File;
/* loaded from: classes.dex */
public class Chart implements ByteData, EscherStream {
    static /* synthetic */ Class class$jxl$biff$drawing$Chart;
    private static final Logger logger;
    private byte[] data;
    private DrawingData drawingData;
    private int drawingNumber;
    private int endpos;
    private File file;
    private boolean initialized;
    private MsoDrawingRecord msoDrawingRecord;
    private ObjRecord objRecord;
    private int startpos;
    private WorkbookSettings workbookSettings;

    static {
        Class cls = class$jxl$biff$drawing$Chart;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.Chart");
            class$jxl$biff$drawing$Chart = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public Chart(MsoDrawingRecord msoDrawingRecord, ObjRecord objRecord, DrawingData drawingData, int i, int i2, File file, WorkbookSettings workbookSettings) {
        this.msoDrawingRecord = msoDrawingRecord;
        this.objRecord = objRecord;
        this.startpos = i;
        this.endpos = i2;
        this.file = file;
        this.workbookSettings = workbookSettings;
        boolean z = true;
        if (msoDrawingRecord != null) {
            this.drawingData = drawingData;
            drawingData.addData(msoDrawingRecord.getRecord().getData());
            this.drawingNumber = this.drawingData.getNumDrawings() - 1;
        }
        this.initialized = false;
        if ((msoDrawingRecord == null || objRecord == null) && (msoDrawingRecord != null || objRecord != null)) {
            z = false;
        }
        Assert.verify(z);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void initialize() {
        File file = this.file;
        int i = this.startpos;
        this.data = file.read(i, this.endpos - i);
        this.initialized = true;
    }

    @Override // jxl.biff.ByteData
    public byte[] getBytes() {
        if (!this.initialized) {
            initialize();
        }
        return this.data;
    }

    @Override // jxl.biff.drawing.EscherStream
    public byte[] getData() {
        return this.msoDrawingRecord.getRecord().getData();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public MsoDrawingRecord getMsoDrawingRecord() {
        return this.msoDrawingRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ObjRecord getObjRecord() {
        return this.objRecord;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public EscherContainer getSpContainer() {
        return this.drawingData.getSpContainer(this.drawingNumber);
    }

    public void rationalize(IndexMapping indexMapping, IndexMapping indexMapping2, IndexMapping indexMapping3) {
        if (!this.initialized) {
            initialize();
        }
        int i = 0;
        while (true) {
            byte[] bArr = this.data;
            if (i >= bArr.length) {
                return;
            }
            int i2 = IntegerHelper.getInt(bArr[i], bArr[i + 1]);
            byte[] bArr2 = this.data;
            int i3 = IntegerHelper.getInt(bArr2[i + 2], bArr2[i + 3]);
            Type type = Type.getType(i2);
            if (type == Type.FONTX) {
                byte[] bArr3 = this.data;
                int i4 = i + 4;
                IntegerHelper.getTwoBytes(indexMapping2.getNewIndex(IntegerHelper.getInt(bArr3[i4], bArr3[i + 5])), this.data, i4);
            } else if (type == Type.FBI) {
                byte[] bArr4 = this.data;
                int i5 = i + 12;
                IntegerHelper.getTwoBytes(indexMapping2.getNewIndex(IntegerHelper.getInt(bArr4[i5], bArr4[i + 13])), this.data, i5);
            } else if (type == Type.IFMT) {
                byte[] bArr5 = this.data;
                int i6 = i + 4;
                IntegerHelper.getTwoBytes(indexMapping3.getNewIndex(IntegerHelper.getInt(bArr5[i6], bArr5[i + 5])), this.data, i6);
            } else if (type == Type.ALRUNS) {
                byte[] bArr6 = this.data;
                int i7 = IntegerHelper.getInt(bArr6[i + 4], bArr6[i + 5]);
                int i8 = i + 6;
                for (int i9 = 0; i9 < i7; i9++) {
                    byte[] bArr7 = this.data;
                    int i10 = i8 + 2;
                    IntegerHelper.getTwoBytes(indexMapping2.getNewIndex(IntegerHelper.getInt(bArr7[i10], bArr7[i8 + 3])), this.data, i10);
                    i8 += 4;
                }
            }
            i += i3 + 4;
        }
    }
}
