package jxl.biff.drawing;

import jxl.biff.IntegerHelper;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class ClientAnchor extends EscherAtom {
    static /* synthetic */ Class class$jxl$biff$drawing$ClientAnchor;
    private static final Logger logger;
    private byte[] data;
    private int properties;
    private double x1;
    private double x2;
    private double y1;
    private double y2;

    static {
        Class cls = class$jxl$biff$drawing$ClientAnchor;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.ClientAnchor");
            class$jxl$biff$drawing$ClientAnchor = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ClientAnchor(double d2, double d3, double d4, double d5, int i) {
        super(EscherRecordType.CLIENT_ANCHOR);
        this.x1 = d2;
        this.y1 = d3;
        this.x2 = d4;
        this.y2 = d5;
        this.properties = i;
    }

    public ClientAnchor(EscherRecordData escherRecordData) {
        super(escherRecordData);
        byte[] bytes = getBytes();
        this.properties = IntegerHelper.getInt(bytes[0], bytes[1]);
        this.x1 = IntegerHelper.getInt(bytes[2], bytes[3]) + (IntegerHelper.getInt(bytes[4], bytes[5]) / 1024.0d);
        this.y1 = IntegerHelper.getInt(bytes[6], bytes[7]) + (IntegerHelper.getInt(bytes[8], bytes[9]) / 256.0d);
        this.x2 = IntegerHelper.getInt(bytes[10], bytes[11]) + (IntegerHelper.getInt(bytes[12], bytes[13]) / 1024.0d);
        this.y2 = IntegerHelper.getInt(bytes[14], bytes[15]) + (IntegerHelper.getInt(bytes[16], bytes[17]) / 256.0d);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherAtom, jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        byte[] bArr = new byte[18];
        this.data = bArr;
        IntegerHelper.getTwoBytes(this.properties, bArr, 0);
        IntegerHelper.getTwoBytes((int) this.x1, this.data, 2);
        double d2 = this.x1;
        IntegerHelper.getTwoBytes((int) ((d2 - ((int) d2)) * 1024.0d), this.data, 4);
        IntegerHelper.getTwoBytes((int) this.y1, this.data, 6);
        double d3 = this.y1;
        IntegerHelper.getTwoBytes((int) ((d3 - ((int) d3)) * 256.0d), this.data, 8);
        IntegerHelper.getTwoBytes((int) this.x2, this.data, 10);
        double d4 = this.x2;
        IntegerHelper.getTwoBytes((int) ((d4 - ((int) d4)) * 1024.0d), this.data, 12);
        IntegerHelper.getTwoBytes((int) this.y2, this.data, 14);
        double d5 = this.y2;
        IntegerHelper.getTwoBytes((int) ((d5 - ((int) d5)) * 256.0d), this.data, 16);
        return setHeaderData(this.data);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getProperties() {
        return this.properties;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public double getX1() {
        return this.x1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public double getX2() {
        return this.x2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public double getY1() {
        return this.y1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public double getY2() {
        return this.y2;
    }
}
