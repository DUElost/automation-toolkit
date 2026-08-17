.class Ljxl/read/biff/PrintHeadersRecord;
.super Ljxl/biff/RecordData;
.source ""


# instance fields
.field private printHeaders:Z


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 2

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte p1, p1, v0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    move v0, v1

    :cond_0
    iput-boolean v0, p0, Ljxl/read/biff/PrintHeadersRecord;->printHeaders:Z

    return-void
.end method


# virtual methods
.method public getPrintHeaders()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/read/biff/PrintHeadersRecord;->printHeaders:Z

    return v0
.end method
