.class Ljxl/biff/drawing/Sp;
.super Ljxl/biff/drawing/EscherAtom;
.source ""


# static fields
.field static synthetic class$jxl$biff$drawing$Sp:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private data:[B

.field private persistenceFlags:I

.field private shapeId:I

.field private shapeType:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/Sp;->class$jxl$biff$drawing$Sp:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.drawing.Sp"

    invoke-static {v0}, Ljxl/biff/drawing/Sp;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Sp;->class$jxl$biff$drawing$Sp:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/drawing/Sp;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/EscherRecordData;)V
    .locals 4

    invoke-direct {p0, p1}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordData;)V

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getInstance()I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/Sp;->shapeType:I

    invoke-virtual {p0}, Ljxl/biff/drawing/EscherRecord;->getBytes()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v0, p1, v0

    const/4 v1, 0x1

    aget-byte v1, p1, v1

    const/4 v2, 0x2

    aget-byte v2, p1, v2

    const/4 v3, 0x3

    aget-byte v3, p1, v3

    invoke-static {v0, v1, v2, v3}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v0

    iput v0, p0, Ljxl/biff/drawing/Sp;->shapeId:I

    const/4 v0, 0x4

    aget-byte v0, p1, v0

    const/4 v1, 0x5

    aget-byte v1, p1, v1

    const/4 v2, 0x6

    aget-byte v2, p1, v2

    const/4 v3, 0x7

    aget-byte p1, p1, v3

    invoke-static {v0, v1, v2, p1}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/Sp;->persistenceFlags:I

    return-void
.end method

.method public constructor <init>(Ljxl/biff/drawing/ShapeType;II)V
    .locals 1

    sget-object v0, Ljxl/biff/drawing/EscherRecordType;->SP:Ljxl/biff/drawing/EscherRecordType;

    invoke-direct {p0, v0}, Ljxl/biff/drawing/EscherAtom;-><init>(Ljxl/biff/drawing/EscherRecordType;)V

    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setVersion(I)V

    invoke-virtual {p1}, Ljxl/biff/drawing/ShapeType;->getValue()I

    move-result p1

    iput p1, p0, Ljxl/biff/drawing/Sp;->shapeType:I

    iput p2, p0, Ljxl/biff/drawing/Sp;->shapeId:I

    iput p3, p0, Ljxl/biff/drawing/Sp;->persistenceFlags:I

    invoke-virtual {p0, p1}, Ljxl/biff/drawing/EscherRecord;->setInstance(I)V

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
.method getData()[B
    .locals 3

    const/16 v0, 0x8

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/biff/drawing/Sp;->data:[B

    iget v1, p0, Ljxl/biff/drawing/Sp;->shapeId:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget v0, p0, Ljxl/biff/drawing/Sp;->persistenceFlags:I

    iget-object v1, p0, Ljxl/biff/drawing/Sp;->data:[B

    const/4 v2, 0x4

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v0, p0, Ljxl/biff/drawing/Sp;->data:[B

    invoke-virtual {p0, v0}, Ljxl/biff/drawing/EscherRecord;->setHeaderData([B)[B

    move-result-object v0

    return-object v0
.end method

.method getShapeId()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Sp;->shapeId:I

    return v0
.end method

.method getShapeType()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/Sp;->shapeType:I

    return v0
.end method
