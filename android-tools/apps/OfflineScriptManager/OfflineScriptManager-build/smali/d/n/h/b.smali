.class public abstract Ld/n/h/b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/h/e;


# instance fields
.field private a:Ljava/nio/ByteBuffer;

.field private b:Z

.field private c:I

.field private d:I

.field private e:Ljava/nio/ByteBuffer;

.field private f:Ld/n/h/e$a;

.field private final g:Ld/s/c;


# direct methods
.method public constructor <init>(Ld/s/c;I)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/h/b;->f:Ld/n/h/e$a;

    iput-object v0, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    const/4 v0, 0x0

    iput v0, p0, Ld/n/h/b;->c:I

    iput p2, p0, Ld/n/h/b;->d:I

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    iput-object p2, p0, Ld/n/h/b;->e:Ljava/nio/ByteBuffer;

    iput-object p1, p0, Ld/n/h/b;->g:Ld/s/c;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public c(Ljava/nio/ByteBuffer;ILd/s/f;)Ld/n/h/e$a$a;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/nio/ByteBuffer;",
            "I",
            "Ld/s/f<",
            "Ljava/lang/Integer;",
            ">;)",
            "Ld/n/h/e$a$a;"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p3, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-boolean v0, p0, Ld/n/h/b;->b:Z

    if-eqz v0, :cond_2

    iget-object p1, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    add-int/2addr v0, p2

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget p1, p0, Ld/n/h/b;->c:I

    sub-int/2addr p1, p2

    iput p1, p0, Ld/n/h/b;->c:I

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p3, p1}, Ld/s/f;->b(Ljava/lang/Object;)V

    :cond_0
    iget-object p1, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object p1

    :cond_1
    iget-object p1, p0, Ld/n/h/b;->f:Ld/n/h/e$a;

    invoke-interface {p1}, Ld/n/h/e$a;->a()Ld/n/h/e$a$a;

    move-result-object p1

    sget-object p2, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    if-eq p1, p2, :cond_0

    return-object p1

    :cond_2
    :goto_0
    invoke-virtual {p3}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-lt v0, p2, :cond_3

    sget-object p1, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object p1

    :cond_3
    iget v0, p0, Ld/n/h/b;->c:I

    invoke-virtual {p3}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    sub-int v1, p2, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    add-int/2addr v2, v0

    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v2, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget v1, p0, Ld/n/h/b;->c:I

    sub-int/2addr v1, v0

    iput v1, p0, Ld/n/h/b;->c:I

    invoke-virtual {p3}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p3, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    :cond_4
    iget-object v0, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-eqz v0, :cond_5

    goto :goto_0

    :cond_5
    iget-object v0, p0, Ld/n/h/b;->f:Ld/n/h/e$a;

    invoke-interface {v0}, Ld/n/h/e$a;->a()Ld/n/h/e$a$a;

    move-result-object v0

    sget-object v1, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    if-eq v0, v1, :cond_4

    return-object v0
.end method

.method public d()Ljava/nio/ByteBuffer;
    .locals 2

    iget v0, p0, Ld/n/h/b;->c:I

    iget v1, p0, Ld/n/h/b;->d:I

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/h/b;->b:Z

    iget-object v0, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/h/b;->b:Z

    iget-object v0, p0, Ld/n/h/b;->e:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/b;->e:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method protected e(I)V
    .locals 1

    iget-object v0, p0, Ld/n/h/b;->g:Ld/s/c;

    invoke-virtual {v0, p1}, Ld/s/c;->c(I)V

    return-void
.end method

.method protected f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V
    .locals 0

    iput-object p1, p0, Ld/n/h/b;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p1

    iput p1, p0, Ld/n/h/b;->c:I

    iput-object p2, p0, Ld/n/h/b;->f:Ld/n/h/e$a;

    return-void
.end method

.method protected g(Ld/e;Ld/n/h/e$a;)V
    .locals 0

    invoke-virtual {p1}, Ld/e;->a()Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    return-void
.end method
