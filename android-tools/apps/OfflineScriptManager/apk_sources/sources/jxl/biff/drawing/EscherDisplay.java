package jxl.biff.drawing;

import java.io.BufferedWriter;
/* loaded from: classes.dex */
public class EscherDisplay {
    private EscherStream stream;
    private BufferedWriter writer;

    public EscherDisplay(EscherStream escherStream, BufferedWriter bufferedWriter) {
        this.stream = escherStream;
        this.writer = bufferedWriter;
    }

    private void displayContainer(EscherContainer escherContainer, int i) {
        EscherRecord[] children;
        displayRecord(escherContainer, i);
        int i2 = i + 1;
        for (EscherRecord escherRecord : escherContainer.getChildren()) {
            if (escherRecord.getEscherData().isContainer()) {
                displayContainer((EscherContainer) escherRecord, i2);
            } else {
                displayRecord(escherRecord, i2);
            }
        }
    }

    private void displayRecord(EscherRecord escherRecord, int i) {
        BufferedWriter bufferedWriter;
        String str;
        indent(i);
        EscherRecordType type = escherRecord.getType();
        this.writer.write(Integer.toString(type.getValue(), 16));
        this.writer.write(" - ");
        if (type == EscherRecordType.DGG_CONTAINER) {
            bufferedWriter = this.writer;
            str = "Dgg Container";
        } else if (type == EscherRecordType.BSTORE_CONTAINER) {
            bufferedWriter = this.writer;
            str = "BStore Container";
        } else if (type == EscherRecordType.DG_CONTAINER) {
            bufferedWriter = this.writer;
            str = "Dg Container";
        } else if (type == EscherRecordType.SPGR_CONTAINER) {
            bufferedWriter = this.writer;
            str = "Spgr Container";
        } else if (type == EscherRecordType.SP_CONTAINER) {
            bufferedWriter = this.writer;
            str = "Sp Container";
        } else if (type == EscherRecordType.DGG) {
            bufferedWriter = this.writer;
            str = "Dgg";
        } else if (type == EscherRecordType.BSE) {
            bufferedWriter = this.writer;
            str = "Bse";
        } else if (type == EscherRecordType.DG) {
            bufferedWriter = this.writer;
            str = "Dg";
        } else if (type == EscherRecordType.SPGR) {
            bufferedWriter = this.writer;
            str = "Spgr";
        } else if (type == EscherRecordType.SP) {
            bufferedWriter = this.writer;
            str = "Sp";
        } else if (type == EscherRecordType.OPT) {
            bufferedWriter = this.writer;
            str = "Opt";
        } else if (type == EscherRecordType.CLIENT_ANCHOR) {
            bufferedWriter = this.writer;
            str = "Client Anchor";
        } else if (type == EscherRecordType.CLIENT_DATA) {
            bufferedWriter = this.writer;
            str = "Client Data";
        } else if (type == EscherRecordType.CLIENT_TEXT_BOX) {
            bufferedWriter = this.writer;
            str = "Client Text Box";
        } else if (type == EscherRecordType.SPLIT_MENU_COLORS) {
            bufferedWriter = this.writer;
            str = "Split Menu Colors";
        } else {
            bufferedWriter = this.writer;
            str = "???";
        }
        bufferedWriter.write(str);
        this.writer.newLine();
    }

    private void indent(int i) {
        for (int i2 = 0; i2 < i * 2; i2++) {
            this.writer.write(32);
        }
    }

    public void display() {
        displayContainer(new EscherContainer(new EscherRecordData(this.stream, 0)), 0);
    }
}
