.class Ljxl/write/biff/DefaultRowHeightRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private changed:Z

.field private data:[B

.field private rowHeight:I


# direct methods
.method public constructor <init>(IZ)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->DEFAULTROWHEIGHT:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v0, 0x4

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/DefaultRowHeightRecord;->data:[B

    iput p1, p0, Ljxl/write/biff/DefaultRowHeightRecord;->rowHeight:I

    iput-boolean p2, p0, Ljxl/write/biff/DefaultRowHeightRecord;->changed:Z

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 3

    iget-boolean v0, p0, Ljxl/write/biff/DefaultRowHeightRecord;->changed:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/DefaultRowHeightRecord;->data:[B

    const/4 v1, 0x0

    aget-byte v2, v0, v1

    or-int/lit8 v2, v2, 0x1

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    :cond_0
    iget v0, p0, Ljxl/write/biff/DefaultRowHeightRecord;->rowHeight:I

    iget-object v1, p0, Ljxl/write/biff/DefaultRowHeightRecord;->data:[B

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-object v0, p0, Ljxl/write/biff/DefaultRowHeightRecord;->data:[B

    return-object v0
.end method
