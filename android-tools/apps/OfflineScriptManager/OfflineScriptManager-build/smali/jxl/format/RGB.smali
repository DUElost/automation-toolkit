.class public final Ljxl/format/RGB;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private blue:I

.field private green:I

.field private red:I


# direct methods
.method public constructor <init>(III)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/format/RGB;->red:I

    iput p2, p0, Ljxl/format/RGB;->green:I

    iput p3, p0, Ljxl/format/RGB;->blue:I

    return-void
.end method


# virtual methods
.method public getBlue()I
    .locals 1

    iget v0, p0, Ljxl/format/RGB;->blue:I

    return v0
.end method

.method public getGreen()I
    .locals 1

    iget v0, p0, Ljxl/format/RGB;->green:I

    return v0
.end method

.method public getRed()I
    .locals 1

    iget v0, p0, Ljxl/format/RGB;->red:I

    return v0
.end method
