.class public abstract Ljxl/write/WritableWorkbook;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final ARIAL_10_PT:Ljxl/write/WritableFont;

.field public static final HIDDEN_STYLE:Ljxl/write/WritableCellFormat;

.field public static final HYPERLINK_FONT:Ljxl/write/WritableFont;

.field public static final HYPERLINK_STYLE:Ljxl/write/WritableCellFormat;

.field public static final NORMAL_STYLE:Ljxl/write/WritableCellFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Ljxl/write/WritableFont;

    sget-object v2, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    invoke-direct {v0, v2}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    sput-object v0, Ljxl/write/WritableWorkbook;->ARIAL_10_PT:Ljxl/write/WritableFont;

    new-instance v8, Ljxl/write/WritableFont;

    sget-object v4, Ljxl/write/WritableFont;->NO_BOLD:Ljxl/write/WritableFont$BoldStyle;

    sget-object v6, Ljxl/format/UnderlineStyle;->SINGLE:Ljxl/format/UnderlineStyle;

    sget-object v7, Ljxl/format/Colour;->BLUE:Ljxl/format/Colour;

    const/16 v3, 0xa

    const/4 v5, 0x0

    move-object v1, v8

    invoke-direct/range {v1 .. v7}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;ILjxl/write/WritableFont$BoldStyle;ZLjxl/format/UnderlineStyle;Ljxl/format/Colour;)V

    sput-object v8, Ljxl/write/WritableWorkbook;->HYPERLINK_FONT:Ljxl/write/WritableFont;

    new-instance v1, Ljxl/write/WritableCellFormat;

    sget-object v2, Ljxl/write/NumberFormats;->DEFAULT:Ljxl/biff/DisplayFormat;

    invoke-direct {v1, v0, v2}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;Ljxl/biff/DisplayFormat;)V

    sput-object v1, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    new-instance v0, Ljxl/write/WritableCellFormat;

    invoke-direct {v0, v8}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    sput-object v0, Ljxl/write/WritableWorkbook;->HYPERLINK_STYLE:Ljxl/write/WritableCellFormat;

    new-instance v0, Ljxl/write/WritableCellFormat;

    new-instance v1, Ljxl/write/DateFormat;

    const-string v2, ";;;"

    invoke-direct {v1, v2}, Ljxl/write/DateFormat;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/biff/DisplayFormat;)V

    sput-object v0, Ljxl/write/WritableWorkbook;->HIDDEN_STYLE:Ljxl/write/WritableCellFormat;

    return-void
.end method

.method protected constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V
.end method

.method public abstract close()V
.end method

.method public copy(Ljxl/Workbook;)V
    .locals 0

    return-void
.end method

.method public abstract copySheet(ILjava/lang/String;I)V
.end method

.method public abstract copySheet(Ljava/lang/String;Ljava/lang/String;I)V
.end method

.method public abstract createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;
.end method

.method public abstract findByName(Ljava/lang/String;)[Ljxl/Range;
.end method

.method public abstract findCellByName(Ljava/lang/String;)Ljxl/write/WritableCell;
.end method

.method public abstract getNumberOfSheets()I
.end method

.method public abstract getRangeNames()[Ljava/lang/String;
.end method

.method public abstract getSheet(I)Ljxl/write/WritableSheet;
.end method

.method public abstract getSheet(Ljava/lang/String;)Ljxl/write/WritableSheet;
.end method

.method public abstract getSheetNames()[Ljava/lang/String;
.end method

.method public abstract getSheets()[Ljxl/write/WritableSheet;
.end method

.method public abstract getWritableCell(Ljava/lang/String;)Ljxl/write/WritableCell;
.end method

.method public abstract importSheet(Ljava/lang/String;ILjxl/Sheet;)Ljxl/write/WritableSheet;
.end method

.method public abstract moveSheet(II)Ljxl/write/WritableSheet;
.end method

.method public abstract removeRangeName(Ljava/lang/String;)V
.end method

.method public abstract removeSheet(I)V
.end method

.method public abstract setColourRGB(Ljxl/format/Colour;III)V
.end method

.method public abstract setOutputFile(Ljava/io/File;)V
.end method

.method public abstract setProtected(Z)V
.end method

.method public abstract write()V
.end method
