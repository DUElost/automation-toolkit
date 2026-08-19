package jxl.biff.drawing;

import jxl.SheetSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class ObjRecord extends WritableRecordData {
    public static final ObjType ARC;
    public static final ObjType BUTTON;
    public static final ObjType CHART;
    public static final ObjType CHECKBOX;
    private static final int CLIPBOARD_FORMAT_LENGTH = 6;
    public static final ObjType COMBOBOX;
    private static final int COMBOBOX_STRUCTURE_LENGTH = 44;
    private static final int COMMON_DATA_LENGTH = 22;
    public static final ObjType DIALOGUEBOX;
    public static final ObjType EDITBOX;
    private static final int END_LENGTH = 4;
    public static final ObjType EXCELNOTE;
    public static final ObjType FORMCONTROL;
    public static final ObjType GROUP;
    public static final ObjType GROUPBOX;
    public static final ObjType LABEL;
    public static final ObjType LINE;
    public static final ObjType LISTBOX;
    public static final ObjType MSOFFICEDRAWING;
    private static final int NOTE_STRUCTURE_LENGTH = 26;
    public static final ObjType OPTION;
    public static final ObjType OVAL;
    public static final ObjType PICTURE;
    private static final int PICTURE_OPTION_LENGTH = 6;
    public static final ObjType POLYGON;
    public static final ObjType RECTANGLE;
    public static final ObjType SCROLLBAR;
    public static final ObjType SPINBOX;
    public static final ObjType TEXT;
    public static final ObjType UNKNOWN;
    static /* synthetic */ Class class$jxl$biff$drawing$ObjRecord;
    private static final Logger logger;
    private int objectId;
    private boolean read;
    private ObjType type;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class ObjType {
        private static ObjType[] types = new ObjType[0];
        public String desc;
        public int value;

        ObjType(int i, String str) {
            this.value = i;
            this.desc = str;
            ObjType[] objTypeArr = types;
            ObjType[] objTypeArr2 = new ObjType[objTypeArr.length + 1];
            types = objTypeArr2;
            System.arraycopy(objTypeArr, 0, objTypeArr2, 0, objTypeArr.length);
            types[objTypeArr.length] = this;
        }

        public static ObjType getType(int i) {
            ObjType objType = ObjRecord.UNKNOWN;
            for (int i2 = 0; i2 < types.length && objType == ObjRecord.UNKNOWN; i2++) {
                ObjType[] objTypeArr = types;
                if (objTypeArr[i2].value == i) {
                    objType = objTypeArr[i2];
                }
            }
            return objType;
        }

        public String toString() {
            return this.desc;
        }
    }

    static {
        Class cls = class$jxl$biff$drawing$ObjRecord;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.ObjRecord");
            class$jxl$biff$drawing$ObjRecord = cls;
        }
        logger = Logger.getLogger(cls);
        GROUP = new ObjType(0, "Group");
        LINE = new ObjType(1, "Line");
        RECTANGLE = new ObjType(2, "Rectangle");
        OVAL = new ObjType(3, "Oval");
        ARC = new ObjType(4, "Arc");
        CHART = new ObjType(5, "Chart");
        TEXT = new ObjType(6, "Text");
        BUTTON = new ObjType(7, "Button");
        PICTURE = new ObjType(8, "Picture");
        POLYGON = new ObjType(9, "Polygon");
        CHECKBOX = new ObjType(11, "Checkbox");
        OPTION = new ObjType(12, "Option");
        EDITBOX = new ObjType(13, "Edit Box");
        LABEL = new ObjType(14, "Label");
        DIALOGUEBOX = new ObjType(15, "Dialogue Box");
        SPINBOX = new ObjType(16, "Spin Box");
        SCROLLBAR = new ObjType(17, "Scrollbar");
        LISTBOX = new ObjType(18, "List Box");
        GROUPBOX = new ObjType(19, "Group Box");
        COMBOBOX = new ObjType(20, "Combo Box");
        MSOFFICEDRAWING = new ObjType(30, "MS Office Drawing");
        FORMCONTROL = new ObjType(20, "Form Combo Box");
        EXCELNOTE = new ObjType(25, "Excel Note");
        UNKNOWN = new ObjType(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT, "Unknown");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ObjRecord(int i, ObjType objType) {
        super(Type.OBJ);
        this.objectId = i;
        this.type = objType;
    }

    public ObjRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        int i = IntegerHelper.getInt(data[4], data[5]);
        this.read = true;
        ObjType type = ObjType.getType(i);
        this.type = type;
        if (type == UNKNOWN) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("unknown object type code ");
            stringBuffer.append(i);
            logger2.warn(stringBuffer.toString());
        }
        this.objectId = IntegerHelper.getInt(data[6], data[7]);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private byte[] getComboBoxData() {
        byte[] bArr = new byte[70];
        IntegerHelper.getTwoBytes(21, bArr, 0);
        IntegerHelper.getTwoBytes(18, bArr, 2);
        IntegerHelper.getTwoBytes(this.type.value, bArr, 4);
        IntegerHelper.getTwoBytes(this.objectId, bArr, 6);
        IntegerHelper.getTwoBytes(0, bArr, 8);
        IntegerHelper.getTwoBytes(12, bArr, 22);
        IntegerHelper.getTwoBytes(20, bArr, 24);
        bArr[36] = 1;
        bArr[38] = 4;
        bArr[42] = 16;
        bArr[46] = 19;
        bArr[48] = -18;
        bArr[49] = 31;
        bArr[52] = 4;
        bArr[56] = 1;
        bArr[57] = 6;
        bArr[60] = 2;
        bArr[62] = 8;
        bArr[64] = 64;
        IntegerHelper.getTwoBytes(0, bArr, 66);
        IntegerHelper.getTwoBytes(0, bArr, 68);
        return bArr;
    }

    private byte[] getNoteData() {
        byte[] bArr = new byte[52];
        IntegerHelper.getTwoBytes(21, bArr, 0);
        IntegerHelper.getTwoBytes(18, bArr, 2);
        IntegerHelper.getTwoBytes(this.type.value, bArr, 4);
        IntegerHelper.getTwoBytes(this.objectId, bArr, 6);
        IntegerHelper.getTwoBytes(16401, bArr, 8);
        IntegerHelper.getTwoBytes(13, bArr, 22);
        IntegerHelper.getTwoBytes(22, bArr, 24);
        IntegerHelper.getTwoBytes(0, bArr, 48);
        IntegerHelper.getTwoBytes(0, bArr, 50);
        return bArr;
    }

    private byte[] getPictureData() {
        byte[] bArr = new byte[38];
        IntegerHelper.getTwoBytes(21, bArr, 0);
        IntegerHelper.getTwoBytes(18, bArr, 2);
        IntegerHelper.getTwoBytes(this.type.value, bArr, 4);
        IntegerHelper.getTwoBytes(this.objectId, bArr, 6);
        IntegerHelper.getTwoBytes(24593, bArr, 8);
        IntegerHelper.getTwoBytes(7, bArr, 22);
        IntegerHelper.getTwoBytes(2, bArr, 24);
        IntegerHelper.getTwoBytes(65535, bArr, 26);
        IntegerHelper.getTwoBytes(8, bArr, 28);
        IntegerHelper.getTwoBytes(2, bArr, 30);
        IntegerHelper.getTwoBytes(1, bArr, 32);
        IntegerHelper.getTwoBytes(0, bArr, 34);
        IntegerHelper.getTwoBytes(0, bArr, 36);
        return bArr;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        if (this.read) {
            return getRecord().getData();
        }
        ObjType objType = this.type;
        if (objType == PICTURE || objType == CHART) {
            return getPictureData();
        }
        if (objType == EXCELNOTE) {
            return getNoteData();
        }
        if (objType == COMBOBOX) {
            return getComboBoxData();
        }
        Assert.verify(false);
        return null;
    }

    public int getObjectId() {
        return this.objectId;
    }

    @Override // jxl.biff.RecordData
    public Record getRecord() {
        return super.getRecord();
    }

    public ObjType getType() {
        return this.type;
    }
}
