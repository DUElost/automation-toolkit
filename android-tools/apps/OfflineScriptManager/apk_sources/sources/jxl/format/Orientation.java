package jxl.format;

import jxl.SheetSettings;
/* loaded from: classes.dex */
public final class Orientation {
    private String string;
    private int value;
    private static Orientation[] orientations = new Orientation[0];
    public static Orientation HORIZONTAL = new Orientation(0, "horizontal");
    public static Orientation VERTICAL = new Orientation(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT, "vertical");
    public static Orientation PLUS_90 = new Orientation(90, "up 90");
    public static Orientation MINUS_90 = new Orientation(180, "down 90");
    public static Orientation PLUS_45 = new Orientation(45, "up 45");
    public static Orientation MINUS_45 = new Orientation(135, "down 45");
    public static Orientation STACKED = new Orientation(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT, "stacked");

    protected Orientation(int i, String str) {
        this.value = i;
        this.string = str;
        Orientation[] orientationArr = orientations;
        Orientation[] orientationArr2 = new Orientation[orientationArr.length + 1];
        orientations = orientationArr2;
        System.arraycopy(orientationArr, 0, orientationArr2, 0, orientationArr.length);
        orientations[orientationArr.length] = this;
    }

    public static Orientation getOrientation(int i) {
        int i2 = 0;
        while (true) {
            Orientation[] orientationArr = orientations;
            if (i2 >= orientationArr.length) {
                return HORIZONTAL;
            }
            if (orientationArr[i2].getValue() == i) {
                return orientations[i2];
            }
            i2++;
        }
    }

    public String getDescription() {
        return this.string;
    }

    public int getValue() {
        return this.value;
    }
}
