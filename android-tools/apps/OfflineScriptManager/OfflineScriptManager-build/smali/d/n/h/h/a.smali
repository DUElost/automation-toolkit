.class public Ld/n/h/h/a;
.super Ld/n/h/a;
.source ""


# instance fields
.field private final o:Ljava/nio/ByteBuffer;


# direct methods
.method public constructor <init>(Ld/s/c;IJLd/o/a;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Ld/n/h/a;-><init>(Ld/s/c;IJLd/o/a;)V

    const/16 p1, 0x8

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object p2, p0, Ld/n/h/a;->j:Ld/n/h/e$a;

    invoke-virtual {p0, p1, p2}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    return-void
.end method


# virtual methods
.method protected i()Ld/n/h/e$a$a;
    .locals 4

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    invoke-static {v0, v1}, Ld/s/g;->b(Ljava/nio/ByteBuffer;I)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-gtz v2, :cond_0

    const v0, 0x9523e34

    invoke-virtual {p0, v0}, Ld/n/h/b;->e(I)V

    sget-object v0, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    return-object v0

    :cond_0
    iget-object v2, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    const-wide/16 v2, 0x1

    sub-long/2addr v0, v2

    invoke-virtual {p0, v0, v1}, Ld/n/h/a;->m(J)Ld/n/h/e$a$a;

    move-result-object v0

    sget-object v1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-eq v0, v1, :cond_1

    iget-object v1, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    iget-object v2, p0, Ld/n/h/a;->l:Ld/n/h/e$a;

    invoke-virtual {p0, v1, v2}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    :cond_1
    return-object v0
.end method

.method protected j()Ld/n/h/e$a$a;
    .locals 2

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    const/4 v1, 0x1

    and-int/2addr v0, v1

    if-lez v0, :cond_0

    iget-object v0, p0, Ld/n/h/a;->i:Ld/e;

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    :cond_0
    iget-object v0, p0, Ld/n/h/a;->i:Ld/e;

    iget-object v1, p0, Ld/n/h/a;->m:Ld/n/h/e$a;

    invoke-virtual {p0, v0, v1}, Ld/n/h/b;->g(Ld/e;Ld/n/h/e$a;)V

    sget-object v0, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object v0
.end method

.method protected k()Ld/n/h/e$a$a;
    .locals 2

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/a;->j:Ld/n/h/e$a;

    invoke-virtual {p0, v0, v1}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    sget-object v0, Ld/n/h/e$a$a;->c:Ld/n/h/e$a$a;

    return-object v0
.end method

.method protected l()Ld/n/h/e$a$a;
    .locals 3

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    const/16 v2, 0xff

    and-int/2addr v0, v2

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/h/a;->k:Ld/n/h/e$a;

    invoke-virtual {p0, v0, v1}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    sget-object v0, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object v0

    :cond_0
    if-gtz v0, :cond_1

    const v0, 0x9523e34

    invoke-virtual {p0, v0}, Ld/n/h/b;->e(I)V

    sget-object v0, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    return-object v0

    :cond_1
    iget-object v2, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    sub-int/2addr v0, v2

    int-to-long v0, v0

    invoke-virtual {p0, v0, v1}, Ld/n/h/a;->m(J)Ld/n/h/e$a$a;

    move-result-object v0

    sget-object v1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-eq v0, v1, :cond_2

    iget-object v1, p0, Ld/n/h/h/a;->o:Ljava/nio/ByteBuffer;

    iget-object v2, p0, Ld/n/h/a;->l:Ld/n/h/e$a;

    invoke-virtual {p0, v1, v2}, Ld/n/h/b;->f(Ljava/nio/ByteBuffer;Ld/n/h/e$a;)V

    :cond_2
    return-object v0
.end method
