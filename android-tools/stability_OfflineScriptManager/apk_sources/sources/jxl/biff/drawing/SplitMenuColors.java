package jxl.biff.drawing;
/* loaded from: classes.dex */
class SplitMenuColors extends EscherAtom {
    private byte[] data;

    public SplitMenuColors() {
        super(EscherRecordType.SPLIT_MENU_COLORS);
        setVersion(0);
        setInstance(4);
        this.data = new byte[]{13, 0, 0, 8, 12, 0, 0, 8, 23, 0, 0, 8, -9, 0, 0, 16};
    }

    public SplitMenuColors(EscherRecordData escherRecordData) {
        super(escherRecordData);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherAtom, jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        return setHeaderData(this.data);
    }
}
