.class public final Ljxl/CellView;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private autosize:Z

.field private depUsed:Z

.field private dimension:I

.field private format:Ljxl/format/CellFormat;

.field private hidden:Z

.field private size:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/CellView;->hidden:Z

    iput-boolean v0, p0, Ljxl/CellView;->depUsed:Z

    const/4 v1, 0x1

    iput v1, p0, Ljxl/CellView;->dimension:I

    iput v1, p0, Ljxl/CellView;->size:I

    iput-boolean v0, p0, Ljxl/CellView;->autosize:Z

    return-void
.end method

.method public constructor <init>(Ljxl/CellView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-boolean v0, p1, Ljxl/CellView;->hidden:Z

    iput-boolean v0, p0, Ljxl/CellView;->hidden:Z

    iget-boolean v0, p1, Ljxl/CellView;->depUsed:Z

    iput-boolean v0, p0, Ljxl/CellView;->depUsed:Z

    iget v0, p1, Ljxl/CellView;->dimension:I

    iput v0, p0, Ljxl/CellView;->dimension:I

    iget v0, p1, Ljxl/CellView;->size:I

    iput v0, p0, Ljxl/CellView;->size:I

    iget-boolean p1, p1, Ljxl/CellView;->autosize:Z

    iput-boolean p1, p0, Ljxl/CellView;->autosize:Z

    return-void
.end method


# virtual methods
.method public depUsed()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/CellView;->depUsed:Z

    return v0
.end method

.method public getDimension()I
    .locals 1

    iget v0, p0, Ljxl/CellView;->dimension:I

    return v0
.end method

.method public getFormat()Ljxl/format/CellFormat;
    .locals 1

    iget-object v0, p0, Ljxl/CellView;->format:Ljxl/format/CellFormat;

    return-object v0
.end method

.method public getSize()I
    .locals 1

    iget v0, p0, Ljxl/CellView;->size:I

    return v0
.end method

.method public isAutosize()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/CellView;->autosize:Z

    return v0
.end method

.method public isHidden()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/CellView;->hidden:Z

    return v0
.end method

.method public setAutosize(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/CellView;->autosize:Z

    return-void
.end method

.method public setDimension(I)V
    .locals 0

    iput p1, p0, Ljxl/CellView;->dimension:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/CellView;->depUsed:Z

    return-void
.end method

.method public setFormat(Ljxl/format/CellFormat;)V
    .locals 0

    iput-object p1, p0, Ljxl/CellView;->format:Ljxl/format/CellFormat;

    return-void
.end method

.method public setHidden(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/CellView;->hidden:Z

    return-void
.end method

.method public setSize(I)V
    .locals 0

    iput p1, p0, Ljxl/CellView;->size:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/CellView;->depUsed:Z

    return-void
.end method
