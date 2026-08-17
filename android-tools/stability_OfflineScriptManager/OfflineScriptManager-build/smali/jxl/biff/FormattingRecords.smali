.class public Ljxl/biff/FormattingRecords;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$biff$FormattingRecords:Ljava/lang/Class; = null

.field private static final customFormatStartIndex:I = 0xa4

.field private static logger:Ljxl/common/Logger; = null

.field private static final maxFormatRecordsIndex:I = 0x1b9

.field private static final minXFRecords:I = 0x15


# instance fields
.field private fonts:Ljxl/biff/Fonts;

.field private formats:Ljava/util/HashMap;

.field private formatsList:Ljava/util/ArrayList;

.field private nextCustomIndexNumber:I

.field private palette:Ljxl/biff/PaletteRecord;

.field private xfRecords:Ljava/util/ArrayList;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/FormattingRecords;->class$jxl$biff$FormattingRecords:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.FormattingRecords"

    invoke-static {v0}, Ljxl/biff/FormattingRecords;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/FormattingRecords;->class$jxl$biff$FormattingRecords:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/FormattingRecords;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/Fonts;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    iput-object p1, p0, Ljxl/biff/FormattingRecords;->fonts:Ljxl/biff/Fonts;

    const/16 p1, 0xa4

    iput p1, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

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
.method public final addFormat(Ljxl/biff/DisplayFormat;)V
    .locals 3

    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->isInitialized()Z

    move-result v0

    const/16 v1, 0x1b9

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v0

    if-lt v0, v1, :cond_0

    sget-object v0, Ljxl/biff/FormattingRecords;->logger:Ljxl/common/Logger;

    const-string v2, "Format index exceeds Excel maximum - assigning custom number"

    invoke-virtual {v0, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    iget v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    invoke-interface {p1, v0}, Ljxl/biff/DisplayFormat;->initialize(I)V

    iget v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    :cond_0
    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_1

    iget v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    invoke-interface {p1, v0}, Ljxl/biff/DisplayFormat;->initialize(I)V

    iget v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    :cond_1
    iget v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    if-gt v0, v1, :cond_4

    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v0

    iget v1, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    if-lt v0, v1, :cond_2

    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    :cond_2
    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->isBuiltIn()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v1, Ljava/lang/Integer;

    invoke-interface {p1}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    return-void

    :cond_4
    iput v1, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    new-instance p1, Ljxl/biff/NumFormatRecordsException;

    invoke-direct {p1}, Ljxl/biff/NumFormatRecordsException;-><init>()V

    throw p1
.end method

.method public final addStyle(Ljxl/biff/XFRecord;)V
    .locals 2

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Ljxl/biff/FormattingRecords;->fonts:Ljxl/biff/Fonts;

    invoke-virtual {p1, v0, p0, v1}, Ljxl/biff/XFRecord;->initialize(ILjxl/biff/FormattingRecords;Ljxl/biff/Fonts;)V

    :goto_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v0

    iget-object v1, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method public getColourRGB(Ljxl/format/Colour;)Ljxl/format/RGB;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljxl/format/Colour;->getDefaultRGB()Ljxl/format/RGB;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {v0, p1}, Ljxl/biff/PaletteRecord;->getColourRGB(Ljxl/format/Colour;)Ljxl/format/RGB;

    move-result-object p1

    return-object p1
.end method

.method public final getDateFormat(I)Ljava/text/DateFormat;
    .locals 2

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/XFRecord;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->isDate()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getDateFormat()Ljava/text/DateFormat;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result p1

    invoke-direct {v1, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/FormatRecord;

    const/4 v0, 0x0

    if-nez p1, :cond_1

    return-object v0

    :cond_1
    invoke-virtual {p1}, Ljxl/biff/FormatRecord;->isDate()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljxl/biff/FormatRecord;->getDateFormat()Ljava/text/DateFormat;

    move-result-object v0

    :cond_2
    return-object v0
.end method

.method protected final getFonts()Ljxl/biff/Fonts;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->fonts:Ljxl/biff/Fonts;

    return-object v0
.end method

.method getFormatRecord(I)Ljxl/biff/FormatRecord;
    .locals 2

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v1, Ljava/lang/Integer;

    invoke-direct {v1, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/FormatRecord;

    return-object p1
.end method

.method public final getNumberFormat(I)Ljava/text/NumberFormat;
    .locals 2

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/XFRecord;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->isNumber()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getNumberFormat()Ljava/text/NumberFormat;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result p1

    invoke-direct {v1, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/FormatRecord;

    const/4 v0, 0x0

    if-nez p1, :cond_1

    return-object v0

    :cond_1
    invoke-virtual {p1}, Ljxl/biff/FormatRecord;->isNumber()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljxl/biff/FormatRecord;->getNumberFormat()Ljava/text/NumberFormat;

    move-result-object v0

    :cond_2
    return-object v0
.end method

.method protected final getNumberOfFormatRecords()I
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public getPalette()Ljxl/biff/PaletteRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    return-object v0
.end method

.method public final getXFRecord(I)Ljxl/biff/XFRecord;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/XFRecord;

    return-object p1
.end method

.method public final isDate(I)Z
    .locals 2

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/XFRecord;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->isDate()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formats:Ljava/util/HashMap;

    new-instance v1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result p1

    invoke-direct {v1, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/FormatRecord;

    if-nez p1, :cond_1

    const/4 p1, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Ljxl/biff/FormatRecord;->isDate()Z

    move-result p1

    :goto_0
    return p1
.end method

.method public rationalize(Ljxl/biff/IndexMapping;Ljxl/biff/IndexMapping;)Ljxl/biff/IndexMapping;
    .locals 8

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/XFRecord;

    invoke-virtual {v1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result v2

    const/16 v3, 0xa4

    if-lt v2, v3, :cond_0

    invoke-virtual {v1}, Ljxl/biff/XFRecord;->getFormatRecord()I

    move-result v2

    invoke-virtual {p2, v2}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljxl/biff/XFRecord;->setFormatIndex(I)V

    :cond_0
    invoke-virtual {v1}, Ljxl/biff/XFRecord;->getFontIndex()I

    move-result v2

    invoke-virtual {p1, v2}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljxl/biff/XFRecord;->setFontIndex(I)V

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/util/ArrayList;

    const/16 p2, 0x15

    invoke-direct {p1, p2}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v0, Ljxl/biff/IndexMapping;

    iget-object v1, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljxl/biff/IndexMapping;-><init>(I)V

    iget-object v1, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-static {p2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/4 v2, 0x0

    move v3, v2

    :goto_1
    if-ge v3, v1, :cond_2

    iget-object v4, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v3, v3}, Ljxl/biff/IndexMapping;->setMapping(II)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    if-ge v1, p2, :cond_3

    sget-object p1, Ljxl/biff/FormattingRecords;->logger:Ljxl/common/Logger;

    const-string p2, "There are less than the expected minimum number of XF records"

    invoke-virtual {p1, p2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    return-object v0

    :cond_3
    move v1, v2

    :goto_2
    iget-object v3, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge p2, v3, :cond_7

    iget-object v3, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v3, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/biff/XFRecord;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v5, v2

    :cond_4
    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    if-nez v5, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/biff/XFRecord;

    invoke-virtual {v6, v3}, Ljxl/biff/XFRecord;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    invoke-virtual {v6}, Ljxl/biff/XFRecord;->getXFIndex()I

    move-result v5

    invoke-virtual {v0, v5}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v5

    invoke-virtual {v0, p2, v5}, Ljxl/biff/IndexMapping;->setMapping(II)V

    add-int/lit8 v1, v1, 0x1

    const/4 v5, 0x1

    goto :goto_3

    :cond_5
    if-nez v5, :cond_6

    invoke-virtual {p1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    sub-int v3, p2, v1

    invoke-virtual {v0, p2, v3}, Ljxl/biff/IndexMapping;->setMapping(II)V

    :cond_6
    add-int/lit8 p2, p2, 0x1

    goto :goto_2

    :cond_7
    iget-object p2, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_4
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/XFRecord;

    invoke-virtual {v1, v0}, Ljxl/biff/XFRecord;->rationalize(Ljxl/biff/IndexMapping;)V

    goto :goto_4

    :cond_8
    iput-object p1, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    return-object v0
.end method

.method public rationalizeDisplayFormats()Ljxl/biff/IndexMapping;
    .locals 11

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljxl/biff/IndexMapping;

    iget v2, p0, Ljxl/biff/FormattingRecords;->nextCustomIndexNumber:I

    invoke-direct {v1, v2}, Ljxl/biff/IndexMapping;-><init>(I)V

    iget-object v2, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v3, 0x0

    move v4, v3

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/DisplayFormat;

    invoke-interface {v5}, Ljxl/biff/DisplayFormat;->isBuiltIn()Z

    move-result v6

    const/4 v7, 0x1

    xor-int/2addr v6, v7

    invoke-static {v6}, Ljxl/common/Assert;->verify(Z)V

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v8, v3

    :cond_1
    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_2

    if-nez v8, :cond_2

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljxl/biff/DisplayFormat;

    invoke-virtual {v9, v5}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_1

    invoke-interface {v5}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v8

    invoke-interface {v9}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v9

    invoke-virtual {v1, v9}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v9

    invoke-virtual {v1, v8, v9}, Ljxl/biff/IndexMapping;->setMapping(II)V

    add-int/lit8 v4, v4, 0x1

    move v8, v7

    goto :goto_1

    :cond_2
    if-nez v8, :cond_0

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-interface {v5}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v6

    sub-int/2addr v6, v4

    const/16 v7, 0x1b9

    if-le v6, v7, :cond_3

    sget-object v6, Ljxl/biff/FormattingRecords;->logger:Ljxl/common/Logger;

    const-string v7, "Too many number formats - using default format."

    invoke-virtual {v6, v7}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_3
    invoke-interface {v5}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v6

    invoke-interface {v5}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v5

    sub-int/2addr v5, v4

    invoke-virtual {v1, v6, v5}, Ljxl/biff/IndexMapping;->setMapping(II)V

    goto :goto_0

    :cond_4
    iput-object v0, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/DisplayFormat;

    invoke-interface {v2}, Ljxl/biff/DisplayFormat;->getFormatIndex()I

    move-result v3

    invoke-virtual {v1, v3}, Ljxl/biff/IndexMapping;->getNewIndex(I)I

    move-result v3

    invoke-interface {v2, v3}, Ljxl/biff/DisplayFormat;->initialize(I)V

    goto :goto_2

    :cond_5
    return-object v1
.end method

.method public rationalizeFonts()Ljxl/biff/IndexMapping;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->fonts:Ljxl/biff/Fonts;

    invoke-virtual {v0}, Ljxl/biff/Fonts;->rationalize()Ljxl/biff/IndexMapping;

    move-result-object v0

    return-object v0
.end method

.method public setColourRGB(Ljxl/format/Colour;III)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/biff/PaletteRecord;

    invoke-direct {v0}, Ljxl/biff/PaletteRecord;-><init>()V

    iput-object v0, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    :cond_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    invoke-virtual {v0, p1, p2, p3, p4}, Ljxl/biff/PaletteRecord;->setColourRGB(Ljxl/format/Colour;III)V

    return-void
.end method

.method public setPalette(Ljxl/biff/PaletteRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/FormattingRecords;->palette:Ljxl/biff/PaletteRecord;

    return-void
.end method

.method public write(Ljxl/write/biff/File;)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/FormattingRecords;->formatsList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/FormatRecord;

    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ljxl/biff/FormattingRecords;->xfRecords:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/XFRecord;

    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto :goto_1

    :cond_1
    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/16 v1, 0x10

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/16 v1, 0x11

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/16 v1, 0x12

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/16 v1, 0x13

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/4 v1, 0x0

    invoke-direct {v0, v1, v1}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/biff/BuiltInStyle;

    const/16 v1, 0x14

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInStyle;-><init>(II)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void
.end method
