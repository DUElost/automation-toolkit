.class public abstract Lb/e/a/i/d/c/b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation runtime Lb/e/a/i/d/c/g;
    tags = {
        0x0
    }
.end annotation


# instance fields
.field a:I

.field b:I

.field c:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method abstract a()I
.end method

.method public b()I
    .locals 2

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->a()I

    move-result v0

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->c()I

    move-result v1

    add-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public c()I
    .locals 3

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->a()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-gtz v0, :cond_0

    iget v2, p0, Lb/e/a/i/d/c/b;->c:I

    if-lt v1, v2, :cond_0

    return v1

    :cond_0
    ushr-int/lit8 v0, v0, 0x7

    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public final d(ILjava/nio/ByteBuffer;)V
    .locals 4

    iput p1, p0, Lb/e/a/i/d/c/b;->a:I

    invoke-static {p2}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result p1

    and-int/lit8 v0, p1, 0x7f

    iput v0, p0, Lb/e/a/i/d/c/b;->b:I

    const/4 v0, 0x1

    move v1, v0

    :goto_0
    ushr-int/lit8 p1, p1, 0x7

    if-eq p1, v0, :cond_0

    iput v1, p0, Lb/e/a/i/d/c/b;->c:I

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object p1

    iget v0, p0, Lb/e/a/i/d/c/b;->b:I

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {p0, p1}, Lb/e/a/i/d/c/b;->e(Ljava/nio/ByteBuffer;)V

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->position()I

    move-result p1

    iget v0, p0, Lb/e/a/i/d/c/b;->b:I

    add-int/2addr p1, v0

    invoke-virtual {p2, p1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    return-void

    :cond_0
    invoke-static {p2}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result p1

    add-int/lit8 v1, v1, 0x1

    iget v2, p0, Lb/e/a/i/d/c/b;->b:I

    shl-int/lit8 v2, v2, 0x7

    and-int/lit8 v3, p1, 0x7f

    or-int/2addr v2, v3

    iput v2, p0, Lb/e/a/i/d/c/b;->b:I

    goto :goto_0
.end method

.method public abstract e(Ljava/nio/ByteBuffer;)V
.end method

.method public f(Ljava/nio/ByteBuffer;I)V
    .locals 4

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-gtz p2, :cond_0

    iget v2, p0, Lb/e/a/i/d/c/b;->c:I

    if-lt v1, v2, :cond_0

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->c()I

    move-result p2

    add-int/2addr v0, p2

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    return-void

    :cond_0
    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->c()I

    move-result v2

    add-int/2addr v2, v0

    sub-int/2addr v2, v1

    if-lez p2, :cond_1

    and-int/lit8 v3, p2, 0x7f

    int-to-byte v3, v3

    goto :goto_1

    :cond_1
    const/16 v3, -0x80

    :goto_1
    invoke-virtual {p1, v2, v3}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    ushr-int/lit8 p2, p2, 0x7

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BaseDescriptor"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "{tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/b;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", sizeOfInstance="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/b;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
