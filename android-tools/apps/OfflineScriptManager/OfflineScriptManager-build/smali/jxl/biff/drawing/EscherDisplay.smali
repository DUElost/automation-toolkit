.class public Ljxl/biff/drawing/EscherDisplay;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private stream:Ljxl/biff/drawing/EscherStream;

.field private writer:Ljava/io/BufferedWriter;


# direct methods
.method public constructor <init>(Ljxl/biff/drawing/EscherStream;Ljava/io/BufferedWriter;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->stream:Ljxl/biff/drawing/EscherStream;

    iput-object p2, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    return-void
.end method

.method private displayContainer(Ljxl/biff/drawing/EscherContainer;I)V
    .locals 3

    invoke-direct {p0, p1, p2}, Ljxl/biff/drawing/EscherDisplay;->displayRecord(Ljxl/biff/drawing/EscherRecord;I)V

    add-int/lit8 p2, p2, 0x1

    invoke-virtual {p1}, Ljxl/biff/drawing/EscherContainer;->getChildren()[Ljxl/biff/drawing/EscherRecord;

    move-result-object p1

    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    aget-object v1, p1, v0

    invoke-virtual {v1}, Ljxl/biff/drawing/EscherRecord;->getEscherData()Ljxl/biff/drawing/EscherRecordData;

    move-result-object v2

    invoke-virtual {v2}, Ljxl/biff/drawing/EscherRecordData;->isContainer()Z

    move-result v2

    if-eqz v2, :cond_0

    check-cast v1, Ljxl/biff/drawing/EscherContainer;

    invoke-direct {p0, v1, p2}, Ljxl/biff/drawing/EscherDisplay;->displayContainer(Ljxl/biff/drawing/EscherContainer;I)V

    goto :goto_1

    :cond_0
    invoke-direct {p0, v1, p2}, Ljxl/biff/drawing/EscherDisplay;->displayRecord(Ljxl/biff/drawing/EscherRecord;I)V

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private displayRecord(Ljxl/biff/drawing/EscherRecord;I)V
    .locals 2

    invoke-direct {p0, p2}, Ljxl/biff/drawing/EscherDisplay;->indent(I)V

    invoke-virtual {p1}, Ljxl/biff/drawing/EscherRecord;->getType()Ljxl/biff/drawing/EscherRecordType;

    move-result-object p1

    iget-object p2, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {p1}, Ljxl/biff/drawing/EscherRecordType;->getValue()I

    move-result v0

    const/16 v1, 0x10

    invoke-static {v0, v1}, Ljava/lang/Integer;->toString(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    iget-object p2, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string v0, " - "

    invoke-virtual {p2, v0}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->DGG_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Dgg Container"

    :goto_0
    invoke-virtual {p1, p2}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->newLine()V

    goto/16 :goto_1

    :cond_0
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->BSTORE_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_1

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "BStore Container"

    goto :goto_0

    :cond_1
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->DG_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_2

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Dg Container"

    goto :goto_0

    :cond_2
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->SPGR_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_3

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Spgr Container"

    goto :goto_0

    :cond_3
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->SP_CONTAINER:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_4

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Sp Container"

    goto :goto_0

    :cond_4
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->DGG:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_5

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Dgg"

    goto :goto_0

    :cond_5
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->BSE:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_6

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Bse"

    goto :goto_0

    :cond_6
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->DG:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_7

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Dg"

    goto :goto_0

    :cond_7
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->SPGR:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_8

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Spgr"

    goto :goto_0

    :cond_8
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->SP:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_9

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Sp"

    goto :goto_0

    :cond_9
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->OPT:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_a

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Opt"

    goto :goto_0

    :cond_a
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->CLIENT_ANCHOR:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_b

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Client Anchor"

    goto :goto_0

    :cond_b
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->CLIENT_DATA:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_c

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Client Data"

    goto :goto_0

    :cond_c
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->CLIENT_TEXT_BOX:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_d

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Client Text Box"

    goto :goto_0

    :cond_d
    sget-object p2, Ljxl/biff/drawing/EscherRecordType;->SPLIT_MENU_COLORS:Ljxl/biff/drawing/EscherRecordType;

    if-ne p1, p2, :cond_e

    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "Split Menu Colors"

    goto/16 :goto_0

    :cond_e
    iget-object p1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const-string p2, "???"

    goto/16 :goto_0

    :goto_1
    return-void
.end method

.method private indent(I)V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    mul-int/lit8 v1, p1, 0x2

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Ljxl/biff/drawing/EscherDisplay;->writer:Ljava/io/BufferedWriter;

    const/16 v2, 0x20

    invoke-virtual {v1, v2}, Ljava/io/BufferedWriter;->write(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public display()V
    .locals 3

    new-instance v0, Ljxl/biff/drawing/EscherRecordData;

    iget-object v1, p0, Ljxl/biff/drawing/EscherDisplay;->stream:Ljxl/biff/drawing/EscherStream;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/EscherRecordData;-><init>(Ljxl/biff/drawing/EscherStream;I)V

    new-instance v1, Ljxl/biff/drawing/EscherContainer;

    invoke-direct {v1, v0}, Ljxl/biff/drawing/EscherContainer;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    invoke-direct {p0, v1, v2}, Ljxl/biff/drawing/EscherDisplay;->displayContainer(Ljxl/biff/drawing/EscherContainer;I)V

    return-void
.end method
