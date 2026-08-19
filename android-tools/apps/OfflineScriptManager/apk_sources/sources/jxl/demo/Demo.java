package jxl.demo;

import jxl.Cell;
import jxl.Range;
import jxl.Workbook;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class Demo {
    private static final int CSVFormat = 13;
    private static final int XMLFormat = 14;
    static /* synthetic */ Class class$jxl$demo$Demo;
    private static Logger logger;

    static {
        Class cls = class$jxl$demo$Demo;
        if (cls == null) {
            cls = class$("jxl.demo.Demo");
            class$jxl$demo$Demo = cls;
        }
        logger = Logger.getLogger(cls);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private static void displayHelp() {
        System.err.println("Command format:  Demo [-unicode] [-csv] [-hide] excelfile");
        System.err.println("                 Demo -xml [-format]  excelfile");
        System.err.println("                 Demo -readwrite|-rw excelfile output");
        System.err.println("                 Demo -biffdump | -bd | -wa | -write | -formulas | -features | -escher | -escherdg excelfile");
        System.err.println("                 Demo -ps excelfile [property] [output]");
        System.err.println("                 Demo -version | -logtest | -h | -help");
    }

    private static void findTest(Workbook workbook) {
        logger.info("Find test");
        Cell findCellByName = workbook.findCellByName("named1");
        if (findCellByName != null) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("named1 contents:  ");
            stringBuffer.append(findCellByName.getContents());
            logger2.info(stringBuffer.toString());
        }
        Cell findCellByName2 = workbook.findCellByName("named2");
        if (findCellByName2 != null) {
            Logger logger3 = logger;
            StringBuffer stringBuffer2 = new StringBuffer();
            stringBuffer2.append("named2 contents:  ");
            stringBuffer2.append(findCellByName2.getContents());
            logger3.info(stringBuffer2.toString());
        }
        Cell findCellByName3 = workbook.findCellByName("namedrange");
        if (findCellByName3 != null) {
            Logger logger4 = logger;
            StringBuffer stringBuffer3 = new StringBuffer();
            stringBuffer3.append("named2 contents:  ");
            stringBuffer3.append(findCellByName3.getContents());
            logger4.info(stringBuffer3.toString());
        }
        Range[] findByName = workbook.findByName("namedrange");
        if (findByName != null) {
            Cell topLeft = findByName[0].getTopLeft();
            Logger logger5 = logger;
            StringBuffer stringBuffer4 = new StringBuffer();
            stringBuffer4.append("namedrange top left contents:  ");
            stringBuffer4.append(topLeft.getContents());
            logger5.info(stringBuffer4.toString());
            Cell bottomRight = findByName[0].getBottomRight();
            Logger logger6 = logger;
            StringBuffer stringBuffer5 = new StringBuffer();
            stringBuffer5.append("namedrange bottom right contents:  ");
            stringBuffer5.append(bottomRight.getContents());
            logger6.info(stringBuffer5.toString());
        }
        Range[] findByName2 = workbook.findByName("nonadjacentrange");
        if (findByName2 != null) {
            for (int i = 0; i < findByName2.length; i++) {
                Cell topLeft2 = findByName2[i].getTopLeft();
                Logger logger7 = logger;
                StringBuffer stringBuffer6 = new StringBuffer();
                stringBuffer6.append("nonadjacent top left contents:  ");
                stringBuffer6.append(topLeft2.getContents());
                logger7.info(stringBuffer6.toString());
                Cell bottomRight2 = findByName2[i].getBottomRight();
                Logger logger8 = logger;
                StringBuffer stringBuffer7 = new StringBuffer();
                stringBuffer7.append("nonadjacent bottom right contents:  ");
                stringBuffer7.append(bottomRight2.getContents());
                logger8.info(stringBuffer7.toString());
            }
        }
        Range[] findByName3 = workbook.findByName("horizontalnonadjacentrange");
        if (findByName3 != null) {
            for (int i2 = 0; i2 < findByName3.length; i2++) {
                Cell topLeft3 = findByName3[i2].getTopLeft();
                Logger logger9 = logger;
                StringBuffer stringBuffer8 = new StringBuffer();
                stringBuffer8.append("horizontalnonadjacent top left contents:  ");
                stringBuffer8.append(topLeft3.getContents());
                logger9.info(stringBuffer8.toString());
                Cell bottomRight3 = findByName3[i2].getBottomRight();
                Logger logger10 = logger;
                StringBuffer stringBuffer9 = new StringBuffer();
                stringBuffer9.append("horizontalnonadjacent bottom right contents:  ");
                stringBuffer9.append(bottomRight3.getContents());
                logger10.info(stringBuffer9.toString());
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:91:0x020d A[Catch: all -> 0x0217, TRY_ENTER, TryCatch #0 {all -> 0x0217, blocks: (B:91:0x020d, B:95:0x021c, B:97:0x0228, B:98:0x0238, B:100:0x023f, B:102:0x0252, B:104:0x0265, B:106:0x0278, B:108:0x0287, B:110:0x0294, B:112:0x0298, B:113:0x029d, B:114:0x02a8, B:116:0x02b5, B:120:0x02c8, B:119:0x02c1), top: B:124:0x020b }] */
    /* JADX WARN: Removed duplicated region for block: B:94:0x021a  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void main(java.lang.String[] r21) {
        /*
            Method dump skipped, instructions count: 729
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: jxl.demo.Demo.main(java.lang.String[]):void");
    }
}
