package jxl.biff.drawing;

import java.io.File;
import java.io.FileInputStream;
import jxl.common.Assert;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class Drawing2 implements DrawingGroupObject {
    static /* synthetic */ Class class$jxl$biff$drawing$Drawing;
    private static Logger logger;
    private int blipId;
    private DrawingData drawingData;
    private DrawingGroup drawingGroup;
    private int drawingNumber;
    private EscherContainer escherData;
    private double height;
    private byte[] imageData;
    private File imageFile;
    private boolean initialized;
    private MsoDrawingRecord msoDrawingRecord;
    private int objectId;
    private Origin origin;
    private EscherContainer readSpContainer;
    private int referenceCount;
    private int shapeId;
    private ShapeType type;
    private double width;
    private double x;
    private double y;

    static {
        Class cls = class$jxl$biff$drawing$Drawing;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.Drawing");
            class$jxl$biff$drawing$Drawing = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public Drawing2(double d2, double d3, double d4, double d5, File file) {
        this.initialized = false;
        this.imageFile = file;
        this.initialized = true;
        this.origin = Origin.WRITE;
        this.x = d2;
        this.y = d3;
        this.width = d4;
        this.height = d5;
        this.referenceCount = 1;
        this.type = ShapeType.PICTURE_FRAME;
    }

    public Drawing2(double d2, double d3, double d4, double d5, byte[] bArr) {
        this.initialized = false;
        this.imageData = bArr;
        this.initialized = true;
        this.origin = Origin.WRITE;
        this.x = d2;
        this.y = d3;
        this.width = d4;
        this.height = d5;
        this.referenceCount = 1;
        this.type = ShapeType.PICTURE_FRAME;
    }

    protected Drawing2(DrawingGroupObject drawingGroupObject, DrawingGroup drawingGroup) {
        this.initialized = false;
        Drawing2 drawing2 = (Drawing2) drawingGroupObject;
        Origin origin = drawing2.origin;
        Origin origin2 = Origin.READ;
        Assert.verify(origin == origin2);
        this.msoDrawingRecord = drawing2.msoDrawingRecord;
        this.initialized = false;
        this.origin = origin2;
        this.drawingData = drawing2.drawingData;
        this.drawingGroup = drawingGroup;
        this.drawingNumber = drawing2.drawingNumber;
        drawingGroup.addDrawing(this);
    }

    public Drawing2(MsoDrawingRecord msoDrawingRecord, DrawingData drawingData, DrawingGroup drawingGroup) {
        this.initialized = false;
        this.drawingGroup = drawingGroup;
        this.msoDrawingRecord = msoDrawingRecord;
        this.drawingData = drawingData;
        this.initialized = false;
        this.origin = Origin.READ;
        drawingData.addRawData(msoDrawingRecord.getData());
        this.drawingGroup.addDrawing(this);
        Assert.verify(msoDrawingRecord != null);
        initialize();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private EscherContainer getReadSpContainer() {
        if (!this.initialized) {
            initialize();
        }
        return this.readSpContainer;
    }

    private void initialize() {
        this.initialized = true;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final int getBlipId() {
        if (!this.initialized) {
            initialize();
        }
        return this.blipId;
    }

    public double getColumn() {
        return getX();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public DrawingGroup getDrawingGroup() {
        return this.drawingGroup;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getHeight() {
        if (!this.initialized) {
            initialize();
        }
        return this.height;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public byte[] getImageBytes() {
        Assert.verify(false);
        Origin origin = this.origin;
        if (origin == Origin.READ || origin == Origin.READ_WRITE) {
            return getImageData();
        }
        Assert.verify(origin == Origin.WRITE);
        File file = this.imageFile;
        if (file == null) {
            Assert.verify(this.imageData != null);
            return this.imageData;
        }
        int length = (int) file.length();
        byte[] bArr = new byte[length];
        FileInputStream fileInputStream = new FileInputStream(this.imageFile);
        fileInputStream.read(bArr, 0, length);
        fileInputStream.close();
        return bArr;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public byte[] getImageData() {
        boolean z = false;
        Assert.verify(false);
        Origin origin = this.origin;
        Assert.verify((origin == Origin.READ || origin == Origin.READ_WRITE) ? true : true);
        if (!this.initialized) {
            initialize();
        }
        return this.drawingGroup.getImageData(this.blipId);
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public String getImageFilePath() {
        Assert.verify(false);
        return null;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public MsoDrawingRecord getMsoDrawingRecord() {
        return this.msoDrawingRecord;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final int getObjectId() {
        if (!this.initialized) {
            initialize();
        }
        return this.objectId;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public Origin getOrigin() {
        return this.origin;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public int getReferenceCount() {
        return this.referenceCount;
    }

    public double getRow() {
        return getY();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public int getShapeId() {
        if (!this.initialized) {
            initialize();
        }
        return this.shapeId;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public EscherContainer getSpContainer() {
        if (!this.initialized) {
            initialize();
        }
        Assert.verify(this.origin == Origin.READ);
        return getReadSpContainer();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public ShapeType getType() {
        return this.type;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getWidth() {
        if (!this.initialized) {
            initialize();
        }
        return this.width;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getX() {
        if (!this.initialized) {
            initialize();
        }
        return this.x;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getY() {
        if (!this.initialized) {
            initialize();
        }
        return this.y;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public boolean isFirst() {
        return this.msoDrawingRecord.isFirst();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public boolean isFormObject() {
        return false;
    }

    public void removeRow(int i) {
        double d2 = i;
        if (this.y > d2) {
            setY(d2);
        }
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setDrawingGroup(DrawingGroup drawingGroup) {
        this.drawingGroup = drawingGroup;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setHeight(double d2) {
        if (this.origin == Origin.READ) {
            if (!this.initialized) {
                initialize();
            }
            this.origin = Origin.READ_WRITE;
        }
        this.height = d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final void setObjectId(int i, int i2, int i3) {
        this.objectId = i;
        this.blipId = i2;
        this.shapeId = i3;
        if (this.origin == Origin.READ) {
            this.origin = Origin.READ_WRITE;
        }
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setReferenceCount(int i) {
        this.referenceCount = i;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setWidth(double d2) {
        if (this.origin == Origin.READ) {
            if (!this.initialized) {
                initialize();
            }
            this.origin = Origin.READ_WRITE;
        }
        this.width = d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setX(double d2) {
        if (this.origin == Origin.READ) {
            if (!this.initialized) {
                initialize();
            }
            this.origin = Origin.READ_WRITE;
        }
        this.x = d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setY(double d2) {
        if (this.origin == Origin.READ) {
            if (!this.initialized) {
                initialize();
            }
            this.origin = Origin.READ_WRITE;
        }
        this.y = d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void writeAdditionalRecords(jxl.write.biff.File file) {
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void writeTailRecords(jxl.write.biff.File file) {
    }
}
