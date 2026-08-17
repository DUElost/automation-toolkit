package jxl.biff.drawing;

import jxl.write.biff.File;
/* loaded from: classes.dex */
public interface DrawingGroupObject {
    int getBlipId();

    DrawingGroup getDrawingGroup();

    double getHeight();

    byte[] getImageBytes();

    byte[] getImageData();

    String getImageFilePath();

    MsoDrawingRecord getMsoDrawingRecord();

    int getObjectId();

    Origin getOrigin();

    int getReferenceCount();

    int getShapeId();

    EscherContainer getSpContainer();

    ShapeType getType();

    double getWidth();

    double getX();

    double getY();

    boolean isFirst();

    boolean isFormObject();

    void setDrawingGroup(DrawingGroup drawingGroup);

    void setHeight(double d2);

    void setObjectId(int i, int i2, int i3);

    void setReferenceCount(int i);

    void setWidth(double d2);

    void setX(double d2);

    void setY(double d2);

    void writeAdditionalRecords(File file);

    void writeTailRecords(File file);
}
