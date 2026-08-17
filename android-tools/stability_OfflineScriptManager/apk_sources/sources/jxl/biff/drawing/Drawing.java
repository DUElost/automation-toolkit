package jxl.biff.drawing;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jxl.CellView;
import jxl.Image;
import jxl.Sheet;
import jxl.common.Assert;
import jxl.common.LengthConverter;
import jxl.common.LengthUnit;
import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class Drawing implements DrawingGroupObject, Image {
    private static final double DEFAULT_FONT_SIZE = 10.0d;
    public static ImageAnchorProperties MOVE_AND_SIZE_WITH_CELLS;
    public static ImageAnchorProperties MOVE_WITH_CELLS;
    public static ImageAnchorProperties NO_MOVE_OR_SIZE_WITH_CELLS;
    static /* synthetic */ Class class$jxl$biff$drawing$Drawing;
    private static Logger logger;
    private int blipId;
    private DrawingData drawingData;
    private DrawingGroup drawingGroup;
    private int drawingNumber;
    private EscherContainer escherData;
    private double height;
    private ImageAnchorProperties imageAnchorProperties;
    private byte[] imageData;
    private File imageFile;
    private boolean initialized;
    private MsoDrawingRecord msoDrawingRecord;
    private ObjRecord objRecord;
    private int objectId;
    private Origin origin;
    private PNGReader pngReader;
    private EscherContainer readSpContainer;
    private int referenceCount;
    private int shapeId;
    private Sheet sheet;
    private ShapeType type;
    private double width;
    private double x;
    private double y;

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class ImageAnchorProperties {
        private static ImageAnchorProperties[] o = new ImageAnchorProperties[0];
        private int value;

        ImageAnchorProperties(int i) {
            this.value = i;
            ImageAnchorProperties[] imageAnchorPropertiesArr = o;
            ImageAnchorProperties[] imageAnchorPropertiesArr2 = new ImageAnchorProperties[imageAnchorPropertiesArr.length + 1];
            o = imageAnchorPropertiesArr2;
            System.arraycopy(imageAnchorPropertiesArr, 0, imageAnchorPropertiesArr2, 0, imageAnchorPropertiesArr.length);
            o[imageAnchorPropertiesArr.length] = this;
        }

        static ImageAnchorProperties getImageAnchorProperties(int i) {
            ImageAnchorProperties imageAnchorProperties = Drawing.MOVE_AND_SIZE_WITH_CELLS;
            int i2 = 0;
            while (true) {
                ImageAnchorProperties[] imageAnchorPropertiesArr = o;
                if (i2 >= imageAnchorPropertiesArr.length) {
                    return imageAnchorProperties;
                }
                if (imageAnchorPropertiesArr[i2].getValue() == i) {
                    return o[i2];
                }
                i2++;
            }
        }

        int getValue() {
            return this.value;
        }
    }

    static {
        Class cls = class$jxl$biff$drawing$Drawing;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.Drawing");
            class$jxl$biff$drawing$Drawing = cls;
        }
        logger = Logger.getLogger(cls);
        MOVE_AND_SIZE_WITH_CELLS = new ImageAnchorProperties(1);
        MOVE_WITH_CELLS = new ImageAnchorProperties(2);
        NO_MOVE_OR_SIZE_WITH_CELLS = new ImageAnchorProperties(3);
    }

    public Drawing(double d2, double d3, double d4, double d5, File file) {
        this.initialized = false;
        this.imageFile = file;
        this.initialized = true;
        this.origin = Origin.WRITE;
        this.x = d2;
        this.y = d3;
        this.width = d4;
        this.height = d5;
        this.referenceCount = 1;
        this.imageAnchorProperties = MOVE_WITH_CELLS;
        this.type = ShapeType.PICTURE_FRAME;
    }

    public Drawing(double d2, double d3, double d4, double d5, byte[] bArr) {
        this.initialized = false;
        this.imageData = bArr;
        this.initialized = true;
        this.origin = Origin.WRITE;
        this.x = d2;
        this.y = d3;
        this.width = d4;
        this.height = d5;
        this.referenceCount = 1;
        this.imageAnchorProperties = MOVE_WITH_CELLS;
        this.type = ShapeType.PICTURE_FRAME;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public Drawing(DrawingGroupObject drawingGroupObject, DrawingGroup drawingGroup) {
        this.initialized = false;
        Drawing drawing = (Drawing) drawingGroupObject;
        Origin origin = drawing.origin;
        Origin origin2 = Origin.READ;
        Assert.verify(origin == origin2);
        this.msoDrawingRecord = drawing.msoDrawingRecord;
        this.objRecord = drawing.objRecord;
        this.initialized = false;
        this.origin = origin2;
        this.drawingData = drawing.drawingData;
        this.drawingGroup = drawingGroup;
        this.drawingNumber = drawing.drawingNumber;
        drawingGroup.addDrawing(this);
    }

    public Drawing(MsoDrawingRecord msoDrawingRecord, ObjRecord objRecord, DrawingData drawingData, DrawingGroup drawingGroup, Sheet sheet) {
        boolean z = false;
        this.initialized = false;
        this.drawingGroup = drawingGroup;
        this.msoDrawingRecord = msoDrawingRecord;
        this.drawingData = drawingData;
        this.objRecord = objRecord;
        this.sheet = sheet;
        this.initialized = false;
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

    private double getHeightInPoints() {
        double d2 = 0.0d;
        if (this.sheet == null) {
            logger.warn("calculating image height:  sheet is null");
            return 0.0d;
        }
        double d3 = this.y;
        int i = (int) d3;
        int ceil = ((int) Math.ceil(d3 + this.height)) - 1;
        double size = this.sheet.getRowView(i).getSize();
        int size2 = ceil != i ? this.sheet.getRowView(ceil).getSize() : 0;
        for (int i2 = 0; i2 < (ceil - i) - 1; i2++) {
            d2 += this.sheet.getRowView(i + 1 + i2).getSize();
        }
        return ((d2 + size) + size2) / 20.0d;
    }

    private PNGReader getPngReader() {
        byte[] imageData;
        PNGReader pNGReader = this.pngReader;
        if (pNGReader != null) {
            return pNGReader;
        }
        Origin origin = this.origin;
        if (origin == Origin.READ || origin == Origin.READ_WRITE) {
            imageData = getImageData();
        } else {
            try {
                imageData = getImageBytes();
            } catch (IOException unused) {
                logger.warn("Could not read image file");
                imageData = new byte[0];
            }
        }
        PNGReader pNGReader2 = new PNGReader(imageData);
        this.pngReader = pNGReader2;
        pNGReader2.read();
        return this.pngReader;
    }

    private EscherContainer getReadSpContainer() {
        if (!this.initialized) {
            initialize();
        }
        return this.readSpContainer;
    }

    private double getWidthInPoints() {
        CellView columnView;
        double d2;
        CellView columnView2;
        CellView columnView3;
        if (this.sheet == null) {
            logger.warn("calculating image width:  sheet is null");
            return 0.0d;
        }
        double d3 = this.x;
        int i = (int) d3;
        int ceil = ((int) Math.ceil(d3 + this.width)) - 1;
        double size = ((((1.0d - (this.x - i)) * columnView.getSize()) * 0.59d) * (this.sheet.getColumnView(i).getFormat() != null ? columnView.getFormat().getFont().getPointSize() : DEFAULT_FONT_SIZE)) / 256.0d;
        if (ceil != i) {
            d2 = (((((this.x + this.width) - ceil) * columnView3.getSize()) * 0.59d) * (this.sheet.getColumnView(ceil).getFormat() != null ? columnView3.getFormat().getFont().getPointSize() : DEFAULT_FONT_SIZE)) / 256.0d;
        } else {
            d2 = 0.0d;
        }
        double d4 = 0.0d;
        for (int i2 = 0; i2 < (ceil - i) - 1; i2++) {
            d4 += ((columnView2.getSize() * 0.59d) * (this.sheet.getColumnView((i + 1) + i2).getFormat() != null ? columnView2.getFormat().getFont().getPointSize() : DEFAULT_FONT_SIZE)) / 256.0d;
        }
        return d4 + size + d2;
    }

    private void initialize() {
        EscherContainer spContainer = this.drawingData.getSpContainer(this.drawingNumber);
        this.readSpContainer = spContainer;
        Assert.verify(spContainer != null);
        EscherRecord[] children = this.readSpContainer.getChildren();
        Sp sp = (Sp) this.readSpContainer.getChildren()[0];
        this.shapeId = sp.getShapeId();
        this.objectId = this.objRecord.getObjectId();
        ShapeType type = ShapeType.getType(sp.getShapeType());
        this.type = type;
        if (type == ShapeType.UNKNOWN) {
            logger.warn("Unknown shape type");
        }
        Opt opt = (Opt) this.readSpContainer.getChildren()[1];
        if (opt.getProperty(260) != null) {
            this.blipId = opt.getProperty(260).value;
        }
        if (opt.getProperty(261) != null) {
            this.imageFile = new File(opt.getProperty(261).stringValue);
        } else if (this.type == ShapeType.PICTURE_FRAME) {
            logger.warn("no filename property for drawing");
            this.imageFile = new File(Integer.toString(this.blipId));
        }
        ClientAnchor clientAnchor = null;
        for (int i = 0; i < children.length && clientAnchor == null; i++) {
            if (children[i].getType() == EscherRecordType.CLIENT_ANCHOR) {
                clientAnchor = (ClientAnchor) children[i];
            }
        }
        if (clientAnchor == null) {
            logger.warn("client anchor not found");
        } else {
            this.x = clientAnchor.getX1();
            this.y = clientAnchor.getY1();
            this.width = clientAnchor.getX2() - this.x;
            this.height = clientAnchor.getY2() - this.y;
            this.imageAnchorProperties = ImageAnchorProperties.getImageAnchorProperties(clientAnchor.getProperties());
        }
        if (this.blipId == 0) {
            logger.warn("linked drawings are not supported");
        }
        this.initialized = true;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public final int getBlipId() {
        if (!this.initialized) {
            initialize();
        }
        return this.blipId;
    }

    @Override // jxl.Image
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

    @Override // jxl.Image
    public double getHeight(LengthUnit lengthUnit) {
        return getHeightInPoints() * LengthConverter.getConversionFactor(LengthUnit.POINTS, lengthUnit);
    }

    @Override // jxl.Image
    public double getHorizontalResolution(LengthUnit lengthUnit) {
        return getPngReader().getHorizontalResolution() / LengthConverter.getConversionFactor(LengthUnit.METRES, lengthUnit);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public ImageAnchorProperties getImageAnchor() {
        if (!this.initialized) {
            initialize();
        }
        return this.imageAnchorProperties;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public byte[] getImageBytes() {
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
        Origin origin = this.origin;
        Assert.verify(origin == Origin.READ || origin == Origin.READ_WRITE);
        if (!this.initialized) {
            initialize();
        }
        return this.drawingGroup.getImageData(this.blipId);
    }

    @Override // jxl.Image
    public File getImageFile() {
        return this.imageFile;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public String getImageFilePath() {
        File file = this.imageFile;
        if (file == null) {
            int i = this.blipId;
            return i != 0 ? Integer.toString(i) : "__new__image__";
        }
        return file.getPath();
    }

    @Override // jxl.Image
    public int getImageHeight() {
        return getPngReader().getHeight();
    }

    @Override // jxl.Image
    public int getImageWidth() {
        return getPngReader().getWidth();
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

    @Override // jxl.Image
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
        if (this.origin == Origin.READ) {
            return getReadSpContainer();
        }
        SpContainer spContainer = new SpContainer();
        spContainer.add(new Sp(this.type, this.shapeId, 2560));
        Opt opt = new Opt();
        opt.addProperty(260, true, false, this.blipId);
        if (this.type == ShapeType.PICTURE_FRAME) {
            File file = this.imageFile;
            String path = file != null ? file.getPath() : BuildConfig.FLAVOR;
            opt.addProperty(261, true, true, path.length() * 2, path);
            opt.addProperty(447, false, false, 65536);
            opt.addProperty(959, false, false, 524288);
            spContainer.add(opt);
        }
        double d2 = this.x;
        double d3 = this.y;
        spContainer.add(new ClientAnchor(d2, d3, d2 + this.width, d3 + this.height, this.imageAnchorProperties.getValue()));
        spContainer.add(new ClientData());
        return spContainer;
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public ShapeType getType() {
        return this.type;
    }

    @Override // jxl.Image
    public double getVerticalResolution(LengthUnit lengthUnit) {
        return getPngReader().getVerticalResolution() / LengthConverter.getConversionFactor(LengthUnit.METRES, lengthUnit);
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public double getWidth() {
        if (!this.initialized) {
            initialize();
        }
        return this.width;
    }

    @Override // jxl.Image
    public double getWidth(LengthUnit lengthUnit) {
        return getWidthInPoints() * LengthConverter.getConversionFactor(LengthUnit.POINTS, lengthUnit);
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

    /* JADX INFO: Access modifiers changed from: protected */
    public void setImageAnchor(ImageAnchorProperties imageAnchorProperties) {
        this.imageAnchorProperties = imageAnchorProperties;
        if (this.origin == Origin.READ) {
            this.origin = Origin.READ_WRITE;
        }
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
        file.write(this.origin == Origin.READ ? this.objRecord : new ObjRecord(this.objectId, ObjRecord.PICTURE));
    }

    @Override // jxl.biff.drawing.DrawingGroupObject
    public void writeTailRecords(jxl.write.biff.File file) {
    }
}
