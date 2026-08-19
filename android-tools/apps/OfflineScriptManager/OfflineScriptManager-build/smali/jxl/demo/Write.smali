.class public Ljxl/demo/Write;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private filename:Ljava/lang/String;

.field private workbook:Ljxl/write/WritableWorkbook;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/demo/Write;->filename:Ljava/lang/String;

    return-void
.end method

.method private writeBordersSheet(Ljxl/write/WritableSheet;)V
    .locals 12

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setProtected(Z)V

    const/16 v0, 0xf

    invoke-interface {p1, v1, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v2, 0x2

    invoke-interface {p1, v2, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v3, 0x4

    invoke-interface {p1, v3, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v4, Ljxl/format/Border;->LEFT:Ljxl/format/Border;

    sget-object v5, Ljxl/format/BorderLineStyle;->THICK:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v4, v5}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v6, Ljxl/write/Label;

    const/4 v7, 0x0

    const-string v8, "Thick left"

    invoke-direct {v6, v1, v7, v8, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v6}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v6, Ljxl/format/Border;->RIGHT:Ljxl/format/Border;

    sget-object v8, Ljxl/format/BorderLineStyle;->DASHED:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v6, v8}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v6, Ljxl/write/Label;

    const-string v8, "Dashed right"

    invoke-direct {v6, v2, v7, v8, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v6}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v6, Ljxl/format/Border;->TOP:Ljxl/format/Border;

    sget-object v7, Ljxl/format/BorderLineStyle;->DOUBLE:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v6, v7}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v7, Ljxl/write/Label;

    const-string v8, "Double top"

    invoke-direct {v7, v1, v2, v8, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v7}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v7, Ljxl/format/Border;->BOTTOM:Ljxl/format/Border;

    sget-object v8, Ljxl/format/BorderLineStyle;->HAIR:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v7, v8}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v8, Ljxl/write/Label;

    const-string v9, "Hair bottom"

    invoke-direct {v8, v2, v2, v9, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v8, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v9, Ljxl/format/BorderLineStyle;->THIN:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v8, v9}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v10, Ljxl/write/Label;

    const-string v11, "All thin"

    invoke-direct {v10, v3, v2, v11, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v10}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    invoke-virtual {v0, v6, v5}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    invoke-virtual {v0, v4, v5}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    new-instance v4, Ljxl/write/Label;

    const/4 v10, 0x6

    const-string v11, "Two borders"

    invoke-direct {v4, v10, v2, v11, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v2, 0x14

    const-string v4, "Dislocated cell - after a page break"

    invoke-direct {v0, v2, v2, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    sget-object v2, Ljxl/format/PaperSize;->A3:Ljxl/format/PaperSize;

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPaperSize(Ljxl/format/PaperSize;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    sget-object v2, Ljxl/format/PageOrientation;->LANDSCAPE:Ljxl/format/PageOrientation;

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setOrientation(Ljxl/format/PageOrientation;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    sget-object v2, Ljxl/format/PageOrder;->DOWN_THEN_RIGHT:Ljxl/format/PageOrder;

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPageOrder(Ljxl/format/PageOrder;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const-wide/high16 v10, 0x4000000000000000L    # 2.0

    invoke-virtual {v0, v10, v11}, Ljxl/SheetSettings;->setHeaderMargin(D)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    invoke-virtual {v0, v10, v11}, Ljxl/SheetSettings;->setFooterMargin(D)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const-wide/high16 v10, 0x4008000000000000L    # 3.0

    invoke-virtual {v0, v10, v11}, Ljxl/SheetSettings;->setTopMargin(D)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    invoke-virtual {v0, v10, v11}, Ljxl/SheetSettings;->setBottomMargin(D)V

    new-instance v0, Ljxl/HeaderFooter;

    invoke-direct {v0}, Ljxl/HeaderFooter;-><init>()V

    invoke-virtual {v0}, Ljxl/HeaderFooter;->getCentre()Ljxl/HeaderFooter$Contents;

    move-result-object v2

    const-string v4, "Page Header"

    invoke-virtual {v2, v4}, Ljxl/HeaderFooter$Contents;->append(Ljava/lang/String;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljxl/SheetSettings;->setHeader(Ljxl/HeaderFooter;)V

    new-instance v0, Ljxl/HeaderFooter;

    invoke-direct {v0}, Ljxl/HeaderFooter;-><init>()V

    invoke-virtual {v0}, Ljxl/HeaderFooter;->getRight()Ljxl/HeaderFooter$Contents;

    move-result-object v2

    const-string v4, "page "

    invoke-virtual {v2, v4}, Ljxl/HeaderFooter$Contents;->append(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljxl/HeaderFooter;->getRight()Ljxl/HeaderFooter$Contents;

    move-result-object v2

    invoke-virtual {v2}, Ljxl/HeaderFooter$Contents;->appendPageNumber()V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljxl/SheetSettings;->setFooter(Ljxl/HeaderFooter;)V

    const/16 v0, 0x12

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addRowPageBreak(I)V

    const/16 v0, 0x11

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->insertRow(I)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->insertRow(I)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->removeRow(I)V

    const/16 v0, 0x1e

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addRowPageBreak(I)V

    new-instance v0, Ljxl/write/Label;

    const/16 v2, 0xa

    const-string v4, "Hidden column"

    invoke-direct {v0, v2, v1, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v2, 0x3

    const/16 v4, 0x8

    const-string v10, "Hidden row"

    invoke-direct {v0, v2, v4, v10}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1, v4, v1}, Ljxl/write/WritableSheet;->setRowView(IZ)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v2, Ljxl/format/Colour;->RED:Ljxl/format/Colour;

    invoke-virtual {v0, v8, v5, v2}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    new-instance v2, Ljxl/write/Label;

    const/4 v4, 0x5

    const-string v5, "All thick red"

    invoke-direct {v2, v1, v4, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v1, Ljxl/format/Colour;->BLUE:Ljxl/format/Colour;

    invoke-virtual {v0, v6, v9, v1}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    invoke-virtual {v0, v7, v9, v1}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;Ljxl/format/Colour;)V

    new-instance v1, Ljxl/write/Label;

    const-string v2, "Top and bottom blue"

    invoke-direct {v1, v3, v4, v2, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    return-void
.end method

.method private writeDateFormatSheet(Ljxl/write/WritableSheet;)V
    .locals 39

    move-object/from16 v0, p1

    new-instance v1, Ljxl/write/WritableCellFormat;

    sget-object v2, Ljxl/write/WritableWorkbook;->ARIAL_10_PT:Ljxl/write/WritableFont;

    invoke-direct {v1, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    const/4 v3, 0x0

    const/16 v4, 0x14

    invoke-interface {v0, v3, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v5, 0x2

    invoke-interface {v0, v5, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v6, 0x3

    invoke-interface {v0, v6, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v7, 0x4

    invoke-interface {v0, v7, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    invoke-interface/range {p1 .. p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljxl/SheetSettings;->setFitWidth(I)V

    invoke-interface/range {p1 .. p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljxl/SheetSettings;->setFitHeight(I)V

    const-string v4, "GMT"

    invoke-static {v4}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v8

    invoke-static {v8}, Ljava/util/Calendar;->getInstance(Ljava/util/TimeZone;)Ljava/util/Calendar;

    move-result-object v8

    const/16 v10, 0x7b7

    const/4 v11, 0x4

    const/16 v12, 0x1f

    const/16 v13, 0xf

    const/16 v14, 0x15

    const/16 v15, 0x2d

    move-object v9, v8

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    const/16 v15, 0xe

    const/16 v9, 0x294

    invoke-virtual {v8, v15, v9}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v14

    const/16 v10, 0x76c

    const/4 v11, 0x0

    const/4 v12, 0x1

    const/4 v13, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    move-object v9, v8

    move-object v6, v14

    move/from16 v14, v16

    move v7, v15

    move/from16 v15, v17

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8, v7, v3}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v7

    const/16 v10, 0x7b2

    const/4 v14, 0x0

    const/4 v15, 0x0

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v10, 0x77e

    const/16 v11, 0xa

    const/16 v12, 0xb

    const/16 v13, 0xb

    move-object/from16 v28, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v10, 0x76c

    const/4 v11, 0x0

    const/4 v12, 0x2

    const/4 v13, 0x0

    move-object/from16 v29, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v10, 0x76d

    const/4 v12, 0x1

    move-object/from16 v30, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v10, 0x76c

    const/4 v11, 0x4

    const/16 v12, 0x1f

    move-object/from16 v31, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/4 v11, 0x1

    const/4 v12, 0x1

    move-object/from16 v32, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/4 v11, 0x0

    const/16 v12, 0x1f

    move-object/from16 v33, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/4 v11, 0x2

    const/4 v12, 0x1

    move-object/from16 v34, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/4 v11, 0x1

    const/16 v12, 0x1b

    move-object/from16 v35, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v12, 0x1c

    move-object/from16 v36, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v15

    const/16 v10, 0x7bc

    const/4 v11, 0x5

    const/16 v12, 0x1f

    const/16 v13, 0xc

    move-object/from16 v37, v15

    move/from16 v15, v16

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v38

    const/16 v10, 0x42a

    const/16 v11, 0x9

    const/16 v12, 0xe

    const/4 v13, 0x0

    const/4 v15, 0x0

    invoke-virtual/range {v9 .. v15}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual {v8}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v8

    new-instance v9, Ljava/text/SimpleDateFormat;

    const-string v10, "dd MMM yyyy HH:mm:ss.SSS"

    invoke-direct {v9, v10}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-static {v4}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v4

    invoke-virtual {v9, v4}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    new-instance v4, Ljxl/write/Label;

    new-instance v10, Ljava/lang/StringBuffer;

    invoke-direct {v10}, Ljava/lang/StringBuffer;-><init>()V

    const-string v11, "All dates are "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v9, v6}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v10}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v4, v3, v3, v10, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "Built in formats"

    invoke-direct {v4, v3, v2, v10, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "Custom formats"

    invoke-direct {v4, v5, v2, v10}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v4, Ljxl/write/DateFormats;->FORMAT1:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/DateTime;

    sget-object v10, Ljxl/write/DateTime;->GMT:Ljxl/write/biff/DateRecord$GMTDate;

    const/16 v18, 0x2

    move-object/from16 v16, v4

    move-object/from16 v19, v6

    move-object/from16 v20, v2

    move-object/from16 v21, v10

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v4, Ljxl/write/DateFormats;->FORMAT2:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/16 v18, 0x3

    move-object/from16 v16, v11

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT3:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/4 v12, 0x4

    invoke-direct {v11, v3, v12, v6, v2}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT4:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/4 v12, 0x5

    invoke-direct {v11, v3, v12, v6, v2}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT5:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/4 v13, 0x6

    invoke-direct {v11, v3, v13, v6, v2}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT6:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/4 v14, 0x7

    invoke-direct {v11, v3, v14, v6, v2}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT7:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/16 v18, 0x8

    move-object/from16 v16, v11

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT8:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v11, Ljxl/write/DateTime;

    const/16 v18, 0x9

    move-object/from16 v16, v11

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v11}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v11, Ljxl/write/DateFormats;->FORMAT9:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v15, Ljxl/write/DateTime;

    const/16 v18, 0xa

    move-object/from16 v16, v15

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v15}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v15, Ljxl/write/DateFormats;->FORMAT10:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v15, Ljxl/write/DateTime;

    const/16 v18, 0xb

    move-object/from16 v16, v15

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v15}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v15, Ljxl/write/DateFormats;->FORMAT11:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v15, Ljxl/write/DateTime;

    const/16 v18, 0xc

    move-object/from16 v16, v15

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v15}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    sget-object v15, Ljxl/write/DateFormats;->FORMAT12:Ljxl/biff/DisplayFormat;

    invoke-direct {v2, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v15, Ljxl/write/DateTime;

    const/16 v18, 0xd

    move-object/from16 v16, v15

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v15}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v15, "dd MM yyyy"

    invoke-direct {v2, v15}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    invoke-direct {v2, v5, v5, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v17, 0x3

    const/16 v18, 0x2

    move-object/from16 v16, v2

    move-object/from16 v20, v3

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "dd MMM yyyy"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v15, Ljxl/write/WritableCellFormat;

    invoke-direct {v15, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    const/4 v14, 0x3

    invoke-direct {v2, v5, v14, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v18, 0x3

    move-object/from16 v16, v2

    move-object/from16 v20, v15

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "hh:mm"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v14, Ljxl/write/WritableCellFormat;

    invoke-direct {v14, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    const/4 v15, 0x4

    invoke-direct {v2, v5, v15, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v18, 0x4

    move-object/from16 v16, v2

    move-object/from16 v20, v14

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "hh:mm:ss"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v14, Ljxl/write/WritableCellFormat;

    invoke-direct {v14, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    invoke-direct {v2, v5, v12, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v18, 0x5

    move-object/from16 v16, v2

    move-object/from16 v20, v14

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "H:mm:ss a"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v14, Ljxl/write/WritableCellFormat;

    invoke-direct {v14, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    invoke-direct {v2, v5, v12, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    move-object/from16 v16, v2

    move-object/from16 v20, v14

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v23, 0x4

    const/16 v24, 0x5

    move-object/from16 v22, v2

    move-object/from16 v25, v38

    move-object/from16 v26, v14

    move-object/from16 v27, v10

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "mm:ss.SSS"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v12, Ljxl/write/WritableCellFormat;

    invoke-direct {v12, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    invoke-direct {v2, v5, v13, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v18, 0x6

    move-object/from16 v16, v2

    move-object/from16 v20, v12

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateFormat;

    const-string v3, "hh:mm:ss a"

    invoke-direct {v2, v3}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v6, Ljxl/write/WritableCellFormat;

    invoke-direct {v6, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Label;

    const/4 v12, 0x7

    invoke-direct {v2, v5, v12, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v24, 0x7

    move-object/from16 v22, v2

    move-object/from16 v26, v6

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "Zero date "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v9, v7}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    const/16 v5, 0x10

    const/4 v6, 0x0

    invoke-direct {v2, v6, v5, v3, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v3, Ljxl/write/DateTime;

    const/16 v23, 0x0

    const/16 v24, 0x11

    move-object/from16 v22, v3

    move-object/from16 v25, v7

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Zero date + 1 "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v6, v30

    invoke-virtual {v9, v6}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v7, 0x3

    invoke-direct {v2, v7, v5, v3, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v3, Ljxl/write/DateTime;

    const/16 v23, 0x3

    move-object/from16 v22, v3

    move-object/from16 v25, v6

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v31

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x13

    const/4 v7, 0x3

    invoke-direct {v2, v7, v6, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x14

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v32

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v7, 0x16

    const/4 v12, 0x3

    invoke-direct {v2, v12, v7, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x17

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v33

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v12, 0x19

    const/4 v13, 0x3

    invoke-direct {v2, v13, v12, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x1a

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v34

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v13, 0x1c

    const/4 v14, 0x3

    invoke-direct {v2, v14, v13, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x1d

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/4 v14, 0x3

    invoke-direct {v2, v14, v13, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    move-object/from16 v22, v5

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v35

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v13, 0x1f

    const/4 v14, 0x3

    invoke-direct {v2, v14, v13, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x20

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v36

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v13, 0x22

    const/4 v14, 0x3

    invoke-direct {v2, v14, v13, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x23

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    move-object/from16 v3, v37

    invoke-virtual {v9, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    const/16 v13, 0x25

    const/4 v14, 0x3

    invoke-direct {v2, v14, v13, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v5, Ljxl/write/DateTime;

    const/16 v24, 0x26

    move-object/from16 v22, v5

    move-object/from16 v25, v3

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "Zero UTC date "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v5, v28

    invoke-virtual {v9, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v3, v13}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v13, 0x0

    invoke-direct {v2, v13, v6, v3, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v3, Ljxl/write/DateTime;

    const/16 v17, 0x0

    const/16 v18, 0x14

    move-object/from16 v16, v3

    move-object/from16 v19, v5

    move-object/from16 v20, v2

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "Armistice date "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-object/from16 v5, v29

    invoke-virtual {v9, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v6, 0x0

    invoke-direct {v2, v6, v7, v3, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/WritableCellFormat;

    invoke-direct {v2, v11}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v3, Ljxl/write/DateTime;

    const/16 v23, 0x0

    const/16 v24, 0x17

    move-object/from16 v22, v3

    move-object/from16 v25, v5

    move-object/from16 v26, v2

    invoke-direct/range {v22 .. v27}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "Battle of Hastings "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v9, v8}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x0

    invoke-direct {v2, v5, v12, v3, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableCellFormat;

    invoke-direct {v1, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/DateTime;

    const/16 v18, 0x1a

    move-object/from16 v16, v2

    move-object/from16 v19, v8

    move-object/from16 v20, v1

    invoke-direct/range {v16 .. v21}, Ljxl/write/DateTime;-><init>(IILjava/util/Date;Ljxl/format/CellFormat;Ljxl/write/biff/DateRecord$GMTDate;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    return-void
.end method

.method private writeFormulaSheet(Ljxl/write/WritableSheet;)V
    .locals 10

    new-instance v0, Ljxl/write/Number;

    const/4 v1, 0x0

    const-wide/high16 v2, 0x402e000000000000L    # 15.0

    invoke-direct {v0, v1, v1, v2, v3}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Number;

    const/4 v2, 0x1

    const-wide/high16 v3, 0x4030000000000000L    # 16.0

    invoke-direct {v0, v1, v2, v3, v4}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Number;

    const/4 v3, 0x2

    const-wide/high16 v4, 0x4024000000000000L    # 10.0

    invoke-direct {v0, v1, v3, v4, v5}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Number;

    const/4 v4, 0x3

    const-wide/high16 v5, 0x4028000000000000L    # 12.0

    invoke-direct {v0, v1, v4, v5, v6}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x14

    invoke-interface {p1, v3, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    new-instance v5, Ljxl/write/WritableCellFormat;

    invoke-direct {v5}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v6, Ljxl/format/Alignment;->RIGHT:Ljxl/format/Alignment;

    invoke-virtual {v5, v6}, Ljxl/write/WritableCellFormat;->setAlignment(Ljxl/format/Alignment;)V

    invoke-virtual {v5, v2}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    new-instance v6, Ljxl/CellView;

    invoke-direct {v6}, Ljxl/CellView;-><init>()V

    const/16 v7, 0x1900

    invoke-virtual {v6, v7}, Ljxl/CellView;->setSize(I)V

    invoke-virtual {v6, v5}, Ljxl/CellView;->setFormat(Ljxl/format/CellFormat;)V

    invoke-interface {p1, v4, v6}, Ljxl/write/WritableSheet;->setColumnView(ILjxl/CellView;)V

    new-instance v5, Ljxl/write/Formula;

    const-string v6, "A1+A2"

    invoke-direct {v5, v3, v1, v6}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v6, "a1+a2"

    invoke-direct {v5, v4, v1, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const-string v6, "A2 * 3"

    invoke-direct {v5, v3, v2, v6}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v2, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const-string v6, "A2+A1/2.5"

    invoke-direct {v5, v3, v3, v6}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v3, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const-string v6, "3+(a1+a2)/2.5"

    invoke-direct {v5, v3, v4, v6}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v4, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/4 v6, 0x4

    const-string v7, "(a1+a2)/2.5"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/4 v6, 0x5

    const-string v7, "15+((a1+a2)/2.5)*17"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/4 v6, 0x6

    const-string v7, "SUM(a1:a4)"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/4 v6, 0x7

    const-string v7, "SUM(a1:a4)/4"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v6, 0x8

    const-string v7, "AVERAGE(A1:A4)"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v7, "AVERAGE(a1:a4)"

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v6, 0x9

    const-string v7, "MIN(5,4,1,2,3)"

    invoke-direct {v5, v3, v6, v7}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v7, "MIN(5,4,1,2,3)"

    invoke-direct {v5, v4, v6, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xa

    const-string v8, "ROUND(3.14159265, 3)"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "ROUND(3.14159265, 3)"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xb

    const-string v8, "MAX(SUM(A1:A2), A1*A2, POWER(A1, 2))"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "MAX(SUM(A1:A2), A1*A2, POWER(A1, 2))"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xc

    const-string v8, "IF(A2>A1, \"A2 bigger\", \"A1 bigger\")"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "IF(A2>A1, \"A2 bigger\", \"A1 bigger\")"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xd

    const-string v8, "IF(A2<=A1, \"A2 smaller\", \"A1 smaller\")"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "IF(A2<=A1, \"A2 smaller\", \"A1 smaller\")"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xe

    const-string v8, "IF(A3<=10, \"<= 10\")"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "IF(A3<=10, \"<= 10\")"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0xf

    const-string v8, "SUM(1,2,3,4,5)"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "SUM(1,2,3,4,5)"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0x10

    const-string v8, "HYPERLINK(\"http://www.andykhan.com/jexcelapi\", \"JExcelApi Home Page\")"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "HYPERLINK(\"http://www.andykhan.com/jexcelapi\", \"JExcelApi Home Page\")"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0x11

    const-string v8, "3*4+5"

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "3*4+5"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v7, 0x12

    const-string v8, "\"Plain text formula\""

    invoke-direct {v5, v3, v7, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "Plain text formula"

    invoke-direct {v5, v4, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const/16 v8, 0x13

    const-string v9, "SUM(a1,a2,-a3,a4)"

    invoke-direct {v5, v3, v8, v9}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v9, "SUM(a1,a2,-a3,a4)"

    invoke-direct {v5, v4, v8, v9}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Formula;

    const-string v8, "2*-(a1+a2)"

    invoke-direct {v5, v3, v0, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v5, Ljxl/write/Label;

    const-string v8, "2*-(a1+a2)"

    invoke-direct {v5, v4, v0, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v5}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x15

    const-string v8, "\'Number Formats\'!B1/2"

    invoke-direct {v0, v3, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v8, "\'Number Formats\'!B1/2"

    invoke-direct {v0, v4, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x16

    const-string v8, "IF(F22=0, 0, F21/F22)"

    invoke-direct {v0, v3, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v8, "IF(F22=0, 0, F21/F22)"

    invoke-direct {v0, v4, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x17

    const-string v8, "RAND()"

    invoke-direct {v0, v3, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v8, "RAND()"

    invoke-direct {v0, v4, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "\'"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v5, p0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    invoke-virtual {v5, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v1

    invoke-interface {v1}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, "\'!"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static {v6, v7}, Ljxl/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, "*25"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    new-instance v1, Ljxl/write/Formula;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x18

    invoke-direct {v1, v3, v6, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/Label;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v5, 0x18

    invoke-direct {v1, v4, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    sget-object v1, Ljxl/write/DateFormats;->DEFAULT:Ljxl/biff/DisplayFormat;

    invoke-direct {v0, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v1, Ljxl/write/Formula;

    const/16 v5, 0x19

    const-string v6, "NOW()"

    invoke-direct {v1, v3, v5, v6, v0}, Ljxl/write/Formula;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x19

    const-string v5, "NOW()"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x1a

    const-string v5, "$A$2+A3"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "$A$2+A3"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x1b

    const-string v5, "IF(COUNT(A1:A9,B1:B9)=0,\"\",COUNT(A1:A9,B1:B9))"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "IF(COUNT(A1:A9,B1:B9)=0,\"\",COUNT(A1:A9,B1:B9))"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x1c

    const-string v5, "SUM(A1,A2,A3,A4)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "SUM(A1,A2,A3,A4)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x1d

    const-string v5, "a1"

    invoke-direct {v0, v2, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const-string v5, "SUM(INDIRECT(ADDRESS(2,29)):A4)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "SUM(INDIRECT(ADDRESS(2,29):A4)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x1e

    const-string v5, "COUNTIF(A1:A4, \">=12\")"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "COUNTIF(A1:A4, \">=12\")"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x1f

    const-string v5, "MAX($A$1:$A$4)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "MAX($A$1:$A$4)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x20

    const-string v5, "OR(A1,TRUE)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "OR(A1,TRUE)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x21

    const-string v5, "ROWS(A1:C14)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "ROWS(A1:C14)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x22

    const-string v5, "COUNTBLANK(A1:C14)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "COUNTBLANK(A1:C14)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x23

    const-string v5, "IF(((F1=\"Not Found\")*(F2=\"Not Found\")*(F3=\"\")*(F4=\"\")*(F5=\"\")),1,0)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "IF(((F1=\"Not Found\")*(F2=\"Not Found\")*(F3=\"\")*(F4=\"\")*(F5=\"\")),1,0)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x24

    const-string v5, "HYPERLINK(\"http://www.amazon.co.uk/exec/obidos/ASIN/0571058086qid=1099836249/sr=1-3/ref=sr_1_11_3/202-6017285-1620664\",  \"Long hyperlink\")"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x25

    const-string v5, "1234567+2699"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "1234567+2699"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x26

    const-string v5, "IF(ISERROR(G25/G29),0,-1)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "IF(ISERROR(G25/G29),0,-1)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x27

    const-string v5, "SEARCH(\"C\",D40)"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "SEARCH(\"C\",D40)"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x28

    const-string v5, "#REF!"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "#REF!"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Number;

    const/16 v1, 0x29

    const-wide v5, 0x4053c00000000000L    # 79.0

    invoke-direct {v0, v2, v1, v5, v6}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const-string v5, "--B42"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "--B42"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x2a

    const-string v5, "CHOOSE(3,A1,A2,A3,A4"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "CHOOSE(3,A1,A2,A3,A4"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x2b

    const-string v5, "A4-A3-A2"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "A4-A3-A2"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v1, 0x2c

    const-string v5, "F29+F34+F41+F48+F55+F62+F69+F76+F83+F90+F97+F104+F111+F118+F125+F132+F139+F146+F153+F160+F167+F174+F181+F188+F195+F202+F209+F216+F223+F230+F237+F244+F251+F258+F265+F272+F279+F286+F293+F300+F305+F308"

    invoke-direct {v0, v3, v1, v5}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "F29+F34+F41+F48+F55+F62+F69+F76+F83+F90+F97+F104+F111+F118+F125+F132+F139+F146+F153+F160+F167+F174+F181+F188+F195+F202+F209+F216+F223+F230+F237+F244+F251+F258+F265+F272+F279+F286+F293+F300+F305+F308"

    invoke-direct {v0, v4, v1, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Number;

    const/16 v1, 0x2d

    const-wide/high16 v5, 0x4031000000000000L    # 17.0

    invoke-direct {v0, v2, v1, v5, v6}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const-string v2, "formulavalue+5"

    invoke-direct {v0, v3, v1, v2}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v2, "formulavalue+5"

    invoke-direct {v0, v4, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    return-void
.end method

.method private writeImageSheet(Ljxl/write/WritableSheet;)V
    .locals 14

    new-instance v0, Ljxl/write/Label;

    const/4 v1, 0x0

    const-string v2, "Weald & Downland Open Air Museum, Sussex"

    invoke-direct {v0, v1, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableImage;

    new-instance v12, Ljava/io/File;

    const-string v2, "resources/wealdanddownland.png"

    invoke-direct {v12, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-wide/16 v4, 0x0

    const-wide/high16 v6, 0x4008000000000000L    # 3.0

    const-wide/high16 v8, 0x4014000000000000L    # 5.0

    const-wide/high16 v10, 0x401c000000000000L    # 7.0

    move-object v3, v0

    invoke-direct/range {v3 .. v12}, Ljxl/write/WritableImage;-><init>(DDDDLjava/io/File;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addImage(Ljxl/write/WritableImage;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v2, 0xc

    const-string v3, "Merchant Adventurers Hall, York"

    invoke-direct {v0, v1, v2, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableImage;

    new-instance v13, Ljava/io/File;

    const-string v1, "resources/merchantadventurers.png"

    invoke-direct {v13, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-wide/high16 v5, 0x4014000000000000L    # 5.0

    const-wide/high16 v7, 0x4028000000000000L    # 12.0

    const-wide/high16 v9, 0x4010000000000000L    # 4.0

    const-wide/high16 v11, 0x4024000000000000L    # 10.0

    move-object v4, v0

    invoke-direct/range {v4 .. v13}, Ljxl/write/WritableImage;-><init>(DDDDLjava/io/File;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addImage(Ljxl/write/WritableImage;)V

    return-void
.end method

.method private writeLabelFormatSheet(Ljxl/write/WritableSheet;)V
    .locals 34

    move-object/from16 v12, p1

    const/4 v13, 0x0

    const/16 v0, 0x3c

    invoke-interface {v12, v13, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    new-instance v0, Ljxl/write/Label;

    const-string v1, "Arial Fonts"

    invoke-direct {v0, v13, v13, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v14, 0x1

    const-string v1, "10pt"

    invoke-direct {v0, v14, v13, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v2, 0x2

    const-string v3, "Normal"

    invoke-direct {v0, v2, v13, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v15, 0x3

    const-string v4, "12pt"

    invoke-direct {v0, v15, v13, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v11, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    const/16 v10, 0xc

    invoke-direct {v0, v11, v10}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v9, Ljxl/write/WritableCellFormat;

    invoke-direct {v9, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-virtual {v9, v14}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    new-instance v0, Ljxl/write/Label;

    const/4 v8, 0x4

    invoke-direct {v0, v8, v13, v3, v9}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v7, Ljxl/write/WritableFont;->BOLD:Ljxl/write/WritableFont$BoldStyle;

    const/16 v6, 0xa

    invoke-direct {v0, v11, v6, v7}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "BOLD"

    invoke-direct {v0, v2, v2, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    invoke-direct {v0, v11, v10, v7}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    invoke-direct {v0, v8, v2, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v4, Ljxl/write/WritableFont;->NO_BOLD:Ljxl/write/WritableFont$BoldStyle;

    invoke-direct {v0, v11, v6, v4, v14}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;Z)V

    new-instance v15, Ljxl/write/WritableCellFormat;

    invoke-direct {v15, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v13, "Italic"

    invoke-direct {v0, v2, v8, v13, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    invoke-direct {v0, v11, v10, v4, v14}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;Z)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v15, "Italic"

    invoke-direct {v0, v8, v8, v15, v13}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v13, Ljxl/write/WritableFont;->TIMES:Ljxl/write/WritableFont$FontName;

    invoke-direct {v0, v13, v6}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v15, Ljxl/write/WritableCellFormat;

    invoke-direct {v15, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v6, 0x7

    const-string v8, "Times Fonts"

    const/4 v10, 0x0

    invoke-direct {v0, v10, v6, v8, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    invoke-direct {v0, v14, v6, v1, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    invoke-direct {v0, v2, v6, v3, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v1, "12pt"

    const/4 v8, 0x3

    invoke-direct {v0, v8, v6, v1, v15}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v15, Ljxl/write/WritableFont;

    const/16 v1, 0xc

    invoke-direct {v15, v13, v1}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const/4 v8, 0x4

    invoke-direct {v1, v8, v6, v3, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    const/16 v1, 0xa

    invoke-direct {v0, v13, v1, v7}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v10, 0x9

    invoke-direct {v0, v2, v10, v5, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    const/16 v3, 0xc

    invoke-direct {v0, v13, v3, v7}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v8, 0x4

    invoke-direct {v0, v8, v10, v5, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/4 v3, 0x6

    const/16 v0, 0x16

    invoke-interface {v12, v3, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    invoke-interface {v12, v6, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/16 v5, 0x8

    invoke-interface {v12, v5, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    invoke-interface {v12, v10, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    new-instance v1, Ljxl/write/Label;

    const/16 v0, 0xb

    const-string v5, "Underlining"

    const/4 v6, 0x0

    invoke-direct {v1, v6, v0, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableFont;

    sget-object v22, Ljxl/format/UnderlineStyle;->SINGLE:Ljxl/format/UnderlineStyle;

    const/16 v6, 0xa

    const/16 v19, 0x0

    move-object/from16 v23, v4

    move-object v4, v1

    const/16 v2, 0x8

    move-object v5, v11

    const/4 v14, 0x7

    move-object/from16 v24, v7

    move-object/from16 v7, v23

    move/from16 v8, v19

    move-object/from16 v25, v9

    move-object/from16 v9, v22

    invoke-direct/range {v4 .. v9}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Underline"

    invoke-direct {v1, v3, v0, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableFont;

    sget-object v9, Ljxl/format/UnderlineStyle;->DOUBLE:Ljxl/format/UnderlineStyle;

    const/4 v8, 0x0

    move-object v4, v1

    move-object v5, v11

    invoke-direct/range {v4 .. v9}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Double Underline"

    invoke-direct {v1, v14, v0, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableFont;

    sget-object v9, Ljxl/format/UnderlineStyle;->SINGLE_ACCOUNTING:Ljxl/format/UnderlineStyle;

    move-object v4, v1

    move-object v5, v11

    invoke-direct/range {v4 .. v9}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Single Accounting Underline"

    invoke-direct {v1, v2, v0, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableFont;

    sget-object v9, Ljxl/format/UnderlineStyle;->DOUBLE_ACCOUNTING:Ljxl/format/UnderlineStyle;

    move-object v4, v1

    move-object v5, v11

    invoke-direct/range {v4 .. v9}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Double Accounting Underline"

    invoke-direct {v1, v10, v0, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    const/16 v18, 0xe

    const/16 v20, 0x0

    move-object/from16 v16, v0

    move-object/from16 v17, v13

    move-object/from16 v19, v24

    move-object/from16 v21, v22

    invoke-direct/range {v16 .. v21}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v1, "Times 14 Bold Underline"

    const/16 v9, 0xc

    invoke-direct {v0, v3, v9, v1, v13}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    const/16 v6, 0x12

    const/4 v8, 0x1

    move-object v4, v0

    move-object v5, v11

    move-object/from16 v7, v24

    move v1, v9

    move-object/from16 v9, v22

    invoke-direct/range {v4 .. v9}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0xd

    const-string v6, "Arial 18 Bold Italic Underline"

    invoke-direct {v0, v3, v5, v6, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v9, 0xf

    const-string v4, "Script styles"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v9, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v16, Ljxl/format/UnderlineStyle;->NO_UNDERLINE:Ljxl/format/UnderlineStyle;

    sget-object v17, Ljxl/format/Colour;->BLACK:Ljxl/format/Colour;

    sget-object v18, Ljxl/format/ScriptStyle;->SUPERSCRIPT:Ljxl/format/ScriptStyle;

    const/16 v6, 0xa

    const/4 v8, 0x0

    move-object v4, v0

    move-object v5, v11

    move-object/from16 v7, v23

    move v1, v9

    move-object/from16 v9, v16

    const/16 v14, 0xc

    move-object/from16 v10, v17

    move-object/from16 v20, v11

    move-object/from16 v11, v18

    invoke-direct/range {v4 .. v11}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;Ljxl/format/ScriptStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "superscript"

    const/4 v6, 0x1

    invoke-direct {v0, v6, v1, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v11, Ljxl/format/ScriptStyle;->SUBSCRIPT:Ljxl/format/ScriptStyle;

    const/16 v6, 0xa

    move-object v4, v0

    move-object/from16 v5, v20

    invoke-direct/range {v4 .. v11}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;Ljxl/format/ScriptStyle;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const-string v5, "subscript"

    const/4 v6, 0x2

    invoke-direct {v0, v6, v1, v5, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x11

    const-string v4, "Colours"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v1, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v10, Ljxl/format/Colour;->RED:Ljxl/format/Colour;

    const/16 v6, 0xa

    move-object v4, v0

    move-object/from16 v5, v20

    invoke-direct/range {v4 .. v10}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;)V

    new-instance v1, Ljxl/write/WritableCellFormat;

    invoke-direct {v1, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v4, 0x11

    const-string v5, "Red"

    const/4 v6, 0x2

    invoke-direct {v0, v6, v4, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v1, Ljxl/format/Colour;->BLUE:Ljxl/format/Colour;

    const/16 v6, 0xa

    move-object v4, v0

    move-object/from16 v5, v20

    move-object v10, v1

    invoke-direct/range {v4 .. v10}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x12

    const-string v6, "Blue"

    const/4 v7, 0x2

    invoke-direct {v0, v7, v5, v6, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    move-object/from16 v5, v20

    invoke-direct {v0, v5}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    sget-object v4, Ljxl/format/Colour;->LIME:Ljxl/format/Colour;

    invoke-virtual {v0, v4}, Ljxl/write/WritableFont;->setColour(Ljxl/format/Colour;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    const/4 v6, 0x1

    invoke-virtual {v4, v6}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    new-instance v0, Ljxl/write/Label;

    const/16 v7, 0x12

    const-string v8, "Modified palette - was lime, now red"

    const/4 v11, 0x4

    invoke-direct {v0, v11, v7, v8, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    invoke-virtual {v0, v6}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    sget-object v4, Ljxl/format/Colour;->GRAY_50:Ljxl/format/Colour;

    invoke-virtual {v0, v4}, Ljxl/write/WritableCellFormat;->setBackground(Ljxl/format/Colour;)V

    new-instance v4, Ljxl/write/Label;

    const/16 v6, 0x13

    const-string v7, "Grey background"

    const/4 v8, 0x2

    invoke-direct {v4, v8, v6, v7, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v10, Ljxl/format/Colour;->YELLOW:Ljxl/format/Colour;

    const/16 v6, 0xa

    const/4 v8, 0x0

    move-object v4, v0

    move-object/from16 v7, v23

    invoke-direct/range {v4 .. v10}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    invoke-virtual {v4, v1}, Ljxl/write/WritableCellFormat;->setBackground(Ljxl/format/Colour;)V

    new-instance v1, Ljxl/write/Label;

    const/16 v6, 0x14

    const-string v7, "Blue background, yellow foreground"

    const/4 v8, 0x2

    invoke-direct {v1, v8, v6, v7, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/WritableCellFormat;

    invoke-direct {v1, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-virtual {v1, v5}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    sget-object v0, Ljxl/format/Colour;->PALETTE_BLACK:Ljxl/format/Colour;

    invoke-virtual {v1, v0}, Ljxl/write/WritableCellFormat;->setBackground(Ljxl/format/Colour;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v4, 0x14

    const-string v5, "Black background, yellow foreground"

    const/4 v6, 0x3

    invoke-direct {v0, v6, v4, v5, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v1, "Null label"

    const/16 v4, 0x16

    const/4 v5, 0x0

    invoke-direct {v0, v5, v4, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v1, 0x0

    const/4 v6, 0x2

    invoke-direct {v0, v6, v4, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x18

    const-string v4, "A very long label, more than 255 characters\nRejoice O shores\nSing O bells\nBut I with mournful tread\nWalk the deck my captain lies\nFallen cold and dead\nSummer surprised, coming over the Starnbergersee\nWith a shower of rain. We stopped in the Colonnade\nA very long label, more than 255 characters\nRejoice O shores\nSing O bells\nBut I with mournful tread\nWalk the deck my captain lies\nFallen cold and dead\nSummer surprised, coming over the Starnbergersee\nWith a shower of rain. We stopped in the Colonnade\nA very long label, more than 255 characters\nRejoice O shores\nSing O bells\nBut I with mournful tread\nWalk the deck my captain lies\nFallen cold and dead\nSummer surprised, coming over the Starnbergersee\nWith a shower of rain. We stopped in the Colonnade\nA very long label, more than 255 characters\nRejoice O shores\nSing O bells\nBut I with mournful tread\nWalk the deck my captain lies\nFallen cold and dead\nSummer surprised, coming over the Starnbergersee\nWith a shower of rain. We stopped in the Colonnade\nAnd sat and drank coffee an talked for an hour\n"

    move-object/from16 v10, v25

    invoke-direct {v0, v5, v1, v4, v10}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v1, Ljxl/format/Orientation;->VERTICAL:Ljxl/format/Orientation;

    invoke-virtual {v0, v1}, Ljxl/write/WritableCellFormat;->setOrientation(Ljxl/format/Orientation;)V

    new-instance v1, Ljxl/write/Label;

    const/16 v4, 0x1a

    const-string v6, "Vertical orientation"

    invoke-direct {v1, v5, v4, v6, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v1, Ljxl/format/Orientation;->PLUS_90:Ljxl/format/Orientation;

    invoke-virtual {v0, v1}, Ljxl/write/WritableCellFormat;->setOrientation(Ljxl/format/Orientation;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Plus 90"

    const/4 v6, 0x1

    invoke-direct {v1, v6, v4, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v1, Ljxl/format/Orientation;->MINUS_90:Ljxl/format/Orientation;

    invoke-virtual {v0, v1}, Ljxl/write/WritableCellFormat;->setOrientation(Ljxl/format/Orientation;)V

    new-instance v1, Ljxl/write/Label;

    const-string v5, "Minus 90"

    const/4 v6, 0x2

    invoke-direct {v1, v6, v4, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x1c

    const-string v4, "Modified row height"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v1, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x1c

    const/16 v1, 0x1e0

    invoke-interface {v12, v0, v1}, Ljxl/write/WritableSheet;->setRowView(II)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x1d

    const-string v4, "Collapsed row"

    invoke-direct {v0, v5, v1, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x1d

    const/4 v1, 0x1

    invoke-interface {v12, v0, v1}, Ljxl/write/WritableSheet;->setRowView(IZ)V

    :try_start_0
    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x1e

    const-string v4, "Hyperlink to home page"

    invoke-direct {v0, v5, v1, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljava/net/URL;

    const-string v1, "http://www.andykhan.com/jexcelapi"

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljxl/write/WritableHyperlink;

    const/16 v27, 0x0

    const/16 v28, 0x1e

    const/16 v29, 0x8

    const/16 v30, 0x1f

    move-object/from16 v26, v1

    move-object/from16 v31, v0

    invoke-direct/range {v26 .. v31}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/net/URL;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V

    new-instance v1, Ljxl/write/WritableHyperlink;

    const/16 v27, 0x7

    const/16 v28, 0x1e

    const/16 v29, 0x9

    const/16 v30, 0x1f

    move-object/from16 v26, v1

    move-object/from16 v31, v0

    invoke-direct/range {v26 .. v31}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/net/URL;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V

    new-instance v0, Ljxl/write/Label;

    const-string v1, "File hyperlink to documentation"

    const/4 v4, 0x2

    invoke-direct {v0, v11, v4, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljava/io/File;

    const-string v1, "../jexcelapi/docs/index.html"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljxl/write/WritableHyperlink;

    const/16 v27, 0x0

    const/16 v28, 0x20

    const/16 v29, 0x8

    const/16 v30, 0x20

    const-string v32, "JExcelApi Documentation"

    move-object/from16 v26, v1

    move-object/from16 v31, v0

    invoke-direct/range {v26 .. v32}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/io/File;Ljava/lang/String;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V

    new-instance v0, Ljxl/write/WritableHyperlink;

    const/4 v4, 0x0

    const/16 v5, 0x22

    const/16 v6, 0x8

    const/16 v7, 0x22

    const-string v8, "Link to another cell"
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v9, 0x0

    const/16 v16, 0xb4

    const/16 v17, 0x1

    const/16 v18, 0xb5

    move-object v1, v0

    move v14, v2

    move v2, v4

    move v4, v3

    move v3, v5

    move v5, v4

    move v4, v6

    move v6, v5

    move v5, v7

    move v7, v6

    move-object v6, v8

    move v8, v7

    move-object/from16 v7, p1

    move v8, v9

    move/from16 v9, v16

    move-object/from16 v33, v10

    move/from16 v10, v17

    move/from16 v11, v18

    :try_start_1
    invoke-direct/range {v1 .. v11}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/lang/String;Ljxl/write/WritableSheet;IIII)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V

    new-instance v0, Ljava/io/File;

    const-string v1, "\\\\localhost\\file.txt"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljxl/write/WritableHyperlink;

    const/16 v27, 0x0

    const/16 v28, 0x24

    const/16 v29, 0x8

    const/16 v30, 0x24

    move-object/from16 v26, v1

    move-object/from16 v31, v0

    invoke-direct/range {v26 .. v31}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/io/File;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V

    new-instance v7, Ljava/net/URL;

    const-string v0, "http://www.amazon.co.uk/exec/obidos/ASIN/0571058086/qid=1099836249/sr=1-3/ref=sr_1_11_3/202-6017285-1620664"

    invoke-direct {v7, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    new-instance v0, Ljxl/write/WritableHyperlink;

    const/4 v3, 0x0

    const/16 v4, 0x26

    const/4 v5, 0x0

    const/16 v6, 0x26

    move-object v2, v0

    invoke-direct/range {v2 .. v7}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/net/URL;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addHyperlink(Ljxl/write/WritableHyperlink;)V
    :try_end_1
    .catch Ljava/net/MalformedURLException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    move v14, v2

    move-object/from16 v33, v10

    :goto_0
    sget-object v1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {v0}, Ljava/net/MalformedURLException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :goto_1
    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x23

    const/4 v2, 0x5

    const-string v3, "Merged cells"

    invoke-direct {v0, v2, v1, v3, v13}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    const/16 v3, 0x25

    invoke-interface {v12, v2, v1, v14, v3}, Ljxl/write/WritableSheet;->mergeCells(IIII)Ljxl/Range;

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x26

    const-string v3, "More merged cells"

    invoke-direct {v0, v2, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x26

    const/16 v1, 0x29

    invoke-interface {v12, v2, v0, v14, v1}, Ljxl/write/WritableSheet;->mergeCells(IIII)Ljxl/Range;

    move-result-object v0

    const/16 v1, 0x28

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->insertRow(I)V

    const/16 v1, 0x27

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->removeRow(I)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->unmergeCells(Ljxl/Range;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v1, Ljxl/format/Alignment;->CENTRE:Ljxl/format/Alignment;

    invoke-virtual {v0, v1}, Ljxl/write/WritableCellFormat;->setAlignment(Ljxl/format/Alignment;)V

    new-instance v1, Ljxl/write/Label;

    const/16 v3, 0x2a

    const-string v4, "Centred across merged cells"

    invoke-direct {v1, v2, v3, v4, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v1, 0xa

    invoke-interface {v12, v2, v3, v1, v3}, Ljxl/write/WritableSheet;->mergeCells(IIII)Ljxl/Range;

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0}, Ljxl/write/WritableCellFormat;-><init>()V

    sget-object v3, Ljxl/format/Border;->ALL:Ljxl/format/Border;

    sget-object v4, Ljxl/format/BorderLineStyle;->THIN:Ljxl/format/BorderLineStyle;

    invoke-virtual {v0, v3, v4}, Ljxl/write/WritableCellFormat;->setBorder(Ljxl/format/Border;Ljxl/format/BorderLineStyle;)V

    sget-object v3, Ljxl/format/Colour;->GRAY_25:Ljxl/format/Colour;

    invoke-virtual {v0, v3}, Ljxl/write/WritableCellFormat;->setBackground(Ljxl/format/Colour;)V

    new-instance v3, Ljxl/write/Label;

    const/16 v4, 0x2c

    const-string v5, "Merged with border"

    const/4 v6, 0x3

    invoke-direct {v3, v6, v4, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x2c

    const/16 v3, 0x2e

    const/4 v4, 0x4

    invoke-interface {v12, v6, v0, v4, v3}, Ljxl/write/WritableSheet;->mergeCells(IIII)Ljxl/Range;

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v3, Ljxl/write/WritableFont;->COURIER:Ljxl/write/WritableFont$FontName;

    invoke-direct {v0, v3, v1}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x31

    const-string v6, "Courier fonts"

    const/4 v7, 0x0

    invoke-direct {v0, v7, v5, v6, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v3, Ljxl/write/WritableFont;->TAHOMA:Ljxl/write/WritableFont$FontName;

    const/16 v5, 0xc

    invoke-direct {v0, v3, v5}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x32

    const-string v6, "Tahoma fonts"

    invoke-direct {v0, v7, v5, v6, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const-string v0, "Wingdings 2"

    invoke-static {v0}, Ljxl/write/WritableFont;->createFont(Ljava/lang/String;)Ljxl/write/WritableFont$FontName;

    move-result-object v0

    new-instance v3, Ljxl/write/WritableFont;

    invoke-direct {v3, v0, v1}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, v3}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v1, Ljxl/write/Label;

    const/16 v3, 0x33

    const-string v5, "Bespoke Windgdings 2"

    invoke-direct {v1, v7, v3, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljxl/write/WritableCellFormat;->setShrinkToFit(Z)V

    new-instance v1, Ljxl/write/Label;

    const/16 v3, 0x35

    const-string v5, "Shrunk to fit"

    const/4 v6, 0x3

    invoke-direct {v1, v6, v3, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x37

    const-string v3, "Some long wrapped text in a merged cell"

    move-object/from16 v5, v33

    invoke-direct {v0, v6, v1, v3, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v12, v6, v1, v4, v1}, Ljxl/write/WritableSheet;->mergeCells(IIII)Ljxl/Range;

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x39

    const-string v3, "A cell with a comment"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    new-instance v1, Ljxl/write/WritableCellFeatures;

    invoke-direct {v1}, Ljxl/write/WritableCellFeatures;-><init>()V

    const-string v3, "the cell comment"

    invoke-virtual {v1, v3}, Ljxl/write/WritableCellFeatures;->setComment(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x3b

    const-string v3, "A cell with a long comment"

    invoke-direct {v0, v5, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    new-instance v1, Ljxl/write/WritableCellFeatures;

    invoke-direct {v1}, Ljxl/write/WritableCellFeatures;-><init>()V

    const-wide/high16 v8, 0x4014000000000000L    # 5.0

    const-wide/high16 v10, 0x4018000000000000L    # 6.0

    const-string v7, "a very long cell comment indeed that won\'t fit inside a standard comment box, so a larger comment box is used instead"

    move-object v6, v1

    invoke-virtual/range {v6 .. v11}, Ljxl/write/WritableCellFeatures;->setComment(Ljava/lang/String;DD)V

    invoke-virtual {v0, v1}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, v15}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-virtual {v0, v4}, Ljxl/write/WritableCellFormat;->setIndentation(I)V

    new-instance v1, Ljxl/write/Label;

    const/16 v3, 0x3d

    const-string v5, "Some indented text"

    const/4 v6, 0x0

    invoke-direct {v1, v6, v3, v5, v0}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v12, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x3f

    const-string v3, "Data validation:  list"

    invoke-direct {v0, v6, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Blank;

    const/4 v3, 0x1

    invoke-direct {v0, v3, v1}, Ljxl/write/Blank;-><init>(II)V

    new-instance v1, Ljxl/write/WritableCellFeatures;

    invoke-direct {v1}, Ljxl/write/WritableCellFeatures;-><init>()V

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    const-string v5, "bagpuss"

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v5, "clangers"

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v5, "ivor the engine"

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v5, "noggin the nog"

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v1, v3}, Ljxl/write/WritableCellFeatures;->setDataValidationList(Ljava/util/Collection;)V

    invoke-virtual {v0, v1}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x40

    const-string v3, "Data validation:  number > 4.5"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Blank;

    const/4 v3, 0x1

    invoke-direct {v0, v3, v1}, Ljxl/write/Blank;-><init>(II)V

    new-instance v1, Ljxl/write/WritableCellFeatures;

    invoke-direct {v1}, Ljxl/write/WritableCellFeatures;-><init>()V

    const-wide/high16 v5, 0x4012000000000000L    # 4.5

    sget-object v3, Ljxl/write/WritableCellFeatures;->GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    invoke-virtual {v1, v5, v6, v3}, Ljxl/write/WritableCellFeatures;->setNumberValidation(DLjxl/biff/BaseCellFeatures$ValidationCondition;)V

    invoke-virtual {v0, v1}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v1, 0x41

    const-string v3, "Data validation:  named range"

    const/4 v5, 0x0

    invoke-direct {v0, v5, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v3, "tiger"

    invoke-direct {v0, v4, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v3, "sword"

    invoke-direct {v0, v2, v1, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v2, "honour"

    const/4 v3, 0x6

    invoke-direct {v0, v3, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v2, "company"

    const/4 v3, 0x7

    invoke-direct {v0, v3, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v2, "victory"

    invoke-direct {v0, v14, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v2, "fortress"

    const/16 v3, 0x9

    invoke-direct {v0, v3, v1, v2}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Blank;

    const/4 v2, 0x1

    invoke-direct {v0, v2, v1}, Ljxl/write/Blank;-><init>(II)V

    new-instance v1, Ljxl/write/WritableCellFeatures;

    invoke-direct {v1}, Ljxl/write/WritableCellFeatures;-><init>()V

    const-string v2, "validation_range"

    invoke-virtual {v1, v2}, Ljxl/write/WritableCellFeatures;->setDataValidationRange(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v12, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x27

    const/16 v1, 0x2d

    const/4 v2, 0x0

    invoke-interface {v12, v0, v1, v2}, Ljxl/write/WritableSheet;->setRowGroup(IIZ)V

    return-void
.end method

.method private writeLabelsSheet(Ljxl/write/WritableSheet;)V
    .locals 12

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljxl/SheetSettings;->setProtected(Z)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const-string v2, "jxl"

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setPassword(Ljava/lang/String;)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const/4 v2, 0x5

    invoke-virtual {v0, v2}, Ljxl/SheetSettings;->setVerticalFreeze(I)V

    invoke-interface {p1}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v0

    const/16 v3, 0x1f4

    invoke-virtual {v0, v3}, Ljxl/SheetSettings;->setDefaultRowHeight(I)V

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v3, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    const/16 v4, 0xc

    invoke-direct {v0, v3, v4}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    invoke-virtual {v0, v1}, Ljxl/write/WritableFont;->setItalic(Z)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    new-instance v0, Ljxl/CellView;

    invoke-direct {v0}, Ljxl/CellView;-><init>()V

    const/16 v4, 0x1900

    invoke-virtual {v0, v4}, Ljxl/CellView;->setSize(I)V

    invoke-virtual {v0, v3}, Ljxl/CellView;->setFormat(Ljxl/format/CellFormat;)V

    const/4 v4, 0x0

    invoke-interface {p1, v4, v0}, Ljxl/write/WritableSheet;->setColumnView(ILjxl/CellView;)V

    const/16 v0, 0xf

    invoke-interface {p1, v1, v0}, Ljxl/write/WritableSheet;->setColumnView(II)V

    move v0, v4

    :goto_0
    const-string v5, "Distinct label number "

    const-string v6, "Common Label"

    const/16 v7, 0x3d

    if-ge v0, v7, :cond_0

    new-instance v7, Ljxl/write/Label;

    invoke-direct {v7, v4, v0, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    new-instance v6, Ljxl/write/Label;

    new-instance v8, Ljava/lang/StringBuffer;

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v8, v0}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v8}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v1, v0, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v7}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1, v6}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    new-instance v0, Ljxl/write/Label;

    invoke-direct {v0, v4, v7, v6, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    new-instance v8, Ljxl/write/Label;

    const-string v9, "1-1234567890"

    invoke-direct {v8, v1, v7, v9, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    new-instance v9, Ljxl/write/Label;

    const/4 v10, 0x2

    const-string v11, "2-1234567890"

    invoke-direct {v9, v10, v7, v11, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x3e

    :goto_1
    const/16 v3, 0xc8

    if-ge v0, v3, :cond_1

    new-instance v3, Ljxl/write/Label;

    invoke-direct {v3, v4, v0, v6}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    new-instance v7, Ljxl/write/Label;

    new-instance v8, Ljava/lang/StringBuffer;

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v8, v0}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v8}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v1, v0, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {p1, v7}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    new-instance v0, Ljxl/write/WritableFont;

    sget-object v3, Ljxl/write/WritableFont;->TIMES:Ljxl/write/WritableFont$FontName;

    const/16 v5, 0xa

    sget-object v6, Ljxl/write/WritableFont;->BOLD:Ljxl/write/WritableFont$BoldStyle;

    invoke-direct {v0, v3, v5, v6}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    sget-object v3, Ljxl/format/Colour;->RED:Ljxl/format/Colour;

    invoke-virtual {v0, v3}, Ljxl/write/WritableFont;->setColour(Ljxl/format/Colour;)V

    new-instance v3, Ljxl/write/WritableCellFormat;

    invoke-direct {v3, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-virtual {v3, v1}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0xcd

    const-string v6, "Different format"

    invoke-direct {v0, v4, v5, v6, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const-string v4, "A column for autosizing"

    invoke-direct {v0, v2, v10, v4, v3}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/4 v3, 0x4

    const-string v4, "Another label, longer this time and in a different font"

    invoke-direct {v0, v2, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {p1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/CellView;

    invoke-direct {v0}, Ljxl/CellView;-><init>()V

    invoke-virtual {v0, v1}, Ljxl/CellView;->setAutosize(Z)V

    invoke-interface {p1, v2, v0}, Ljxl/write/WritableSheet;->setColumnView(ILjxl/CellView;)V

    return-void
.end method

.method private writeNumberFormatSheet(Ljxl/write/WritableSheet;)V
    .locals 23

    move-object/from16 v0, p1

    new-instance v1, Ljxl/write/WritableCellFormat;

    sget-object v2, Ljxl/write/WritableWorkbook;->ARIAL_10_PT:Ljxl/write/WritableFont;

    invoke-direct {v1, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljxl/write/WritableCellFormat;->setWrap(Z)V

    const/4 v3, 0x0

    const/16 v4, 0x14

    invoke-interface {v0, v3, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v5, 0x4

    invoke-interface {v0, v5, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v6, 0x5

    invoke-interface {v0, v6, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    const/4 v7, 0x6

    invoke-interface {v0, v7, v4}, Ljxl/write/WritableSheet;->setColumnView(II)V

    new-instance v4, Ljxl/write/Label;

    const-string v8, "+/- Pi - default format"

    invoke-direct {v4, v3, v3, v8, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const-wide v8, 0x400921fb54411744L    # 3.1415926535

    invoke-direct {v4, v2, v3, v8, v9}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v8, 0x2

    const-wide v9, -0x3ff6de04abbee8bcL    # -3.1415926535

    invoke-direct {v4, v8, v3, v9, v10}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v9, "+/- Pi - integer format"

    invoke-direct {v4, v3, v2, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v9, Ljxl/write/NumberFormats;->INTEGER:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v9, Ljxl/write/Number;

    const/4 v11, 0x1

    const/4 v12, 0x1

    const-wide v13, 0x400921fb54411744L    # 3.1415926535

    move-object v10, v9

    move-object v15, v4

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v9, Ljxl/write/Number;

    const/4 v11, 0x2

    const-wide v13, -0x3ff6de04abbee8bcL    # -3.1415926535

    move-object v10, v9

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v9, "+/- Pi - float 2dps"

    invoke-direct {v4, v3, v8, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v9, Ljxl/write/NumberFormats;->FLOAT:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v15, Ljxl/write/Number;

    const/4 v11, 0x1

    const/4 v12, 0x2

    const-wide v13, 0x400921fb54411744L    # 3.1415926535

    move-object v10, v15

    move-object v8, v15

    move-object v15, v4

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v8, Ljxl/write/Number;

    const/4 v11, 0x2

    const-wide v13, -0x3ff6de04abbee8bcL    # -3.1415926535

    move-object v10, v8

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/4 v8, 0x3

    const-string v10, "+/- Pi - custom 3dps"

    invoke-direct {v4, v3, v8, v10, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v10, "#.###"

    invoke-direct {v4, v10}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v10, Ljxl/write/WritableCellFormat;

    invoke-direct {v10, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x1

    const/16 v19, 0x3

    const-wide v20, 0x400921fb54411744L    # 3.1415926535

    move-object/from16 v17, v4

    move-object/from16 v22, v10

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x2

    const-wide v20, -0x3ff6de04abbee8bcL    # -3.1415926535

    move-object/from16 v17, v4

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "+/- Pi - custom &3.14"

    invoke-direct {v4, v3, v5, v10, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v10, "&#.00"

    invoke-direct {v4, v10}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v10, Ljxl/write/WritableCellFormat;

    invoke-direct {v10, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x1

    const/16 v19, 0x4

    const-wide v20, 0x400921fb54411744L    # 3.1415926535

    move-object/from16 v17, v4

    move-object/from16 v22, v10

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x2

    const-wide v20, -0x3ff6de04abbee8bcL    # -3.1415926535

    move-object/from16 v17, v4

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "+/- Pi - custom Text #.### Text"

    invoke-direct {v4, v3, v6, v10, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v10, "Text#.####Text"

    invoke-direct {v4, v10}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v10, Ljxl/write/WritableCellFormat;

    invoke-direct {v10, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x1

    const/16 v19, 0x5

    const-wide v20, 0x400921fb54411744L    # 3.1415926535

    move-object/from16 v17, v4

    move-object/from16 v22, v10

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/16 v18, 0x2

    const-wide v20, -0x3ff6de04abbee8bcL    # -3.1415926535

    move-object/from16 v17, v4

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "+/- Bilko default format"

    invoke-direct {v4, v5, v3, v10}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const-wide v10, 0x416cb11160000000L    # 1.5042699E7

    invoke-direct {v4, v6, v3, v10, v11}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const-wide v10, -0x3e934eeea0000000L    # -1.5042699E7

    invoke-direct {v4, v7, v3, v10, v11}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v10, "+/- Bilko float format"

    invoke-direct {v4, v5, v2, v10}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    invoke-direct {v4, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v9, Ljxl/write/Number;

    const/16 v18, 0x5

    const/16 v19, 0x1

    const-wide v20, 0x416cb11160000000L    # 1.5042699E7

    move-object/from16 v17, v9

    move-object/from16 v22, v4

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v9, Ljxl/write/Number;

    const/16 v18, 0x6

    const-wide v20, -0x3e934eeea0000000L    # -1.5042699E7

    move-object/from16 v17, v9

    invoke-direct/range {v17 .. v22}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v9, "+/- Thousands separator"

    const/4 v10, 0x2

    invoke-direct {v4, v5, v10, v9}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v9, Ljxl/write/NumberFormats;->THOUSANDS_INTEGER:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v9, Ljxl/write/Number;

    const/4 v12, 0x5

    const/4 v13, 0x2

    const-wide v14, 0x416cb11160000000L    # 1.5042699E7

    move-object v11, v9

    move-object/from16 v16, v4

    invoke-direct/range {v11 .. v16}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v9, Ljxl/write/Number;

    const/4 v12, 0x6

    const-wide v14, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v11, v9

    invoke-direct/range {v11 .. v16}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v9}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v9, "+/- Accounting red - added 0.01"

    invoke-direct {v4, v5, v8, v9}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v8, Ljxl/write/NumberFormats;->ACCOUNTING_RED_FLOAT:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v8}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v8, Ljxl/write/Number;

    const/4 v11, 0x5

    const/4 v12, 0x3

    const-wide v13, 0x416cb1116051eb85L    # 1.504269901E7

    move-object v10, v8

    move-object v15, v4

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v8, Ljxl/write/Number;

    const/4 v11, 0x6

    const-wide v13, -0x3e934eee9fae147bL    # -1.504269901E7

    move-object v10, v8

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v8, "+/- Percent"

    invoke-direct {v4, v5, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v8, Ljxl/write/NumberFormats;->PERCENT_INTEGER:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v8}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v8, Ljxl/write/Number;

    const/4 v10, 0x5

    const/4 v11, 0x4

    const-wide v12, 0x416cb11160000000L    # 1.5042699E7

    move-object v9, v8

    move-object v14, v4

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v8, Ljxl/write/Number;

    const/4 v10, 0x6

    const-wide v12, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v9, v8

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v8, "+/- Exponential - 2dps"

    invoke-direct {v4, v5, v6, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/WritableCellFormat;

    sget-object v6, Ljxl/write/NumberFormats;->EXPONENTIAL:Ljxl/biff/DisplayFormat;

    invoke-direct {v4, v6}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v6, Ljxl/write/Number;

    const/4 v10, 0x5

    const/4 v11, 0x5

    const-wide v12, 0x416cb11160000000L    # 1.5042699E7

    move-object v9, v6

    move-object v14, v4

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v6}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v6, Ljxl/write/Number;

    const/4 v10, 0x6

    const-wide v12, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v9, v6

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v6}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const-string v6, "+/- Custom exponentional - 3dps"

    invoke-direct {v4, v5, v7, v6, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v6, "0.000E0"

    invoke-direct {v4, v6}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v6, Ljxl/write/WritableCellFormat;

    invoke-direct {v6, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v8, 0x5

    const/4 v9, 0x6

    const-wide v10, 0x416cb11160000000L    # 1.5042699E7

    move-object v7, v4

    move-object v12, v6

    invoke-direct/range {v7 .. v12}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v8, 0x6

    const-wide v10, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v7, v4

    invoke-direct/range {v7 .. v12}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/4 v6, 0x7

    const-string v7, "Custom neg brackets"

    invoke-direct {v4, v5, v6, v7, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v6, "#,##0;(#,##0)"

    invoke-direct {v4, v6}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v6, Ljxl/write/WritableCellFormat;

    invoke-direct {v6, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v8, 0x5

    const/4 v9, 0x7

    const-wide v10, 0x416cb11160000000L    # 1.5042699E7

    move-object v7, v4

    move-object v12, v6

    invoke-direct/range {v7 .. v12}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v8, 0x6

    const-wide v10, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v7, v4

    invoke-direct/range {v7 .. v12}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/16 v6, 0x8

    const-string v7, "Custom neg brackets 2"

    invoke-direct {v4, v5, v6, v7, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v7, "#,##0;(#,##0)a"

    invoke-direct {v4, v7}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v7, Ljxl/write/WritableCellFormat;

    invoke-direct {v7, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v9, 0x5

    const/16 v10, 0x8

    const-wide v11, 0x416cb11160000000L    # 1.5042699E7

    move-object v8, v4

    move-object v13, v7

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v9, 0x6

    const-wide v11, -0x3e934eeea0000000L    # -1.5042699E7

    move-object v8, v4

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/16 v7, 0x9

    const-string v8, "Custom percent"

    invoke-direct {v4, v5, v7, v8, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/NumberFormat;

    const-string v7, "0.0%"

    invoke-direct {v4, v7}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v4, Ljxl/write/Number;

    const/4 v9, 0x5

    const/16 v10, 0x9

    const-wide v11, 0x400921fb53c8d4f1L    # 3.14159265

    move-object v8, v4

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/16 v7, 0xa

    const-string v8, "Boolean - TRUE"

    invoke-direct {v4, v3, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Boolean;

    invoke-direct {v4, v2, v7, v2}, Ljxl/write/Boolean;-><init>(IIZ)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Label;

    const/16 v7, 0xb

    const-string v8, "Boolean - FALSE"

    invoke-direct {v4, v3, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v4, Ljxl/write/Boolean;

    invoke-direct {v4, v2, v7, v3}, Ljxl/write/Boolean;-><init>(IIZ)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v4, 0xc

    const-string v7, "A hidden cell->"

    invoke-direct {v2, v3, v4, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Number;

    sget-object v13, Ljxl/write/WritableWorkbook;->HIDDEN_STYLE:Ljxl/write/WritableCellFormat;

    const/4 v9, 0x1

    const/16 v10, 0xc

    const-wide/high16 v11, 0x4031000000000000L    # 17.0

    move-object v8, v2

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v4, 0x13

    const-string v7, "Currency formats"

    invoke-direct {v2, v5, v4, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v4, 0x15

    const-string v7, "UK Pound"

    invoke-direct {v2, v5, v4, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    sget-object v4, Ljxl/write/NumberFormat;->COMPLEX_FORMAT:Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;

    const-string v7, "\u00a3 #,###.00"

    invoke-direct {v2, v7, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/4 v9, 0x5

    const/16 v10, 0x15

    const-wide v11, 0x40c81c8000000000L    # 12345.0

    move-object v8, v2

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v7, 0x16

    const-string v8, "Euro 1"

    invoke-direct {v2, v5, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    const-string v7, "[$\u20ac-2] #,###.00"

    invoke-direct {v2, v7, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/16 v10, 0x16

    move-object v8, v2

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v7, 0x17

    const-string v8, "Euro 2"

    invoke-direct {v2, v5, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    const-string v7, "#,###.00[$\u20ac-1]"

    invoke-direct {v2, v7, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/16 v10, 0x17

    move-object v8, v2

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v7, 0x18

    const-string v8, "Dollar"

    invoke-direct {v2, v5, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    const-string v7, "[$$-409] #,###.00"

    invoke-direct {v2, v7, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/16 v10, 0x18

    move-object v8, v2

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v7, 0x19

    const-string v8, "Japanese Yen"

    invoke-direct {v2, v5, v7, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    const-string v8, "[$\u00a5-411] #,###.00"

    invoke-direct {v2, v8, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v14, Ljxl/write/WritableCellFormat;

    invoke-direct {v14, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/4 v10, 0x5

    const/16 v11, 0x19

    const-wide v12, 0x40c81c8000000000L    # 12345.0

    move-object v9, v2

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v8, 0x1e

    const-string v9, "Fraction formats"

    invoke-direct {v2, v5, v8, v9}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v8, 0x20

    const-string v9, "One digit fraction format"

    invoke-direct {v2, v5, v8, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v15, Ljxl/write/WritableCellFormat;

    sget-object v2, Ljxl/write/NumberFormats;->FRACTION_ONE_DIGIT:Ljxl/biff/DisplayFormat;

    invoke-direct {v15, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/4 v11, 0x5

    const/16 v12, 0x20

    const-wide v13, 0x4009765a9a804966L    # 3.18279

    move-object v10, v2

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v8, 0x21

    const-string v9, "Two digit fraction format"

    invoke-direct {v2, v5, v8, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v15, Ljxl/write/WritableCellFormat;

    sget-object v2, Ljxl/write/NumberFormats;->FRACTION_TWO_DIGITS:Ljxl/biff/DisplayFormat;

    invoke-direct {v15, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/16 v12, 0x21

    move-object v10, v2

    invoke-direct/range {v10 .. v15}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v8, 0x22

    const-string v9, "Three digit fraction format (improper)"

    invoke-direct {v2, v5, v8, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/NumberFormat;

    const-string v8, "???/???"

    invoke-direct {v2, v8, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v14, Ljxl/write/WritableCellFormat;

    invoke-direct {v14, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v2, Ljxl/write/Number;

    const/4 v10, 0x5

    const/16 v11, 0x22

    const-wide v12, 0x4009839ffd60e94fL    # 3.18927

    move-object v9, v2

    invoke-direct/range {v9 .. v14}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v2, Ljxl/write/Label;

    const/16 v8, 0x23

    const-string v9, "Three digit fraction format (proper)"

    invoke-direct {v2, v5, v8, v9, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v0, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v1, Ljxl/write/NumberFormat;

    const-string v2, "# ???/???"

    invoke-direct {v1, v2, v4}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;Ljxl/write/biff/NumberFormatRecord$NonValidatingFormat;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    new-instance v1, Ljxl/write/Number;

    const/4 v9, 0x5

    const/16 v10, 0x23

    const-wide v11, 0x4009839ffd60e94fL    # 3.18927

    move-object v8, v1

    invoke-direct/range {v8 .. v13}, Ljxl/write/Number;-><init>(IIDLjxl/format/CellFormat;)V

    invoke-interface {v0, v1}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    move v1, v3

    :goto_0
    const/16 v2, 0x64

    if-ge v1, v2, :cond_1

    move v2, v6

    :goto_1
    const/16 v4, 0x6c

    if-ge v2, v4, :cond_0

    new-instance v4, Ljxl/write/Number;

    add-int v5, v2, v1

    int-to-double v8, v5

    invoke-direct {v4, v2, v1, v8, v9}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/16 v1, 0x65

    :goto_2
    const/16 v2, 0xbb8

    if-ge v1, v2, :cond_3

    move v2, v3

    :goto_3
    if-ge v2, v7, :cond_2

    new-instance v4, Ljxl/write/Number;

    add-int v5, v2, v1

    int-to-double v5, v5

    invoke-direct {v4, v2, v1, v5, v6}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v0, v4}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_3
    return-void
.end method


# virtual methods
.method public write()V
    .locals 24

    move-object/from16 v0, p0

    new-instance v1, Ljxl/WorkbookSettings;

    invoke-direct {v1}, Ljxl/WorkbookSettings;-><init>()V

    new-instance v2, Ljava/util/Locale;

    const-string v3, "en"

    const-string v4, "EN"

    invoke-direct {v2, v3, v4}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljxl/WorkbookSettings;->setLocale(Ljava/util/Locale;)V

    new-instance v2, Ljava/io/File;

    iget-object v3, v0, Ljxl/demo/Write;->filename:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2, v1}, Ljxl/Workbook;->createWorkbook(Ljava/io/File;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;

    move-result-object v1

    iput-object v1, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v2, "Number Formats"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v1

    iget-object v2, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v4, "Date Formats"

    const/4 v5, 0x1

    invoke-virtual {v2, v4, v5}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v2

    iget-object v4, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v5, "Label Formats"

    const/4 v6, 0x2

    invoke-virtual {v4, v5, v6}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v4

    iget-object v5, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v6, "Borders"

    const/4 v7, 0x3

    invoke-virtual {v5, v6, v7}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v5

    iget-object v6, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v7, "Labels"

    const/4 v15, 0x4

    invoke-virtual {v6, v7, v15}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v6

    iget-object v7, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v8, "Formulas"

    const/4 v9, 0x5

    invoke-virtual {v7, v8, v9}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v7

    iget-object v8, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v9, "Images"

    const/4 v10, 0x6

    invoke-virtual {v8, v9, v10}, Ljxl/write/WritableWorkbook;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object v14

    iget-object v8, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    sget-object v9, Ljxl/format/Colour;->LIME:Ljxl/format/Colour;

    const/16 v10, 0xff

    invoke-virtual {v8, v9, v10, v3, v3}, Ljxl/write/WritableWorkbook;->setColourRGB(Ljxl/format/Colour;III)V

    iget-object v8, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v9, "namedrange"

    const/4 v11, 0x1

    const/16 v12, 0xb

    const/4 v13, 0x5

    const/16 v3, 0xe

    move-object v10, v5

    move-object/from16 v23, v14

    move v14, v3

    invoke-virtual/range {v8 .. v14}, Ljxl/write/WritableWorkbook;->addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V

    iget-object v3, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v8, "validation_range"

    const/4 v10, 0x4

    const/16 v11, 0x41

    const/16 v12, 0x9

    const/16 v13, 0x41

    move-object v14, v7

    move-object v7, v3

    move-object v9, v4

    invoke-virtual/range {v7 .. v13}, Ljxl/write/WritableWorkbook;->addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V

    iget-object v3, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    const-string v17, "formulavalue"

    const/16 v19, 0x1

    const/16 v20, 0x2d

    const/16 v21, 0x1

    const/16 v22, 0x2d

    move-object/from16 v16, v3

    move-object/from16 v18, v14

    invoke-virtual/range {v16 .. v22}, Ljxl/write/WritableWorkbook;->addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V

    invoke-interface {v6}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v3

    const/16 v7, 0xf

    const/16 v8, 0x23

    invoke-virtual {v3, v15, v15, v7, v8}, Ljxl/SheetSettings;->setPrintArea(IIII)V

    invoke-direct {v0, v4}, Ljxl/demo/Write;->writeLabelFormatSheet(Ljxl/write/WritableSheet;)V

    invoke-direct {v0, v1}, Ljxl/demo/Write;->writeNumberFormatSheet(Ljxl/write/WritableSheet;)V

    invoke-direct {v0, v2}, Ljxl/demo/Write;->writeDateFormatSheet(Ljxl/write/WritableSheet;)V

    invoke-direct {v0, v5}, Ljxl/demo/Write;->writeBordersSheet(Ljxl/write/WritableSheet;)V

    invoke-direct {v0, v6}, Ljxl/demo/Write;->writeLabelsSheet(Ljxl/write/WritableSheet;)V

    invoke-direct {v0, v14}, Ljxl/demo/Write;->writeFormulaSheet(Ljxl/write/WritableSheet;)V

    move-object/from16 v1, v23

    invoke-direct {v0, v1}, Ljxl/demo/Write;->writeImageSheet(Ljxl/write/WritableSheet;)V

    iget-object v1, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    invoke-virtual {v1}, Ljxl/write/WritableWorkbook;->write()V

    iget-object v1, v0, Ljxl/demo/Write;->workbook:Ljxl/write/WritableWorkbook;

    invoke-virtual {v1}, Ljxl/write/WritableWorkbook;->close()V

    return-void
.end method
