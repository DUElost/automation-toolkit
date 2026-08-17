.class Ljxl/biff/ConditionalFormatRangeRecord$Range;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/ConditionalFormatRangeRecord;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Range"
.end annotation


# instance fields
.field public firstColumn:I

.field public firstRow:I

.field public lastColumn:I

.field public lastRow:I

.field public modified:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    return-void
.end method


# virtual methods
.method public insertColumn(I)V
    .locals 3

    iget v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    const/4 v2, 0x1

    if-gt p1, v1, :cond_1

    add-int/2addr v1, v2

    iput v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_1
    if-gt p1, v0, :cond_2

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_2
    return-void
.end method

.method public insertRow(I)V
    .locals 3

    iget v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    const/4 v2, 0x1

    if-gt p1, v1, :cond_1

    add-int/2addr v1, v2

    iput v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_1
    if-gt p1, v0, :cond_2

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_2
    return-void
.end method

.method public removeColumn(I)V
    .locals 3

    iget v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    const/4 v2, 0x1

    if-ge p1, v1, :cond_1

    sub-int/2addr v1, v2

    iput v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstColumn:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_1
    if-gt p1, v0, :cond_2

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastColumn:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_2
    return-void
.end method

.method public removeRow(I)V
    .locals 3

    iget v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    if-le p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    const/4 v2, 0x1

    if-ge p1, v1, :cond_1

    sub-int/2addr v1, v2

    iput v1, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->firstRow:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_1
    if-gt p1, v0, :cond_2

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->lastRow:I

    iput-boolean v2, p0, Ljxl/biff/ConditionalFormatRangeRecord$Range;->modified:Z

    :cond_2
    return-void
.end method
