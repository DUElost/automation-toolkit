.class Ljxl/write/biff/DefaultColumnWidth;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private data:[B

.field private width:I


# direct methods
.method public constructor <init>(I)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->DEFCOLWIDTH:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/DefaultColumnWidth;->width:I

    const/4 v0, 0x2

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/DefaultColumnWidth;->data:[B

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-void
.end method


# virtual methods
.method protected getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/DefaultColumnWidth;->data:[B

    return-object v0
.end method
