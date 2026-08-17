package jxl.read.biff;

import java.util.ArrayList;
import java.util.Iterator;
import jxl.WorkbookSettings;
import jxl.biff.BaseCompoundFile;
import jxl.biff.IntegerHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
public final class CompoundFile extends BaseCompoundFile {
    static /* synthetic */ Class class$jxl$read$biff$CompoundFile;
    private static Logger logger;
    private int[] bigBlockChain;
    private int[] bigBlockDepotBlocks;
    private byte[] data;
    private int extensionBlock;
    private int numBigBlockDepotBlocks;
    private int numExtensionBlocks;
    private ArrayList propertySets;
    private byte[] rootEntry;
    private BaseCompoundFile.PropertyStorage rootEntryPropertyStorage;
    private int rootStartBlock;
    private int sbdStartBlock;
    private WorkbookSettings settings;
    private int[] smallBlockChain;

    static {
        Class cls = class$jxl$read$biff$CompoundFile;
        if (cls == null) {
            cls = class$("jxl.read.biff.CompoundFile");
            class$jxl$read$biff$CompoundFile = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public CompoundFile(byte[] bArr, WorkbookSettings workbookSettings) {
        int i;
        this.data = bArr;
        this.settings = workbookSettings;
        int i2 = 0;
        int i3 = 0;
        while (true) {
            byte[] bArr2 = BaseCompoundFile.IDENTIFIER;
            if (i3 >= bArr2.length) {
                this.propertySets = new ArrayList();
                byte[] bArr3 = this.data;
                this.numBigBlockDepotBlocks = IntegerHelper.getInt(bArr3[44], bArr3[45], bArr3[46], bArr3[47]);
                byte[] bArr4 = this.data;
                this.sbdStartBlock = IntegerHelper.getInt(bArr4[60], bArr4[61], bArr4[62], bArr4[63]);
                byte[] bArr5 = this.data;
                this.rootStartBlock = IntegerHelper.getInt(bArr5[48], bArr5[49], bArr5[50], bArr5[51]);
                byte[] bArr6 = this.data;
                this.extensionBlock = IntegerHelper.getInt(bArr6[68], bArr6[69], bArr6[70], bArr6[71]);
                byte[] bArr7 = this.data;
                int i4 = IntegerHelper.getInt(bArr7[72], bArr7[73], bArr7[74], bArr7[75]);
                this.numExtensionBlocks = i4;
                int i5 = this.numBigBlockDepotBlocks;
                this.bigBlockDepotBlocks = new int[i5];
                int i6 = 76;
                i5 = i4 != 0 ? 109 : i5;
                for (int i7 = 0; i7 < i5; i7++) {
                    this.bigBlockDepotBlocks[i7] = IntegerHelper.getInt(bArr[i6], bArr[i6 + 1], bArr[i6 + 2], bArr[i6 + 3]);
                    i6 += 4;
                }
                while (i2 < this.numExtensionBlocks) {
                    int i8 = (this.extensionBlock + 1) * 512;
                    int min = Math.min(this.numBigBlockDepotBlocks - i5, 127);
                    int i9 = i5;
                    while (true) {
                        i = i5 + min;
                        if (i9 >= i) {
                            break;
                        }
                        this.bigBlockDepotBlocks[i9] = IntegerHelper.getInt(bArr[i8], bArr[i8 + 1], bArr[i8 + 2], bArr[i8 + 3]);
                        i8 += 4;
                        i9++;
                    }
                    if (i < this.numBigBlockDepotBlocks) {
                        this.extensionBlock = IntegerHelper.getInt(bArr[i8], bArr[i8 + 1], bArr[i8 + 2], bArr[i8 + 3]);
                    }
                    i2++;
                    i5 = i;
                }
                readBigBlockDepot();
                readSmallBlockDepot();
                this.rootEntry = readData(this.rootStartBlock);
                readPropertySets();
                return;
            } else if (this.data[i3] != bArr2[i3]) {
                throw new BiffException(BiffException.unrecognizedOLEFile);
            } else {
                i3++;
            }
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private BaseCompoundFile.PropertyStorage findPropertyStorage(String str, BaseCompoundFile.PropertyStorage propertyStorage) {
        int i = propertyStorage.child;
        if (i == -1) {
            return null;
        }
        BaseCompoundFile.PropertyStorage propertyStorage2 = getPropertyStorage(i);
        if (propertyStorage2.name.equalsIgnoreCase(str)) {
            return propertyStorage2;
        }
        BaseCompoundFile.PropertyStorage propertyStorage3 = propertyStorage2;
        do {
            int i2 = propertyStorage3.previous;
            if (i2 == -1) {
                BaseCompoundFile.PropertyStorage propertyStorage4 = propertyStorage2;
                do {
                    int i3 = propertyStorage4.next;
                    if (i3 == -1) {
                        return findPropertyStorage(str, propertyStorage2);
                    }
                    propertyStorage4 = getPropertyStorage(i3);
                } while (!propertyStorage4.name.equalsIgnoreCase(str));
                return propertyStorage4;
            }
            propertyStorage3 = getPropertyStorage(i2);
        } while (!propertyStorage3.name.equalsIgnoreCase(str));
        return propertyStorage3;
    }

    private byte[] getBigBlockStream(BaseCompoundFile.PropertyStorage propertyStorage) {
        int i = propertyStorage.size;
        int i2 = i / 512;
        if (i % 512 != 0) {
            i2++;
        }
        byte[] bArr = new byte[i2 * 512];
        int i3 = propertyStorage.startBlock;
        int i4 = 0;
        while (i3 != -2 && i4 < i2) {
            System.arraycopy(this.data, (i3 + 1) * 512, bArr, i4 * 512, 512);
            i4++;
            i3 = this.bigBlockChain[i3];
        }
        if (i3 != -2 && i4 == i2) {
            logger.warn("Property storage size inconsistent with block chain.");
        }
        return bArr;
    }

    private BaseCompoundFile.PropertyStorage getPropertyStorage(int i) {
        return (BaseCompoundFile.PropertyStorage) this.propertySets.get(i);
    }

    private BaseCompoundFile.PropertyStorage getPropertyStorage(String str) {
        Iterator it = this.propertySets.iterator();
        BaseCompoundFile.PropertyStorage propertyStorage = null;
        boolean z = false;
        boolean z2 = false;
        while (it.hasNext()) {
            BaseCompoundFile.PropertyStorage propertyStorage2 = (BaseCompoundFile.PropertyStorage) it.next();
            if (propertyStorage2.name.equalsIgnoreCase(str)) {
                z = z2;
                propertyStorage = propertyStorage2;
                z2 = true;
            }
        }
        if (z) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("found multiple copies of property set ");
            stringBuffer.append(str);
            logger2.warn(stringBuffer.toString());
        }
        if (z2) {
            return propertyStorage;
        }
        throw new BiffException(BiffException.streamNotFound);
    }

    private byte[] getSmallBlockStream(BaseCompoundFile.PropertyStorage propertyStorage) {
        int[] iArr;
        byte[] readData = readData(this.rootEntryPropertyStorage.startBlock);
        byte[] bArr = new byte[0];
        int i = propertyStorage.startBlock;
        int i2 = 0;
        while (true) {
            iArr = this.smallBlockChain;
            if (i2 > iArr.length || i == -2) {
                break;
            }
            byte[] bArr2 = new byte[bArr.length + 64];
            System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
            System.arraycopy(readData, i * 64, bArr2, bArr.length, 64);
            int i3 = this.smallBlockChain[i];
            if (i3 == -1) {
                Logger logger2 = logger;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("Incorrect terminator for small block stream ");
                stringBuffer.append(propertyStorage.name);
                logger2.warn(stringBuffer.toString());
                i = -2;
            } else {
                i = i3;
            }
            i2++;
            bArr = bArr2;
        }
        if (i2 <= iArr.length) {
            return bArr;
        }
        throw new BiffException(BiffException.corruptFileFormat);
    }

    private void readBigBlockDepot() {
        this.bigBlockChain = new int[(this.numBigBlockDepotBlocks * 512) / 4];
        int i = 0;
        for (int i2 = 0; i2 < this.numBigBlockDepotBlocks; i2++) {
            int i3 = (this.bigBlockDepotBlocks[i2] + 1) * 512;
            for (int i4 = 0; i4 < 128; i4++) {
                int[] iArr = this.bigBlockChain;
                byte[] bArr = this.data;
                iArr[i] = IntegerHelper.getInt(bArr[i3], bArr[i3 + 1], bArr[i3 + 2], bArr[i3 + 3]);
                i3 += 4;
                i++;
            }
        }
    }

    private byte[] readData(int i) {
        int[] iArr;
        byte[] bArr = new byte[0];
        int i2 = 0;
        while (true) {
            iArr = this.bigBlockChain;
            if (i2 > iArr.length || i == -2) {
                break;
            }
            byte[] bArr2 = new byte[bArr.length + 512];
            System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
            System.arraycopy(this.data, (i + 1) * 512, bArr2, bArr.length, 512);
            int[] iArr2 = this.bigBlockChain;
            if (iArr2[i] == i) {
                throw new BiffException(BiffException.corruptFileFormat);
            }
            i = iArr2[i];
            i2++;
            bArr = bArr2;
        }
        if (i2 <= iArr.length) {
            return bArr;
        }
        throw new BiffException(BiffException.corruptFileFormat);
    }

    private void readPropertySets() {
        Logger logger2;
        StringBuffer stringBuffer;
        int i = 0;
        while (true) {
            byte[] bArr = this.rootEntry;
            if (i >= bArr.length) {
                break;
            }
            byte[] bArr2 = new byte[128];
            System.arraycopy(bArr, i, bArr2, 0, 128);
            BaseCompoundFile.PropertyStorage propertyStorage = new BaseCompoundFile.PropertyStorage(bArr2);
            String str = propertyStorage.name;
            if (str == null || str.length() == 0) {
                if (propertyStorage.type == 5) {
                    propertyStorage.name = BaseCompoundFile.ROOT_ENTRY_NAME;
                    logger2 = logger;
                    stringBuffer = new StringBuffer();
                    stringBuffer.append("Property storage name for ");
                    stringBuffer.append(propertyStorage.type);
                    stringBuffer.append(" is empty - setting to ");
                    stringBuffer.append(BaseCompoundFile.ROOT_ENTRY_NAME);
                } else if (propertyStorage.size != 0) {
                    logger2 = logger;
                    stringBuffer = new StringBuffer();
                    stringBuffer.append("Property storage type ");
                    stringBuffer.append(propertyStorage.type);
                    stringBuffer.append(" is non-empty and has no associated name");
                }
                logger2.warn(stringBuffer.toString());
            }
            this.propertySets.add(propertyStorage);
            if (propertyStorage.name.equalsIgnoreCase(BaseCompoundFile.ROOT_ENTRY_NAME)) {
                this.rootEntryPropertyStorage = propertyStorage;
            }
            i += 128;
        }
        if (this.rootEntryPropertyStorage == null) {
            this.rootEntryPropertyStorage = (BaseCompoundFile.PropertyStorage) this.propertySets.get(0);
        }
    }

    private void readSmallBlockDepot() {
        int[] iArr;
        int i = this.sbdStartBlock;
        this.smallBlockChain = new int[0];
        if (i == -1) {
            logger.warn("invalid small block depot number");
            return;
        }
        int i2 = 0;
        int i3 = 0;
        while (true) {
            iArr = this.bigBlockChain;
            if (i2 > iArr.length || i == -2) {
                break;
            }
            int[] iArr2 = this.smallBlockChain;
            int[] iArr3 = new int[iArr2.length + 128];
            this.smallBlockChain = iArr3;
            System.arraycopy(iArr2, 0, iArr3, 0, iArr2.length);
            int i4 = (i + 1) * 512;
            for (int i5 = 0; i5 < 128; i5++) {
                int[] iArr4 = this.smallBlockChain;
                byte[] bArr = this.data;
                iArr4[i3] = IntegerHelper.getInt(bArr[i4], bArr[i4 + 1], bArr[i4 + 2], bArr[i4 + 3]);
                i4 += 4;
                i3++;
            }
            i = this.bigBlockChain[i];
            i2++;
        }
        if (i2 > iArr.length) {
            throw new BiffException(BiffException.corruptFileFormat);
        }
    }

    public BaseCompoundFile.PropertyStorage findPropertyStorage(String str) {
        return findPropertyStorage(str, this.rootEntryPropertyStorage);
    }

    public int getNumberOfPropertySets() {
        return this.propertySets.size();
    }

    public BaseCompoundFile.PropertyStorage getPropertySet(int i) {
        return getPropertyStorage(i);
    }

    public byte[] getStream(int i) {
        BaseCompoundFile.PropertyStorage propertyStorage = getPropertyStorage(i);
        return (propertyStorage.size >= 4096 || propertyStorage.name.equalsIgnoreCase(BaseCompoundFile.ROOT_ENTRY_NAME)) ? getBigBlockStream(propertyStorage) : getSmallBlockStream(propertyStorage);
    }

    public byte[] getStream(String str) {
        BaseCompoundFile.PropertyStorage findPropertyStorage = findPropertyStorage(str, this.rootEntryPropertyStorage);
        if (findPropertyStorage == null) {
            findPropertyStorage = getPropertyStorage(str);
        }
        return (findPropertyStorage.size >= 4096 || str.equalsIgnoreCase(BaseCompoundFile.ROOT_ENTRY_NAME)) ? getBigBlockStream(findPropertyStorage) : getSmallBlockStream(findPropertyStorage);
    }
}
