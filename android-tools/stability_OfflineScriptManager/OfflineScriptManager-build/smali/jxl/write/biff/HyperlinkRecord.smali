.class public Ljxl/write/biff/HyperlinkRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/write/biff/HyperlinkRecord$LinkType;
    }
.end annotation


# static fields
.field static synthetic class$jxl$write$biff$HyperlinkRecord:Ljava/lang/Class;

.field private static final fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

.field private static logger:Ljxl/common/Logger;

.field private static final uncLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

.field private static final unknown:Ljxl/write/biff/HyperlinkRecord$LinkType;

.field private static final urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

.field private static final workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;


# instance fields
.field private contents:Ljava/lang/String;

.field private data:[B

.field private file:Ljava/io/File;

.field private firstColumn:I

.field private firstRow:I

.field private lastColumn:I

.field private lastRow:I

.field private linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

.field private location:Ljava/lang/String;

.field private modified:Z

.field private range:Ljxl/Range;

.field private sheet:Ljxl/write/WritableSheet;

.field private url:Ljava/net/URL;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/write/biff/HyperlinkRecord;->class$jxl$write$biff$HyperlinkRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.HyperlinkRecord"

    invoke-static {v0}, Ljxl/write/biff/HyperlinkRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->class$jxl$write$biff$HyperlinkRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljxl/write/biff/HyperlinkRecord$LinkType;-><init>(Ljxl/write/biff/HyperlinkRecord$1;)V

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    new-instance v0, Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-direct {v0, v1}, Ljxl/write/biff/HyperlinkRecord$LinkType;-><init>(Ljxl/write/biff/HyperlinkRecord$1;)V

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    new-instance v0, Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-direct {v0, v1}, Ljxl/write/biff/HyperlinkRecord$LinkType;-><init>(Ljxl/write/biff/HyperlinkRecord$1;)V

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->uncLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    new-instance v0, Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-direct {v0, v1}, Ljxl/write/biff/HyperlinkRecord$LinkType;-><init>(Ljxl/write/biff/HyperlinkRecord$1;)V

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    new-instance v0, Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-direct {v0, v1}, Ljxl/write/biff/HyperlinkRecord$LinkType;-><init>(Ljxl/write/biff/HyperlinkRecord$1;)V

    sput-object v0, Ljxl/write/biff/HyperlinkRecord;->unknown:Ljxl/write/biff/HyperlinkRecord$LinkType;

    return-void
.end method

.method protected constructor <init>(IIIILjava/io/File;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iput p2, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-static {p1, p3}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget p1, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-static {p1, p4}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iput-object p6, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    iput-object p5, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {p5}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    const-string p2, "\\\\"

    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Ljxl/write/biff/HyperlinkRecord;->uncLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    goto :goto_0

    :cond_0
    sget-object p1, Ljxl/write/biff/HyperlinkRecord;->fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    :goto_0
    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    return-void
.end method

.method protected constructor <init>(IIIILjava/lang/String;Ljxl/write/WritableSheet;IIII)V
    .locals 7

    move-object v6, p0

    move v0, p1

    sget-object v1, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    invoke-direct {p0, v1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput v0, v6, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    move v1, p2

    iput v1, v6, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    move v1, p3

    invoke-static {p1, p3}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, v6, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v0, v6, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    move v1, p4

    invoke-static {v0, p4}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, v6, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v0, p0

    move-object v1, p6

    move v2, p7

    move v3, p8

    move/from16 v4, p9

    move/from16 v5, p10

    invoke-direct/range {v0 .. v5}, Ljxl/write/biff/HyperlinkRecord;->setLocation(Ljxl/write/WritableSheet;IIII)V

    move-object v0, p5

    iput-object v0, v6, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    sget-object v0, Ljxl/write/biff/HyperlinkRecord;->workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object v0, v6, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 v0, 0x1

    iput-boolean v0, v6, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    return-void
.end method

.method protected constructor <init>(IIIILjava/net/URL;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iput p2, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-static {p1, p3}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget p1, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-static {p1, p4}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iput-object p5, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    iput-object p6, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    sget-object p1, Ljxl/write/biff/HyperlinkRecord;->urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    return-void
.end method

.method protected constructor <init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    instance-of v0, p1, Ljxl/read/biff/HyperlinkRecord;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Ljxl/write/biff/HyperlinkRecord;->copyReadHyperlink(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1, p2}, Ljxl/write/biff/HyperlinkRecord;->copyWritableHyperlink(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    :goto_0
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

.method private copyReadHyperlink(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V
    .locals 7

    check-cast p1, Ljxl/read/biff/HyperlinkRecord;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getRecord()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getRow()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getColumn()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getLastRow()I

    move-result v0

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getLastColumn()I

    move-result v5

    iput v5, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    new-instance v0, Ljxl/biff/SheetRangeImpl;

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v6, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v1, v0

    move-object v2, p2

    invoke-direct/range {v1 .. v6}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    sget-object p2, Ljxl/write/biff/HyperlinkRecord;->unknown:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->isFile()Z

    move-result p2

    if-eqz p2, :cond_0

    sget-object p2, Ljxl/write/biff/HyperlinkRecord;->fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getFile()Ljava/io/File;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->isURL()Z

    move-result p2

    if-eqz p2, :cond_1

    sget-object p2, Ljxl/write/biff/HyperlinkRecord;->urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getURL()Ljava/net/URL;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->isLocation()Z

    move-result p2

    if-eqz p2, :cond_2

    sget-object p2, Ljxl/write/biff/HyperlinkRecord;->workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    invoke-virtual {p1}, Ljxl/read/biff/HyperlinkRecord;->getLocation()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    :cond_2
    :goto_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    return-void
.end method

.method private copyWritableHyperlink(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V
    .locals 6

    check-cast p1, Ljxl/write/biff/HyperlinkRecord;

    iget v0, p1, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v0, p1, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iget v0, p1, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v0, p1, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget-object v0, p1, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v0, Ljava/net/URL;

    iget-object v1, p1, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    invoke-virtual {v1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    :cond_0
    :goto_0
    iget-object v0, p1, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/io/File;

    iget-object v1, p1, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    :cond_1
    iget-object v0, p1, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    iget-object v0, p1, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    iget-object p1, p1, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    iput-object p2, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    new-instance p1, Ljxl/biff/SheetRangeImpl;

    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v0, p1

    move-object v1, p2

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    return-void
.end method

.method private getFileData([B)[B
    .locals 10

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Ljxl/write/biff/HyperlinkRecord;->getShortName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    :goto_0
    invoke-virtual {v2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Ljxl/write/biff/HyperlinkRecord;->getShortName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    const/4 v4, 0x0

    move v5, v3

    move v6, v4

    :goto_1
    if-eqz v5, :cond_2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    const-string v8, ".."

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    goto :goto_2

    :cond_1
    move v5, v4

    :goto_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_1

    :cond_2
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    iget-object v7, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v7}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x3a

    if-ne v7, v8, :cond_3

    iget-object v7, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v7}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v9, 0x43

    if-eq v7, v9, :cond_3

    const/16 v9, 0x63

    if-eq v7, v9, :cond_3

    invoke-virtual {v2, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-virtual {v2, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v7}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    :cond_3
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v7

    sub-int/2addr v7, v3

    :goto_3
    if-ltz v7, :cond_5

    invoke-virtual {v0, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v2, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    if-eqz v7, :cond_4

    const-string v8, "\\"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_4
    add-int/lit8 v7, v7, -0x1

    goto :goto_3

    :cond_5
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    array-length v2, p1

    add-int/lit8 v2, v2, 0x4

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v3

    add-int/2addr v2, v5

    add-int/lit8 v2, v2, 0x10

    add-int/lit8 v2, v2, 0x2

    add-int/lit8 v2, v2, 0x8

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v3

    mul-int/lit8 v5, v5, 0x2

    add-int/2addr v2, v5

    add-int/lit8 v2, v2, 0x18

    iget-object v5, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v5, :cond_6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v3

    mul-int/lit8 v5, v5, 0x2

    add-int/lit8 v5, v5, 0x4

    add-int/2addr v2, v5

    :cond_6
    new-array v2, v2, [B

    array-length v5, p1

    invoke-static {p1, v4, v2, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length p1, p1

    iget-object v5, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v5, :cond_7

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v3

    invoke-static {v5, v2, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v5, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    add-int/lit8 v7, p1, 0x4

    invoke-static {v5, v2, v7}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v5, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v5, v3

    mul-int/lit8 v5, v5, 0x2

    add-int/lit8 v5, v5, 0x4

    add-int/2addr p1, v5

    :cond_7
    const/4 v5, 0x3

    aput-byte v5, v2, p1

    add-int/lit8 v7, p1, 0x1

    aput-byte v5, v2, v7

    add-int/lit8 v7, p1, 0x2

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x3

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x4

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x5

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x6

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x7

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0x8

    const/16 v8, -0x40

    aput-byte v8, v2, v7

    add-int/lit8 v7, p1, 0x9

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xa

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xb

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xc

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xd

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xe

    aput-byte v4, v2, v7

    add-int/lit8 v7, p1, 0xf

    const/16 v8, 0x46

    aput-byte v8, v2, v7

    add-int/lit8 p1, p1, 0x10

    invoke-static {v6, v2, p1}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 p1, p1, 0x2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    add-int/2addr v6, v3

    invoke-static {v6, v2, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 v6, p1, 0x4

    invoke-static {v1, v2, v6}, Ljxl/biff/StringHelper;->getBytes(Ljava/lang/String;[BI)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v1, v3

    add-int/lit8 v1, v1, 0x4

    add-int/2addr p1, v1

    const/4 v1, -0x1

    aput-byte v1, v2, p1

    add-int/lit8 v3, p1, 0x1

    aput-byte v1, v2, v3

    add-int/lit8 v1, p1, 0x2

    const/16 v3, -0x53

    aput-byte v3, v2, v1

    add-int/lit8 v1, p1, 0x3

    const/16 v3, -0x22

    aput-byte v3, v2, v1

    add-int/lit8 v1, p1, 0x4

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x5

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x6

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x7

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x8

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x9

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xa

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xb

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xc

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xd

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xe

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0xf

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x10

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x11

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x12

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x13

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x14

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x15

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x16

    aput-byte v4, v2, v1

    add-int/lit8 v1, p1, 0x17

    aput-byte v4, v2, v1

    add-int/lit8 p1, p1, 0x18

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    mul-int/lit8 v1, v1, 0x2

    add-int/lit8 v1, v1, 0x6

    invoke-static {v1, v2, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 p1, p1, 0x4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    mul-int/lit8 v1, v1, 0x2

    invoke-static {v1, v2, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 p1, p1, 0x4

    aput-byte v5, v2, p1

    add-int/lit8 v1, p1, 0x1

    aput-byte v4, v2, v1

    add-int/lit8 p1, p1, 0x2

    invoke-static {v0, v2, p1}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    return-object v2
.end method

.method private getLocationData([B)[B
    .locals 3

    array-length v0, p1

    add-int/lit8 v0, v0, 0x4

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    mul-int/lit8 v1, v1, 0x2

    add-int/2addr v0, v1

    new-array v0, v0, [B

    array-length v1, p1

    const/4 v2, 0x0

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length p1, p1

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1, v0, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    add-int/lit8 p1, p1, 0x4

    invoke-static {v1, v0, p1}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    return-object v0
.end method

.method private getShortName(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    const/16 v0, 0x2e

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, -0x1

    if-ne v1, v3, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    invoke-virtual {p1, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    move-object p1, v3

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    const/16 v4, 0x8

    if-le v3, v4, :cond_1

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const/4 v5, 0x6

    invoke-virtual {p1, v2, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v5, "~"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    sub-int/2addr p1, v4

    invoke-virtual {v3, p1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    :cond_1
    const/4 v3, 0x3

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_2

    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_2
    return-object p1
.end method

.method private getUNCData([B)[B
    .locals 4

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    array-length v1, p1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    mul-int/lit8 v2, v2, 0x2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x2

    add-int/lit8 v1, v1, 0x4

    new-array v1, v1, [B

    array-length v2, p1

    const/4 v3, 0x0

    invoke-static {p1, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length p1, p1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2, v1, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 p1, p1, 0x4

    invoke-static {v0, v1, p1}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    return-object v1
.end method

.method private getURLData([B)[B
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    invoke-virtual {v0}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v0

    array-length v1, p1

    add-int/lit8 v1, v1, 0x14

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    mul-int/lit8 v2, v2, 0x2

    add-int/2addr v1, v2

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    mul-int/lit8 v2, v2, 0x2

    add-int/lit8 v2, v2, 0x4

    add-int/2addr v1, v2

    :cond_0
    new-array v1, v1, [B

    array-length v2, p1

    const/4 v3, 0x0

    invoke-static {p1, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length p1, p1

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-static {v2, v1, p1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    add-int/lit8 v4, p1, 0x4

    invoke-static {v2, v1, v4}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    mul-int/lit8 v2, v2, 0x2

    add-int/lit8 v2, v2, 0x4

    add-int/2addr p1, v2

    :cond_1
    const/16 v2, -0x20

    aput-byte v2, v1, p1

    add-int/lit8 v2, p1, 0x1

    const/16 v4, -0x37

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x2

    const/16 v4, -0x16

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x3

    const/16 v4, 0x79

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x4

    const/4 v4, -0x7

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x5

    const/16 v4, -0x46

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x6

    const/16 v4, -0x32

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x7

    const/16 v4, 0x11

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x8

    const/16 v4, -0x74

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0x9

    const/16 v4, -0x7e

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0xa

    aput-byte v3, v1, v2

    add-int/lit8 v2, p1, 0xb

    const/16 v4, -0x56

    aput-byte v4, v1, v2

    add-int/lit8 v2, p1, 0xc

    aput-byte v3, v1, v2

    add-int/lit8 v2, p1, 0xd

    const/16 v3, 0x4b

    aput-byte v3, v1, v2

    add-int/lit8 v2, p1, 0xe

    const/16 v3, -0x57

    aput-byte v3, v1, v2

    add-int/lit8 v2, p1, 0xf

    const/16 v3, 0xb

    aput-byte v3, v1, v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    mul-int/lit8 v2, v2, 0x2

    add-int/lit8 v3, p1, 0x10

    invoke-static {v2, v1, v3}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    add-int/lit8 p1, p1, 0x14

    invoke-static {v0, v1, p1}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    return-object v1
.end method

.method private setLocation(Ljxl/write/WritableSheet;IIII)V
    .locals 6

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    const/16 v1, 0x27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-interface {p1}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    const/4 v3, -0x1

    invoke-interface {p1}, Ljxl/Sheet;->getName()Ljava/lang/String;

    move-result-object p1

    if-ne v2, v3, :cond_0

    :goto_0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_2

    :cond_0
    const/4 v2, 0x0

    :goto_1
    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v4

    if-eq v4, v3, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v2, v5, :cond_1

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v2, "\'\'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v2, v4, 0x1

    goto :goto_1

    :cond_1
    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    const/16 p1, 0x21

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-static {p2, p4}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-static {p3, p5}, Ljava/lang/Math;->max(II)I

    move-result p4

    invoke-static {p2, p3, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    const/16 p2, 0x3a

    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-static {p1, p4, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getColumn()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    return v0
.end method

.method getContents()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    return-object v0
.end method

.method public getData()[B
    .locals 8

    iget-boolean v0, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    return-object v0

    :cond_0
    const/16 v0, 0x20

    new-array v0, v0, [B

    iget v1, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    const/4 v3, 0x2

    invoke-static {v1, v0, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    const/4 v4, 0x4

    invoke-static {v1, v0, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    const/4 v4, 0x6

    invoke-static {v1, v0, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    const/16 v1, -0x30

    const/16 v4, 0x8

    aput-byte v1, v0, v4

    const/16 v1, 0x9

    const/16 v5, -0x37

    aput-byte v5, v0, v1

    const/16 v1, 0xa

    const/16 v5, -0x16

    aput-byte v5, v0, v1

    const/16 v1, 0x79

    const/16 v5, 0xb

    aput-byte v1, v0, v5

    const/16 v1, 0xc

    const/4 v6, -0x7

    aput-byte v6, v0, v1

    const/16 v1, 0xd

    const/16 v6, -0x46

    aput-byte v6, v0, v1

    const/16 v1, 0xe

    const/16 v6, -0x32

    aput-byte v6, v0, v1

    const/16 v1, 0xf

    const/16 v6, 0x11

    aput-byte v6, v0, v1

    const/16 v1, 0x10

    const/16 v7, -0x74

    aput-byte v7, v0, v1

    const/16 v1, -0x7e

    aput-byte v1, v0, v6

    const/16 v1, 0x12

    aput-byte v2, v0, v1

    const/16 v1, 0x13

    const/16 v6, -0x56

    aput-byte v6, v0, v1

    const/16 v1, 0x14

    aput-byte v2, v0, v1

    const/16 v1, 0x4b

    const/16 v6, 0x15

    aput-byte v1, v0, v6

    const/16 v1, 0x16

    const/16 v7, -0x57

    aput-byte v7, v0, v1

    const/16 v1, 0x17

    aput-byte v5, v0, v1

    const/16 v5, 0x18

    aput-byte v3, v0, v5

    const/16 v3, 0x19

    aput-byte v2, v0, v3

    const/16 v3, 0x1a

    aput-byte v2, v0, v3

    const/16 v3, 0x1b

    aput-byte v2, v0, v3

    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isURL()Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v2, 0x3

    iget-object v3, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v3, :cond_4

    move v2, v1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isFile()Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 v2, 0x1

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    if-eqz v1, :cond_4

    move v2, v6

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isLocation()Z

    move-result v1

    if-eqz v1, :cond_3

    move v2, v4

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isUNC()Z

    move-result v1

    if-eqz v1, :cond_4

    const/16 v2, 0x103

    :cond_4
    :goto_0
    const/16 v1, 0x1c

    invoke-static {v2, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isURL()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-direct {p0, v0}, Ljxl/write/biff/HyperlinkRecord;->getURLData([B)[B

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    goto :goto_1

    :cond_5
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isFile()Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-direct {p0, v0}, Ljxl/write/biff/HyperlinkRecord;->getFileData([B)[B

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    goto :goto_1

    :cond_6
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isLocation()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-direct {p0, v0}, Ljxl/write/biff/HyperlinkRecord;->getLocationData([B)[B

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    goto :goto_1

    :cond_7
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isUNC()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-direct {p0, v0}, Ljxl/write/biff/HyperlinkRecord;->getUNCData([B)[B

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    :cond_8
    :goto_1
    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->data:[B

    return-object v0
.end method

.method public getFile()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    return-object v0
.end method

.method public getLastColumn()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    return v0
.end method

.method public getLastRow()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    return v0
.end method

.method public getRange()Ljxl/Range;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    return-object v0
.end method

.method public getRow()I
    .locals 1

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    return v0
.end method

.method public getURL()Ljava/net/URL;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    return-object v0
.end method

.method initialize(Ljxl/write/WritableSheet;)V
    .locals 7

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    new-instance v6, Ljxl/biff/SheetRangeImpl;

    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v0, v6

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object v6, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    return-void
.end method

.method insertColumn(I)V
    .locals 6

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    if-le p1, v0, :cond_1

    return-void

    :cond_1
    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    if-gt p1, v2, :cond_2

    add-int/2addr v2, v1

    iput v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iput-boolean v1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_2
    if-gt p1, v0, :cond_3

    add-int/2addr v0, v1

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iput-boolean v1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_3
    iget-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    if-eqz p1, :cond_4

    new-instance p1, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v0, p1

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    :cond_4
    return-void
.end method

.method insertRow(I)V
    .locals 6

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    if-le p1, v0, :cond_1

    return-void

    :cond_1
    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    if-gt p1, v2, :cond_2

    add-int/2addr v2, v1

    iput v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iput-boolean v1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_2
    if-gt p1, v0, :cond_3

    add-int/2addr v0, v1

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iput-boolean v1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_3
    iget-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    if-eqz p1, :cond_4

    new-instance p1, Ljxl/biff/SheetRangeImpl;

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v0, p1

    invoke-direct/range {v0 .. v5}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    :cond_4
    return-void
.end method

.method public isFile()Z
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    sget-object v1, Ljxl/write/biff/HyperlinkRecord;->fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isLocation()Z
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    sget-object v1, Ljxl/write/biff/HyperlinkRecord;->workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isUNC()Z
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    sget-object v1, Ljxl/write/biff/HyperlinkRecord;->uncLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isURL()Z
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    sget-object v1, Ljxl/write/biff/HyperlinkRecord;->urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method removeColumn(I)V
    .locals 8

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    if-le p1, v0, :cond_1

    return-void

    :cond_1
    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    if-ge p1, v3, :cond_2

    sub-int/2addr v3, v2

    iput v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iput-boolean v2, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_2
    if-ge p1, v0, :cond_3

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iput-boolean v2, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_3
    iget-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    if-eqz p1, :cond_5

    iget-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz p1, :cond_4

    move v1, v2

    :cond_4
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    new-instance p1, Ljxl/biff/SheetRangeImpl;

    iget-object v3, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v6, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v7, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v2, p1

    invoke-direct/range {v2 .. v7}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    :cond_5
    return-void
.end method

.method removeRow(I)V
    .locals 8

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iget v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    if-le p1, v0, :cond_1

    return-void

    :cond_1
    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    if-ge p1, v3, :cond_2

    sub-int/2addr v3, v2

    iput v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iput-boolean v2, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_2
    if-ge p1, v0, :cond_3

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    iput-boolean v2, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    :cond_3
    iget-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    if-eqz p1, :cond_5

    iget-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    if-eqz p1, :cond_4

    move v1, v2

    :cond_4
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    new-instance p1, Ljxl/biff/SheetRangeImpl;

    iget-object v3, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v5, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    iget v6, p0, Ljxl/write/biff/HyperlinkRecord;->lastColumn:I

    iget v7, p0, Ljxl/write/biff/HyperlinkRecord;->lastRow:I

    move-object v2, p1

    invoke-direct/range {v2 .. v7}, Ljxl/biff/SheetRangeImpl;-><init>(Ljxl/Sheet;IIII)V

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->range:Ljxl/Range;

    :cond_5
    return-void
.end method

.method protected setContents(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    return-void
.end method

.method public setFile(Ljava/io/File;)V
    .locals 4

    sget-object v0, Ljxl/write/biff/HyperlinkRecord;->fileLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 v0, 0x0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    iget-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    if-nez v1, :cond_0

    return-void

    :cond_0
    iget v2, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-interface {v1, v2, v3}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v1

    invoke-interface {v1}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v2

    sget-object v3, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-ne v2, v3, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    check-cast v1, Ljxl/write/Label;

    invoke-virtual {p1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    return-void
.end method

.method protected setLocation(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V
    .locals 7

    sget-object v0, Ljxl/write/biff/HyperlinkRecord;->workbookLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 v0, 0x0

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    iput-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    move-object v1, p0

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-direct/range {v1 .. v6}, Ljxl/write/biff/HyperlinkRecord;->setLocation(Ljxl/write/WritableSheet;IIII)V

    if-nez p2, :cond_0

    return-void

    :cond_0
    iget p3, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget p4, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-interface {p2, p3, p4}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object p2

    invoke-interface {p2}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object p3

    sget-object p4, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-ne p3, p4, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    check-cast p2, Ljxl/write/Label;

    invoke-virtual {p2, p1}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    return-void
.end method

.method public setURL(Ljava/net/URL;)V
    .locals 5

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    sget-object v1, Ljxl/write/biff/HyperlinkRecord;->urlLink:Ljxl/write/biff/HyperlinkRecord$LinkType;

    iput-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->linkType:Ljxl/write/biff/HyperlinkRecord$LinkType;

    const/4 v1, 0x0

    iput-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    iput-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->location:Ljava/lang/String;

    iput-object v1, p0, Ljxl/write/biff/HyperlinkRecord;->contents:Ljava/lang/String;

    iput-object p1, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    const/4 v1, 0x1

    iput-boolean v1, p0, Ljxl/write/biff/HyperlinkRecord;->modified:Z

    iget-object v2, p0, Ljxl/write/biff/HyperlinkRecord;->sheet:Ljxl/write/WritableSheet;

    if-nez v2, :cond_0

    return-void

    :cond_0
    iget v3, p0, Ljxl/write/biff/HyperlinkRecord;->firstColumn:I

    iget v4, p0, Ljxl/write/biff/HyperlinkRecord;->firstRow:I

    invoke-interface {v2, v3, v4}, Ljxl/write/WritableSheet;->getWritableCell(II)Ljxl/write/WritableCell;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v3

    sget-object v4, Ljxl/CellType;->LABEL:Ljxl/CellType;

    if-ne v3, v4, :cond_4

    check-cast v2, Ljxl/write/Label;

    invoke-virtual {v0}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v3, v1

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x2f

    if-eq v3, v4, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v3, v1

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x5c

    if-ne v3, v4, :cond_1

    goto :goto_0

    :cond_1
    const-string v1, ""

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v3, 0x0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    sub-int/2addr v4, v1

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v2}, Ljxl/write/biff/LabelRecord;->getString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {v2}, Ljxl/write/biff/LabelRecord;->getString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    invoke-virtual {p1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljxl/write/Label;->setString(Ljava/lang/String;)V

    :cond_4
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isFile()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isURL()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->url:Ljava/net/URL;

    invoke-virtual {v0}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_1
    invoke-virtual {p0}, Ljxl/write/biff/HyperlinkRecord;->isUNC()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Ljxl/write/biff/HyperlinkRecord;->file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_2
    const-string v0, ""

    return-object v0
.end method
