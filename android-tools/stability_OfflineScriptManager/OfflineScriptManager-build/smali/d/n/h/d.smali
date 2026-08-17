.class public abstract Ld/n/h/d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/h/f;


# instance fields
.field private a:Ljava/nio/ByteBuffer;

.field private b:Ljava/lang/Runnable;

.field private c:Z

.field private d:I

.field private final e:Ljava/nio/ByteBuffer;

.field private final f:I

.field protected g:Ld/e;


# direct methods
.method protected constructor <init>(Ld/s/c;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Ld/n/h/d;->f:I

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/d;->e:Ljava/nio/ByteBuffer;

    return-void
.end method

.method private g([BILjava/lang/Runnable;Z)V
    .locals 0

    if-eqz p1, :cond_0

    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    :goto_0
    iput p2, p0, Ld/n/h/d;->d:I

    iput-object p3, p0, Ld/n/h/d;->b:Ljava/lang/Runnable;

    iput-boolean p4, p0, Ld/n/h/d;->c:Z

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public final b(Ld/s/f;I)I
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/s/f<",
            "Ljava/nio/ByteBuffer;",
            ">;I)I"
        }
    .end annotation

    invoke-virtual {p1}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/h/d;->e:Ljava/nio/ByteBuffer;

    iget p2, p0, Ld/n/h/d;->f:I

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    :cond_0
    iget-object v1, p0, Ld/n/h/d;->g:Ld/e;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move v1, v2

    :goto_0
    if-lt v1, p2, :cond_2

    goto :goto_1

    :cond_2
    iget v3, p0, Ld/n/h/d;->d:I

    const/4 v4, 0x0

    if-nez v3, :cond_4

    iget-boolean v3, p0, Ld/n/h/d;->c:Z

    if-eqz v3, :cond_3

    iput-object v4, p0, Ld/n/h/d;->g:Ld/e;

    :goto_1
    invoke-virtual {p1, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    return v1

    :cond_3
    invoke-virtual {p0}, Ld/n/h/d;->e()V

    :cond_4
    if-nez v1, :cond_5

    invoke-virtual {p1}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_5

    iget v3, p0, Ld/n/h/d;->d:I

    if-lt v3, p2, :cond_5

    iget-object p2, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v0

    invoke-virtual {p2, v0}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object p2, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget p1, p0, Ld/n/h/d;->d:I

    iput-object v4, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    iput v2, p0, Ld/n/h/d;->d:I

    return p1

    :cond_5
    iget v3, p0, Ld/n/h/d;->d:I

    sub-int v4, p2, v1

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    iget-object v4, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->limit()I

    move-result v4

    iget-object v5, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v6

    iget-object v7, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->position()I

    move-result v7

    add-int/2addr v7, v3

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-virtual {v5, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    iget-object v5, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v5

    sub-int/2addr v5, v3

    iget-object v3, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    add-int/2addr v1, v5

    iget v3, p0, Ld/n/h/d;->d:I

    sub-int/2addr v3, v5

    iput v3, p0, Ld/n/h/d;->d:I

    goto :goto_0
.end method

.method public final c(Ld/e;)V
    .locals 0

    iput-object p1, p0, Ld/n/h/d;->g:Ld/e;

    invoke-virtual {p0}, Ld/n/h/d;->e()V

    return-void
.end method

.method protected d(Ljava/lang/Runnable;Z)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1, p1, p2}, Ld/n/h/d;->g([BILjava/lang/Runnable;Z)V

    return-void
.end method

.method protected e()V
    .locals 1

    iget-object v0, p0, Ld/n/h/d;->b:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method protected f(Ljava/nio/ByteBuffer;ILjava/lang/Runnable;Z)V
    .locals 0

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    iput-object p1, p0, Ld/n/h/d;->a:Ljava/nio/ByteBuffer;

    iput p2, p0, Ld/n/h/d;->d:I

    iput-object p3, p0, Ld/n/h/d;->b:Ljava/lang/Runnable;

    iput-boolean p4, p0, Ld/n/h/d;->c:Z

    return-void
.end method
