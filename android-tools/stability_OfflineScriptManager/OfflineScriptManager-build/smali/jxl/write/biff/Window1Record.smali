.class Ljxl/write/biff/Window1Record;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private data:[B

.field private selectedSheet:I


# direct methods
.method public constructor <init>(I)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->WINDOW1:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/Window1Record;->selectedSheet:I

    const/16 v0, 0x12

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    iput-object v0, p0, Ljxl/write/biff/Window1Record;->data:[B

    const/16 v1, 0xa

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-void

    :array_0
    .array-data 1
        0x68t
        0x1t
        0xet
        0x1t
        0x5ct
        0x3at
        -0x42t
        0x23t
        0x38t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x1t
        0x0t
        0x58t
        0x2t
    .end array-data
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/Window1Record;->data:[B

    return-object v0
.end method
