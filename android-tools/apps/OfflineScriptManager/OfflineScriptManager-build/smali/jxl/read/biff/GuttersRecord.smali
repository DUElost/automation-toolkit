.class public Ljxl/read/biff/GuttersRecord;
.super Ljxl/biff/RecordData;
.source ""


# instance fields
.field private columnOutlineLevel:I

.field private height:I

.field private rowOutlineLevel:I

.field private width:I


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 2

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v0, p1, v0

    const/4 v1, 0x1

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/GuttersRecord;->width:I

    const/4 v0, 0x2

    aget-byte v0, p1, v0

    const/4 v1, 0x3

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/GuttersRecord;->height:I

    const/4 v0, 0x4

    aget-byte v0, p1, v0

    const/4 v1, 0x5

    aget-byte v1, p1, v1

    invoke-static {v0, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/read/biff/GuttersRecord;->rowOutlineLevel:I

    const/4 v0, 0x6

    aget-byte v0, p1, v0

    const/4 v1, 0x7

    aget-byte p1, p1, v1

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/read/biff/GuttersRecord;->columnOutlineLevel:I

    return-void
.end method


# virtual methods
.method getColumnOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/GuttersRecord;->columnOutlineLevel:I

    return v0
.end method

.method getRowOutlineLevel()I
    .locals 1

    iget v0, p0, Ljxl/read/biff/GuttersRecord;->rowOutlineLevel:I

    return v0
.end method
