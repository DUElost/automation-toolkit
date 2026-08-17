.class Ljxl/biff/drawing/EscherContainer;
.super Ljxl/biff/drawing/EscherRecord;
.source ""


# static fields
.field static synthetic class$jxl$biff$drawing$EscherContainer:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private children:Ljava/util/ArrayList;

.field private initialized:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/EscherContainer;->class$jxl$biff$drawing$EscherContainer:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.EscherContainer"

    invoke-static {v0}, Ljxl/biff/drawing/EscherContainer;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/EscherContainer;->class$jxl$biff$drawing$EscherContainer:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/EscherContainer;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/EscherRecordData;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherRecord;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/drawing/EscherContainer;->initialized:Z

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/drawing/EscherRecordType;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherRecord;-><init>(Ljxl/biff/drawing/EscherRecordType;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljxl/biff/drawing/EscherRecord;->setContainer(Z)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

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

.method private initialize()V
    .locals 5

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getPos()I

    move-result v0

    add-int/lit8 v0, v0, 0x8

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getPos()I

    move-result v1

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getLength()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getStreamLength()I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_d

    new-instance v2, Ljxl/biff/drawing/EscherRecordData;

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getEscherStream()Ljxl/biff/drawing/EscherStream;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Ljxl/biff/drawing/EscherRecordData;-><init>(Ljxl/biff/drawing/EscherStream;I)V

    invoke-virtual {v2}, Ljxl/biff/drawing/EscherRecordData;->getType()Ljxl/biff/drawing/EscherRecordType;

    move-result-object v3

    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->DGG:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_0

    new-instance v3, Ljxl/biff/drawing/Dgg;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/Dgg;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto/16 :goto_1

    :cond_0
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->DG:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_1

    new-instance v3, Ljxl/biff/drawing/Dg;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/Dg;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto/16 :goto_1

    :cond_1
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->BSTORE_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_2

    new-instance v3, Ljxl/biff/drawing/BStoreContainer;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/BStoreContainer;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto/16 :goto_1

    :cond_2
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->SPGR_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_3

    new-instance v3, Ljxl/biff/drawing/SpgrContainer;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/SpgrContainer;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_3
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->SP_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_4

    new-instance v3, Ljxl/biff/drawing/SpContainer;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/SpContainer;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_4
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->SPGR:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_5

    new-instance v3, Ljxl/biff/drawing/Spgr;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/Spgr;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_5
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->SP:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_6

    new-instance v3, Ljxl/biff/drawing/Sp;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/Sp;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_6
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->CLIENT_ANCHOR:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_7

    new-instance v3, Ljxl/biff/drawing/ClientAnchor;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/ClientAnchor;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_7
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->CLIENT_DATA:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_8

    new-instance v3, Ljxl/biff/drawing/ClientData;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/ClientData;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_8
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->BSE:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_9

    new-instance v3, Ljxl/biff/drawing/BlipStoreEntry;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/BlipStoreEntry;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_9
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->OPT:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_a

    new-instance v3, Ljxl/biff/drawing/Opt;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/Opt;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_a
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->SPLIT_MENU_COLORS:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_b

    new-instance v3, Ljxl/biff/drawing/SplitMenuColors;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/SplitMenuColors;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_b
    sget-object v4, Ljxl/biff/drawing/EscherRecordType;->CLIENT_TEXT_BOX:Ljxl/biff/drawing/EscherRecordType;

    if-ne v3, v4, :cond_c

    new-instance v3, Ljxl/biff/drawing/ClientTextBox;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/ClientTextBox;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    goto :goto_1

    :cond_c
    new-instance v3, Ljxl/biff/drawing/EscherAtom;

    invoke-direct {v3, v2}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    :goto_1
    iget-object v2, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherRecord;->getLength()I

    move-result v2

    add-int/2addr v0, v2

    goto/16 :goto_0

    :cond_d
    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/drawing/EscherContainer;->initialized:Z

    return-void
.end method


# virtual methods
.method public add(Ljxl/biff/drawing/EscherRecord;)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public getChildren()[Ljxl/biff/drawing/EscherRecord;
    .locals 2

    iget-boolean v0, p0, Ljxl/biff/drawing/EscherContainer;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/EscherContainer;->initialize()V

    :cond_0
    iget-object v0, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Ljxl/biff/drawing/EscherRecord;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljxl/biff/drawing/EscherRecord;

    return-object v0
.end method

.method getData()[B
    .locals 6

    iget-boolean v0, p0, Ljxl/biff/drawing/EscherContainer;->initialized:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Ljxl/biff/drawing/EscherContainer;->initialize()V

    :cond_0
    const/4 v0, 0x0

    new-array v1, v0, [B

    iget-object v2, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/biff/drawing/EscherRecord;

    invoke-virtual {v3}, Ljxl/biff/drawing/EscherRecord;->getData()[B

    move-result-object v3

    if-eqz v3, :cond_1

    array-length v4, v1

    array-length v5, v3

    add-int/2addr v4, v5

    new-array v4, v4, [B

    array-length v5, v1

    invoke-static {v1, v0, v4, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v1, v1

    array-length v5, v3

    invoke-static {v3, v0, v4, v1, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object v1, v4

    goto :goto_0

    :cond_2
    invoke-virtual {p0, v1}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v0

    return-object v0
.end method

.method public remove(Ljxl/biff/drawing/EscherRecord;)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/EscherContainer;->children:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
