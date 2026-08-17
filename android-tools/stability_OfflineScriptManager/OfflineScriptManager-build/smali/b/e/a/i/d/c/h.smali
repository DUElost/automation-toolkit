.class public Lb/e/a/i/d/c/h;
.super Lb/e/a/i/d/c/b;
.source ""


# annotations
.annotation runtime Lb/e/a/i/d/c/g;
    tags = {
        0x3
    }
.end annotation


# instance fields
.field d:I

.field e:I

.field f:I

.field g:I

.field h:I

.field i:I

.field j:Ljava/lang/String;

.field k:I

.field l:I

.field m:I

.field n:Lb/e/a/i/d/c/e;

.field o:Lb/e/a/i/d/c/n;

.field p:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/i/d/c/b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/i/d/c/h;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lb/e/a/i/d/c/b;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/e/a/i/d/c/h;->i:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    const/4 v0, 0x3

    iput v0, p0, Lb/e/a/i/d/c/b;->a:I

    return-void
.end method


# virtual methods
.method a()I
    .locals 2

    iget v0, p0, Lb/e/a/i/d/c/h;->e:I

    if-lez v0, :cond_0

    const/4 v0, 0x5

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    :goto_0
    iget v1, p0, Lb/e/a/i/d/c/h;->f:I

    if-lez v1, :cond_1

    iget v1, p0, Lb/e/a/i/d/c/h;->i:I

    add-int/lit8 v1, v1, 0x1

    add-int/2addr v0, v1

    :cond_1
    iget v1, p0, Lb/e/a/i/d/c/h;->g:I

    if-lez v1, :cond_2

    add-int/lit8 v0, v0, 0x2

    :cond_2
    iget-object v1, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    invoke-virtual {v1}, Lb/e/a/i/d/c/b;->b()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    invoke-virtual {v1}, Lb/e/a/i/d/c/b;->b()I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-gtz v1, :cond_3

    return v0

    :cond_3
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, " Doesn\'t handle other descriptors yet"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public e(Ljava/nio/ByteBuffer;)V
    .locals 4

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/h;->d:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    ushr-int/lit8 v1, v0, 0x7

    iput v1, p0, Lb/e/a/i/d/c/h;->e:I

    ushr-int/lit8 v2, v0, 0x6

    const/4 v3, 0x1

    and-int/2addr v2, v3

    iput v2, p0, Lb/e/a/i/d/c/h;->f:I

    ushr-int/lit8 v2, v0, 0x5

    and-int/2addr v2, v3

    iput v2, p0, Lb/e/a/i/d/c/h;->g:I

    and-int/lit8 v0, v0, 0x1f

    iput v0, p0, Lb/e/a/i/d/c/h;->h:I

    if-ne v1, v3, :cond_0

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/h;->l:I

    :cond_0
    iget v0, p0, Lb/e/a/i/d/c/h;->f:I

    if-ne v0, v3, :cond_1

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/h;->i:I

    invoke-static {p1, v0}, Lb/c/a/e;->h(Ljava/nio/ByteBuffer;I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    :cond_1
    iget v0, p0, Lb/e/a/i/d/c/h;->g:I

    if-ne v0, v3, :cond_2

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/h;->m:I

    :cond_2
    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-gt v0, v3, :cond_3

    return-void

    :cond_3
    const/4 v0, -0x1

    invoke-static {v0, p1}, Lb/e/a/i/d/c/l;->a(ILjava/nio/ByteBuffer;)Lb/e/a/i/d/c/b;

    move-result-object v0

    instance-of v1, v0, Lb/e/a/i/d/c/e;

    if-eqz v1, :cond_4

    check-cast v0, Lb/e/a/i/d/c/e;

    iput-object v0, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    goto :goto_0

    :cond_4
    instance-of v1, v0, Lb/e/a/i/d/c/n;

    if-eqz v1, :cond_5

    check-cast v0, Lb/e/a/i/d/c/n;

    iput-object v0, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    goto :goto_0

    :cond_5
    iget-object v1, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_13

    const-class v2, Lb/e/a/i/d/c/h;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto/16 :goto_4

    :cond_1
    check-cast p1, Lb/e/a/i/d/c/h;

    iget v2, p0, Lb/e/a/i/d/c/h;->f:I

    iget v3, p1, Lb/e/a/i/d/c/h;->f:I

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    iget v2, p0, Lb/e/a/i/d/c/h;->i:I

    iget v3, p1, Lb/e/a/i/d/c/h;->i:I

    if-eq v2, v3, :cond_3

    return v1

    :cond_3
    iget v2, p0, Lb/e/a/i/d/c/h;->l:I

    iget v3, p1, Lb/e/a/i/d/c/h;->l:I

    if-eq v2, v3, :cond_4

    return v1

    :cond_4
    iget v2, p0, Lb/e/a/i/d/c/h;->d:I

    iget v3, p1, Lb/e/a/i/d/c/h;->d:I

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    iget v2, p0, Lb/e/a/i/d/c/h;->m:I

    iget v3, p1, Lb/e/a/i/d/c/h;->m:I

    if-eq v2, v3, :cond_6

    return v1

    :cond_6
    iget v2, p0, Lb/e/a/i/d/c/h;->g:I

    iget v3, p1, Lb/e/a/i/d/c/h;->g:I

    if-eq v2, v3, :cond_7

    return v1

    :cond_7
    iget v2, p0, Lb/e/a/i/d/c/h;->k:I

    iget v3, p1, Lb/e/a/i/d/c/h;->k:I

    if-eq v2, v3, :cond_8

    return v1

    :cond_8
    iget v2, p0, Lb/e/a/i/d/c/h;->e:I

    iget v3, p1, Lb/e/a/i/d/c/h;->e:I

    if-eq v2, v3, :cond_9

    return v1

    :cond_9
    iget v2, p0, Lb/e/a/i/d/c/h;->h:I

    iget v3, p1, Lb/e/a/i/d/c/h;->h:I

    if-eq v2, v3, :cond_a

    return v1

    :cond_a
    iget-object v2, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    if-eqz v2, :cond_b

    iget-object v3, p1, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_c

    goto :goto_0

    :cond_b
    iget-object v2, p1, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    if-eqz v2, :cond_c

    :goto_0
    return v1

    :cond_c
    iget-object v2, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    if-eqz v2, :cond_d

    iget-object v3, p1, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_e

    goto :goto_1

    :cond_d
    iget-object v2, p1, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    if-eqz v2, :cond_e

    :goto_1
    return v1

    :cond_e
    iget-object v2, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    if-eqz v2, :cond_f

    iget-object v3, p1, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    invoke-interface {v2, v3}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_10

    goto :goto_2

    :cond_f
    iget-object v2, p1, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    if-eqz v2, :cond_10

    :goto_2
    return v1

    :cond_10
    iget-object v2, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    iget-object p1, p1, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    if-eqz v2, :cond_11

    invoke-virtual {v2, p1}, Lb/e/a/i/d/c/n;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_12

    goto :goto_3

    :cond_11
    if-eqz p1, :cond_12

    :goto_3
    return v1

    :cond_12
    return v0

    :cond_13
    :goto_4
    return v1
.end method

.method public g()Lb/e/a/i/d/c/e;
    .locals 1

    iget-object v0, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    return-object v0
.end method

.method public h()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->l:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lb/e/a/i/d/c/h;->d:I

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->e:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->f:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->g:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->h:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->i:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->k:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->l:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/h;->m:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    goto :goto_1

    :cond_1
    move v1, v2

    :goto_1
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lb/e/a/i/d/c/n;->hashCode()I

    move-result v1

    goto :goto_2

    :cond_2
    move v1, v2

    :goto_2
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    if-eqz v1, :cond_3

    invoke-interface {v1}, Ljava/util/List;->hashCode()I

    move-result v2

    :cond_3
    add-int/2addr v0, v2

    return v0
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->d:I

    return v0
.end method

.method public j()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/e/a/i/d/c/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/i/d/c/h;->p:Ljava/util/List;

    return-object v0
.end method

.method public k()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->k:I

    return v0
.end method

.method public l()Lb/e/a/i/d/c/n;
    .locals 1

    iget-object v0, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    return-object v0
.end method

.method public m()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->e:I

    return v0
.end method

.method public n()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->h:I

    return v0
.end method

.method public o()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->f:I

    return v0
.end method

.method public p()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->i:I

    return v0
.end method

.method public q()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    return-object v0
.end method

.method public r()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->m:I

    return v0
.end method

.method public s()I
    .locals 1

    iget v0, p0, Lb/e/a/i/d/c/h;->g:I

    return v0
.end method

.method public t()Ljava/nio/ByteBuffer;
    .locals 3

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->b()I

    move-result v0

    new-array v0, v0, [B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    const/4 v1, 0x3

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/e/a/i/d/c/h;->a()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lb/e/a/i/d/c/b;->f(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/h;->d:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/h;->e:I

    shl-int/lit8 v1, v1, 0x7

    iget v2, p0, Lb/e/a/i/d/c/h;->f:I

    shl-int/lit8 v2, v2, 0x6

    or-int/2addr v1, v2

    iget v2, p0, Lb/e/a/i/d/c/h;->g:I

    shl-int/lit8 v2, v2, 0x5

    or-int/2addr v1, v2

    iget v2, p0, Lb/e/a/i/d/c/h;->h:I

    and-int/lit8 v2, v2, 0x1f

    or-int/2addr v1, v2

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/e/a/i/d/c/h;->e:I

    if-lez v1, :cond_0

    iget v1, p0, Lb/e/a/i/d/c/h;->l:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    :cond_0
    iget v1, p0, Lb/e/a/i/d/c/h;->f:I

    if-lez v1, :cond_1

    iget v1, p0, Lb/e/a/i/d/c/h;->i:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget-object v1, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    invoke-static {v0, v1}, Lb/c/a/f;->k(Ljava/nio/ByteBuffer;Ljava/lang/String;)V

    :cond_1
    iget v1, p0, Lb/e/a/i/d/c/h;->g:I

    if-lez v1, :cond_2

    iget v1, p0, Lb/e/a/i/d/c/h;->m:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    :cond_2
    iget-object v1, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    invoke-virtual {v1}, Lb/e/a/i/d/c/e;->p()Ljava/nio/ByteBuffer;

    move-result-object v1

    iget-object v2, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    invoke-virtual {v2}, Lb/e/a/i/d/c/n;->g()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ESDescriptor"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "{esId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", streamDependenceFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->e:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", URLFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->f:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", oCRstreamFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", streamPriority="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->h:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", URLLength="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->i:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", URLString=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/h;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v1, ", remoteODFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->k:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", dependsOnEsId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->l:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", oCREsId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/h;->m:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", decoderConfigDescriptor="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/h;->n:Lb/e/a/i/d/c/e;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", slConfigDescriptor="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/h;->o:Lb/e/a/i/d/c/n;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
