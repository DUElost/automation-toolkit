.class Ljxl/write/biff/HorizontalCentreRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private centre:Z

.field private data:[B


# direct methods
.method public constructor <init>(Z)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->HCENTER:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-boolean p1, p0, Ljxl/write/biff/HorizontalCentreRecord;->centre:Z

    const/4 v0, 0x2

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/HorizontalCentreRecord;->data:[B

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    const/4 v1, 0x1

    aput-byte v1, v0, p1

    :cond_0
    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/HorizontalCentreRecord;->data:[B

    return-object v0
.end method
