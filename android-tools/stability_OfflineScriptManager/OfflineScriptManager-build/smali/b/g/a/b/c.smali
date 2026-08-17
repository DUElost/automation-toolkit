.class public Lb/g/a/b/c;
.super Lb/e/a/i/d/d/b;
.source ""


# instance fields
.field a:I

.field b:I

.field c:Z

.field d:I

.field e:J

.field f:J

.field g:I

.field h:I

.field i:I

.field j:I

.field k:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lb/e/a/i/d/d/b;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/nio/ByteBuffer;
    .locals 3

    const/16 v0, 0x14

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lb/g/a/b/c;->a:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/g/a/b/c;->b:I

    shl-int/lit8 v1, v1, 0x6

    iget-boolean v2, p0, Lb/g/a/b/c;->c:Z

    if-eqz v2, :cond_0

    const/16 v2, 0x20

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    add-int/2addr v1, v2

    iget v2, p0, Lb/g/a/b/c;->d:I

    add-int/2addr v1, v2

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget-wide v1, p0, Lb/g/a/b/c;->e:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v1, p0, Lb/g/a/b/c;->f:J

    invoke-static {v0, v1, v2}, Lb/c/a/f;->h(Ljava/nio/ByteBuffer;J)V

    iget v1, p0, Lb/g/a/b/c;->g:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/g/a/b/c;->h:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/g/a/b/c;->i:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/g/a/b/c;->j:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v1, p0, Lb/g/a/b/c;->k:I

    invoke-static {v0, v1}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    const-string v0, "tscl"

    return-object v0
.end method

.method public c(Ljava/nio/ByteBuffer;)V
    .locals 2

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/g/a/b/c;->a:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    and-int/lit16 v1, v0, 0xc0

    shr-int/lit8 v1, v1, 0x6

    iput v1, p0, Lb/g/a/b/c;->b:I

    and-int/lit8 v1, v0, 0x20

    if-lez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iput-boolean v1, p0, Lb/g/a/b/c;->c:Z

    and-int/lit8 v0, v0, 0x1f

    iput v0, p0, Lb/g/a/b/c;->d:I

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/g/a/b/c;->e:J

    invoke-static {p1}, Lb/c/a/e;->l(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/g/a/b/c;->f:J

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/g/a/b/c;->g:I

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/g/a/b/c;->h:I

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/g/a/b/c;->i:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/g/a/b/c;->j:I

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    move-result p1

    iput p1, p0, Lb/g/a/b/c;->k:I

    return-void
.end method

.method public d()I
    .locals 1

    const/16 v0, 0x14

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_d

    const-class v2, Lb/g/a/b/c;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    check-cast p1, Lb/g/a/b/c;

    iget v2, p0, Lb/g/a/b/c;->a:I

    iget v3, p1, Lb/g/a/b/c;->a:I

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    iget v2, p0, Lb/g/a/b/c;->i:I

    iget v3, p1, Lb/g/a/b/c;->i:I

    if-eq v2, v3, :cond_3

    return v1

    :cond_3
    iget v2, p0, Lb/g/a/b/c;->k:I

    iget v3, p1, Lb/g/a/b/c;->k:I

    if-eq v2, v3, :cond_4

    return v1

    :cond_4
    iget v2, p0, Lb/g/a/b/c;->j:I

    iget v3, p1, Lb/g/a/b/c;->j:I

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    iget v2, p0, Lb/g/a/b/c;->h:I

    iget v3, p1, Lb/g/a/b/c;->h:I

    if-eq v2, v3, :cond_6

    return v1

    :cond_6
    iget-wide v2, p0, Lb/g/a/b/c;->f:J

    iget-wide v4, p1, Lb/g/a/b/c;->f:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_7

    return v1

    :cond_7
    iget v2, p0, Lb/g/a/b/c;->g:I

    iget v3, p1, Lb/g/a/b/c;->g:I

    if-eq v2, v3, :cond_8

    return v1

    :cond_8
    iget-wide v2, p0, Lb/g/a/b/c;->e:J

    iget-wide v4, p1, Lb/g/a/b/c;->e:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_9

    return v1

    :cond_9
    iget v2, p0, Lb/g/a/b/c;->d:I

    iget v3, p1, Lb/g/a/b/c;->d:I

    if-eq v2, v3, :cond_a

    return v1

    :cond_a
    iget v2, p0, Lb/g/a/b/c;->b:I

    iget v3, p1, Lb/g/a/b/c;->b:I

    if-eq v2, v3, :cond_b

    return v1

    :cond_b
    iget-boolean v2, p0, Lb/g/a/b/c;->c:Z

    iget-boolean p1, p1, Lb/g/a/b/c;->c:Z

    if-eq v2, p1, :cond_c

    return v1

    :cond_c
    return v0

    :cond_d
    :goto_0
    return v1
.end method

.method public hashCode()I
    .locals 6

    iget v0, p0, Lb/g/a/b/c;->a:I

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->b:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/g/a/b/c;->c:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->d:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-wide v1, p0, Lb/g/a/b/c;->e:J

    const/16 v3, 0x20

    ushr-long v4, v1, v3

    xor-long/2addr v1, v4

    long-to-int v1, v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-wide v1, p0, Lb/g/a/b/c;->f:J

    ushr-long v3, v1, v3

    xor-long/2addr v1, v3

    long-to-int v1, v1

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->g:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->h:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->i:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->j:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/g/a/b/c;->k:I

    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "TemporalLayerSampleGroup{temporalLayerId="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lb/g/a/b/c;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlprofile_space="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tltier_flag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lb/g/a/b/c;->c:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", tlprofile_idc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlprofile_compatibility_flags="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/g/a/b/c;->e:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", tlconstraint_indicator_flags="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/g/a/b/c;->f:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", tllevel_idc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlMaxBitRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->h:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlAvgBitRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->i:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlConstantFrameRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->j:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", tlAvgFrameRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/g/a/b/c;->k:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
