.class public Lb/e/a/i/d/c/e;
.super Lb/e/a/i/d/c/b;
.source ""


# annotations
.annotation runtime Lb/e/a/i/d/c/g;
    tags = {
        0x4
    }
.end annotation


# static fields
.field private static n:Ljava/util/logging/Logger;


# instance fields
.field d:I

.field e:I

.field f:I

.field g:I

.field h:J

.field i:J

.field j:Lb/e/a/i/d/c/f;

.field k:Lb/e/a/i/d/c/a;

.field l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/i/d/c/m;",
            ">;"
        }
    .end annotation
.end field

.field m:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/i/d/c/e;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lb/e/a/i/d/c/e;->n:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lb/e/a/i/d/c/b;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    const/4 v0, 0x4

    iput v0, p0, Lb/e/a/i/d/c/b;->a:I

    return-void
.end method


# virtual methods
.method a()I
    .locals 3

    iget-object v0, p0, Lb/e/a/i/d/c/e;->k:Lb/e/a/i/d/c/a;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lb/e/a/i/d/c/b;->b()I

    move-result v0

    :goto_0
    add-int/lit8 v0, v0, 0xd

    iget-object v2, p0, Lb/e/a/i/d/c/e;->j:Lb/e/a/i/d/c/f;

    if-nez v2, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v2}, Lb/e/a/i/d/c/b;->b()I

    move-result v1

    :goto_1
    add-int/2addr v0, v1

    iget-object v1, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_2

    return v0

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/i/d/c/m;

    invoke-virtual {v2}, Lb/e/a/i/d/c/b;->b()I

    move-result v2

    add-int/2addr v0, v2

    goto :goto_2
.end method

.method public e(Ljava/nio/ByteBuffer;)V
    .locals 5

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/e;->d:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    ushr-int/lit8 v1, v0, 0x2

    iput v1, p0, Lb/e/a/i/d/c/e;->e:I

    shr-int/lit8 v0, v0, 0x1

    and-int/lit8 v0, v0, 0x1

    iput v0, p0, Lb/e/a/i/d/c/e;->f:I

    invoke-static {p1}, Lb/c/a/e;->j(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/e;->g:I

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/e/a/i/d/c/e;->h:J

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/e/a/i/d/c/e;->i:J

    :cond_0
    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    const/4 v1, 0x2

    if-gt v0, v1, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    iget v1, p0, Lb/e/a/i/d/c/e;->d:I

    invoke-static {v1, p1}, Lb/e/a/i/d/c/l;->a(ILjava/nio/ByteBuffer;)Lb/e/a/i/d/c/b;

    move-result-object v1

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    sub-int/2addr v2, v0

    sget-object v0, Lb/e/a/i/d/c/e;->n:Ljava/util/logging/Logger;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, " - DecoderConfigDescr1 read: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, ", size: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lb/e/a/i/d/c/b;->b()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_1

    :cond_2
    const/4 v4, 0x0

    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/logging/Logger;->finer(Ljava/lang/String;)V

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lb/e/a/i/d/c/b;->b()I

    move-result v0

    if-ge v2, v0, :cond_3

    sub-int/2addr v0, v2

    new-array v0, v0, [B

    iput-object v0, p0, Lb/e/a/i/d/c/e;->m:[B

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    :cond_3
    instance-of v0, v1, Lb/e/a/i/d/c/f;

    if-eqz v0, :cond_4

    check-cast v1, Lb/e/a/i/d/c/f;

    iput-object v1, p0, Lb/e/a/i/d/c/e;->j:Lb/e/a/i/d/c/f;

    goto :goto_0

    :cond_4
    instance-of v0, v1, Lb/e/a/i/d/c/a;

    if-eqz v0, :cond_5

    check-cast v1, Lb/e/a/i/d/c/a;

    iput-object v1, p0, Lb/e/a/i/d/c/e;->k:Lb/e/a/i/d/c/a;

    goto :goto_0

    :cond_5
    instance-of v0, v1, Lb/e/a/i/d/c/m;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    check-cast v1, Lb/e/a/i/d/c/m;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public g()Lb/e/a/i/d/c/a;
    .locals 1

    iget-object v0, p0, Lb/e/a/i/d/c/e;->k:Lb/e/a/i/d/c/a;

    return-object v0
.end method

.method public h()J
    .locals 2

    iget-wide v0, p0, Lb/e/a/i/d/c/e;->i:J

    return-wide v0
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/e;->g:I

    return v0
.end method

.method public j()Lb/e/a/i/d/c/f;
    .locals 1

    iget-object v0, p0, Lb/e/a/i/d/c/e;->j:Lb/e/a/i/d/c/f;

    return-object v0
.end method

.method public k()J
    .locals 2

    iget-wide v0, p0, Lb/e/a/i/d/c/e;->h:J

    return-wide v0
.end method

.method public l()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/e;->d:I

    return v0
.end method

.method public m()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/e/a/i/d/c/m;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    return-object v0
.end method

.method public n()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/e;->e:I

    return v0
.end method

.method public o()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/e;->f:I

    return v0
.end method

.method public p()Ljava/nio/ByteBuffer;
    .locals 3

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->b()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lb/e/a/i/d/c/b;->a:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/e/a/i/d/c/e;->a()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lb/e/a/i/d/c/b;->f(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/e;->d:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/e;->e:I

    shl-int/lit8 v1, v1, 0x2

    iget v2, p0, Lb/e/a/i/d/c/e;->f:I

    shl-int/lit8 v2, v2, 0x1

    or-int/2addr v1, v2

    or-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/e;->g:I

    invoke-static {v0, v1}, Lb/c/a/f;->f(Ljava/nio/ByteBuffer;I)V

    iget-wide v1, p0, Lb/e/a/i/d/c/e;->h:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/e/a/i/d/c/e;->i:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v1, p0, Lb/e/a/i/d/c/e;->j:Lb/e/a/i/d/c/f;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lb/e/a/i/d/c/f;->g()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    :cond_0
    iget-object v1, p0, Lb/e/a/i/d/c/e;->k:Lb/e/a/i/d/c/a;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lb/e/a/i/d/c/a;->o()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    :cond_1
    iget-object v1, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    return-object v0

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/i/d/c/m;

    invoke-virtual {v2}, Lb/e/a/i/d/c/m;->g()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    goto :goto_0
.end method

.method public q(J)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/i/d/c/e;->i:J

    return-void
.end method

.method public r(J)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/i/d/c/e;->h:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "DecoderConfigDescriptor"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "{objectTypeIndication="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/e;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", streamType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/e;->e:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", upStream="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/e;->f:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", bufferSizeDB="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/e;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", maxBitRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/i/d/c/e;->h:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", avgBitRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/i/d/c/e;->i:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", decoderSpecificInfo="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/e;->j:Lb/e/a/i/d/c/f;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", audioSpecificInfo="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/e;->k:Lb/e/a/i/d/c/a;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", configDescriptorDeadBytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/e;->m:[B

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    new-array v1, v2, [B

    :goto_0
    invoke-static {v1}, Lb/c/a/c;->a([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", profileLevelIndicationDescriptors="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/e;->l:Ljava/util/List;

    if-nez v1, :cond_1

    const-string v1, "null"

    goto :goto_1

    :cond_1
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/util/List;

    aput-object v1, v3, v2

    invoke-static {v3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
