.class abstract Ljxl/write/biff/MarginRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private margin:D


# direct methods
.method public constructor <init>(Ljxl/biff/Type;D)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-wide p2, p0, Ljxl/write/biff/MarginRecord;->margin:D

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 4

    const/16 v0, 0x8

    new-array v0, v0, [B

    iget-wide v1, p0, Ljxl/write/biff/MarginRecord;->margin:D

    const/4 v3, 0x0

    invoke-static {v1, v2, v0, v3}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    return-object v0
.end method
