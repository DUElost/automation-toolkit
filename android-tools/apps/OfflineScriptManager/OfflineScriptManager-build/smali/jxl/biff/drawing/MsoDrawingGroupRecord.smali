.class public Ljxl/biff/drawing/MsoDrawingGroupRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private data:[B


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/drawing/MsoDrawingGroupRecord;->data:[B

    return-void
.end method

.method constructor <init>([B)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->MSODRAWINGGROUP:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-object p1, p0, Ljxl/biff/drawing/MsoDrawingGroupRecord;->data:[B

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/MsoDrawingGroupRecord;->data:[B

    return-object v0
.end method
