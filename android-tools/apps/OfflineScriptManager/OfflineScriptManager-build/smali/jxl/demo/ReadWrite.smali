.class public Ljxl/demo/ReadWrite;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$demo$ReadWrite:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private inputWorkbook:Ljava/io/File;

.field private outputWorkbook:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/demo/ReadWrite;->class$jxl$demo$ReadWrite:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.demo.ReadWrite"

    invoke-static {v0}, Ljxl/demo/ReadWrite;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/demo/ReadWrite;->class$jxl$demo$ReadWrite:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljxl/demo/ReadWrite;->inputWorkbook:Ljava/io/File;

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljxl/demo/ReadWrite;->outputWorkbook:Ljava/io/File;

    sget-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    const-string v1, "jxl.nowarnings"

    invoke-static {v1}, Ljava/lang/Boolean;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->setSuppressWarnings(Z)V

    sget-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v2, "Input file:  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    sget-object p1, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    const-string v1, "Output file:  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1

    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/NoClassDefFoundError;

    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private modify(Ljxl/write/WritableWorkbook;)V
    .locals 21

    sget-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    const-string v1, "Modifying..."

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    const-string v0, "modified"

    move-object/from16 v1, p1

    invoke-virtual {v1, v0}, Ljxl/write/WritableWorkbook;->getSheet(Ljava/lang/String;)Ljxl/write/WritableSheet;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x3

    invoke-interface {v1, v2, v3}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v4, Ljxl/write/WritableFont;

    sget-object v11, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    sget-object v5, Ljxl/write/WritableFont;->BOLD:Ljxl/write/WritableFont$BoldStyle;

    const/16 v12, 0xa

    invoke-direct {v4, v11, v12, v5}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;)V

    new-instance v5, Ljxl/write/WritableCellFormat;

    invoke-direct {v5, v4}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/4 v4, 0x4

    invoke-interface {v1, v2, v4}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v13, Ljxl/write/WritableFont;

    sget-object v8, Ljxl/write/WritableFont;->NO_BOLD:Ljxl/write/WritableFont$BoldStyle;

    sget-object v10, Ljxl/format/UnderlineStyle;->SINGLE:Ljxl/format/UnderlineStyle;

    const/16 v7, 0xa

    const/4 v9, 0x0

    move-object v5, v13

    move-object v6, v11

    invoke-direct/range {v5 .. v10}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;)V

    new-instance v5, Ljxl/write/WritableCellFormat;

    invoke-direct {v5, v13}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/4 v5, 0x5

    invoke-interface {v1, v2, v5}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v6, Ljxl/write/WritableFont;

    invoke-direct {v6, v11, v12}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;I)V

    new-instance v7, Ljxl/write/WritableCellFormat;

    invoke-direct {v7, v6}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    invoke-interface {v0, v7}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/4 v6, 0x6

    invoke-interface {v1, v2, v6}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v7

    sget-object v8, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-ne v7, v8, :cond_0

    check-cast v0, Ljxl/write/Label;

    new-instance v7, Ljava/lang/StringBuffer;

    invoke-direct {v7}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v0}, Ljxl/write/biff/LabelRecord;->getString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v9, " - mod"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v7}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    :cond_0
    const/16 v7, 0x9

    invoke-interface {v1, v2, v7}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v9, Ljxl/write/NumberFormat;

    const-string v10, "#.0000000"

    invoke-direct {v9, v10}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v10, Ljxl/write/WritableCellFormat;

    invoke-direct {v10, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    invoke-interface {v0, v10}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    invoke-interface {v1, v2, v12}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v9, Ljxl/write/NumberFormat;

    const-string v10, "0.####E0"

    invoke-direct {v9, v10}, Ljxl/write/NumberFormat;-><init>(Ljava/lang/String;)V

    new-instance v10, Ljxl/write/WritableCellFormat;

    invoke-direct {v10, v9}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    invoke-interface {v0, v10}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/16 v0, 0xb

    invoke-interface {v1, v2, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v9

    sget-object v10, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    invoke-interface {v9, v10}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/16 v9, 0xc

    invoke-interface {v1, v2, v9}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v9

    invoke-interface {v9}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v10

    sget-object v11, Ljxl/CellType;->NUMBER:Ljxl/CellType;

    if-ne v10, v11, :cond_1

    check-cast v9, Ljxl/write/Number;

    const-wide/high16 v12, 0x4045000000000000L    # 42.0

    invoke-virtual {v9, v12, v13}, Ljxl/write/Number;->setValue(D)V

    :cond_1
    const/16 v9, 0xd

    invoke-interface {v1, v2, v9}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v9

    invoke-interface {v9}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v10

    if-ne v10, v11, :cond_2

    check-cast v9, Ljxl/write/Number;

    invoke-virtual {v9}, Ljxl/write/biff/NumberRecord;->getValue()D

    move-result-wide v12

    const-wide v14, 0x3fb999999999999aL    # 0.1

    add-double/2addr v12, v14

    invoke-virtual {v9, v12, v13}, Ljxl/write/Number;->setValue(D)V

    :cond_2
    const/16 v9, 0x10

    invoke-interface {v1, v2, v9}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v10

    new-instance v12, Ljxl/write/DateFormat;

    const-string v13, "dd MMM yyyy HH:mm:ss"

    invoke-direct {v12, v13}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    new-instance v13, Ljxl/write/WritableCellFormat;

    invoke-direct {v13, v12}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    invoke-interface {v10, v13}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/16 v10, 0x11

    invoke-interface {v1, v2, v10}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v10

    new-instance v12, Ljxl/write/WritableCellFormat;

    sget-object v13, Ljxl/write/DateFormats;->FORMAT9:Ljxl/biff/DisplayFormat;

    invoke-direct {v12, v13}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    invoke-interface {v10, v12}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    const/16 v10, 0x12

    invoke-interface {v1, v2, v10}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v10

    invoke-interface {v10}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v13

    sget-object v14, Ljxl/CellType;->DATE:Ljxl/CellType;

    if-ne v13, v14, :cond_3

    check-cast v10, Ljxl/write/DateTime;

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v20

    const/16 v14, 0x7ce

    const/4 v15, 0x1

    const/16 v16, 0x12

    const/16 v17, 0xb

    const/16 v18, 0x17

    const/16 v19, 0x1c

    move-object/from16 v13, v20

    invoke-virtual/range {v13 .. v19}, Ljava/util/Calendar;->set(IIIIII)V

    invoke-virtual/range {v20 .. v20}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v13

    invoke-virtual {v10, v13}, Ljxl/write/DateTime;->setDate(Ljava/util/Date;)V

    :cond_3
    const/16 v10, 0x16

    invoke-interface {v1, v2, v10}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v10

    invoke-interface {v10}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v13

    if-ne v13, v11, :cond_4

    check-cast v10, Ljxl/write/Number;

    const-wide v13, 0x401b333333333333L    # 6.8

    invoke-virtual {v10, v13, v14}, Ljxl/write/Number;->setValue(D)V

    :cond_4
    const/16 v10, 0x1d

    invoke-interface {v1, v2, v10}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v10

    invoke-interface {v10}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v11

    if-ne v11, v8, :cond_5

    check-cast v10, Ljxl/write/Label;

    const-string v8, "Modified string contents"

    invoke-virtual {v10, v8}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    :cond_5
    const/16 v8, 0x22

    invoke-interface {v1, v8}, Ljxl/write/WritableSheet;->insertRow(I)V

    const/16 v8, 0x26

    invoke-interface {v1, v8}, Ljxl/write/WritableSheet;->removeRow(I)V

    invoke-interface {v1, v7}, Ljxl/write/WritableSheet;->insertColumn(I)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->removeColumn(I)V

    const/16 v0, 0x2b

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->removeRow(I)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->insertRow(I)V

    invoke-interface {v1}, Ljxl/write/WritableSheet;->getWritableHyperlinks()[Ljxl/write/WritableHyperlink;

    move-result-object v8

    const/4 v10, 0x0

    move v11, v10

    :goto_0
    array-length v0, v8

    const/16 v13, 0x27

    if-ge v11, v0, :cond_a

    aget-object v0, v8, v11

    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getColumn()I

    move-result v14

    if-ne v14, v2, :cond_6

    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getRow()I

    move-result v14

    if-ne v14, v13, :cond_6

    :try_start_0
    new-instance v13, Ljava/net/URL;

    const-string v14, "http://www.andykhan.com/jexcelapi/index.html"

    invoke-direct {v13, v14}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v13}, Ljxl/write/WritableHyperlink;->setURL(Ljava/net/URL;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    sget-object v13, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    invoke-virtual {v0}, Ljava/net/MalformedURLException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v13, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_6
    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getColumn()I

    move-result v13

    if-ne v13, v2, :cond_7

    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getRow()I

    move-result v13

    const/16 v14, 0x28

    if-ne v13, v14, :cond_7

    new-instance v13, Ljava/io/File;

    const-string v14, "../jexcelapi/docs/overview-summary.html"

    invoke-direct {v13, v14}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :goto_1
    invoke-virtual {v0, v13}, Ljxl/write/WritableHyperlink;->setFile(Ljava/io/File;)V

    goto :goto_2

    :cond_7
    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getColumn()I

    move-result v13

    if-ne v13, v2, :cond_8

    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getRow()I

    move-result v13

    const/16 v14, 0x29

    if-ne v13, v14, :cond_8

    new-instance v13, Ljava/io/File;

    const-string v14, "d:/home/jexcelapi/docs/jxl/package-summary.html"

    invoke-direct {v13, v14}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_1

    :cond_8
    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getColumn()I

    move-result v13

    if-ne v13, v2, :cond_9

    invoke-virtual {v0}, Ljxl/write/biff/HyperlinkRecord;->getRow()I

    move-result v13

    const/16 v14, 0x2c

    if-ne v13, v14, :cond_9

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->removeHyperlink(Ljxl/write/WritableHyperlink;)V

    :cond_9
    :goto_2
    add-int/lit8 v11, v11, 0x1

    goto :goto_0

    :cond_a
    const/16 v0, 0x1e

    invoke-interface {v1, v5, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    new-instance v5, Ljxl/write/WritableCellFormat;

    invoke-interface {v0}, Ljxl/Cell;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v8

    invoke-direct {v5, v8}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/format/CellFormat;)V

    sget-object v8, Ljxl/format/Colour;->RED:Ljxl/format/Colour;

    invoke-virtual {v5, v8}, Ljxl/write/WritableCellFormat;->setBackground(Ljxl/format/Colour;)V

    invoke-interface {v0, v5}, Ljxl/write/WritableCell;->setCellFormat(Ljxl/format/CellFormat;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x31

    const-string v8, "Modified merged cells"

    invoke-direct {v0, v10, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x46

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    check-cast v0, Ljxl/write/Number;

    const-wide/high16 v14, 0x4022000000000000L    # 9.0

    invoke-virtual {v0, v14, v15}, Ljxl/write/Number;->setValue(D)V

    const/16 v0, 0x47

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    check-cast v0, Ljxl/write/Number;

    const-wide/high16 v14, 0x4024000000000000L    # 10.0

    invoke-virtual {v0, v14, v15}, Ljxl/write/Number;->setValue(D)V

    const/16 v0, 0x49

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    check-cast v0, Ljxl/write/Number;

    const-wide/high16 v14, 0x4010000000000000L    # 4.0

    invoke-virtual {v0, v14, v15}, Ljxl/write/Number;->setValue(D)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x50

    const-string v8, "ROUND(COS(original!B10),2)"

    invoke-direct {v0, v2, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x53

    const-string v8, "value1+value2"

    invoke-direct {v0, v2, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const/16 v5, 0x54

    const-string v8, "AVERAGE(value1,value1*4,value2)"

    invoke-direct {v0, v2, v5, v8}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x58

    const-string v8, "Some copied cells"

    invoke-direct {v0, v10, v5, v8, v12}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x59

    const-string v8, "Number from B9"

    invoke-direct {v0, v10, v5, v8}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2, v7}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v5}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v5, 0x5a

    const-string v7, "Label from B4 (modified format)"

    invoke-direct {v0, v10, v5, v7}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2, v3}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v5}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x5b

    const-string v5, "Date from B17"

    invoke-direct {v0, v10, v3, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2, v9}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v3}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x5c

    const-string v5, "Boolean from E16"

    invoke-direct {v0, v10, v3, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0xf

    invoke-interface {v1, v4, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v3}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x5d

    const-string v4, "URL from B40"

    invoke-direct {v0, v10, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2, v13}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v3}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    move v0, v10

    :goto_3
    if-ge v0, v6, :cond_b

    new-instance v3, Ljxl/write/Number;

    add-int/lit8 v4, v0, 0x5e

    add-int/lit8 v5, v0, 0x1

    int-to-double v7, v5

    int-to-double v11, v0

    const-wide/high16 v13, 0x4020000000000000L    # 8.0

    div-double/2addr v11, v13

    add-double/2addr v7, v11

    invoke-direct {v3, v2, v4, v7, v8}, Ljxl/write/Number;-><init>(IID)V

    invoke-interface {v1, v3}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    move v0, v5

    goto :goto_3

    :cond_b
    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x64

    const-string v4, "Formula from B27"

    invoke-direct {v0, v10, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x1a

    invoke-interface {v1, v2, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v3}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x65

    const-string v4, "A brand new formula"

    invoke-direct {v0, v10, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Formula;

    const-string v4, "SUM(B94:B96)"

    invoke-direct {v0, v2, v3, v4}, Ljxl/write/Formula;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v4, 0x66

    const-string v5, "A copy of it"

    invoke-direct {v0, v10, v4, v5}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2, v3}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0, v2, v4}, Ljxl/write/WritableCell;->copyTo(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    invoke-interface {v1, v2}, Ljxl/write/WritableSheet;->getImage(I)Ljxl/write/WritableImage;

    move-result-object v0

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->removeImage(Ljxl/write/WritableImage;)V

    new-instance v0, Ljxl/write/WritableImage;

    const-wide/high16 v12, 0x3ff0000000000000L    # 1.0

    const-wide/high16 v14, 0x405d000000000000L    # 116.0

    const-wide/high16 v16, 0x4000000000000000L    # 2.0

    const-wide/high16 v18, 0x4022000000000000L    # 9.0

    new-instance v3, Ljava/io/File;

    const-string v4, "resources/littlemoretonhall.png"

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v11, v0

    move-object/from16 v20, v3

    invoke-direct/range {v11 .. v20}, Ljxl/write/WritableImage;-><init>(DDDDLjava/io/File;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addImage(Ljxl/write/WritableImage;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x97

    const-string v4, "Added drop down validation"

    invoke-direct {v0, v10, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Blank;

    invoke-direct {v0, v2, v3}, Ljxl/write/Blank;-><init>(II)V

    new-instance v3, Ljxl/write/WritableCellFeatures;

    invoke-direct {v3}, Ljxl/write/WritableCellFeatures;-><init>()V

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    const-string v5, "The Fellowship of the Ring"

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v5, "The Two Towers"

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v5, "The Return of the King"

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3, v4}, Ljxl/write/WritableCellFeatures;->setDataValidationList(Ljava/util/Collection;)V

    invoke-virtual {v0, v3}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Label;

    const/16 v3, 0x98

    const-string v4, "Added number validation 2.718 < x < 3.142"

    invoke-direct {v0, v10, v3, v4}, Ljxl/write/Label;-><init>(IILjava/lang/String;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    new-instance v0, Ljxl/write/Blank;

    invoke-direct {v0, v2, v3}, Ljxl/write/Blank;-><init>(II)V

    new-instance v2, Ljxl/write/WritableCellFeatures;

    invoke-direct {v2}, Ljxl/write/WritableCellFeatures;-><init>()V

    const-wide v5, 0x4005be76c8b43958L    # 2.718

    const-wide v7, 0x400922d0e5604189L    # 3.142

    sget-object v9, Ljxl/write/WritableCellFeatures;->BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    move-object v4, v2

    invoke-virtual/range {v4 .. v9}, Ljxl/write/WritableCellFeatures;->setNumberValidation(DDLjxl/biff/BaseCellFeatures$ValidationCondition;)V

    invoke-virtual {v0, v2}, Ljxl/write/biff/CellValue;->setCellFeatures(Ljxl/write/WritableCellFeatures;)V

    invoke-interface {v1, v0}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V

    const/16 v0, 0x9c

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    check-cast v0, Ljxl/write/Label;

    const-string v2, "Label text modified"

    invoke-virtual {v0, v2}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    const/16 v0, 0x9d

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/write/WritableCell;->getWritableCellFeatures()Ljxl/write/WritableCellFeatures;

    move-result-object v0

    const-string v2, "modified comment text"

    invoke-virtual {v0, v2}, Ljxl/write/WritableCellFeatures;->setComment(Ljava/lang/String;)V

    const/16 v0, 0x9e

    invoke-interface {v1, v10, v0}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v0

    invoke-interface {v0}, Ljxl/write/WritableCell;->getWritableCellFeatures()Ljxl/write/WritableCellFeatures;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/write/WritableCellFeatures;->removeComment()V

    return-void
.end method


# virtual methods
.method public readWrite()V
    .locals 3

    sget-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    const-string v1, "Reading..."

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    iget-object v0, p0, Ljxl/demo/ReadWrite;->inputWorkbook:Ljava/io/File;

    invoke-static {v0}, Ljxl/Workbook;->getWorkbook(Ljava/io/File;)Ljxl/Workbook;

    move-result-object v0

    sget-object v1, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    const-string v2, "Copying..."

    invoke-virtual {v1, v2}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    iget-object v1, p0, Ljxl/demo/ReadWrite;->outputWorkbook:Ljava/io/File;

    invoke-static {v1, v0}, Ljxl/Workbook;->createWorkbook(Ljava/io/File;Ljxl/Workbook;)Ljxl/write/WritableWorkbook;

    move-result-object v0

    iget-object v1, p0, Ljxl/demo/ReadWrite;->inputWorkbook:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "jxlrwtest.xls"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, v0}, Ljxl/demo/ReadWrite;->modify(Ljxl/write/WritableWorkbook;)V

    :cond_0
    invoke-virtual {v0}, Ljxl/write/WritableWorkbook;->write()V

    invoke-virtual {v0}, Ljxl/write/WritableWorkbook;->close()V

    sget-object v0, Ljxl/demo/ReadWrite;->logger:Ljxl/common/Logger;

    const-string v1, "Done"

    invoke-virtual {v0, v1}, Ljxl/common/Logger;->info(Ljava/lang/Object;)V

    return-void
.end method
