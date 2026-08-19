.class public Ljxl/write/biff/WritableWorkbookImpl;
.super Ljxl/write/WritableWorkbook;
.source ""

# interfaces
.implements Ljxl/biff/formula/ExternalSheet;
.implements Ljxl/biff/WorkbookMethods;


# static fields
.field private static SYNCHRONIZER:Ljava/lang/Object;

.field static synthetic class$jxl$write$biff$WritableWorkbookImpl:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private addInFunctionNames:[Ljava/lang/String;

.field private buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

.field private closeStream:Z

.field private containsMacros:Z

.field private countryRecord:Ljxl/write/biff/CountryRecord;

.field private drawingGroup:Ljxl/biff/drawing/DrawingGroup;

.field private externSheet:Ljxl/write/biff/ExternalSheetRecord;

.field private fonts:Ljxl/biff/Fonts;

.field private formatRecords:Ljxl/biff/FormattingRecords;

.field private nameRecords:Ljava/util/HashMap;

.field private names:Ljava/util/ArrayList;

.field private outputFile:Ljxl/write/biff/File;

.field private rcirCells:Ljava/util/ArrayList;

.field private settings:Ljxl/WorkbookSettings;

.field private sharedStrings:Ljxl/write/biff/SharedStrings;

.field private sheets:Ljava/util/ArrayList;

.field private styles:Ljxl/write/biff/Styles;

.field private supbooks:Ljava/util/ArrayList;

.field private wbProtected:Z

.field private xctRecords:[Ljxl/biff/XCTRecord;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/WritableWorkbookImpl;->class$jxl$write$biff$WritableWorkbookImpl:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.WritableWorkbookImpl"

    invoke-static {v0}, Ljxl/write/biff/WritableWorkbookImpl;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/WritableWorkbookImpl;->class$jxl$write$biff$WritableWorkbookImpl:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Ljxl/write/biff/WritableWorkbookImpl;->SYNCHRONIZER:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;Ljxl/Workbook;ZLjxl/WorkbookSettings;)V
    .locals 5

    invoke-direct {p0}, Ljxl/write/WritableWorkbook;-><init>()V

    move-object v0, p2

    check-cast v0, Ljxl/read/biff/WorkbookParser;

    sget-object v1, Ljxl/write/biff/WritableWorkbookImpl;->SYNCHRONIZER:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    sget-object v2, Ljxl/write/WritableWorkbook;->ARIAL_10_PT:Ljxl/write/WritableFont;

    invoke-virtual {v2}, Ljxl/biff/FontRecord;->uninitialize()V

    sget-object v2, Ljxl/write/WritableWorkbook;->HYPERLINK_FONT:Ljxl/write/WritableFont;

    invoke-virtual {v2}, Ljxl/biff/FontRecord;->uninitialize()V

    sget-object v2, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {v2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object v2, Ljxl/write/WritableWorkbook;->HYPERLINK_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {v2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object v2, Ljxl/write/WritableWorkbook;->HIDDEN_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {v2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object v2, Ljxl/write/biff/DateRecord;->defaultDateFormat:Ljxl/write/WritableCellFormat;

    invoke-virtual {v2}, Ljxl/biff/XFRecord;->uninitialize()V

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iput-boolean p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->closeStream:Z

    new-instance p3, Ljava/util/ArrayList;

    invoke-direct {p3}, Ljava/util/ArrayList;-><init>()V

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    new-instance p3, Ljxl/write/biff/SharedStrings;

    invoke-direct {p3}, Ljxl/write/biff/SharedStrings;-><init>()V

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->sharedStrings:Ljxl/write/biff/SharedStrings;

    new-instance p3, Ljava/util/HashMap;

    invoke-direct {p3}, Ljava/util/HashMap;-><init>()V

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getFonts()Ljxl/biff/Fonts;

    move-result-object p3

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->fonts:Ljxl/biff/Fonts;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getFormattingRecords()Ljxl/biff/FormattingRecords;

    move-result-object p3

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    const/4 p3, 0x0

    iput-boolean p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->wbProtected:Z

    iput-object p4, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    new-instance v1, Ljxl/write/biff/Styles;

    invoke-direct {v1}, Ljxl/write/biff/Styles;-><init>()V

    iput-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->styles:Ljxl/write/biff/Styles;

    new-instance v1, Ljxl/write/biff/File;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getCompoundFile()Ljxl/read/biff/CompoundFile;

    move-result-object v2

    invoke-direct {v1, p1, p4, v2}, Ljxl/write/biff/File;-><init>(Ljava/io/OutputStream;Ljxl/WorkbookSettings;Ljxl/read/biff/CompoundFile;)V

    iput-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iput-boolean p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->containsMacros:Z

    invoke-virtual {p4}, Ljxl/WorkbookSettings;->getPropertySetsDisabled()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->containsMacros()Z

    move-result p1

    iput-boolean p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->containsMacros:Z

    :cond_0
    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getCountryRecord()Ljxl/read/biff/CountryRecord;

    move-result-object p1

    if-eqz p1, :cond_1

    new-instance p1, Ljxl/write/biff/CountryRecord;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getCountryRecord()Ljxl/read/biff/CountryRecord;

    move-result-object p4

    invoke-direct {p1, p4}, Ljxl/write/biff/CountryRecord;-><init>(Ljxl/read/biff/CountryRecord;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->countryRecord:Ljxl/write/biff/CountryRecord;

    :cond_1
    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getAddInFunctionNames()[Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->addInFunctionNames:[Ljava/lang/String;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getXCTRecords()[Ljxl/biff/XCTRecord;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->xctRecords:[Ljxl/biff/XCTRecord;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getExternalSheetRecord()Ljxl/read/biff/ExternalSheetRecord;

    move-result-object p1

    if-eqz p1, :cond_5

    new-instance p1, Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getExternalSheetRecord()Ljxl/read/biff/ExternalSheetRecord;

    move-result-object p4

    invoke-direct {p1, p4}, Ljxl/write/biff/ExternalSheetRecord;-><init>(Ljxl/read/biff/ExternalSheetRecord;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getSupbookRecords()[Ljxl/read/biff/SupbookRecord;

    move-result-object p1

    new-instance p4, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {p4, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p4, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    move p4, p3

    :goto_0
    array-length v1, p1

    if-ge p4, v1, :cond_5

    aget-object v1, p1, p4

    invoke-virtual {v1}, Ljxl/read/biff/SupbookRecord;->getType()Ljxl/read/biff/SupbookRecord$Type;

    move-result-object v2

    sget-object v3, Ljxl/read/biff/SupbookRecord;->INTERNAL:Ljxl/read/biff/SupbookRecord$Type;

    if-eq v2, v3, :cond_3

    invoke-virtual {v1}, Ljxl/read/biff/SupbookRecord;->getType()Ljxl/read/biff/SupbookRecord$Type;

    move-result-object v2

    sget-object v3, Ljxl/read/biff/SupbookRecord;->EXTERNAL:Ljxl/read/biff/SupbookRecord$Type;

    if-ne v2, v3, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v1}, Ljxl/read/biff/SupbookRecord;->getType()Ljxl/read/biff/SupbookRecord$Type;

    move-result-object v1

    sget-object v2, Ljxl/read/biff/SupbookRecord;->ADDIN:Ljxl/read/biff/SupbookRecord$Type;

    if-eq v1, v2, :cond_4

    sget-object v1, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    const-string v2, "unsupported supbook type - ignoring"

    invoke-virtual {v1, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_2

    :cond_3
    :goto_1
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    new-instance v3, Ljxl/write/biff/SupbookRecord;

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v3, v1, v4}, Ljxl/write/biff/SupbookRecord;-><init>(Ljxl/read/biff/SupbookRecord;Ljxl/WorkbookSettings;)V

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_4
    :goto_2
    add-int/lit8 p4, p4, 0x1

    goto :goto_0

    :cond_5
    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object p1

    if-eqz p1, :cond_6

    new-instance p1, Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object p4

    invoke-direct {p1, p4}, Ljxl/biff/drawing/DrawingGroup;-><init>(Ljxl/biff/drawing/DrawingGroup;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    :cond_6
    iget-boolean p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->containsMacros:Z

    if-eqz p1, :cond_7

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object p1

    if-eqz p1, :cond_7

    new-instance p1, Ljxl/write/biff/ButtonPropertySetRecord;

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getButtonPropertySet()Ljxl/read/biff/ButtonPropertySetRecord;

    move-result-object p4

    invoke-direct {p1, p4}, Ljxl/write/biff/ButtonPropertySetRecord;-><init>(Ljxl/read/biff/ButtonPropertySetRecord;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    :cond_7
    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1}, Ljxl/WorkbookSettings;->getNamesDisabled()Z

    move-result p1

    if-nez p1, :cond_9

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getNameRecords()[Ljxl/read/biff/NameRecord;

    move-result-object p1

    new-instance p4, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {p4, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p4, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    :goto_3
    array-length p4, p1

    if-ge p3, p4, :cond_9

    aget-object p4, p1, p3

    invoke-virtual {p4}, Ljxl/read/biff/NameRecord;->isBiff8()Z

    move-result p4

    if-eqz p4, :cond_8

    new-instance p4, Ljxl/write/biff/NameRecord;

    aget-object v1, p1, p3

    invoke-direct {p4, v1, p3}, Ljxl/write/biff/NameRecord;-><init>(Ljxl/read/biff/NameRecord;I)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v1, p4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {p4}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v2, v1, p4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_4

    :cond_8
    sget-object p4, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    const-string v1, "Cannot copy Biff7 name records - ignoring"

    invoke-virtual {p4, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_4
    add-int/lit8 p3, p3, 0x1

    goto :goto_3

    :cond_9
    invoke-direct {p0, p2}, Ljxl/write/biff/WritableWorkbookImpl;->copyWorkbook(Ljxl/Workbook;)V

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    if-eqz p1, :cond_a

    invoke-virtual {v0}, Ljxl/read/biff/WorkbookParser;->getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljxl/biff/drawing/DrawingGroup;->updateData(Ljxl/biff/drawing/DrawingGroup;)V

    :cond_a
    return-void

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public constructor <init>(Ljava/io/OutputStream;ZLjxl/WorkbookSettings;)V
    .locals 2

    invoke-direct {p0}, Ljxl/write/WritableWorkbook;-><init>()V

    new-instance v0, Ljxl/write/biff/File;

    const/4 v1, 0x0

    invoke-direct {v0, p1, p3, v1}, Ljxl/write/biff/File;-><init>(Ljava/io/OutputStream;Ljxl/WorkbookSettings;Ljxl/read/biff/CompoundFile;)V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    new-instance p1, Ljxl/write/biff/SharedStrings;

    invoke-direct {p1}, Ljxl/write/biff/SharedStrings;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->sharedStrings:Ljxl/write/biff/SharedStrings;

    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    iput-boolean p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->closeStream:Z

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->wbProtected:Z

    iput-boolean p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->containsMacros:Z

    iput-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    new-instance p1, Ljxl/write/biff/Styles;

    invoke-direct {p1}, Ljxl/write/biff/Styles;-><init>()V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->styles:Ljxl/write/biff/Styles;

    sget-object p1, Ljxl/write/biff/WritableWorkbookImpl;->SYNCHRONIZER:Ljava/lang/Object;

    monitor-enter p1

    :try_start_0
    sget-object p2, Ljxl/write/WritableWorkbook;->ARIAL_10_PT:Ljxl/write/WritableFont;

    invoke-virtual {p2}, Ljxl/biff/FontRecord;->uninitialize()V

    sget-object p2, Ljxl/write/WritableWorkbook;->HYPERLINK_FONT:Ljxl/write/WritableFont;

    invoke-virtual {p2}, Ljxl/biff/FontRecord;->uninitialize()V

    sget-object p2, Ljxl/write/WritableWorkbook;->NORMAL_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {p2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object p2, Ljxl/write/WritableWorkbook;->HYPERLINK_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {p2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object p2, Ljxl/write/WritableWorkbook;->HIDDEN_STYLE:Ljxl/write/WritableCellFormat;

    invoke-virtual {p2}, Ljxl/biff/XFRecord;->uninitialize()V

    sget-object p2, Ljxl/write/biff/DateRecord;->defaultDateFormat:Ljxl/write/WritableCellFormat;

    invoke-virtual {p2}, Ljxl/biff/XFRecord;->uninitialize()V

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    new-instance p1, Ljxl/write/biff/WritableFonts;

    invoke-direct {p1, p0}, Ljxl/write/biff/WritableFonts;-><init>(Ljxl/write/biff/WritableWorkbookImpl;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->fonts:Ljxl/biff/Fonts;

    new-instance p1, Ljxl/write/biff/WritableFormattingRecords;

    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->fonts:Ljxl/biff/Fonts;

    iget-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->styles:Ljxl/write/biff/Styles;

    invoke-direct {p1, p2, p3}, Ljxl/write/biff/WritableFormattingRecords;-><init>(Ljxl/biff/Fonts;Ljxl/write/biff/Styles;)V

    iput-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    return-void

    :catchall_0
    move-exception p2

    :try_start_1
    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p2
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

.method private copyWorkbook(Ljxl/Workbook;)V
    .locals 5

    invoke-virtual {p1}, Ljxl/Workbook;->getNumberOfSheets()I

    move-result v0

    invoke-virtual {p1}, Ljxl/Workbook;->isProtected()Z

    move-result v1

    iput-boolean v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->wbProtected:Z

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_0

    invoke-virtual {p1, v2}, Ljxl/Workbook;->getSheet(I)Ljxl/Sheet;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4, v2, v1}, Ljxl/write/biff/WritableWorkbookImpl;->createSheet(Ljava/lang/String;IZ)Ljxl/write/WritableSheet;

    move-result-object v4

    check-cast v4, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4, v3}, Ljxl/write/biff/WritableSheetImpl;->copy(Ljxl/Sheet;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method private createSheet(Ljava/lang/String;IZ)Ljxl/write/WritableSheet;
    .locals 8

    new-instance v7, Ljxl/write/biff/WritableSheetImpl;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->sharedStrings:Ljxl/write/biff/SharedStrings;

    iget-object v5, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    move-object v0, v7

    move-object v1, p1

    move-object v6, p0

    invoke-direct/range {v0 .. v6}, Ljxl/write/biff/WritableSheetImpl;-><init>(Ljava/lang/String;Ljxl/write/biff/File;Ljxl/biff/FormattingRecords;Ljxl/write/biff/SharedStrings;Ljxl/WorkbookSettings;Ljxl/write/biff/WritableWorkbookImpl;)V

    const/4 p1, 0x0

    if-gtz p2, :cond_0

    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {p2, p1, v7}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    move p2, p1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-le p2, v0, :cond_1

    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p2, v7}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    :goto_0
    if-eqz p3, :cond_2

    iget-object p3, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-eqz p3, :cond_2

    invoke-virtual {p3, p2}, Ljxl/write/biff/ExternalSheetRecord;->sheetInserted(I)V

    :cond_2
    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    if-lez p2, :cond_3

    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {p1}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object p2

    sget-object p3, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne p2, p3, :cond_3

    iget-object p2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    invoke-virtual {p1, p2}, Ljxl/write/biff/SupbookRecord;->adjustInternal(I)V

    :cond_3
    return-object v7
.end method

.method private getInternalSheetIndex(Ljava/lang/String;)I
    .locals 3

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getSheetNames()[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v1, -0x1

    :goto_1
    return v1
.end method

.method private rationalize()V
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v0}, Ljxl/biff/FormattingRecords;->rationalizeFonts()Ljxl/biff/IndexMapping;

    move-result-object v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1}, Ljxl/biff/FormattingRecords;->rationalizeDisplayFormats()Ljxl/biff/IndexMapping;

    move-result-object v1

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v2, v0, v1}, Ljxl/biff/FormattingRecords;->rationalize(Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;)Ljxl/biff/IndexMapping;

    move-result-object v2

    const/4 v3, 0x0

    :goto_0
    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge v3, v4, :cond_0

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4, v2, v0, v1}, Ljxl/write/biff/WritableSheetImpl;->rationalize(Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method addDrawing(Ljxl/biff/drawing/DrawingGroupObject;)V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/biff/drawing/DrawingGroup;

    sget-object v1, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    invoke-direct {v0, v1}, Ljxl/biff/drawing/DrawingGroup;-><init>(Ljxl/biff/drawing/Origin;)V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {v0, p1}, Ljxl/biff/drawing/DrawingGroup;->add(Ljxl/biff/drawing/DrawingGroupObject;)V

    return-void
.end method

.method public addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V
    .locals 8

    const/4 v7, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-virtual/range {v0 .. v7}, Ljxl/write/biff/WritableWorkbookImpl;->addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIIIZ)V

    return-void
.end method

.method addNameArea(Ljava/lang/String;Ljxl/write/WritableSheet;IIIIZ)V
    .locals 11

    move-object v0, p0

    iget-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    :cond_0
    invoke-interface {p2}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v5

    new-instance v1, Ljxl/write/biff/NameRecord;

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    move-object v2, v1

    move-object v3, p1

    move v6, p4

    move/from16 v7, p6

    move v8, p3

    move/from16 v9, p5

    move/from16 v10, p7

    invoke-direct/range {v2 .. v10}, Ljxl/write/biff/NameRecord;-><init>(Ljava/lang/String;IIIIIIZ)V

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method addNameArea(Ljxl/biff/BuiltInName;Ljxl/write/WritableSheet;IIIIIIIIZ)V
    .locals 15

    move-object v0, p0

    iget-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    :cond_0
    invoke-interface/range {p2 .. p2}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getInternalSheetIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface/range {p2 .. p2}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v5

    new-instance v1, Ljxl/write/biff/NameRecord;

    move-object v2, v1

    move-object/from16 v3, p1

    move/from16 v6, p8

    move/from16 v7, p10

    move/from16 v8, p7

    move/from16 v9, p9

    move/from16 v10, p4

    move/from16 v11, p6

    move/from16 v12, p3

    move/from16 v13, p5

    move/from16 v14, p11

    invoke-direct/range {v2 .. v14}, Ljxl/write/biff/NameRecord;-><init>(Ljxl/biff/BuiltInName;IIIIIIIIIIZ)V

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v2, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method addNameArea(Ljxl/biff/BuiltInName;Ljxl/write/WritableSheet;IIIIZ)V
    .locals 11

    move-object v0, p0

    iget-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-nez v1, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    :cond_0
    invoke-interface {p2}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getInternalSheetIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {p2}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v5

    new-instance v1, Ljxl/write/biff/NameRecord;

    move-object v2, v1

    move-object v3, p1

    move v6, p4

    move/from16 v7, p6

    move v8, p3

    move/from16 v9, p5

    move/from16 v10, p7

    invoke-direct/range {v2 .. v10}, Ljxl/write/biff/NameRecord;-><init>(Ljxl/biff/BuiltInName;IIIIIIZ)V

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, v0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method addRCIRCell(Ljxl/write/biff/CellValue;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public close()V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iget-boolean v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->closeStream:Z

    invoke-virtual {v0, v1}, Ljxl/write/biff/File;->close(Z)V

    return-void
.end method

.method columnInserted(Ljxl/write/biff/WritableSheetImpl;I)V
    .locals 3

    invoke-virtual {p1}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/CellValue;

    invoke-virtual {v2, p1, v0, p2}, Ljxl/write/biff/CellValue;->columnInserted(Ljxl/Sheet;II)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/NameRecord;

    invoke-virtual {v1, v0, p2}, Ljxl/write/biff/NameRecord;->columnInserted(II)V

    goto :goto_1

    :cond_1
    return-void
.end method

.method columnRemoved(Ljxl/write/biff/WritableSheetImpl;I)V
    .locals 4

    invoke-virtual {p1}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/CellValue;

    invoke-virtual {v2, p1, v0, p2}, Ljxl/write/biff/CellValue;->columnRemoved(Ljxl/Sheet;II)V

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/NameRecord;

    invoke-virtual {v2, v0, p2}, Ljxl/write/biff/NameRecord;->columnRemoved(II)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljxl/write/biff/NameRecord;

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    move-result v0

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v2, "Could not remove name "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p2}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v0, p2}, Ljxl/common/Assert;->verify(ZLjava/lang/String;)V

    goto :goto_2

    :cond_3
    return-void
.end method

.method public copySheet(ILjava/lang/String;I)V
    .locals 0

    invoke-virtual {p0, p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    invoke-virtual {p0, p2, p3}, Ljxl/write/biff/WritableWorkbookImpl;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object p2

    check-cast p2, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {p2, p1}, Ljxl/write/biff/WritableSheetImpl;->copy(Ljxl/write/WritableSheet;)V

    return-void
.end method

.method public copySheet(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0

    invoke-virtual {p0, p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(Ljava/lang/String;)Ljxl/write/WritableSheet;

    move-result-object p1

    invoke-virtual {p0, p2, p3}, Ljxl/write/biff/WritableWorkbookImpl;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object p2

    check-cast p2, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {p2, p1}, Ljxl/write/biff/WritableSheetImpl;->copy(Ljxl/write/WritableSheet;)V

    return-void
.end method

.method createDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/biff/drawing/DrawingGroup;

    sget-object v1, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    invoke-direct {v0, v1}, Ljxl/biff/drawing/DrawingGroup;-><init>(Ljxl/biff/drawing/Origin;)V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Ljxl/write/biff/WritableWorkbookImpl;->createSheet(Ljava/lang/String;IZ)Ljxl/write/WritableSheet;

    move-result-object p1

    return-object p1
.end method

.method public findByName(Ljava/lang/String;)[Ljxl/Range;
    .locals 11

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/NameRecord;

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {p1}, Ljxl/write/biff/NameRecord;->getRanges()[Ljxl/write/biff/NameRecord$NameRange;

    move-result-object p1

    array-length v0, p1

    new-array v0, v0, [Ljxl/Range;

    const/4 v1, 0x0

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    new-instance v2, Ljxl/biff/RangeImpl;

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v3

    invoke-virtual {p0, v3}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(I)I

    move-result v5

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v6

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getFirstRow()I

    move-result v7

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v3

    invoke-virtual {p0, v3}, Ljxl/write/biff/WritableWorkbookImpl;->getLastExternalSheetIndex(I)I

    move-result v8

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getLastColumn()I

    move-result v9

    aget-object v3, p1, v1

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord$NameRange;->getLastRow()I

    move-result v10

    move-object v3, v2

    move-object v4, p0

    invoke-direct/range {v3 .. v10}, Ljxl/biff/RangeImpl;-><init>(Ljxl/biff/WorkbookMethods;IIIIII)V

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public findCellByName(Ljava/lang/String;)Ljxl/write/WritableCell;
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/NameRecord;

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {p1}, Ljxl/write/biff/NameRecord;->getRanges()[Ljxl/write/biff/NameRecord$NameRange;

    move-result-object p1

    const/4 v0, 0x0

    aget-object v1, p1, v0

    invoke-virtual {v1}, Ljxl/write/biff/NameRecord$NameRange;->getExternalSheet()I

    move-result v1

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(I)I

    move-result v1

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v1

    aget-object v2, p1, v0

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord$NameRange;->getFirstColumn()I

    move-result v2

    aget-object p1, p1, v0

    invoke-virtual {p1}, Ljxl/write/biff/NameRecord$NameRange;->getFirstRow()I

    move-result p1

    invoke-interface {v1, v2, p1}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object p1

    return-object p1
.end method

.method public getColourRGB(Ljxl/format/Colour;)Ljxl/format/RGB;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v0, p1}, Ljxl/biff/FormattingRecords;->getColourRGB(Ljxl/format/Colour;)Ljxl/format/RGB;

    move-result-object p1

    return-object p1
.end method

.method getDrawingGroup()Ljxl/biff/drawing/DrawingGroup;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    return-object v0
.end method

.method public getExternalSheetIndex(I)I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-nez v0, :cond_0

    return p1

    :cond_0
    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0, p1}, Ljxl/write/biff/ExternalSheetRecord;->getFirstTabIndex(I)I

    move-result p1

    return p1
.end method

.method public getExternalSheetIndex(Ljava/lang/String;)I
    .locals 8

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/write/biff/ExternalSheetRecord;

    invoke-direct {v0}, Ljxl/write/biff/ExternalSheetRecord;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    new-instance v1, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v2, v3}, Ljxl/write/biff/SupbookRecord;-><init>(ILjxl/WorkbookSettings;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    if-nez v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v5}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    move v3, v1

    goto :goto_0

    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_5

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v1

    sget-object v3, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v1, v3, :cond_3

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getNumberOfSheets()I

    move-result v0

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v1

    if-eq v0, v1, :cond_4

    :cond_3
    sget-object v0, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Cannot find sheet "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, " in supbook record"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_4
    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {p1, v2, v4}, Ljxl/write/biff/ExternalSheetRecord;->getIndex(II)I

    move-result p1

    return p1

    :cond_5
    const/16 v0, 0x5d

    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v0

    const/16 v3, 0x5b

    invoke-virtual {p1, v3}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v3

    const/4 v4, -0x1

    if-eq v0, v4, :cond_a

    if-ne v3, v4, :cond_6

    goto :goto_2

    :cond_6
    add-int/lit8 v5, v0, 0x1

    invoke-virtual {p1, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    add-int/lit8 v6, v3, 0x1

    invoke-virtual {p1, v6, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    move v3, v2

    :goto_1
    iget-object v6, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v2, v6, :cond_8

    if-nez v3, :cond_8

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v6

    sget-object v7, Ljxl/write/biff/SupbookRecord;->EXTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v6, v7, :cond_7

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getFileName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    move v3, v1

    move v4, v2

    :cond_7
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_8
    if-nez v3, :cond_9

    new-instance v0, Ljxl/write/biff/SupbookRecord;

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v0, p1, v1}, Ljxl/write/biff/SupbookRecord;-><init>(Ljava/lang/String;Ljxl/WorkbookSettings;)V

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v4

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_9
    invoke-virtual {v0, v5}, Ljxl/write/biff/SupbookRecord;->getSheetIndex(Ljava/lang/String;)I

    move-result p1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0, v4, p1}, Ljxl/write/biff/ExternalSheetRecord;->getIndex(II)I

    move-result p1

    return p1

    :cond_a
    :goto_2
    sget-object p1, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    const-string v0, "Square brackets"

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return v4
.end method

.method public getExternalSheetName(I)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0, p1}, Ljxl/write/biff/ExternalSheetRecord;->getSupbookIndex(I)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/write/biff/SupbookRecord;

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v1, p1}, Ljxl/write/biff/ExternalSheetRecord;->getFirstTabIndex(I)I

    move-result p1

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v1

    sget-object v2, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    invoke-interface {p1}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v1

    sget-object v2, Ljxl/write/biff/SupbookRecord;->EXTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v1, v2, :cond_1

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getFileName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0, p1}, Ljxl/write/biff/SupbookRecord;->getSheetName(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_1
    sget-object p1, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    const-string v0, "Unknown Supbook 1"

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const-string p1, "[UNKNOWN]"

    return-object p1
.end method

.method public getLastExternalSheetIndex(I)I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-nez v0, :cond_0

    return p1

    :cond_0
    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0, p1}, Ljxl/write/biff/ExternalSheetRecord;->getLastTabIndex(I)I

    move-result p1

    return p1
.end method

.method public getLastExternalSheetIndex(Ljava/lang/String;)I
    .locals 6

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/write/biff/ExternalSheetRecord;

    invoke-direct {v0}, Ljxl/write/biff/ExternalSheetRecord;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    new-instance v1, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v1, v2, v3}, Ljxl/write/biff/SupbookRecord;-><init>(ILjxl/WorkbookSettings;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    if-nez v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v5}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    move v3, v1

    goto :goto_0

    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_2
    if-nez v3, :cond_3

    const/4 p1, -0x1

    return p1

    :cond_3
    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {p1}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v0

    sget-object v3, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v0, v3, :cond_4

    invoke-virtual {p1}, Ljxl/write/biff/SupbookRecord;->getNumberOfSheets()I

    move-result p1

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v0

    if-ne p1, v0, :cond_4

    goto :goto_1

    :cond_4
    move v1, v2

    :goto_1
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {p1, v2, v4}, Ljxl/write/biff/ExternalSheetRecord;->getIndex(II)I

    move-result p1

    return p1
.end method

.method public getLastExternalSheetName(I)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v0, p1}, Ljxl/write/biff/ExternalSheetRecord;->getSupbookIndex(I)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/write/biff/SupbookRecord;

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v1, p1}, Ljxl/write/biff/ExternalSheetRecord;->getLastTabIndex(I)I

    move-result p1

    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v1

    sget-object v2, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v1, v2, :cond_0

    invoke-virtual {p0, p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    invoke-interface {p1}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {v0}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object p1

    sget-object v0, Ljxl/write/biff/SupbookRecord;->EXTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne p1, v0, :cond_1

    const/4 p1, 0x0

    invoke-static {p1}, Ljxl/common/Assert;->verify(Z)V

    :cond_1
    sget-object p1, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    const-string v0, "Unknown Supbook 2"

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const-string p1, "[UNKNOWN]"

    return-object p1
.end method

.method public getName(I)Ljava/lang/String;
    .locals 1

    if-ltz p1, :cond_0

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/NameRecord;

    invoke-virtual {p1}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public getNameIndex(Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/biff/NameRecord;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljxl/write/biff/NameRecord;->getIndex()I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, -0x1

    :goto_0
    return p1
.end method

.method public getNumberOfSheets()I
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getRangeNames()[Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    new-array v0, v1, [Ljava/lang/String;

    return-object v0

    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    :goto_0
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/NameRecord;

    invoke-virtual {v2}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public getReadSheet(I)Ljxl/Sheet;
    .locals 0

    invoke-virtual {p0, p1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    return-object p1
.end method

.method getSettings()Ljxl/WorkbookSettings;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    return-object v0
.end method

.method public getSheet(I)Ljxl/write/WritableSheet;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/WritableSheet;

    return-object p1
.end method

.method public getSheet(Ljava/lang/String;)Ljxl/write/WritableSheet;
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v3, v1

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    if-nez v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/WritableSheet;

    invoke-interface {v3}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_1
    if-eqz v2, :cond_2

    move-object v1, v3

    :cond_2
    return-object v1
.end method

.method public getSheetNames()[Ljava/lang/String;
    .locals 4

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v0

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    invoke-virtual {p0, v2}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method public getSheets()[Ljxl/write/WritableSheet;
    .locals 3

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v0

    new-array v0, v0, [Ljxl/write/WritableSheet;

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method getStyles()Ljxl/write/biff/Styles;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->styles:Ljxl/write/biff/Styles;

    return-object v0
.end method

.method public getWorkbookBof()Ljxl/read/biff/BOFRecord;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getWritableCell(Ljava/lang/String;)Ljxl/write/WritableCell;
    .locals 1

    invoke-static {p1}, Ljxl/biff/CellReferenceHelper;->getSheet(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(Ljava/lang/String;)Ljxl/write/WritableSheet;

    move-result-object v0

    invoke-interface {v0, p1}, Ljxl/write/WritableSheet;->getWritableCell(Ljava/lang/String;)Ljxl/write/WritableCell;

    move-result-object p1

    return-object p1
.end method

.method public importSheet(Ljava/lang/String;ILjxl/Sheet;)Ljxl/write/WritableSheet;
    .locals 0

    invoke-virtual {p0, p1, p2}, Ljxl/write/biff/WritableWorkbookImpl;->createSheet(Ljava/lang/String;I)Ljxl/write/WritableSheet;

    move-result-object p1

    move-object p2, p1

    check-cast p2, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {p2, p3}, Ljxl/write/biff/WritableSheetImpl;->importSheet(Ljxl/Sheet;)V

    return-object p1
.end method

.method public moveSheet(II)Ljxl/write/WritableSheet;
    .locals 2

    const/4 v0, 0x0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    move-result p1

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p1, v1}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {p2, v0}, Ljava/lang/Math;->max(II)I

    move-result p2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/write/WritableSheet;

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p2, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    return-object p1
.end method

.method removeDrawing(Ljxl/biff/drawing/Drawing;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    invoke-virtual {v0, p1}, Ljxl/biff/drawing/DrawingGroup;->remove(Ljxl/biff/drawing/DrawingGroupObject;)V

    return-void
.end method

.method public removeRangeName(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    if-nez v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/biff/NameRecord;

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    if-eqz v1, :cond_2

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->nameRecords:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    sget-object v0, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v2, "Could not remove "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, " from index lookups"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_2
    return-void
.end method

.method public removeSheet(I)V
    .locals 6

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-gtz p1, :cond_0

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move p1, v0

    goto :goto_0

    :cond_0
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt p1, v2, :cond_1

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    sub-int/2addr p1, v1

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v3

    sub-int/2addr v3, v1

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :goto_0
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-eqz v2, :cond_2

    invoke-virtual {v2, p1}, Ljxl/write/biff/ExternalSheetRecord;->sheetRemoved(I)V

    :cond_2
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_3

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/SupbookRecord;

    invoke-virtual {v2}, Ljxl/write/biff/SupbookRecord;->getType()Ljxl/write/biff/SupbookRecord$SupbookType;

    move-result-object v3

    sget-object v4, Ljxl/write/biff/SupbookRecord;->INTERNAL:Ljxl/write/biff/SupbookRecord$SupbookType;

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljxl/write/biff/SupbookRecord;->adjustInternal(I)V

    :cond_3
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_7

    move v2, v0

    :goto_1
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_7

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/biff/NameRecord;

    invoke-virtual {v3}, Ljxl/write/biff/NameRecord;->getSheetRef()I

    move-result v4

    add-int/lit8 v5, p1, 0x1

    if-ne v4, v5, :cond_4

    invoke-virtual {v3, v0}, Ljxl/write/biff/NameRecord;->setSheetRef(I)V

    goto :goto_2

    :cond_4
    if-le v4, v5, :cond_6

    if-ge v4, v1, :cond_5

    move v4, v1

    :cond_5
    sub-int/2addr v4, v1

    invoke-virtual {v3, v4}, Ljxl/write/biff/NameRecord;->setSheetRef(I)V

    :cond_6
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_7
    return-void
.end method

.method rowInserted(Ljxl/write/biff/WritableSheetImpl;I)V
    .locals 3

    invoke-virtual {p1}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/CellValue;

    invoke-virtual {v2, p1, v0, p2}, Ljxl/write/biff/CellValue;->rowInserted(Ljxl/Sheet;II)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/NameRecord;

    invoke-virtual {v1, v0, p2}, Ljxl/write/biff/NameRecord;->rowInserted(II)V

    goto :goto_1

    :cond_1
    return-void
.end method

.method rowRemoved(Ljxl/write/biff/WritableSheetImpl;I)V
    .locals 4

    invoke-virtual {p1}, Ljxl/write/biff/WritableSheetImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getExternalSheetIndex(Ljava/lang/String;)I

    move-result v0

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->rcirCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/CellValue;

    invoke-virtual {v2, p1, v0, p2}, Ljxl/write/biff/CellValue;->rowRemoved(Ljxl/Sheet;II)V

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/NameRecord;

    invoke-virtual {v2, v0, p2}, Ljxl/write/biff/NameRecord;->rowRemoved(II)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljxl/write/biff/NameRecord;

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    move-result v0

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v2, "Could not remove name "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p2}, Ljxl/write/biff/NameRecord;->getName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v0, p2}, Ljxl/common/Assert;->verify(ZLjava/lang/String;)V

    goto :goto_2

    :cond_3
    return-void
.end method

.method public setColourRGB(Ljxl/format/Colour;III)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v0, p1, p2, p3, p4}, Ljxl/biff/FormattingRecords;->setColourRGB(Ljxl/format/Colour;III)V

    return-void
.end method

.method public setOutputFile(Ljava/io/File;)V
    .locals 1

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iget-object p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->setOutputFile(Ljava/io/OutputStream;)V

    return-void
.end method

.method public setProtected(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/write/biff/WritableWorkbookImpl;->wbProtected:Z

    return-void
.end method

.method public write()V
    .locals 15

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    if-ge v1, v2, :cond_4

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->checkMergedBorders()V

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getSettings()Ljxl/SheetSettings;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/SheetSettings;->getPrintArea()Ljxl/Range;

    move-result-object v3

    if-eqz v3, :cond_0

    sget-object v4, Ljxl/biff/BuiltInName;->PRINT_AREA:Ljxl/biff/BuiltInName;

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getRow()I

    move-result v7

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getColumn()I

    move-result v8

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v9

    const/4 v10, 0x0

    move-object v3, p0

    move-object v5, v2

    invoke-virtual/range {v3 .. v10}, Ljxl/write/biff/WritableWorkbookImpl;->addNameArea(Ljxl/biff/BuiltInName;Ljxl/write/WritableSheet;IIIIZ)V

    :cond_0
    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getSettings()Ljxl/SheetSettings;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/SheetSettings;->getPrintTitlesRow()Ljxl/Range;

    move-result-object v3

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->getSettings()Ljxl/SheetSettings;

    move-result-object v4

    invoke-virtual {v4}, Ljxl/SheetSettings;->getPrintTitlesCol()Ljxl/Range;

    move-result-object v4

    if-eqz v3, :cond_1

    if-eqz v4, :cond_1

    sget-object v5, Ljxl/biff/BuiltInName;->PRINT_TITLES:Ljxl/biff/BuiltInName;

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v6

    invoke-interface {v6}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v7

    invoke-interface {v7}, Ljxl/Cell;->getRow()I

    move-result v7

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v8

    invoke-interface {v8}, Ljxl/Cell;->getColumn()I

    move-result v8

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v9

    invoke-interface {v4}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v10

    invoke-interface {v4}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v11

    invoke-interface {v4}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v12

    invoke-interface {v4}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v13

    const/4 v14, 0x0

    move-object v3, p0

    move-object v4, v5

    move-object v5, v2

    invoke-virtual/range {v3 .. v14}, Ljxl/write/biff/WritableWorkbookImpl;->addNameArea(Ljxl/biff/BuiltInName;Ljxl/write/WritableSheet;IIIIIIIIZ)V

    goto :goto_2

    :cond_1
    if-eqz v3, :cond_2

    sget-object v4, Ljxl/biff/BuiltInName;->PRINT_TITLES:Ljxl/biff/BuiltInName;

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v3}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getRow()I

    move-result v7

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v5

    invoke-interface {v5}, Ljxl/Cell;->getColumn()I

    move-result v8

    invoke-interface {v3}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v9

    const/4 v10, 0x0

    move-object v3, p0

    :goto_1
    move-object v5, v2

    invoke-virtual/range {v3 .. v10}, Ljxl/write/biff/WritableWorkbookImpl;->addNameArea(Ljxl/biff/BuiltInName;Ljxl/write/WritableSheet;IIIIZ)V

    goto :goto_2

    :cond_2
    if-eqz v4, :cond_3

    sget-object v5, Ljxl/biff/BuiltInName;->PRINT_TITLES:Ljxl/biff/BuiltInName;

    invoke-interface {v4}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v6

    invoke-interface {v4}, Ljxl/Range;->getTopLeft()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v7

    invoke-interface {v4}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v8

    invoke-interface {v4}, Ljxl/Range;->getBottomRight()Ljxl/Cell;

    move-result-object v3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v9

    const/4 v10, 0x0

    move-object v3, p0

    move-object v4, v5

    goto :goto_1

    :cond_3
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_4
    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getRationalizationDisabled()Z

    move-result v1

    if-nez v1, :cond_5

    invoke-direct {p0}, Ljxl/write/biff/WritableWorkbookImpl;->rationalize()V

    :cond_5
    new-instance v1, Ljxl/write/biff/BOFRecord;

    sget-object v2, Ljxl/write/biff/BOFRecord;->workbookGlobals:Ljxl/write/biff/BOFRecord$WorkbookGlobalsBOF;

    invoke-direct {v1, v2}, Ljxl/write/biff/BOFRecord;-><init>(Ljxl/write/biff/BOFRecord$WorkbookGlobalsBOF;)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getTemplate()Z

    move-result v1

    if-eqz v1, :cond_6

    new-instance v1, Ljxl/write/biff/TemplateRecord;

    invoke-direct {v1}, Ljxl/write/biff/TemplateRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_6
    new-instance v1, Ljxl/write/biff/InterfaceHeaderRecord;

    invoke-direct {v1}, Ljxl/write/biff/InterfaceHeaderRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/MMSRecord;

    invoke-direct {v1, v0, v0}, Ljxl/write/biff/MMSRecord;-><init>(II)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/InterfaceEndRecord;

    invoke-direct {v1}, Ljxl/write/biff/InterfaceEndRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/WriteAccessRecord;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v2}, Ljxl/WorkbookSettings;->getWriteAccess()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljxl/write/biff/WriteAccessRecord;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/CodepageRecord;

    invoke-direct {v1}, Ljxl/write/biff/CodepageRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/DSFRecord;

    invoke-direct {v1}, Ljxl/write/biff/DSFRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v1}, Ljxl/WorkbookSettings;->getExcel9File()Z

    move-result v1

    if-eqz v1, :cond_7

    new-instance v1, Ljxl/write/biff/Excel9FileRecord;

    invoke-direct {v1}, Ljxl/write/biff/Excel9FileRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_7
    new-instance v1, Ljxl/write/biff/TabIdRecord;

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/TabIdRecord;-><init>(I)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-boolean v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->containsMacros:Z

    if-eqz v1, :cond_8

    new-instance v1, Ljxl/write/biff/ObjProjRecord;

    invoke-direct {v1}, Ljxl/write/biff/ObjProjRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_8
    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->buttonPropertySet:Ljxl/write/biff/ButtonPropertySetRecord;

    if-eqz v1, :cond_9

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_9
    new-instance v1, Ljxl/write/biff/FunctionGroupCountRecord;

    invoke-direct {v1}, Ljxl/write/biff/FunctionGroupCountRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/WindowProtectRecord;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v2}, Ljxl/WorkbookSettings;->getWindowProtected()Z

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/WindowProtectRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/ProtectRecord;

    iget-boolean v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->wbProtected:Z

    invoke-direct {v1, v2}, Ljxl/write/biff/ProtectRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/PasswordRecord;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljxl/write/biff/PasswordRecord;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/Prot4RevRecord;

    invoke-direct {v1, v0}, Ljxl/write/biff/Prot4RevRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/Prot4RevPassRecord;

    invoke-direct {v1}, Ljxl/write/biff/Prot4RevPassRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    move v1, v0

    move v2, v1

    move v3, v2

    :goto_3
    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v4

    const/4 v5, 0x1

    if-ge v1, v4, :cond_b

    if-nez v2, :cond_b

    invoke-virtual {p0, v1}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v4

    check-cast v4, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v4}, Ljxl/write/biff/WritableSheetImpl;->getSettings()Ljxl/SheetSettings;

    move-result-object v4

    invoke-virtual {v4}, Ljxl/SheetSettings;->isSelected()Z

    move-result v4

    if-eqz v4, :cond_a

    move v3, v1

    move v2, v5

    :cond_a
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_b
    if-nez v2, :cond_c

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v1

    check-cast v1, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v1}, Ljxl/write/biff/WritableSheetImpl;->getSettings()Ljxl/SheetSettings;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljxl/SheetSettings;->setSelected(Z)V

    move v3, v0

    :cond_c
    new-instance v1, Ljxl/write/biff/Window1Record;

    invoke-direct {v1, v3}, Ljxl/write/biff/Window1Record;-><init>(I)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/BackupRecord;

    invoke-direct {v1, v0}, Ljxl/write/biff/BackupRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/HideobjRecord;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v2}, Ljxl/WorkbookSettings;->getHideobj()I

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/HideobjRecord;-><init>(I)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/NineteenFourRecord;

    invoke-direct {v1, v0}, Ljxl/write/biff/NineteenFourRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/PrecisionRecord;

    invoke-direct {v1, v0}, Ljxl/write/biff/PrecisionRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/RefreshAllRecord;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v2}, Ljxl/WorkbookSettings;->getRefreshAll()Z

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/RefreshAllRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v1, Ljxl/write/biff/BookboolRecord;

    invoke-direct {v1, v5}, Ljxl/write/biff/BookboolRecord;-><init>(Z)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->fonts:Ljxl/biff/Fonts;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v1, v2}, Ljxl/biff/Fonts;->write(Ljxl/write/biff/File;)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v1, v2}, Ljxl/biff/FormattingRecords;->write(Ljxl/write/biff/File;)V

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v1}, Ljxl/biff/FormattingRecords;->getPalette()Ljxl/biff/PaletteRecord;

    move-result-object v1

    if-eqz v1, :cond_d

    iget-object v1, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->formatRecords:Ljxl/biff/FormattingRecords;

    invoke-virtual {v2}, Ljxl/biff/FormattingRecords;->getPalette()Ljxl/biff/PaletteRecord;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_d
    new-instance v1, Ljxl/write/biff/UsesElfsRecord;

    invoke-direct {v1}, Ljxl/write/biff/UsesElfsRecord;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v1

    new-array v1, v1, [I

    move v2, v0

    :goto_4
    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v3

    if-ge v2, v3, :cond_10

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3}, Ljxl/write/biff/File;->getPos()I

    move-result v3

    aput v3, v1, v2

    invoke-virtual {p0, v2}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v3

    new-instance v4, Ljxl/write/biff/BoundsheetRecord;

    invoke-interface {v3}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljxl/write/biff/BoundsheetRecord;-><init>(Ljava/lang/String;)V

    invoke-interface {v3}, Ljxl/Sheet;->getSettings()Ljxl/SheetSettings;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/SheetSettings;->isHidden()Z

    move-result v3

    if-eqz v3, :cond_e

    invoke-virtual {v4}, Ljxl/write/biff/BoundsheetRecord;->setHidden()V

    :cond_e
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->sheets:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v3}, Ljxl/write/biff/WritableSheetImpl;->isChartOnly()Z

    move-result v3

    if-eqz v3, :cond_f

    invoke-virtual {v4}, Ljxl/write/biff/BoundsheetRecord;->setChartOnly()V

    :cond_f
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v4}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_10
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->countryRecord:Ljxl/write/biff/CountryRecord;

    if-nez v2, :cond_12

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v2}, Ljxl/WorkbookSettings;->getExcelDisplayLanguage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljxl/biff/CountryCode;->getCountryCode(Ljava/lang/String;)Ljxl/biff/CountryCode;

    move-result-object v2

    sget-object v3, Ljxl/biff/CountryCode;->UNKNOWN:Ljxl/biff/CountryCode;

    const-string v4, " using "

    const-string v5, "Unknown country code "

    if-ne v2, v3, :cond_11

    sget-object v2, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v7, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v7}, Ljxl/WorkbookSettings;->getExcelDisplayLanguage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    sget-object v7, Ljxl/biff/CountryCode;->USA:Ljxl/biff/CountryCode;

    invoke-virtual {v7}, Ljxl/biff/CountryCode;->getCode()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    move-object v2, v7

    :cond_11
    iget-object v6, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v6}, Ljxl/WorkbookSettings;->getExcelRegionalSettings()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljxl/biff/CountryCode;->getCountryCode(Ljava/lang/String;)Ljxl/biff/CountryCode;

    move-result-object v6

    new-instance v7, Ljxl/write/biff/CountryRecord;

    invoke-direct {v7, v2, v6}, Ljxl/write/biff/CountryRecord;-><init>(Ljxl/biff/CountryCode;Ljxl/biff/CountryCode;)V

    iput-object v7, p0, Ljxl/write/biff/WritableWorkbookImpl;->countryRecord:Ljxl/write/biff/CountryRecord;

    if-ne v6, v3, :cond_12

    sget-object v2, Ljxl/write/biff/WritableWorkbookImpl;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v5, p0, Ljxl/write/biff/WritableWorkbookImpl;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v5}, Ljxl/WorkbookSettings;->getExcelDisplayLanguage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    sget-object v4, Ljxl/biff/CountryCode;->UK:Ljxl/biff/CountryCode;

    invoke-virtual {v4}, Ljxl/biff/CountryCode;->getCode()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_12
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->countryRecord:Ljxl/write/biff/CountryRecord;

    invoke-virtual {v2, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->addInFunctionNames:[Ljava/lang/String;

    if-eqz v2, :cond_13

    array-length v2, v2

    if-lez v2, :cond_13

    move v2, v0

    :goto_5
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->addInFunctionNames:[Ljava/lang/String;

    array-length v3, v3

    if-ge v2, v3, :cond_13

    new-instance v3, Ljxl/write/biff/ExternalNameRecord;

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->addInFunctionNames:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-direct {v3, v4}, Ljxl/write/biff/ExternalNameRecord;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v4, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    :cond_13
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->xctRecords:[Ljxl/biff/XCTRecord;

    if-eqz v2, :cond_14

    move v2, v0

    :goto_6
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->xctRecords:[Ljxl/biff/XCTRecord;

    array-length v4, v3

    if-ge v2, v4, :cond_14

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    aget-object v3, v3, v2

    invoke-virtual {v4, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    :cond_14
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    if-eqz v2, :cond_16

    move v2, v0

    :goto_7
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_15

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->supbooks:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/biff/SupbookRecord;

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v4, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_7

    :cond_15
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->externSheet:Ljxl/write/biff/ExternalSheetRecord;

    invoke-virtual {v2, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_16
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    if-eqz v2, :cond_17

    move v2, v0

    :goto_8
    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_17

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->names:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/write/biff/NameRecord;

    iget-object v4, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v4, v3}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_8

    :cond_17
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->drawingGroup:Ljxl/biff/drawing/DrawingGroup;

    if-eqz v2, :cond_18

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v3}, Ljxl/biff/drawing/DrawingGroup;->write(Ljxl/write/biff/File;)V

    :cond_18
    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->sharedStrings:Ljxl/write/biff/SharedStrings;

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2, v3}, Ljxl/write/biff/SharedStrings;->write(Ljxl/write/biff/File;)V

    new-instance v2, Ljxl/write/biff/EOFRecord;

    invoke-direct {v2}, Ljxl/write/biff/EOFRecord;-><init>()V

    iget-object v3, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v3, v2}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :goto_9
    invoke-virtual {p0}, Ljxl/write/biff/WritableWorkbookImpl;->getNumberOfSheets()I

    move-result v2

    if-ge v0, v2, :cond_19

    iget-object v2, p0, Ljxl/write/biff/WritableWorkbookImpl;->outputFile:Ljxl/write/biff/File;

    invoke-virtual {v2}, Ljxl/write/biff/File;->getPos()I

    move-result v3

    invoke-static {v3}, Ljxl/biff/IntegerHelper;->getFourBytes(I)[B

    move-result-object v3

    aget v4, v1, v0

    add-int/lit8 v4, v4, 0x4

    invoke-virtual {v2, v3, v4}, Ljxl/write/biff/File;->setData([BI)V

    invoke-virtual {p0, v0}, Ljxl/write/biff/WritableWorkbookImpl;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object v2

    check-cast v2, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v2}, Ljxl/write/biff/WritableSheetImpl;->write()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_9

    :cond_19
    return-void
.end method
