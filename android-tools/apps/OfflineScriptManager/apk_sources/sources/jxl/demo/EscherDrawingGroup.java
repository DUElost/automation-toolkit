package jxl.demo;

import java.io.BufferedWriter;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import jxl.Workbook;
import jxl.biff.drawing.DrawingGroup;
import jxl.biff.drawing.EscherDisplay;
import jxl.read.biff.WorkbookParser;
/* loaded from: classes.dex */
public class EscherDrawingGroup {
    public EscherDrawingGroup(Workbook workbook, OutputStream outputStream, String str) {
        try {
            BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream, (str == null || !str.equals("UnicodeBig")) ? "UTF8" : "UTF8"));
            DrawingGroup drawingGroup = ((WorkbookParser) workbook).getDrawingGroup();
            if (drawingGroup != null) {
                new EscherDisplay(drawingGroup, bufferedWriter).display();
            }
            bufferedWriter.newLine();
            bufferedWriter.newLine();
            bufferedWriter.flush();
            bufferedWriter.close();
        } catch (UnsupportedEncodingException e) {
            System.err.println(e.toString());
        }
    }
}
