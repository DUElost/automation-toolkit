.class Ljxl/read/biff/ExternalSheetRecord$XTI;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/read/biff/ExternalSheetRecord;
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

    iput p1, p0, Ljxl/read/biff/ExternalSheetRecord$XTI;->supbookIndex:I

    iput p2, p0, Ljxl/read/biff/ExternalSheetRecord$XTI;->firstTab:I

    iput p3, p0, Ljxl/read/biff/ExternalSheetRecord$XTI;->lastTab:I

    return-void
.end method
