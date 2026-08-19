.class public abstract Ljxl/write/biff/LabelRecord;
.super Ljxl/write/biff/CellValue;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$LabelRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private contents:Ljava/lang/String;

.field private index:I

.field private sharedStrings:Ljxl/write/biff/SharedStrings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/LabelRecord;->class$jxl$write$biff$LabelRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.LabelRecord"

    invoke-static {v0}, Ljxl/write/biff/LabelRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/LabelRecord;->class$jxl$write$biff$LabelRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/LabelRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method protected constructor <init>(IILjava/lang/String;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;II)V

    iput-object p3, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    if-nez p3, :cond_0

    const-string p1, ""

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method protected constructor <init>(IILjava/lang/String;Ljxl/format/CellFormat;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p4}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/format/CellFormat;)V

    iput-object p3, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    if-nez p3, :cond_0

    const-string p1, ""

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method protected constructor <init>(IILjxl/write/biff/LabelRecord;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1, p2, p3}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;IILjxl/write/biff/CellValue;)V

    iget-object p1, p3, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    return-void
.end method

.method protected constructor <init>(Ljxl/LabelCell;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    invoke-direct {p0, v0, p1}, Ljxl/write/biff/CellValue;-><init>(Ljxl/biff/Type;Ljxl/Cell;)V

    invoke-interface {p1}, Ljxl/LabelCell;->getString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    if-nez p1, :cond_0

    const-string p1, ""

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1

    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/NoClassDefFoundError;

    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getContents()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    return-object v0
.end method

.method public getData()[B
    .locals 4

    invoke-super {p0}, Ljxl/write/biff/CellValue;->getData()[B

    move-result-object v0

    array-length v1, v0

    add-int/lit8 v1, v1, 0x4

    new-array v1, v1, [B

    array-length v2, v0

    const/4 v3, 0x0

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget v2, p0, Ljxl/write/biff/LabelRecord;->index:I

    array-length v0, v0

    invoke-static {v2, v1, v0}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-object v1
.end method

.method public getString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Ljxl/CellType;
    .locals 1

    sget-object v0, Ljxl/CellType;->LABEL:Ljxl/CellType;

    return-object v0
.end method

.method setCellDetails(Ljxl/biff/FormattingRecords;Ljxl/write/biff/SharedStrings;Ljxl/write/biff/WritableSheetImpl;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Ljxl/write/biff/CellValue;->setCellDetails(Ljxl/biff/FormattingRecords;Ljxl/write/biff/SharedStrings;Ljxl/write/biff/WritableSheetImpl;)V

    iput-object p2, p0, Ljxl/write/biff/LabelRecord;->sharedStrings:Ljxl/write/biff/SharedStrings;

    iget-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    invoke-virtual {p2, p1}, Ljxl/write/biff/SharedStrings;->getIndex(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/LabelRecord;->index:I

    iget-object p2, p0, Ljxl/write/biff/LabelRecord;->sharedStrings:Ljxl/write/biff/SharedStrings;

    invoke-virtual {p2, p1}, Ljxl/write/biff/SharedStrings;->get(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    return-void
.end method

.method protected setString(Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    const-string p1, ""

    :cond_0
    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    invoke-virtual {p0}, Ljxl/write/biff/CellValue;->isReferenced()Z

    move-result p1

    if-nez p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Ljxl/write/biff/LabelRecord;->sharedStrings:Ljxl/write/biff/SharedStrings;

    if-eqz p1, :cond_2

    const/4 p1, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    :goto_0
    invoke-static {p1}, Ljxl/common/Assert;->verify(Z)V

    iget-object p1, p0, Ljxl/write/biff/LabelRecord;->sharedStrings:Ljxl/write/biff/SharedStrings;

    iget-object v0, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljxl/write/biff/SharedStrings;->getIndex(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/LabelRecord;->index:I

    iget-object v0, p0, Ljxl/write/biff/LabelRecord;->sharedStrings:Ljxl/write/biff/SharedStrings;

    invoke-virtual {v0, p1}, Ljxl/write/biff/SharedStrings;->get(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/LabelRecord;->contents:Ljava/lang/String;

    return-void
.end method
