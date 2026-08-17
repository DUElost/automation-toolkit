.class public Ljxl/common/BaseUnit;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private index:I


# direct methods
.method protected constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/common/BaseUnit;->index:I

    return-void
.end method


# virtual methods
.method protected getIndex()I
    .locals 1

    iget v0, p0, Ljxl/common/BaseUnit;->index:I

    return v0
.end method
