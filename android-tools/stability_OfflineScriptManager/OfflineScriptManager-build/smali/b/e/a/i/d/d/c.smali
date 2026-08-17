.class public Lb/e/a/i/d/d/c;
.super Lb/e/a/i/d/d/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/e/a/i/d/d/c$a;
    }
.end annotation


# instance fields
.field private a:S

.field private b:S

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/i/d/d/c$a;",
            ">;"
        }
    .end annotation
.end field

.field private d:I

.field private e:I

.field private f:S


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lb/e/a/i/d/d/b;-><init>()V

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public a()Ljava/nio/ByteBuffer;
    .locals 4

    iget-short v0, p0, Lb/e/a/i/d/d/c;->a:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/16 v0, 0xd

    goto :goto_0

    :cond_0
    mul-int/lit8 v0, v0, 0x6

    add-int/lit8 v0, v0, 0xb

    :goto_0
    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget-short v2, p0, Lb/e/a/i/d/d/c;->a:S

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    iget-short v2, p0, Lb/e/a/i/d/d/c;->a:S

    if-ne v2, v1, :cond_1

    iget-short v1, p0, Lb/e/a/i/d/d/c;->b:S

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    goto :goto_2

    :cond_1
    iget-object v1, p0, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_2

    :goto_2
    iget v1, p0, Lb/e/a/i/d/d/c;->d:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    iget v1, p0, Lb/e/a/i/d/d/c;->e:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    iget-short v1, p0, Lb/e/a/i/d/d/c;->f:S

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    return-object v0

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/i/d/d/c$a;

    invoke-virtual {v2}, Lb/e/a/i/d/d/c$a;->a()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Lb/e/a/i/d/d/c$a;->b()S

    move-result v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    goto :goto_1
.end method

.method public b()Ljava/lang/String;
    .locals 1

    const-string v0, "rash"

    return-object v0
.end method

.method public c(Ljava/nio/ByteBuffer;)V
    .locals 5

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v0

    iput-short v0, p0, Lb/e/a/i/d/d/c;->a:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v0

    iput-short v0, p0, Lb/e/a/i/d/d/c;->b:S

    goto :goto_1

    :cond_0
    :goto_0
    add-int/lit8 v1, v0, -0x1

    if-gtz v0, :cond_1

    :goto_1
    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/d/c;->d:I

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/d/c;->e:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result p1

    int-to-short p1, p1

    iput-short p1, p0, Lb/e/a/i/d/d/c;->f:S

    return-void

    :cond_1
    iget-object v0, p0, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    new-instance v2, Lb/e/a/i/d/d/c$a;

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v3

    invoke-static {v3, v4}, Lb/e/a/j/b;->a(J)I

    move-result v3

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v4

    invoke-direct {v2, v3, v4}, Lb/e/a/i/d/d/c$a;-><init>(IS)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move v0, v1

    goto :goto_0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_9

    const-class v2, Lb/e/a/i/d/d/c;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_1

    :cond_1
    check-cast p1, Lb/e/a/i/d/d/c;

    iget-short v2, p0, Lb/e/a/i/d/d/c;->f:S

    iget-short v3, p1, Lb/e/a/i/d/d/c;->f:S

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    iget v2, p0, Lb/e/a/i/d/d/c;->d:I

    iget v3, p1, Lb/e/a/i/d/d/c;->d:I

    if-eq v2, v3, :cond_3

    return v1

    :cond_3
    iget v2, p0, Lb/e/a/i/d/d/c;->e:I

    iget v3, p1, Lb/e/a/i/d/d/c;->e:I

    if-eq v2, v3, :cond_4

    return v1

    :cond_4
    iget-short v2, p0, Lb/e/a/i/d/d/c;->a:S

    iget-short v3, p1, Lb/e/a/i/d/d/c;->a:S

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    iget-short v2, p0, Lb/e/a/i/d/d/c;->b:S

    iget-short v3, p1, Lb/e/a/i/d/d/c;->b:S

    if-eq v2, v3, :cond_6

    return v1

    :cond_6
    iget-object v2, p0, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    iget-object p1, p1, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    if-eqz v2, :cond_7

    invoke-interface {v2, p1}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_8

    goto :goto_0

    :cond_7
    if-eqz p1, :cond_8

    :goto_0
    return v1

    :cond_8
    return v0

    :cond_9
    :goto_1
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget-short v0, p0, Lb/e/a/i/d/d/c;->a:S

    mul-int/lit8 v0, v0, 0x1f

    iget-short v1, p0, Lb/e/a/i/d/d/c;->b:S

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/d/d/c;->c:Ljava/util/List;

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->hashCode()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/d/c;->d:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/d/c;->e:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-short v1, p0, Lb/e/a/i/d/d/c;->f:S

    add-int/2addr v0, v1

    return v0
.end method
