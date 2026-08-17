.class public abstract Ljxl/write/biff/NumberRecord;
.super Ljxl/write/biff/CellValue;
.source ""


# static fields
.field private static defaultFormat:Ljava/text/DecimalFormat;


# instance fields
.field private format:Ljava/text/NumberFormat;

.field private value:D


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/text/DecimalFormat;

    const-string v1, "#.###"

    invoke-direct {v0, v1}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/write/biff/NumberRecord;->defaultFormat:Ljava/text/DecimalFormat;

    return-void
.end method

.method protected constructor <init>(IID)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;II)V

    iput-wide p3, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-void
.end method

.method protected constructor <init>(IIDLjxl/format/CellFormat;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p5}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/format/CellFormat;)V

    iput-wide p3, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-void
.end method

.method protected constructor <init>(IILjxl/write/biff/NumberRecord;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p3}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/write/biff/CellValue;)V

    iget-wide p1, p3, Ljxl/write/biff/NumberRecord;->value:D

    iput-wide p1, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-void
.end method

.method protected constructor <init>(Ljxl/NumberCell;)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;Ljxl/Cell;)V

    invoke-interface {p1}, Ljxl/NumberCell;->getValue()D

    move-result-wide v0

    iput-wide v0, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-void
.end method


# virtual methods
.method public getContents()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/NumberRecord;->format:Ljava/text/NumberFormat;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljxl/write/biff/CellValue;->getCellFormat()Ljxl/format/CellFormat;

    move-result-object v0

    check-cast v0, Ljxl/biff/XFRecord;

    invoke-virtual {v0}, Ljxl/biff/XFRecord;->getNumberFormat()Ljava/text/NumberFormat;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/NumberRecord;->format:Ljava/text/NumberFormat;

    if-nez v0, :cond_0

    sget-object v0, Ljxl/write/biff/NumberRecord;->defaultFormat:Ljava/text/DecimalFormat;

    iput-object v0, p0, Ljxl/write/biff/NumberRecord;->format:Ljava/text/NumberFormat;

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/NumberRecord;->format:Ljava/text/NumberFormat;

    iget-wide v1, p0, Ljxl/write/biff/NumberRecord;->value:D

    invoke-virtual {v0, v1, v2}, Ljava/text/NumberFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getData()[B
    .locals 4

    invoke-super {p0}, Ljxl/write/biff/CellValue;->getData()[B

    move-result-object v0

    array-length v1, v0

    add-int/lit8 v1, v1, 0x8

    new-array v1, v1, [B

    array-length v2, v0

    const/4 v3, 0x0

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-wide v2, p0, Ljxl/write/biff/NumberRecord;->value:D

    array-length v0, v0

    invoke-static {v2, v3, v1, v0}, Ljxl/biff/DoubleHelper;->getIEEEBytes(D[BI)V

    return-object v1
.end method

.method public getNumberFormat()Ljava/text/NumberFormat;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->NUMBER:Ljxl/CellType;

    return-object v0
.end method

.method public getValue()D
    .locals 2

    iget-wide v0, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-wide v0
.end method

.method public setValue(D)V
    .locals 0

    iput-wide p1, p0, Ljxl/write/biff/NumberRecord;->value:D

    return-void
.end method
