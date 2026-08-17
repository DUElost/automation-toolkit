.class public Ljxl/biff/BaseCompoundFile$PropertyStorage;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/BaseCompoundFile;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "PropertyStorage"
.end annotation


# instance fields
.field public child:I

.field public colour:I

.field public data:[B

.field public name:Ljava/lang/String;

.field public next:I

.field public previous:I

.field public size:I

.field public startBlock:I

.field private final synthetic this$0:Ljxl/biff/BaseCompoundFile;

.field public type:I


# direct methods
.method public constructor <init>(Ljxl/biff/BaseCompoundFile;Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->this$0:Ljxl/biff/BaseCompoundFile;

    const/16 p1, 0x80

    new-array p1, p1, [B

    iput-object p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/16 v2, 0x20

    if-ge p1, v2, :cond_0

    move p1, v1

    goto :goto_0

    :cond_0
    move p1, v0

    :goto_0
    invoke-static {p1}, Ljxl/common/Assert;->verify(Z)V

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p1

    add-int/2addr p1, v1

    mul-int/lit8 p1, p1, 0x2

    iget-object v1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v2, 0x40

    invoke-static {p1, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :goto_1
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p1

    if-ge v0, p1, :cond_1

    iget-object p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    mul-int/lit8 v1, v0, 0x2

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, p1, v1

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method public constructor <init>(Ljxl/biff/BaseCompoundFile;[B)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->this$0:Ljxl/biff/BaseCompoundFile;

    iput-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 p1, 0x40

    aget-byte v0, p2, p1

    const/16 v1, 0x41

    aget-byte p2, p2, v1

    invoke-static {v0, p2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p2

    if-le p2, p1, :cond_0

    invoke-static {}, Ljxl/biff/BaseCompoundFile;->access$000()Ljxl/common/Logger;

    move-result-object p2

    const-string v0, "property set name exceeds max length - truncating"

    invoke-virtual {p2, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    move p1, p2

    :goto_0
    iget-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v0, 0x42

    aget-byte v0, p2, v0

    iput v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    const/16 v0, 0x43

    aget-byte v0, p2, v0

    iput v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->colour:I

    const/16 v0, 0x74

    aget-byte v0, p2, v0

    const/16 v1, 0x75

    aget-byte v1, p2, v1

    const/16 v2, 0x76

    aget-byte v2, p2, v2

    const/16 v3, 0x77

    aget-byte p2, p2, v3

    invoke-static {v0, v1, v2, p2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p2

    iput p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->startBlock:I

    iget-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v0, 0x78

    aget-byte v0, p2, v0

    const/16 v1, 0x79

    aget-byte v1, p2, v1

    const/16 v2, 0x7a

    aget-byte v2, p2, v2

    const/16 v3, 0x7b

    aget-byte p2, p2, v3

    invoke-static {v0, v1, v2, p2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p2

    iput p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    iget-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v0, 0x44

    aget-byte v0, p2, v0

    const/16 v1, 0x45

    aget-byte v1, p2, v1

    const/16 v2, 0x46

    aget-byte v2, p2, v2

    const/16 v3, 0x47

    aget-byte p2, p2, v3

    invoke-static {v0, v1, v2, p2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p2

    iput p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    iget-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v0, 0x48

    aget-byte v0, p2, v0

    const/16 v1, 0x49

    aget-byte v1, p2, v1

    const/16 v2, 0x4a

    aget-byte v2, p2, v2

    const/16 v3, 0x4b

    aget-byte p2, p2, v3

    invoke-static {v0, v1, v2, p2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p2

    iput p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    iget-object p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v0, 0x4c

    aget-byte v0, p2, v0

    const/16 v1, 0x4d

    aget-byte v1, p2, v1

    const/16 v2, 0x4e

    aget-byte v2, p2, v2

    const/16 v3, 0x4f

    aget-byte p2, p2, v3

    invoke-static {v0, v1, v2, p2}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result p2

    iput p2, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->child:I

    const/4 p2, 0x0

    const/4 v0, 0x2

    if-le p1, v0, :cond_1

    add-int/lit8 p1, p1, -0x1

    div-int/2addr p1, v0

    goto :goto_1

    :cond_1
    move p1, p2

    :goto_1
    new-instance v0, Ljava/lang/StringBuffer;

    const-string v1, ""

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    :goto_2
    if-ge p2, p1, :cond_2

    iget-object v1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    mul-int/lit8 v2, p2, 0x2

    aget-byte v1, v1, v2

    int-to-char v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    add-int/lit8 p2, p2, 0x1

    goto :goto_2

    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->name:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public setChild(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->child:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x4c

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method

.method public setColour(I)V
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    :goto_0
    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->colour:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x43

    int-to-byte p1, p1

    aput-byte p1, v0, v1

    return-void
.end method

.method public setNext(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->next:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x48

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method

.method public setPrevious(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->previous:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x44

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method

.method public setSize(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->size:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x78

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method

.method public setStartBlock(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->startBlock:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    const/16 v1, 0x74

    invoke-static {p1, v0, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    return-void
.end method

.method public setType(I)V
    .locals 2

    iput p1, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->type:I

    iget-object v0, p0, Ljxl/biff/BaseCompoundFile$PropertyStorage;->data:[B

    int-to-byte p1, p1

    const/16 v1, 0x42

    aput-byte p1, v0, v1

    return-void
.end method
