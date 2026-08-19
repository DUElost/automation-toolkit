package jxl.biff.drawing;

import java.util.ArrayList;
import java.util.Iterator;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class EscherContainer extends EscherRecord {
    static /* synthetic */ Class class$jxl$biff$drawing$EscherContainer;
    private static Logger logger;
    private ArrayList children;
    private boolean initialized;

    static {
        Class cls = class$jxl$biff$drawing$EscherContainer;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.EscherContainer");
            class$jxl$biff$drawing$EscherContainer = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public EscherContainer(EscherRecordData escherRecordData) {
        super(escherRecordData);
        this.initialized = false;
        this.children = new ArrayList();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public EscherContainer(EscherRecordType escherRecordType) {
        super(escherRecordType);
        setContainer(true);
        this.children = new ArrayList();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void initialize() {
        int pos = getPos() + 8;
        int min = Math.min(getPos() + getLength(), getStreamLength());
        while (pos < min) {
            EscherRecordData escherRecordData = new EscherRecordData(getEscherStream(), pos);
            EscherRecordType type = escherRecordData.getType();
            EscherRecord dgg = type == EscherRecordType.DGG ? new Dgg(escherRecordData) : type == EscherRecordType.DG ? new Dg(escherRecordData) : type == EscherRecordType.BSTORE_CONTAINER ? new BStoreContainer(escherRecordData) : type == EscherRecordType.SPGR_CONTAINER ? new SpgrContainer(escherRecordData) : type == EscherRecordType.SP_CONTAINER ? new SpContainer(escherRecordData) : type == EscherRecordType.SPGR ? new Spgr(escherRecordData) : type == EscherRecordType.SP ? new Sp(escherRecordData) : type == EscherRecordType.CLIENT_ANCHOR ? new ClientAnchor(escherRecordData) : type == EscherRecordType.CLIENT_DATA ? new ClientData(escherRecordData) : type == EscherRecordType.BSE ? new BlipStoreEntry(escherRecordData) : type == EscherRecordType.OPT ? new Opt(escherRecordData) : type == EscherRecordType.SPLIT_MENU_COLORS ? new SplitMenuColors(escherRecordData) : type == EscherRecordType.CLIENT_TEXT_BOX ? new ClientTextBox(escherRecordData) : new EscherAtom(escherRecordData);
            this.children.add(dgg);
            pos += dgg.getLength();
        }
        this.initialized = true;
    }

    public void add(EscherRecord escherRecord) {
        this.children.add(escherRecord);
    }

    public EscherRecord[] getChildren() {
        if (!this.initialized) {
            initialize();
        }
        ArrayList arrayList = this.children;
        return (EscherRecord[]) arrayList.toArray(new EscherRecord[arrayList.size()]);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        if (!this.initialized) {
            initialize();
        }
        byte[] bArr = new byte[0];
        Iterator it = this.children.iterator();
        while (it.hasNext()) {
            byte[] data = ((EscherRecord) it.next()).getData();
            if (data != null) {
                byte[] bArr2 = new byte[bArr.length + data.length];
                System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
                System.arraycopy(data, 0, bArr2, bArr.length, data.length);
                bArr = bArr2;
            }
        }
        return setHeaderData(bArr);
    }

    public void remove(EscherRecord escherRecord) {
        this.children.remove(escherRecord);
    }
}
