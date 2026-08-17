package jxl.format;
/* loaded from: classes.dex */
public class BoldStyle {
    private String string;
    private int value;
    public static final BoldStyle NORMAL = new BoldStyle(400, "Normal");
    public static final BoldStyle BOLD = new BoldStyle(700, "Bold");

    /* JADX INFO: Access modifiers changed from: protected */
    public BoldStyle(int i, String str) {
        this.value = i;
        this.string = str;
    }

    public String getDescription() {
        return this.string;
    }

    public int getValue() {
        return this.value;
    }
}
