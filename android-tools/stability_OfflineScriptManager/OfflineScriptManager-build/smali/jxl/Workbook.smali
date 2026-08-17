.class public abstract Ljxl/Workbook;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final VERSION:Ljava/lang/String; = "2.6.10"


# direct methods
.method protected constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static createWorkbook(Ljava/io/File;)Ljxl/write/WritableWorkbook;
    .locals 1

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-static {p0, v0}, Ljxl/Workbook;->createWorkbook(Ljava/io/File;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;

    move-result-object p0

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/File;Ljxl/Workbook;)Ljxl/write/WritableWorkbook;
    .locals 1

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-static {p0, p1, v0}, Ljxl/Workbook;->createWorkbook(Ljava/io/File;Ljxl/Workbook;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;

    move-result-object p0

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/File;Ljxl/Workbook;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;
    .locals 2

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Ljxl/write/biff/WritableWorkbookImpl;

    const/4 v1, 0x1

    invoke-direct {p0, v0, p1, v1, p2}, Ljxl/write/biff/WritableWorkbookImpl;-><init>(Ljava/io/OutputStream;Ljxl/Workbook;ZLjxl/WorkbookSettings;)V

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/File;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;
    .locals 2

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance p0, Ljxl/write/biff/WritableWorkbookImpl;

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1, p1}, Ljxl/write/biff/WritableWorkbookImpl;-><init>(Ljava/io/OutputStream;ZLjxl/WorkbookSettings;)V

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/OutputStream;)Ljxl/write/WritableWorkbook;
    .locals 1

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-static {p0, v0}, Ljxl/Workbook;->createWorkbook(Ljava/io/OutputStream;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;

    move-result-object p0

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/OutputStream;Ljxl/Workbook;)Ljxl/write/WritableWorkbook;
    .locals 1

    move-object v0, p1

    check-cast v0, Ljxl/read/biff/WorkbookParser;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getSettings()Ljxl/WorkbookSettings;

    move-result-object v0

    invoke-static {p0, p1, v0}, Ljxl/Workbook;->createWorkbook(Ljava/io/OutputStream;Ljxl/Workbook;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;

    move-result-object p0

    return-object p0
.end method

.method public static createWorkbook(Ljava/io/OutputStream;Ljxl/Workbook;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;
    .locals 2

    new-instance v0, Ljxl/write/biff/WritableWorkbookImpl;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1, p2}, Ljxl/write/biff/WritableWorkbookImpl;-><init>(Ljava/io/OutputStream;Ljxl/Workbook;ZLjxl/WorkbookSettings;)V

    return-object v0
.end method

.method public static createWorkbook(Ljava/io/OutputStream;Ljxl/WorkbookSettings;)Ljxl/write/WritableWorkbook;
    .locals 2

    new-instance v0, Ljxl/write/biff/WritableWorkbookImpl;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1, p1}, Ljxl/write/biff/WritableWorkbookImpl;-><init>(Ljava/io/OutputStream;ZLjxl/WorkbookSettings;)V

    return-object v0
.end method

.method public static getVersion()Ljava/lang/String;
    .locals 1

    const-string v0, "2.6.10"

    return-object v0
.end method

.method public static getWorkbook(Ljava/io/File;)Ljxl/Workbook;
    .locals 1

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-static {p0, v0}, Ljxl/Workbook;->getWorkbook(Ljava/io/File;Ljxl/WorkbookSettings;)Ljxl/Workbook;

    move-result-object p0

    return-object p0
.end method

.method public static getWorkbook(Ljava/io/File;Ljxl/WorkbookSettings;)Ljxl/Workbook;
    .locals 1

    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    :try_start_0
    new-instance p0, Ljxl/read/biff/File;

    invoke-direct {p0, v0, p1}, Ljxl/read/biff/File;-><init>(Ljava/io/InputStream;Ljxl/WorkbookSettings;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljxl/read/biff/BiffException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    new-instance v0, Ljxl/read/biff/WorkbookParser;

    invoke-direct {v0, p0, p1}, Ljxl/read/biff/WorkbookParser;-><init>(Ljxl/read/biff/File;Ljxl/WorkbookSettings;)V

    invoke-virtual {v0}, Ljxl/Workbook;->parse()V

    return-object v0

    :catch_0
    move-exception p0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    throw p0

    :catch_1
    move-exception p0

    invoke-virtual {v0}, Ljava/io/FileInputStream;->close()V

    throw p0
.end method

.method public static getWorkbook(Ljava/io/InputStream;)Ljxl/Workbook;
    .locals 1

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-static {p0, v0}, Ljxl/Workbook;->getWorkbook(Ljava/io/InputStream;Ljxl/WorkbookSettings;)Ljxl/Workbook;

    move-result-object p0

    return-object p0
.end method

.method public static getWorkbook(Ljava/io/InputStream;Ljxl/WorkbookSettings;)Ljxl/Workbook;
    .locals 1

    new-instance v0, Ljxl/read/biff/File;

    invoke-direct {v0, p0, p1}, Ljxl/read/biff/File;-><init>(Ljava/io/InputStream;Ljxl/WorkbookSettings;)V

    new-instance p0, Ljxl/read/biff/WorkbookParser;

    invoke-direct {p0, v0, p1}, Ljxl/read/biff/WorkbookParser;-><init>(Ljxl/read/biff/File;Ljxl/WorkbookSettings;)V

    invoke-virtual {p0}, Ljxl/Workbook;->parse()V

    return-object p0
.end method


# virtual methods
.method public abstract close()V
.end method

.method public abstract findByName(Ljava/lang/String;)[Ljxl/Range;
.end method

.method public abstract findCellByName(Ljava/lang/String;)Ljxl/Cell;
.end method

.method public abstract getCell(Ljava/lang/String;)Ljxl/Cell;
.end method

.method public abstract getNumberOfSheets()I
.end method

.method public abstract getRangeNames()[Ljava/lang/String;
.end method

.method public abstract getSheet(I)Ljxl/Sheet;
.end method

.method public abstract getSheet(Ljava/lang/String;)Ljxl/Sheet;
.end method

.method public abstract getSheetNames()[Ljava/lang/String;
.end method

.method public abstract getSheets()[Ljxl/Sheet;
.end method

.method public abstract isProtected()Z
.end method

.method protected abstract parse()V
.end method
