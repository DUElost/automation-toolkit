package jxl.format;
/* loaded from: classes.dex */
public class Border {
    private String string;
    public static final Border NONE = new Border("none");
    public static final Border ALL = new Border("all");
    public static final Border TOP = new Border("top");
    public static final Border BOTTOM = new Border("bottom");
    public static final Border LEFT = new Border("left");
    public static final Border RIGHT = new Border("right");

    /* JADX INFO: Access modifiers changed from: protected */
    public Border(String str) {
        this.string = str;
    }

    public String getDescription() {
        return this.string;
    }
}
