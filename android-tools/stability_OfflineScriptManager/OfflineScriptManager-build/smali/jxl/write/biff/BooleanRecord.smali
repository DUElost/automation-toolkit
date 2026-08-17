.class public abstract Ljxl/write/biff/BooleanRecord;
.super Ljxl/write/biff/CellValue;
.source ""


# instance fields
.field private value:Z


# direct methods
.method protected constructor <init>(IILjxl/write/biff/BooleanRecord;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p3}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/write/biff/CellValue;)V

    iget-boolean p1, p3, Ljxl/write/biff/BooleanRecord;->value:Z

    iput-boolean p1, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return-void
.end method

.method protected constructor <init>(IIZ)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;II)V

    iput-boolean p3, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return-void
.end method

.method protected constructor <init>(IIZLjxl/format/CellFormat;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p4}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/format/CellFormat;)V

    iput-boolean p3, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return-void
.end method

.method protected constructor <init>(Ljxl/BooleanCell;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;Ljxl/Cell;)V

    invoke-interface {p1}, Ljxl/BooleanCell;->getValue()Z

    move-result p1

    iput-boolean p1, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return-void
.end method


# virtual methods
.method public getContents()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/Boolean;

    iget-boolean v1, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    invoke-direct {v0, v1}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v0}, Ljava/lang/Boolean;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getData()[B
    .locals 4

    invoke-super {p0}, Ljxl/write/biff/CellValue;->getData()[B

    move-result-object v0

    array-length v1, v0

    add-int/lit8 v1, v1, 0x2

    new-array v1, v1, [B

    array-length v2, v0

    const/4 v3, 0x0

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-boolean v2, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    if-eqz v2, :cond_0

    array-length v0, v0

    const/4 v2, 0x1

    aput-byte v2, v1, v0

    :cond_0
    return-object v1
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->BOOLEAN:Ljxl/CellType;

    return-object v0
.end method

.method public getValue()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return v0
.end method

.method protected setValue(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/write/biff/BooleanRecord;->value:Z

    return-void
.end method
