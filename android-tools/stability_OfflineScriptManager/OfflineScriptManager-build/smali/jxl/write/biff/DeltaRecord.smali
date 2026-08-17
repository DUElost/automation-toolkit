.class Ljxl/write/biff/DeltaRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private data:[B

.field private iterationValue:D


# direct methods
.method public constructor <init>(D)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->DELTA:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-wide p1, p0, Ljxl/write/biff/DeltaRecord;->iterationValue:D

    const/16 p1, 0x8

    new-array p1, p1, [B

    iput-object p1, p0, Ljxl/write/biff/DeltaRecord;->data:[B

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 4

    iget-wide v0, p0, Ljxl/write/biff/DeltaRecord;->iterationValue:D

    iget-object v2, p0, Ljxl/write/biff/DeltaRecord;->data:[B

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    iget-object v0, p0, Ljxl/write/biff/DeltaRecord;->data:[B

    return-object v0
.end method
