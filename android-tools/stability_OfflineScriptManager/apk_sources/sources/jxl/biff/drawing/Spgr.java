package jxl.biff.drawing;
/* loaded from: classes.dex */
class Spgr extends EscherAtom {
    private byte[] data;

    public Spgr() {
        super(EscherRecordType.SPGR);
        setVersion(1);
        this.data = new byte[16];
    }

    public Spgr(EscherRecordData escherRecordData) {
        super(escherRecordData);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherAtom, jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        return setHeaderData(this.data);
    }
}
