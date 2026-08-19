.class public Lb/c/a/i/j$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/c/a/i/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field a:Lb/c/a/i/j;

.field private b:J

.field private c:J

.field private d:D


# direct methods
.method public constructor <init>(Lb/c/a/i/j;JJD)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p2, p0, Lb/c/a/i/j$a;->b:J

    iput-wide p4, p0, Lb/c/a/i/j$a;->c:J

    iput-wide p6, p0, Lb/c/a/i/j$a;->d:D

    iput-object p1, p0, Lb/c/a/i/j$a;->a:Lb/c/a/i/j;

    return-void
.end method

.method public constructor <init>(Lb/c/a/i/j;Ljava/nio/ByteBuffer;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Lb/e/a/c;->n()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-static {p2}, Lb/c/a/e;->m(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/j$a;->b:J

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-static {p2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/j$a;->b:J

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    int-to-long v0, v0

    :goto_0
    iput-wide v0, p0, Lb/c/a/i/j$a;->c:J

    invoke-static {p2}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/j$a;->d:D

    iput-object p1, p0, Lb/c/a/i/j$a;->a:Lb/c/a/i/j;

    return-void
.end method


# virtual methods
.method public a(Ljava/nio/ByteBuffer;)V
    .locals 2

    iget-object v0, p0, Lb/c/a/i/j$a;->a:Lb/c/a/i/j;

    invoke-virtual {v0}, Lb/e/a/c;->n()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-wide v0, p0, Lb/c/a/i/j$a;->b:J

    invoke-static {p1, v0, v1}, Lb/c/a/f;->i(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/j$a;->c:J

    invoke-virtual {p1, v0, v1}, Ljava/nio/ByteBuffer;->putLong(J)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_0
    iget-wide v0, p0, Lb/c/a/i/j$a;->b:J

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    int-to-long v0, v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/j$a;->c:J

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    :goto_0
    iget-wide v0, p0, Lb/c/a/i/j$a;->d:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    return-void
.end method

.method public b()D
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/j$a;->d:D

    return-wide v0
.end method

.method public c()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/j$a;->c:J

    return-wide v0
.end method

.method public d()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/j$a;->b:J

    return-wide v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_4

    const-class v2, Lb/c/a/i/j$a;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    check-cast p1, Lb/c/a/i/j$a;

    iget-wide v2, p0, Lb/c/a/i/j$a;->c:J

    iget-wide v4, p1, Lb/c/a/i/j$a;->c:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_2

    return v1

    :cond_2
    iget-wide v2, p0, Lb/c/a/i/j$a;->b:J

    iget-wide v4, p1, Lb/c/a/i/j$a;->b:J

    cmp-long p1, v2, v4

    if-eqz p1, :cond_3

    return v1

    :cond_3
    return v0

    :cond_4
    :goto_0
    return v1
.end method

.method public hashCode()I
    .locals 5

    iget-wide v0, p0, Lb/c/a/i/j$a;->b:J

    const/16 v2, 0x20

    ushr-long v3, v0, v2

    xor-long/2addr v0, v3

    long-to-int v0, v0

    mul-int/lit8 v0, v0, 0x1f

    iget-wide v3, p0, Lb/c/a/i/j$a;->c:J

    ushr-long v1, v3, v2

    xor-long/2addr v1, v3

    long-to-int v1, v1

    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Entry{segmentDuration="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lb/c/a/i/j$a;->b:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", mediaTime="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/j$a;->c:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", mediaRate="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/j$a;->d:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
