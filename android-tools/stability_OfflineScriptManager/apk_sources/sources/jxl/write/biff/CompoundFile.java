package jxl.write.biff;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import jxl.biff.BaseCompoundFile;
import jxl.biff.IntegerHelper;
import jxl.common.Assert;
import jxl.common.Logger;
import jxl.read.biff.BiffException;
/* loaded from: classes.dex */
final class CompoundFile extends BaseCompoundFile {
    static /* synthetic */ Class class$jxl$write$biff$CompoundFile;
    private static Logger logger;
    private int additionalPropertyBlocks;
    private ArrayList additionalPropertySets;
    private int bbdPos;
    private int bbdStartBlock;
    private byte[] bigBlockDepot;
    private ExcelDataOutput excelData;
    private int excelDataBlocks;
    private int excelDataStartBlock;
    private int extensionBlock;
    private int numBigBlockDepotBlocks;
    private int numExtensionBlocks;
    private int numPropertySets;
    private int numRootEntryBlocks;
    private int numSmallBlockDepotBlocks;
    private int numSmallBlockDepotChainBlocks;
    private int numSmallBlocks;
    private OutputStream out;
    private int requiredSize;
    private int rootStartBlock;
    private int sbdStartBlock;
    private int sbdStartBlockChain;
    private int size;
    private HashMap standardPropertySets;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class ReadPropertyStorage {
        byte[] data;
        int number;
        BaseCompoundFile.PropertyStorage propertyStorage;

        ReadPropertyStorage(BaseCompoundFile.PropertyStorage propertyStorage, byte[] bArr, int i) {
            this.propertyStorage = propertyStorage;
            this.data = bArr;
            this.number = i;
        }
    }

    static {
        Class cls = class$jxl$write$biff$CompoundFile;
        if (cls == null) {
            cls = class$("jxl.write.biff.CompoundFile");
            class$jxl$write$biff$CompoundFile = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public CompoundFile(ExcelDataOutput excelDataOutput, int i, OutputStream outputStream, jxl.read.biff.CompoundFile compoundFile) {
        int ceil;
        int ceil2;
        this.size = i;
        this.excelData = excelDataOutput;
        readAdditionalPropertySets(compoundFile);
        this.numRootEntryBlocks = 1;
        ArrayList arrayList = this.additionalPropertySets;
        this.numPropertySets = (arrayList != null ? arrayList.size() : 0) + 4;
        if (this.additionalPropertySets != null) {
            this.numSmallBlockDepotChainBlocks = getBigBlocksRequired(this.numSmallBlocks * 4);
            this.numSmallBlockDepotBlocks = getBigBlocksRequired(this.numSmallBlocks * 64);
            this.numRootEntryBlocks += getBigBlocksRequired(this.additionalPropertySets.size() * 128);
        }
        int bigBlocksRequired = getBigBlocksRequired(i);
        if (i < 4096) {
            this.requiredSize = 4096;
        } else {
            this.requiredSize = bigBlocksRequired * 512;
        }
        this.out = outputStream;
        int i2 = this.requiredSize / 512;
        this.excelDataBlocks = i2;
        this.numBigBlockDepotBlocks = 1;
        int i3 = i2 + 8 + 8 + this.additionalPropertyBlocks + this.numSmallBlockDepotBlocks + this.numSmallBlockDepotChainBlocks + this.numRootEntryBlocks;
        this.numBigBlockDepotBlocks = (int) Math.ceil((i3 + 1) / 128.0d);
        int ceil3 = (int) Math.ceil((ceil + i3) / 128.0d);
        this.numBigBlockDepotBlocks = ceil3;
        int i4 = i3 + ceil3;
        if (ceil3 > 108) {
            this.extensionBlock = 0;
            this.numExtensionBlocks = (int) Math.ceil(((ceil3 - 109) + 1) / 127.0d);
            int ceil4 = (int) Math.ceil(((ceil2 + i3) + this.numBigBlockDepotBlocks) / 128.0d);
            this.numBigBlockDepotBlocks = ceil4;
            i4 = i3 + this.numExtensionBlocks + ceil4;
        } else {
            this.extensionBlock = -2;
            this.numExtensionBlocks = 0;
        }
        int i5 = this.numExtensionBlocks;
        this.excelDataStartBlock = i5;
        this.sbdStartBlock = -2;
        if (this.additionalPropertySets != null && this.numSmallBlockDepotBlocks != 0) {
            this.sbdStartBlock = this.excelDataBlocks + i5 + this.additionalPropertyBlocks + 16;
        }
        this.sbdStartBlockChain = -2;
        int i6 = this.sbdStartBlock;
        if (i6 != -2) {
            this.sbdStartBlockChain = i6 + this.numSmallBlockDepotBlocks;
        }
        int i7 = this.sbdStartBlockChain;
        if (i7 != -2) {
            this.bbdStartBlock = i7 + this.numSmallBlockDepotChainBlocks;
        } else {
            this.bbdStartBlock = i5 + this.excelDataBlocks + this.additionalPropertyBlocks + 16;
        }
        int i8 = this.bbdStartBlock + this.numBigBlockDepotBlocks;
        this.rootStartBlock = i8;
        if (i4 != i8 + this.numRootEntryBlocks) {
            logger.warn("Root start block and total blocks are inconsistent  generated file may be corrupt");
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("RootStartBlock ");
            stringBuffer.append(this.rootStartBlock);
            stringBuffer.append(" totalBlocks ");
            stringBuffer.append(i4);
            logger2.warn(stringBuffer.toString());
        }
    }

    private void checkBbdPos() {
        if (this.bbdPos >= 512) {
            this.out.write(this.bigBlockDepot);
            this.bigBlockDepot = new byte[512];
            this.bbdPos = 0;
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private int getBigBlocksRequired(int i) {
        int i2 = i / 512;
        return i % 512 > 0 ? i2 + 1 : i2;
    }

    private int getSmallBlocksRequired(int i) {
        int i2 = i / 64;
        return i % 64 > 0 ? i2 + 1 : i2;
    }

    private void readAdditionalPropertySets(jxl.read.biff.CompoundFile compoundFile) {
        boolean z;
        if (compoundFile == null) {
            return;
        }
        this.additionalPropertySets = new ArrayList();
        this.standardPropertySets = new HashMap();
        int numberOfPropertySets = compoundFile.getNumberOfPropertySets();
        int i = 0;
        for (int i2 = 0; i2 < numberOfPropertySets; i2++) {
            BaseCompoundFile.PropertyStorage propertySet = compoundFile.getPropertySet(i2);
            if (propertySet.name.equalsIgnoreCase(BaseCompoundFile.ROOT_ENTRY_NAME)) {
                this.standardPropertySets.put(BaseCompoundFile.ROOT_ENTRY_NAME, new ReadPropertyStorage(propertySet, null, i2));
                z = true;
            } else {
                z = false;
            }
            int i3 = 0;
            while (true) {
                String[] strArr = BaseCompoundFile.STANDARD_PROPERTY_SETS;
                if (i3 >= strArr.length || z) {
                    break;
                }
                if (propertySet.name.equalsIgnoreCase(strArr[i3])) {
                    BaseCompoundFile.PropertyStorage findPropertyStorage = compoundFile.findPropertyStorage(propertySet.name);
                    Assert.verify(findPropertyStorage != null);
                    if (findPropertyStorage == propertySet) {
                        this.standardPropertySets.put(strArr[i3], new ReadPropertyStorage(propertySet, null, i2));
                        z = true;
                    }
                }
                i3++;
            }
            if (!z) {
                try {
                    byte[] stream = propertySet.size > 0 ? compoundFile.getStream(i2) : new byte[0];
                    this.additionalPropertySets.add(new ReadPropertyStorage(propertySet, stream, i2));
                    if (stream.length > 4096) {
                        i += getBigBlocksRequired(stream.length);
                    } else {
                        this.numSmallBlocks += getSmallBlocksRequired(stream.length);
                    }
                } catch (BiffException e) {
                    logger.error(e);
                    throw new CopyAdditionalPropertySetsException();
                }
            }
        }
        this.additionalPropertyBlocks = i;
    }

    private void writeAdditionalPropertySetBlockChains() {
        ArrayList arrayList = this.additionalPropertySets;
        if (arrayList == null) {
            return;
        }
        int i = this.excelDataStartBlock + this.excelDataBlocks + 16;
        Iterator it = arrayList.iterator();
        while (it.hasNext()) {
            byte[] bArr = ((ReadPropertyStorage) it.next()).data;
            if (bArr.length > 4096) {
                int bigBlocksRequired = getBigBlocksRequired(bArr.length);
                writeBlockChain(i, bigBlocksRequired);
                i += bigBlocksRequired;
            }
        }
    }

    private void writeAdditionalPropertySets() {
        ArrayList arrayList = this.additionalPropertySets;
        if (arrayList == null) {
            return;
        }
        Iterator it = arrayList.iterator();
        while (it.hasNext()) {
            byte[] bArr = ((ReadPropertyStorage) it.next()).data;
            if (bArr.length > 4096) {
                this.out.write(bArr, 0, bArr.length);
                int bigBlocksRequired = (getBigBlocksRequired(bArr.length) * 512) - bArr.length;
                this.out.write(new byte[bigBlocksRequired], 0, bigBlocksRequired);
            }
        }
    }

    private void writeBigBlockDepot() {
        this.bigBlockDepot = new byte[512];
        this.bbdPos = 0;
        for (int i = 0; i < this.numExtensionBlocks; i++) {
            IntegerHelper.getFourBytes(-3, this.bigBlockDepot, this.bbdPos);
            this.bbdPos += 4;
            checkBbdPos();
        }
        writeBlockChain(this.excelDataStartBlock, this.excelDataBlocks);
        int i2 = this.excelDataStartBlock + this.excelDataBlocks + this.additionalPropertyBlocks;
        int i3 = i2;
        while (i3 < i2 + 7) {
            i3++;
            IntegerHelper.getFourBytes(i3, this.bigBlockDepot, this.bbdPos);
            this.bbdPos += 4;
            checkBbdPos();
        }
        IntegerHelper.getFourBytes(-2, this.bigBlockDepot, this.bbdPos);
        this.bbdPos += 4;
        checkBbdPos();
        int i4 = i2 + 8;
        while (i4 < i2 + 15) {
            i4++;
            IntegerHelper.getFourBytes(i4, this.bigBlockDepot, this.bbdPos);
            this.bbdPos += 4;
            checkBbdPos();
        }
        IntegerHelper.getFourBytes(-2, this.bigBlockDepot, this.bbdPos);
        this.bbdPos += 4;
        checkBbdPos();
        writeAdditionalPropertySetBlockChains();
        int i5 = this.sbdStartBlock;
        if (i5 != -2) {
            writeBlockChain(i5, this.numSmallBlockDepotBlocks);
            writeBlockChain(this.sbdStartBlockChain, this.numSmallBlockDepotChainBlocks);
        }
        for (int i6 = 0; i6 < this.numBigBlockDepotBlocks; i6++) {
            IntegerHelper.getFourBytes(-3, this.bigBlockDepot, this.bbdPos);
            this.bbdPos += 4;
            checkBbdPos();
        }
        writeBlockChain(this.rootStartBlock, this.numRootEntryBlocks);
        int i7 = this.bbdPos;
        if (i7 != 0) {
            while (i7 < 512) {
                this.bigBlockDepot[i7] = -1;
                i7++;
            }
            this.out.write(this.bigBlockDepot);
        }
    }

    private void writeBlockChain(int i, int i2) {
        int i3 = i2 - 1;
        int i4 = i + 1;
        while (i3 > 0) {
            int min = Math.min(i3, (512 - this.bbdPos) / 4);
            for (int i5 = 0; i5 < min; i5++) {
                IntegerHelper.getFourBytes(i4, this.bigBlockDepot, this.bbdPos);
                this.bbdPos += 4;
                i4++;
            }
            i3 -= min;
            checkBbdPos();
        }
        IntegerHelper.getFourBytes(-2, this.bigBlockDepot, this.bbdPos);
        this.bbdPos += 4;
        checkBbdPos();
    }

    private void writeDocumentSummaryData() {
        this.out.write(new byte[4096]);
    }

    private void writeExcelData() {
        this.excelData.writeData(this.out);
        this.out.write(new byte[this.requiredSize - this.size]);
    }

    private void writeHeader() {
        int i;
        byte[] bArr = new byte[512];
        int i2 = this.numExtensionBlocks * 512;
        byte[] bArr2 = new byte[i2];
        byte[] bArr3 = BaseCompoundFile.IDENTIFIER;
        System.arraycopy(bArr3, 0, bArr, 0, bArr3.length);
        bArr[24] = 62;
        bArr[26] = 3;
        bArr[28] = -2;
        bArr[29] = -1;
        bArr[30] = 9;
        bArr[32] = 6;
        bArr[57] = 16;
        IntegerHelper.getFourBytes(this.numBigBlockDepotBlocks, bArr, 44);
        IntegerHelper.getFourBytes(this.sbdStartBlockChain, bArr, 60);
        IntegerHelper.getFourBytes(this.numSmallBlockDepotChainBlocks, bArr, 64);
        IntegerHelper.getFourBytes(this.extensionBlock, bArr, 68);
        IntegerHelper.getFourBytes(this.numExtensionBlocks, bArr, 72);
        IntegerHelper.getFourBytes(this.rootStartBlock, bArr, 48);
        int min = Math.min(this.numBigBlockDepotBlocks, 109);
        int i3 = 76;
        int i4 = 0;
        for (int i5 = 0; i5 < min; i5++) {
            IntegerHelper.getFourBytes(this.bbdStartBlock + i5, bArr, i3);
            i3 += 4;
            i4++;
        }
        while (i3 < 512) {
            bArr[i3] = -1;
            i3++;
        }
        this.out.write(bArr);
        int i6 = 0;
        int i7 = 0;
        while (true) {
            i = this.numExtensionBlocks;
            if (i6 >= i) {
                break;
            }
            int min2 = Math.min(this.numBigBlockDepotBlocks - i4, 127);
            for (int i8 = 0; i8 < min2; i8++) {
                IntegerHelper.getFourBytes(this.bbdStartBlock + i4 + i8, bArr2, i7);
                i7 += 4;
            }
            i4 += min2;
            IntegerHelper.getFourBytes(i4 == this.numBigBlockDepotBlocks ? -2 : i6 + 1, bArr2, i7);
            i7 += 4;
            i6++;
        }
        if (i > 0) {
            while (i7 < i2) {
                bArr2[i7] = -1;
                i7++;
            }
            this.out.write(bArr2);
        }
    }

    private void writePropertySets() {
        int[] iArr;
        int i;
        int i2;
        int i3;
        ReadPropertyStorage readPropertyStorage;
        String[] strArr;
        int i4 = 512;
        byte[] bArr = new byte[this.numRootEntryBlocks * 512];
        int i5 = 1;
        if (this.additionalPropertySets != null) {
            iArr = new int[this.numPropertySets];
            int i6 = 0;
            while (true) {
                strArr = BaseCompoundFile.STANDARD_PROPERTY_SETS;
                if (i6 >= strArr.length) {
                    break;
                }
                ReadPropertyStorage readPropertyStorage2 = (ReadPropertyStorage) this.standardPropertySets.get(strArr[i6]);
                if (readPropertyStorage2 != null) {
                    iArr[readPropertyStorage2.number] = i6;
                } else {
                    Logger logger2 = logger;
                    StringBuffer stringBuffer = new StringBuffer();
                    stringBuffer.append("Standard property set ");
                    stringBuffer.append(strArr[i6]);
                    stringBuffer.append(" not present in source file");
                    logger2.warn(stringBuffer.toString());
                }
                i6++;
            }
            int length = strArr.length;
            Iterator it = this.additionalPropertySets.iterator();
            while (it.hasNext()) {
                iArr[((ReadPropertyStorage) it.next()).number] = length;
                length++;
            }
        } else {
            iArr = null;
        }
        if (this.additionalPropertySets != null) {
            i = (getBigBlocksRequired(this.requiredSize) * 512) + 0 + (getBigBlocksRequired(4096) * 512) + (getBigBlocksRequired(4096) * 512);
            Iterator it2 = this.additionalPropertySets.iterator();
            while (it2.hasNext()) {
                BaseCompoundFile.PropertyStorage propertyStorage = ((ReadPropertyStorage) it2.next()).propertyStorage;
                if (propertyStorage.type != 1) {
                    int i7 = propertyStorage.size;
                    i += i7 >= 4096 ? getBigBlocksRequired(i7) * 512 : getSmallBlocksRequired(i7) * 64;
                }
            }
        } else {
            i = 0;
        }
        BaseCompoundFile.PropertyStorage propertyStorage2 = new BaseCompoundFile.PropertyStorage(BaseCompoundFile.ROOT_ENTRY_NAME);
        propertyStorage2.setType(5);
        propertyStorage2.setStartBlock(this.sbdStartBlock);
        propertyStorage2.setSize(i);
        propertyStorage2.setPrevious(-1);
        propertyStorage2.setNext(-1);
        propertyStorage2.setColour(0);
        propertyStorage2.setChild(this.additionalPropertySets != null ? iArr[((ReadPropertyStorage) this.standardPropertySets.get(BaseCompoundFile.ROOT_ENTRY_NAME)).propertyStorage.child] : 1);
        System.arraycopy(propertyStorage2.data, 0, bArr, 0, 128);
        BaseCompoundFile.PropertyStorage propertyStorage3 = new BaseCompoundFile.PropertyStorage(BaseCompoundFile.WORKBOOK_NAME);
        propertyStorage3.setType(2);
        propertyStorage3.setStartBlock(this.excelDataStartBlock);
        propertyStorage3.setSize(this.requiredSize);
        int i8 = 3;
        if (this.additionalPropertySets != null) {
            BaseCompoundFile.PropertyStorage propertyStorage4 = ((ReadPropertyStorage) this.standardPropertySets.get(BaseCompoundFile.WORKBOOK_NAME)).propertyStorage;
            int i9 = propertyStorage4.previous;
            i3 = i9 != -1 ? iArr[i9] : -1;
            int i10 = propertyStorage4.next;
            i2 = i10 != -1 ? iArr[i10] : -1;
        } else {
            i2 = -1;
            i3 = 3;
        }
        propertyStorage3.setPrevious(i3);
        propertyStorage3.setNext(i2);
        propertyStorage3.setChild(-1);
        System.arraycopy(propertyStorage3.data, 0, bArr, 128, 128);
        BaseCompoundFile.PropertyStorage propertyStorage5 = new BaseCompoundFile.PropertyStorage(BaseCompoundFile.SUMMARY_INFORMATION_NAME);
        propertyStorage5.setType(2);
        propertyStorage5.setStartBlock(this.excelDataStartBlock + this.excelDataBlocks);
        propertyStorage5.setSize(4096);
        if (this.additionalPropertySets != null && (readPropertyStorage = (ReadPropertyStorage) this.standardPropertySets.get(BaseCompoundFile.SUMMARY_INFORMATION_NAME)) != null) {
            BaseCompoundFile.PropertyStorage propertyStorage6 = readPropertyStorage.propertyStorage;
            int i11 = propertyStorage6.previous;
            int i12 = i11 != -1 ? iArr[i11] : -1;
            int i13 = propertyStorage6.next;
            i8 = i13 != -1 ? iArr[i13] : -1;
            i5 = i12;
        }
        propertyStorage5.setPrevious(i5);
        propertyStorage5.setNext(i8);
        propertyStorage5.setChild(-1);
        System.arraycopy(propertyStorage5.data, 0, bArr, 256, 128);
        BaseCompoundFile.PropertyStorage propertyStorage7 = new BaseCompoundFile.PropertyStorage(BaseCompoundFile.DOCUMENT_SUMMARY_INFORMATION_NAME);
        propertyStorage7.setType(2);
        propertyStorage7.setStartBlock(this.excelDataStartBlock + this.excelDataBlocks + 8);
        propertyStorage7.setSize(4096);
        propertyStorage7.setPrevious(-1);
        propertyStorage7.setNext(-1);
        propertyStorage7.setChild(-1);
        System.arraycopy(propertyStorage7.data, 0, bArr, 384, 128);
        ArrayList arrayList = this.additionalPropertySets;
        if (arrayList != null) {
            int i14 = this.excelDataStartBlock + this.excelDataBlocks + 16;
            Iterator it3 = arrayList.iterator();
            int i15 = 0;
            while (it3.hasNext()) {
                ReadPropertyStorage readPropertyStorage3 = (ReadPropertyStorage) it3.next();
                int i16 = readPropertyStorage3.data.length > 4096 ? i14 : i15;
                BaseCompoundFile.PropertyStorage propertyStorage8 = new BaseCompoundFile.PropertyStorage(readPropertyStorage3.propertyStorage.name);
                propertyStorage8.setType(readPropertyStorage3.propertyStorage.type);
                propertyStorage8.setStartBlock(i16);
                propertyStorage8.setSize(readPropertyStorage3.propertyStorage.size);
                BaseCompoundFile.PropertyStorage propertyStorage9 = readPropertyStorage3.propertyStorage;
                int i17 = propertyStorage9.previous;
                int i18 = i17 != -1 ? iArr[i17] : -1;
                int i19 = propertyStorage9.next;
                int i20 = i19 != -1 ? iArr[i19] : -1;
                int i21 = propertyStorage9.child;
                int i22 = i21 != -1 ? iArr[i21] : -1;
                propertyStorage8.setPrevious(i18);
                propertyStorage8.setNext(i20);
                propertyStorage8.setChild(i22);
                System.arraycopy(propertyStorage8.data, 0, bArr, i4, 128);
                i4 += 128;
                byte[] bArr2 = readPropertyStorage3.data;
                int length2 = bArr2.length;
                int length3 = bArr2.length;
                if (length2 > 4096) {
                    i14 += getBigBlocksRequired(length3);
                } else {
                    i15 += getSmallBlocksRequired(length3);
                }
            }
        }
        this.out.write(bArr);
    }

    private void writeSmallBlockDepot() {
        ArrayList arrayList = this.additionalPropertySets;
        if (arrayList == null) {
            return;
        }
        byte[] bArr = new byte[this.numSmallBlockDepotBlocks * 512];
        Iterator it = arrayList.iterator();
        int i = 0;
        while (it.hasNext()) {
            ReadPropertyStorage readPropertyStorage = (ReadPropertyStorage) it.next();
            byte[] bArr2 = readPropertyStorage.data;
            if (bArr2.length <= 4096) {
                byte[] bArr3 = readPropertyStorage.data;
                System.arraycopy(bArr3, 0, bArr, i, bArr3.length);
                i += getSmallBlocksRequired(bArr2.length) * 64;
            }
        }
        this.out.write(bArr);
    }

    private void writeSmallBlockDepotChain() {
        if (this.sbdStartBlockChain == -2) {
            return;
        }
        byte[] bArr = new byte[this.numSmallBlockDepotChainBlocks * 512];
        Iterator it = this.additionalPropertySets.iterator();
        int i = 0;
        int i2 = 1;
        while (it.hasNext()) {
            byte[] bArr2 = ((ReadPropertyStorage) it.next()).data;
            if (bArr2.length <= 4096 && bArr2.length != 0) {
                int smallBlocksRequired = getSmallBlocksRequired(bArr2.length);
                for (int i3 = 0; i3 < smallBlocksRequired - 1; i3++) {
                    IntegerHelper.getFourBytes(i2, bArr, i);
                    i += 4;
                    i2++;
                }
                IntegerHelper.getFourBytes(-2, bArr, i);
                i += 4;
                i2++;
            }
        }
        this.out.write(bArr);
    }

    private void writeSummaryData() {
        this.out.write(new byte[4096]);
    }

    public void write() {
        writeHeader();
        writeExcelData();
        writeDocumentSummaryData();
        writeSummaryData();
        writeAdditionalPropertySets();
        writeSmallBlockDepot();
        writeSmallBlockDepotChain();
        writeBigBlockDepot();
        writePropertySets();
    }
}
