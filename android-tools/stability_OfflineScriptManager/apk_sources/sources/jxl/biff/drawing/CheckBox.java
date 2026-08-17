package jxl.biff.drawing;

import jxl.WorkbookSettings;
import jxl.biff.ContinueRecord;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.write.biff.File;
/* loaded from: classes.dex */
public class CheckBox implements DrawingGroupObject {
    static /* synthetic */ Class class$jxl$biff$drawing$CheckBox;
    private static Logger logger;
    private int blipId;
    private int column;
    private DrawingData drawingData;
    private DrawingGroup drawingGroup;
    private int drawingNumber;
    private EscherContainer escherData;
    private ContinueRecord formatting;
    private double height;
    private boolean initialized;
    private MsoDrawingRecord mso;
    private MsoDrawingRecord msoDrawingRecord;
    private ObjRecord objRecord;
    private int objectId;
    private Origin origin;
    private EscherContainer readSpContainer;
    private int referenceCount;
    private int row;
    private int shapeId;
    private EscherContainer spContainer;
    private ContinueRecord text;
    private TextObjectRecord txo;
    private ShapeType type;
    private double width;
    private WorkbookSettings workbookSettings;

    static {
        Class cls = class$jxl$biff$drawing$CheckBox;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.CheckBox");
            class$jxl$biff$drawing$CheckBox = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public CheckBox() {
        this.initialized = false;
        this.initialized = true;
        this.origin = Origin.WRITE;
        this.referenceCount = 1;
        this.type = ShapeType.HOST_CONTROL;
    }

    public CheckBox(DrawingGroupObject drawingGroupObject, DrawingGroup drawingGroup, WorkbookSettings workbookSettings) {
        this.initialized = false;
        CheckBox checkBox = (CheckBox) drawingGroupObject;
        Origin origin = checkBox.origin;
        Origin origin2 = Origin.READ;
        Assert.verify(origin == origin2);
        this.msoDrawingRecord = checkBox.msoDrawingRecord;
        this.objRecord = checkBox.objRecord;
        this.initialized = false;
        this.origin = origin2;
        this.drawingData = checkBox.drawingData;
        this.drawingGroup = drawingGroup;
        this.drawingNumber = checkBox.drawingNumber;
        drawingGroup.addDrawing(this);
        this.mso = checkBox.mso;
        this.txo = checkBox.txo;
        this.text = checkBox.text;
        this.formatting = checkBox.formatting;
        this.workbookSettings = workbookSettings;
    }

    public CheckBox(MsoDrawingRecord msoDrawingRecord, ObjRecord objRecord, DrawingData drawingData, DrawingGroup drawingGroup, WorkbookSettings workbookSettings) {
        boolean z = false;
        this.initialized = false;
        this.drawingGroup = drawingGroup;
        this.msoDrawingRecord = msoDrawingRecord;
        this.drawingData = drawingData;
        this.objRecord = objRecord;
        this.initialized = false;
        this.workbookSettings = workbookSettings;
        this.origin = Origin.READ;
        drawingData.addData(msoDrawingRecord.getData());
        this.drawingNumber = this.drawingData.getNumDrawings() - 1;
        this.drawingGroup.addDrawing(this);
        if (msoDrawingRecord != null && objRecord != null) {
            z = true;
        }
        Assert.verify(z);
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
        EscherContainer spContainer = this.drawingData.getSpContainer(this.drawingNumber);
        this.readSpContainer = spContainer;
        Assert.verify(spContainer != null);
        EscherRecord[] children = this.readSpContainer.getChildren();
        Sp sp = (Sp) this.readSpContainer.getChildren()[0];
        this.objectId = this.objRecord.getObjectId();
        this.shapeId = sp.getShapeId();
        ShapeType type = ShapeType.getType(sp.getShapeType());
        this.type = type;
        if (type == ShapeType.UNKNOWN) {
            logger.warn("Unknown shape type");
        }
        ClientAnchor clientAnchor = null;
        for (int i = 0; i < children.length && clientAnchor == null; i++) {
            if (children[i].getType() == EscherRecordType.CLIENT_ANCHOR) {
                clientAnchor = (ClientAnchor) children[i];
            }
        }
        if (clientAnchor == null) {
            logger.warn("Client anchor not found");
        } else {
            this.column = (int) clientAnchor.getX1();
            this.row = (int) clientAnchor.getY1();
        }
        this.initialized = true;
    }

    public void addMso(MsoDrawingRecord msoDrawingRecord) {
        this.mso = msoDrawingRecord;
        this.drawingData.addRawData(msoDrawingRecord.getData());
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final int getBlipId() {
        if (!this.initialized) {
            initialize();
        }
        return this.blipId;
    }

    public int getColumn() {
        return 0;
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
        return null;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public byte[] getImageData() {
        Origin origin = this.origin;
        Assert.verify(origin == Origin.READ || origin == Origin.READ_WRITE);
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

    public int getRow() {
        return 0;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final int getShapeId() {
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
        if (this.origin == Origin.READ) {
            return getReadSpContainer();
        }
        SpContainer spContainer = new SpContainer();
        spContainer.add(new Sp(this.type, this.shapeId, 2560));
        Opt opt = new Opt();
        opt.addProperty(127, false, false, 17039620);
        opt.addProperty(191, false, false, 524296);
        opt.addProperty(511, false, false, 524288);
        opt.addProperty(959, false, false, 131072);
        spContainer.add(opt);
        int i = this.column;
        int i2 = this.row;
        spContainer.add(new ClientAnchor(i, i2, i + 1, i2 + 1, 1));
        spContainer.add(new ClientData());
        return spContainer;
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
        return this.column;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getY() {
        if (!this.initialized) {
            initialize();
        }
        return this.row;
    }

    public int hashCode() {
        return getClass().getName().hashCode();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public boolean isFirst() {
        return this.msoDrawingRecord.isFirst();
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public boolean isFormObject() {
        return false;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setDrawingGroup(DrawingGroup drawingGroup) {
        this.drawingGroup = drawingGroup;
    }

    public void setFormatting(ContinueRecord continueRecord) {
        this.formatting = continueRecord;
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

    public void setText(ContinueRecord continueRecord) {
        this.text = continueRecord;
    }

    public void setTextObject(TextObjectRecord textObjectRecord) {
        this.txo = textObjectRecord;
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
        this.column = (int) d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void setY(double d2) {
        if (this.origin == Origin.READ) {
            if (!this.initialized) {
                initialize();
            }
            this.origin = Origin.READ_WRITE;
        }
        this.row = (int) d2;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void writeAdditionalRecords(File file) {
        if (this.origin != Origin.READ) {
            file.write(new ObjRecord(this.objectId, ObjRecord.CHECKBOX));
            logger.warn("Writing of additional records for checkboxes not implemented");
            return;
        }
        file.write(this.objRecord);
        MsoDrawingRecord msoDrawingRecord = this.mso;
        if (msoDrawingRecord != null) {
            file.write(msoDrawingRecord);
        }
        file.write(this.txo);
        file.write(this.text);
        ContinueRecord continueRecord = this.formatting;
        if (continueRecord != null) {
            file.write(continueRecord);
        }
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void writeTailRecords(File file) {
    }
}
