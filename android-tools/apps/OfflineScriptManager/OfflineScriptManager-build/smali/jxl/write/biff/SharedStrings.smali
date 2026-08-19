.class Ljxl/write/biff/SharedStrings;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private stringList:Ljava/util/ArrayList;

.field private strings:Ljava/util/HashMap;

.field private totalOccurrences:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x64

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Ljxl/write/biff/SharedStrings;->strings:Ljava/util/HashMap;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput v0, p0, Ljxl/write/biff/SharedStrings;->totalOccurrences:I

    return-void
.end method

.method private createContinueRecord(Ljava/lang/String;ILjxl/write/biff/File;)Ljxl/write/biff/SSTContinueRecord;
    .locals 2

    const/4 v0, 0x0

    :cond_0
    :goto_0
    if-eqz p2, :cond_3

    new-instance v0, Ljxl/write/biff/SSTContinueRecord;

    invoke-direct {v0}, Ljxl/write/biff/SSTContinueRecord;-><init>()V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-eq p2, v1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, p2

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p2

    const/4 v1, 0x0

    invoke-virtual {v0, p2, v1}, Ljxl/write/biff/SSTContinueRecord;->setFirstString(Ljava/lang/String;Z)I

    move-result p2

    goto :goto_2

    :cond_2
    :goto_1
    const/4 p2, 0x1

    invoke-virtual {v0, p1, p2}, Ljxl/write/biff/SSTContinueRecord;->setFirstString(Ljava/lang/String;Z)I

    move-result p2

    :goto_2
    if-eqz p2, :cond_0

    invoke-virtual {p3, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    new-instance v0, Ljxl/write/biff/SSTContinueRecord;

    invoke-direct {v0}, Ljxl/write/biff/SSTContinueRecord;-><init>()V

    goto :goto_0

    :cond_3
    return-object v0
.end method


# virtual methods
.method public get(I)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1
.end method

.method public getIndex(Ljava/lang/String;)I
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/SharedStrings;->strings:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/Integer;

    iget-object v1, p0, Ljxl/write/biff/SharedStrings;->strings:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/lang/Integer;-><init>(I)V

    iget-object v1, p0, Ljxl/write/biff/SharedStrings;->strings:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    iget p1, p0, Ljxl/write/biff/SharedStrings;->totalOccurrences:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/write/biff/SharedStrings;->totalOccurrences:I

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1
.end method

.method public write(Ljxl/write/biff/File;)V
    .locals 9

    new-instance v0, Ljxl/write/biff/SSTRecord;

    iget v1, p0, Ljxl/write/biff/SharedStrings;->totalOccurrences:I

    iget-object v2, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-direct {v0, v1, v2}, Ljxl/write/biff/SSTRecord;-><init>(II)V

    new-instance v1, Ljxl/write/biff/ExtendedSSTRecord;

    iget-object v2, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljxl/write/biff/ExtendedSSTRecord;-><init>(I)V

    invoke-virtual {v1}, Ljxl/write/biff/ExtendedSSTRecord;->getNumberOfStringsPerBucket()I

    move-result v2

    iget-object v3, p0, Ljxl/write/biff/SharedStrings;->stringList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v6, v5

    move v5, v4

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    if-nez v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    move-object v6, v4

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v0}, Ljxl/write/biff/SSTRecord;->getOffset()I

    move-result v4

    add-int/lit8 v4, v4, 0x4

    invoke-virtual {v0, v6}, Ljxl/write/biff/SSTRecord;->add(Ljava/lang/String;)I

    move-result v7

    rem-int v8, v5, v2

    if-nez v8, :cond_0

    invoke-virtual {p1}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-virtual {v1, v8, v4}, Ljxl/write/biff/ExtendedSSTRecord;->addString(II)V

    :cond_0
    add-int/lit8 v5, v5, 0x1

    move v4, v7

    goto :goto_0

    :cond_1
    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    if-nez v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_2
    invoke-direct {p0, v6, v4, p1}, Ljxl/write/biff/SharedStrings;->createContinueRecord(Ljava/lang/String;ILjxl/write/biff/File;)Ljxl/write/biff/SSTContinueRecord;

    move-result-object v0

    :cond_3
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v0}, Ljxl/write/biff/SSTContinueRecord;->getOffset()I

    move-result v6

    add-int/lit8 v6, v6, 0x4

    invoke-virtual {v0, v4}, Ljxl/write/biff/SSTContinueRecord;->add(Ljava/lang/String;)I

    move-result v7

    rem-int v8, v5, v2

    if-nez v8, :cond_4

    invoke-virtual {p1}, Ljxl/write/biff/File;->getPos()I

    move-result v8

    invoke-virtual {v1, v8, v6}, Ljxl/write/biff/ExtendedSSTRecord;->addString(II)V

    :cond_4
    add-int/lit8 v5, v5, 0x1

    if-eqz v7, :cond_3

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    invoke-direct {p0, v4, v7, p1}, Ljxl/write/biff/SharedStrings;->createContinueRecord(Ljava/lang/String;ILjxl/write/biff/File;)Ljxl/write/biff/SSTContinueRecord;

    move-result-object v0

    goto :goto_1

    :cond_5
    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_6
    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void
.end method
