.class Ljxl/biff/drawing/SpContainer;
.super Ljxl/biff/drawing/EscherContainer;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/EscherRecordType;->SP_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    invoke-direct {p0, v0}, Ljxl/biff/drawing/EscherContainer;-><init>(Ljxl/biff/drawing/EscherRecordType;)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/EscherRecordData;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherContainer;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    return-void
.end method
