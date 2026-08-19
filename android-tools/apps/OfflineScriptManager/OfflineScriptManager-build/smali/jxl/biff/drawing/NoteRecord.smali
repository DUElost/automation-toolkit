.class public Ljxl/biff/drawing/NoteRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field static synthetic class$jxl$biff$drawing$NoteRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private column:I

.field private data:[B

.field private objectId:I

.field private row:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/NoteRecord;->class$jxl$biff$drawing$NoteRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.NoteRecord"

    invoke-static {v0}, Ljxl/biff/drawing/NoteRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/NoteRecord;->class$jxl$biff$drawing$NoteRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/NoteRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(III)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->NOTE:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p2, p0, Ljxl/biff/drawing/NoteRecord;->row:I

    iput p1, p0, Ljxl/biff/drawing/NoteRecord;->column:I

    iput p3, p0, Ljxl/biff/drawing/NoteRecord;->objectId:I

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 2

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/4 v0, 0x0

    aget-byte v0, p1, v0

    const/4 v1, 0x1

    aget-byte p1, p1, v1

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/NoteRecord;->row:I

    iget-object p1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/4 v0, 0x2

    aget-byte v0, p1, v0

    const/4 v1, 0x3

    aget-byte p1, p1, v1

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/NoteRecord;->column:I

    iget-object p1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/4 v0, 0x6

    aget-byte v0, p1, v0

    const/4 v1, 0x7

    aget-byte p1, p1, v1

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/NoteRecord;->objectId:I

    return-void
.end method

.method public constructor <init>([B)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->NOTE:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-object p1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

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


# virtual methods
.method getColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/NoteRecord;->column:I

    return v0
.end method

.method public getData()[B
    .locals 4

    iget-object v0, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    const/16 v0, 0xc

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    iget v1, p0, Ljxl/biff/drawing/NoteRecord;->row:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/NoteRecord;->column:I

    iget-object v1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/4 v3, 0x2

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/NoteRecord;->objectId:I

    iget-object v1, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/4 v3, 0x6

    invoke-static {v0, v1, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    const/16 v1, 0x8

    invoke-static {v2, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/NoteRecord;->data:[B

    return-object v0
.end method

.method public getObjectId()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/NoteRecord;->objectId:I

    return v0
.end method

.method getRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/NoteRecord;->row:I

    return v0
.end method
