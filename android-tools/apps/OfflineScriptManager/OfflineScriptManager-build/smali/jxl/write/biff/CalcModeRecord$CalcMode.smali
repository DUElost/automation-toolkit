.class Ljxl/write/biff/CalcModeRecord$CalcMode;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/write/biff/CalcModeRecord;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CalcMode"
.end annotation


# instance fields
.field value:I


# direct methods
.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/write/biff/CalcModeRecord$CalcMode;->value:I

    return-void
.end method
