.class Ljxl/read/biff/LabelSSTRecord;
.super Ljxl/read/biff/CellValue;
.source ""

# interfaces
.implements Ljxl/LabelCell;


# instance fields
.field private index:I

.field private string:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;Ljxl/read/biff/SSTRecord;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V
    .locals 2

    invoke-direct {p0, p1, p3, p4}, Ljxl/read/biff/CellValue;-><init>(Ljxl/read/biff/Record;Ljxl/biff/FormattingRecords;Ljxl/read/biff/SheetImpl;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 p3, 0x6

    aget-byte p3, p1, p3

    const/4 p4, 0x7

    aget-byte p4, p1, p4

    const/16 v0, 0x8

    aget-byte v0, p1, v0

    const/16 v1, 0x9

    aget-byte p1, p1, v1

    invoke-static {p3, p4, v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/LabelSSTRecord;->index:I

    invoke-virtual {p2, p1}, Ljxl/read/biff/SSTRecord;->getString(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/read/biff/LabelSSTRecord;->string:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getContents()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/LabelSSTRecord;->string:Ljava/lang/String;

    return-object v0
.end method

.method public getString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/LabelSSTRecord;->string:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->LABEL:Ljxl/CellType;

    return-object v0
.end method
