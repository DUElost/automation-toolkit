.class public Ljxl/biff/drawing/Drawing$ImageAnchorProperties;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/drawing/Drawing;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xc
    name = "ImageAnchorProperties"
.end annotation


# static fields
.field private static o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;


# instance fields
.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    new-array v0, v0, [Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    sput-object v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    return-void
.end method

.method constructor <init>(I)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->value:I

    sget-object p1, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    array-length v0, p1

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    sput-object v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    array-length v1, p1

    const/4 v2, 0x0

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    array-length p1, p1

    aput-object p0, v0, p1

    return-void
.end method

.method static getImageAnchorProperties(I)Ljxl/biff/drawing/Drawing$ImageAnchorProperties;
    .locals 4

    sget-object v0, Ljxl/biff/drawing/Drawing;->MOVE_AND_SIZE_WITH_CELLS:Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    const/4 v1, 0x0

    :goto_0
    sget-object v2, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    array-length v3, v2

    if-ge v1, v3, :cond_1

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->getValue()I

    move-result v2

    if-ne v2, p0, :cond_0

    sget-object p0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->o:[Ljxl/biff/drawing/Drawing$ImageAnchorProperties;

    aget-object v0, p0, v1

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-object v0
.end method


# virtual methods
.method getValue()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Drawing$ImageAnchorProperties;->value:I

    return v0
.end method
