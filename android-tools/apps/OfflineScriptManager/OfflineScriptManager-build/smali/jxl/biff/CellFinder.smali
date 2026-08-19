.class public Ljxl/biff/CellFinder;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private sheet:Ljxl/Sheet;


# direct methods
.method public constructor <init>(Ljxl/Sheet;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    return-void
.end method


# virtual methods
.method public findCell(Ljava/lang/String;)Ljxl/Cell;
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x0

    move v2, v0

    move v3, v2

    :goto_0
    iget-object v4, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v4}, Ljxl/Sheet;->getRows()I

    move-result v4

    if-ge v2, v4, :cond_2

    if-nez v3, :cond_2

    iget-object v4, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v4, v2}, Ljxl/Sheet;->getRow(I)[Ljxl/Cell;

    move-result-object v4

    move v5, v0

    :goto_1
    array-length v6, v4

    if-ge v5, v6, :cond_1

    if-nez v3, :cond_1

    aget-object v6, v4, v5

    invoke-interface {v6}, Ljxl/Cell;->getContents()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    aget-object v1, v4, v5

    const/4 v3, 0x1

    :cond_0
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-object v1
.end method

.method public findCell(Ljava/lang/String;IIIIZ)Ljxl/Cell;
    .locals 9

    sub-int v0, p4, p2

    sub-int v1, p5, p3

    if-eqz p6, :cond_0

    move p3, p5

    :cond_0
    if-eqz p6, :cond_1

    move p2, p4

    :cond_1
    const/4 p4, 0x1

    if-eqz p6, :cond_2

    const/4 p5, -0x1

    goto :goto_0

    :cond_2
    move p5, p4

    :goto_0
    const/4 p6, 0x0

    const/4 v2, 0x0

    move v3, p6

    move v4, v3

    :goto_1
    if-gt v3, v0, :cond_5

    if-nez v4, :cond_5

    move v5, p6

    :goto_2
    if-gt v5, v1, :cond_4

    if-nez v4, :cond_4

    mul-int v6, v3, p5

    add-int/2addr v6, p2

    mul-int v7, v5, p5

    add-int/2addr v7, p3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8}, Ljxl/Sheet;->getColumns()I

    move-result v8

    if-ge v6, v8, :cond_3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8}, Ljxl/Sheet;->getRows()I

    move-result v8

    if-ge v7, v8, :cond_3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8, v6, v7}, Ljxl/Sheet;->getCell(II)Ljxl/Cell;

    move-result-object v6

    invoke-interface {v6}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v7

    sget-object v8, Ljxl/CellType;->EMPTY:Ljxl/CellType;

    if-eq v7, v8, :cond_3

    invoke-interface {v6}, Ljxl/Cell;->getContents()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    move v4, p4

    move-object v2, v6

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_5
    return-object v2
.end method

.method public findCell(Ljava/util/regex/Pattern;IIIIZ)Ljxl/Cell;
    .locals 9

    sub-int v0, p4, p2

    sub-int v1, p5, p3

    if-eqz p6, :cond_0

    move p3, p5

    :cond_0
    if-eqz p6, :cond_1

    move p2, p4

    :cond_1
    const/4 p4, 0x1

    if-eqz p6, :cond_2

    const/4 p5, -0x1

    goto :goto_0

    :cond_2
    move p5, p4

    :goto_0
    const/4 p6, 0x0

    const/4 v2, 0x0

    move v3, p6

    move v4, v3

    :goto_1
    if-gt v3, v0, :cond_5

    if-nez v4, :cond_5

    move v5, p6

    :goto_2
    if-gt v5, v1, :cond_4

    if-nez v4, :cond_4

    mul-int v6, v3, p5

    add-int/2addr v6, p2

    mul-int v7, v5, p5

    add-int/2addr v7, p3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8}, Ljxl/Sheet;->getColumns()I

    move-result v8

    if-ge v6, v8, :cond_3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8}, Ljxl/Sheet;->getRows()I

    move-result v8

    if-ge v7, v8, :cond_3

    iget-object v8, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v8, v6, v7}, Ljxl/Sheet;->getCell(II)Ljxl/Cell;

    move-result-object v6

    invoke-interface {v6}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v7

    sget-object v8, Ljxl/CellType;->EMPTY:Ljxl/CellType;

    if-eq v7, v8, :cond_3

    invoke-interface {v6}, Ljxl/Cell;->getContents()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1, v7}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v7

    invoke-virtual {v7}, Ljava/util/regex/Matcher;->matches()Z

    move-result v7

    if-eqz v7, :cond_3

    move v4, p4

    move-object v2, v6

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_5
    return-object v2
.end method

.method public findLabelCell(Ljava/lang/String;)Ljxl/LabelCell;
    .locals 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    move v2, v0

    move v3, v2

    :goto_0
    iget-object v4, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v4}, Ljxl/Sheet;->getRows()I

    move-result v4

    if-ge v2, v4, :cond_3

    if-nez v3, :cond_3

    iget-object v4, p0, Ljxl/biff/CellFinder;->sheet:Ljxl/Sheet;

    invoke-interface {v4, v2}, Ljxl/Sheet;->getRow(I)[Ljxl/Cell;

    move-result-object v4

    move v5, v0

    :goto_1
    array-length v6, v4

    if-ge v5, v6, :cond_2

    if-nez v3, :cond_2

    aget-object v6, v4, v5

    invoke-interface {v6}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v6

    sget-object v7, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-eq v6, v7, :cond_0

    aget-object v6, v4, v5

    invoke-interface {v6}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v6

    sget-object v7, Ljxl/CellType;->STRING_FORMULA:Ljxl/CellType;

    if-ne v6, v7, :cond_1

    :cond_0
    aget-object v6, v4, v5

    invoke-interface {v6}, Ljxl/Cell;->getContents()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    aget-object v1, v4, v5

    check-cast v1, Ljxl/LabelCell;

    const/4 v3, 0x1

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_3
    return-object v1
.end method
