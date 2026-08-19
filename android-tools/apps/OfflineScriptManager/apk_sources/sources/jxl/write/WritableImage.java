package jxl.write;

import java.io.File;
import jxl.biff.drawing.Drawing;
import jxl.biff.drawing.DrawingGroup;
import jxl.biff.drawing.DrawingGroupObject;
/* loaded from: classes.dex */
public class WritableImage extends Drawing {
    public static Drawing.ImageAnchorProperties MOVE_AND_SIZE_WITH_CELLS = Drawing.MOVE_AND_SIZE_WITH_CELLS;
    public static Drawing.ImageAnchorProperties MOVE_WITH_CELLS = Drawing.MOVE_WITH_CELLS;
    public static Drawing.ImageAnchorProperties NO_MOVE_OR_SIZE_WITH_CELLS = Drawing.NO_MOVE_OR_SIZE_WITH_CELLS;

    public WritableImage(double d2, double d3, double d4, double d5, File file) {
        super(d2, d3, d4, d5, file);
    }

    public WritableImage(double d2, double d3, double d4, double d5, byte[] bArr) {
        super(d2, d3, d4, d5, bArr);
    }

    public WritableImage(DrawingGroupObject drawingGroupObject, DrawingGroup drawingGroup) {
        super(drawingGroupObject, drawingGroup);
    }

    @Override // jxl.biff.drawing.Drawing, jxl.Image
    public double getColumn() {
        return super.getX();
    }

    @Override // jxl.biff.drawing.Drawing, jxl.biff.drawing.DrawingGroupObject
    public double getHeight() {
        return super.getHeight();
    }

    @Override // jxl.biff.drawing.Drawing
    public Drawing.ImageAnchorProperties getImageAnchor() {
        return super.getImageAnchor();
    }

    @Override // jxl.biff.drawing.Drawing, jxl.biff.drawing.DrawingGroupObject
    public byte[] getImageData() {
        return super.getImageData();
    }

    @Override // jxl.biff.drawing.Drawing, jxl.Image
    public File getImageFile() {
        return super.getImageFile();
    }

    @Override // jxl.biff.drawing.Drawing, jxl.Image
    public double getRow() {
        return super.getY();
    }

    @Override // jxl.biff.drawing.Drawing, jxl.biff.drawing.DrawingGroupObject
    public double getWidth() {
        return super.getWidth();
    }

    public void setColumn(double d2) {
        super.setX(d2);
    }

    @Override // jxl.biff.drawing.Drawing, jxl.biff.drawing.DrawingGroupObject
    public void setHeight(double d2) {
        super.setHeight(d2);
    }

    @Override // jxl.biff.drawing.Drawing
    public void setImageAnchor(Drawing.ImageAnchorProperties imageAnchorProperties) {
        super.setImageAnchor(imageAnchorProperties);
    }

    public void setRow(double d2) {
        super.setY(d2);
    }

    @Override // jxl.biff.drawing.Drawing, jxl.biff.drawing.DrawingGroupObject
    public void setWidth(double d2) {
        super.setWidth(d2);
    }
}
