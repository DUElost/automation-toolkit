.class Ljxl/write/biff/ExternalSheetRecord$XTI;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/write/biff/ExternalSheetRecord;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "XTI"
.end annotation


# instance fields
.field firstTab:I

.field lastTab:I

.field supbookIndex:I


# direct methods
.method constructor <init>(III)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->supbookIndex:I

    iput p2, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    iput p3, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    return-void
.end method


# virtual methods
.method sheetInserted(I)V
    .locals 1

    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    if-lt v0, p1, :cond_0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    :cond_0
    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    if-lt v0, p1, :cond_1

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    :cond_1
    return-void
.end method

.method sheetRemoved(I)V
    .locals 2

    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    const/4 v1, 0x0

    if-ne v0, p1, :cond_0

    iput v1, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    :cond_0
    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    if-ne v0, p1, :cond_1

    iput v1, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    :cond_1
    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    if-le v0, p1, :cond_2

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->firstTab:I

    :cond_2
    iget v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    if-le v0, p1, :cond_3

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ljxl/write/biff/ExternalSheetRecord$XTI;->lastTab:I

    :cond_3
    return-void
.end method
