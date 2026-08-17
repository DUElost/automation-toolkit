.class Ljxl/write/biff/PaneRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field private static final bottomLeftPane:I = 0x2

.field private static final bottomRightPane:I = 0x0

.field private static final topLeftPane:I = 0x3

.field private static final topRightPane:I = 0x1


# instance fields
.field private columnsVisible:I

.field private rowsVisible:I


# direct methods
.method public constructor <init>(II)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->PANE:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p2, p0, Ljxl/write/biff/PaneRecord;->rowsVisible:I

    iput p1, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 6

    const/16 v0, 0xa

    new-array v0, v0, [B

    iget v1, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/PaneRecord;->rowsVisible:I

    const/4 v3, 0x2

    invoke-static {v1, v0, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/PaneRecord;->rowsVisible:I

    if-lez v1, :cond_0

    const/4 v4, 0x4

    invoke-static {v1, v0, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :cond_0
    iget v1, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    if-lez v1, :cond_1

    const/4 v4, 0x6

    invoke-static {v1, v0, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :cond_1
    const/4 v1, 0x3

    iget v4, p0, Ljxl/write/biff/PaneRecord;->rowsVisible:I

    if-lez v4, :cond_2

    iget v5, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    if-nez v5, :cond_2

    move v2, v3

    goto :goto_0

    :cond_2
    if-nez v4, :cond_3

    iget v3, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    if-lez v3, :cond_3

    const/4 v2, 0x1

    goto :goto_0

    :cond_3
    if-lez v4, :cond_4

    iget v3, p0, Ljxl/write/biff/PaneRecord;->columnsVisible:I

    if-lez v3, :cond_4

    goto :goto_0

    :cond_4
    move v2, v1

    :goto_0
    const/16 v1, 0x8

    invoke-static {v2, v0, v1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v0
.end method
