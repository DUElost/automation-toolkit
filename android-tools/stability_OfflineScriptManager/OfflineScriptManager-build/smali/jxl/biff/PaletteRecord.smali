.class public Ljxl/biff/PaletteRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field private static final numColours:I = 0x38


# instance fields
.field private dirty:Z

.field private initialized:Z

.field private read:Z

.field private rgbColours:[Ljxl/format/RGB;


# direct methods
.method public constructor <init>()V
    .locals 6

    sget-object v0, Ljxl/biff/Type;->PALETTE:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/16 v0, 0x38

    new-array v0, v0, [Ljxl/format/RGB;

    iput-object v0, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/PaletteRecord;->initialized:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/PaletteRecord;->dirty:Z

    iput-boolean v0, p0, Ljxl/biff/PaletteRecord;->read:Z

    invoke-static {}, Ljxl/format/Colour;->getAllColours()[Ljxl/format/Colour;

    move-result-object v1

    :goto_0
    array-length v2, v1

    if-ge v0, v2, :cond_0

    aget-object v2, v1, v0

    invoke-virtual {v2}, Ljxl/format/Colour;->getDefaultRGB()Ljxl/format/RGB;

    move-result-object v3

    invoke-virtual {v3}, Ljxl/format/RGB;->getRed()I

    move-result v3

    invoke-virtual {v2}, Ljxl/format/Colour;->getDefaultRGB()Ljxl/format/RGB;

    move-result-object v4

    invoke-virtual {v4}, Ljxl/format/RGB;->getGreen()I

    move-result v4

    invoke-virtual {v2}, Ljxl/format/Colour;->getDefaultRGB()Ljxl/format/RGB;

    move-result-object v5

    invoke-virtual {v5}, Ljxl/format/RGB;->getBlue()I

    move-result v5

    invoke-virtual {p0, v2, v3, v4, v5}, Ljxl/biff/PaletteRecord;->setColourRGB(Ljxl/format/Colour;III)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    const/16 p1, 0x38

    new-array p1, p1, [Ljxl/format/RGB;

    iput-object p1, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/PaletteRecord;->initialized:Z

    iput-boolean p1, p0, Ljxl/biff/PaletteRecord;->dirty:Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/PaletteRecord;->read:Z

    return-void
.end method

.method private initialize()V
    .locals 10

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    const/4 v1, 0x0

    aget-byte v2, v0, v1

    const/4 v3, 0x1

    aget-byte v4, v0, v3

    invoke-static {v2, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    move v4, v1

    :goto_0
    if-ge v4, v2, :cond_0

    mul-int/lit8 v5, v4, 0x4

    add-int/lit8 v5, v5, 0x2

    aget-byte v6, v0, v5

    invoke-static {v6, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v6

    add-int/lit8 v7, v5, 0x1

    aget-byte v7, v0, v7

    invoke-static {v7, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v7

    add-int/lit8 v5, v5, 0x2

    aget-byte v5, v0, v5

    invoke-static {v5, v1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v5

    iget-object v8, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    new-instance v9, Ljxl/format/RGB;

    invoke-direct {v9, v6, v7, v5}, Ljxl/format/RGB;-><init>(III)V

    aput-object v9, v8, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    iput-boolean v3, p0, Ljxl/biff/PaletteRecord;->initialized:Z

    return-void
.end method

.method private setValueRange(III)I
    .locals 0

    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {p1, p3}, Ljava/lang/Math;->min(II)I

    move-result p1

    return p1
.end method


# virtual methods
.method public getColourRGB(Ljxl/format/Colour;)Ljxl/format/RGB;
    .locals 2

    invoke-virtual {p1}, Ljxl/format/Colour;->getValue()I

    move-result v0

    add-int/lit8 v0, v0, -0x8

    if-ltz v0, :cond_2

    const/16 v1, 0x38

    if-lt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-boolean p1, p0, Ljxl/biff/PaletteRecord;->initialized:Z

    if-nez p1, :cond_1

    invoke-direct {p0}, Ljxl/biff/PaletteRecord;->initialize()V

    :cond_1
    iget-object p1, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    aget-object p1, p1, v0

    return-object p1

    :cond_2
    :goto_0
    invoke-virtual {p1}, Ljxl/format/Colour;->getDefaultRGB()Ljxl/format/RGB;

    move-result-object p1

    return-object p1
.end method

.method public getData()[B
    .locals 6

    iget-boolean v0, p0, Ljxl/biff/PaletteRecord;->read:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Ljxl/biff/PaletteRecord;->dirty:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    return-object v0

    :cond_0
    const/16 v0, 0xe2

    new-array v0, v0, [B

    const/16 v1, 0x38

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :goto_0
    if-ge v2, v1, :cond_1

    mul-int/lit8 v3, v2, 0x4

    add-int/lit8 v3, v3, 0x2

    iget-object v4, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    aget-object v4, v4, v2

    invoke-virtual {v4}, Ljxl/format/RGB;->getRed()I

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, v0, v3

    add-int/lit8 v4, v3, 0x1

    iget-object v5, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    aget-object v5, v5, v2

    invoke-virtual {v5}, Ljxl/format/RGB;->getGreen()I

    move-result v5

    int-to-byte v5, v5

    aput-byte v5, v0, v4

    add-int/lit8 v3, v3, 0x2

    iget-object v4, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    aget-object v4, v4, v2

    invoke-virtual {v4}, Ljxl/format/RGB;->getBlue()I

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, v0, v3

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public isDirty()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/PaletteRecord;->dirty:Z

    return v0
.end method

.method public setColourRGB(Ljxl/format/Colour;III)V
    .locals 2

    invoke-virtual {p1}, Ljxl/format/Colour;->getValue()I

    move-result p1

    add-int/lit8 p1, p1, -0x8

    if-ltz p1, :cond_2

    const/16 v0, 0x38

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-boolean v0, p0, Ljxl/biff/PaletteRecord;->initialized:Z

    if-nez v0, :cond_1

    invoke-direct {p0}, Ljxl/biff/PaletteRecord;->initialize()V

    :cond_1
    const/4 v0, 0x0

    const/16 v1, 0xff

    invoke-direct {p0, p2, v0, v1}, Ljxl/biff/PaletteRecord;->setValueRange(III)I

    move-result p2

    invoke-direct {p0, p3, v0, v1}, Ljxl/biff/PaletteRecord;->setValueRange(III)I

    move-result p3

    invoke-direct {p0, p4, v0, v1}, Ljxl/biff/PaletteRecord;->setValueRange(III)I

    move-result p4

    iget-object v0, p0, Ljxl/biff/PaletteRecord;->rgbColours:[Ljxl/format/RGB;

    new-instance v1, Ljxl/format/RGB;

    invoke-direct {v1, p2, p3, p4}, Ljxl/format/RGB;-><init>(III)V

    aput-object v1, v0, p1

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/PaletteRecord;->dirty:Z

    :cond_2
    :goto_0
    return-void
.end method
