.class final Ljxl/biff/drawing/Dgg$Cluster;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/drawing/Dgg;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Cluster"
.end annotation


# instance fields
.field drawingGroupId:I

.field shapeIdsUsed:I


# direct methods
.method constructor <init>(II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/Dgg$Cluster;->drawingGroupId:I

    iput p2, p0, Ljxl/biff/drawing/Dgg$Cluster;->shapeIdsUsed:I

    return-void
.end method
