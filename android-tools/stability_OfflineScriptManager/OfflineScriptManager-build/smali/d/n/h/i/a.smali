.class public Ld/n/h/i/a;
.super Ld/n/h/a;
.source ""


# instance fields
.field private final o:Ljava/nio/ByteBuffer;

.field private p:I


# direct methods
.method public constructor <init>(Ld/s/c;IJLd/o/a;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Ld/n/h/a;-><init>(Ld/s/c;IJLd/o/a;)V

    const/16 p1, 0x8

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object p2, p0, Ld/n/h/a;->l:Ld/n/h/e$a;

    invoke-virtual {p0, p1, p2}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    return-void
.end method


# virtual methods
.method protected h(I)Ld/e;
    .locals 1

    invoke-super {p0, p1}, Ld/n/h/a;->h(I)Ld/e;

    move-result-object p1

    iget v0, p0, Ld/n/h/i/a;->p:I

    invoke-virtual {p1, v0}, Ld/e;->y(I)V

    return-object p1
.end method

.method protected i()Ld/n/h/e$a$a;
    .locals 3

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    invoke-static {v0, v1}, Ld/s/g;->b(Ljava/nio/ByteBuffer;I)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Ld/n/h/a;->m(J)Ld/n/h/e$a$a;

    move-result-object v0

    sget-object v1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-eq v0, v1, :cond_0

    iget-object v1, p0, Ld/n/h/a;->i:Ld/e;

    iget-object v2, p0, Ld/n/h/a;->m:Ld/n/h/e$a;

    invoke-virtual {p0, v1, v2}, Ld/n/h/b;->g(Ld/e;Ld/n/h/e$a;)V

    :cond_0
    return-object v0
.end method

.method protected j()Ld/n/h/e$a$a;
    .locals 4

    const/4 v0, 0x0

    iput v0, p0, Ld/n/h/i/a;->p:I

    iget-object v1, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    and-int/lit8 v2, v1, 0x1

    const/4 v3, 0x1

    if-lez v2, :cond_0

    iget v2, p0, Ld/n/h/i/a;->p:I

    or-int/2addr v2, v3

    iput v2, p0, Ld/n/h/i/a;->p:I

    :cond_0
    and-int/lit8 v2, v1, 0x4

    if-lez v2, :cond_1

    iget v2, p0, Ld/n/h/i/a;->p:I

    or-int/lit8 v2, v2, 0x2

    iput v2, p0, Ld/n/h/i/a;->p:I

    :cond_1
    iget-object v2, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    and-int/lit8 v0, v1, 0x2

    if-lez v0, :cond_2

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/a;->k:Ld/n/h/e$a;

    goto :goto_0

    :cond_2
    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/a;->j:Ld/n/h/e$a;

    :goto_0
    invoke-virtual {p0, v0, v1}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    sget-object v0, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object v0
.end method

.method protected k()Ld/n/h/e$a$a;
    .locals 2

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/a;->l:Ld/n/h/e$a;

    invoke-virtual {p0, v0, v1}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    sget-object v0, Ld/n/h/e$a$a;->c:Ld/n/h/e$a$a;

    return-object v0
.end method

.method protected l()Ld/n/h/e$a$a;
    .locals 3

    iget-object v0, p0, Ld/n/h/i/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    int-to-long v0, v0

    invoke-virtual {p0, v0, v1}, Ld/n/h/a;->m(J)Ld/n/h/e$a$a;

    move-result-object v0

    sget-object v1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-eq v0, v1, :cond_0

    iget-object v1, p0, Ld/n/h/a;->i:Ld/e;

    iget-object v2, p0, Ld/n/h/a;->m:Ld/n/h/e$a;

    invoke-virtual {p0, v1, v2}, Ld/n/h/b;->g(Ld/e;Ld/n/h/e$a;)V

    :cond_0
    return-object v0
.end method
