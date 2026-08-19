.class abstract Ljxl/read/biff/MarginRecord;
.super Ljxl/biff/RecordData;
.source ""


# instance fields
.field private margin:D


# direct methods
.method protected constructor <init>(Ljxl/biff/Type;Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/biff/Type;)V

    invoke-virtual {p2}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {p1, p2}, Ljxl/biff/DoubleHelper;->getIEEEDouble([BI)D

    move-result-wide p1

    iput-wide p1, p0, Ljxl/read/biff/MarginRecord;->margin:D

    return-void
.end method


# virtual methods
.method getMargin()D
    .locals 2

    iget-wide v0, p0, Ljxl/read/biff/MarginRecord;->margin:D

    return-wide v0
.end method
