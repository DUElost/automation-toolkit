.class public Ld/e;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/e$a;,
        Ld/e$b;
    }
.end annotation


# instance fields
.field private a:Ld/n/e;

.field private b:I

.field private c:Ld/e$b;

.field private d:I

.field private e:[B

.field private final f:Ljava/nio/ByteBuffer;

.field private g:I


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Ld/e;-><init>(I)V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/e;->g:I

    sget-object v1, Ld/e$b;->b:Ld/e$b;

    iput-object v1, p0, Ld/e;->c:Ld/e$b;

    iput v0, p0, Ld/e;->b:I

    iput p1, p0, Ld/e;->d:I

    new-array p1, p1, [B

    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    sget-object v0, Ljava/nio/ByteOrder;->BIG_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object p1

    iput-object p1, p0, Ld/e;->e:[B

    return-void
.end method

.method private constructor <init>(Ld/e;Ljava/io/ByteArrayOutputStream;)V
    .locals 0

    invoke-virtual {p2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p2

    invoke-static {p2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p2

    invoke-direct {p0, p2}, Ld/e;-><init>(Ljava/nio/ByteBuffer;)V

    iget-object p2, p1, Ld/e;->c:Ld/e$b;

    iput-object p2, p0, Ld/e;->c:Ld/e$b;

    iget p1, p1, Ld/e;->b:I

    iput p1, p0, Ld/e;->b:I

    return-void
.end method

.method synthetic constructor <init>(Ld/e;Ljava/io/ByteArrayOutputStream;Ld/e;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/e;-><init>(Ld/e;Ljava/io/ByteArrayOutputStream;)V

    return-void
.end method

.method public constructor <init>(Ljava/nio/ByteBuffer;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/e;->g:I

    if-eqz p1, :cond_1

    sget-object v1, Ld/e$b;->b:Ld/e$b;

    iput-object v1, p0, Ld/e;->c:Ld/e$b;

    iput v0, p0, Ld/e;->b:I

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    if-ne v0, v1, :cond_0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    iput-object v0, p0, Ld/e;->e:[B

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/e;->e:[B

    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p1

    iput p1, p0, Ld/e;->d:I

    return-void

    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "ByteBuffer cannot be null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public constructor <init>([B)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/e;->g:I

    if-nez p1, :cond_0

    new-array p1, v0, [B

    :cond_0
    sget-object v1, Ld/e$b;->b:Ld/e$b;

    iput-object v1, p0, Ld/e;->c:Ld/e$b;

    iput v0, p0, Ld/e;->b:I

    array-length v0, p1

    iput v0, p0, Ld/e;->d:I

    iput-object p1, p0, Ld/e;->e:[B

    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    sget-object v0, Ljava/nio/ByteOrder;->BIG_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    return-void
.end method


# virtual methods
.method protected final A(I)V
    .locals 0

    iput p1, p0, Ld/e;->g:I

    return-void
.end method

.method public B()I
    .locals 1

    iget v0, p0, Ld/e;->d:I

    return v0
.end method

.method public C(Ljava/nio/ByteBuffer;II)V
    .locals 3

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    iget-object v1, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    iget-object v2, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    add-int/2addr p3, p2

    invoke-virtual {v2, p3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p3

    invoke-virtual {p3, p2}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    iget-object p2, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    return-void
.end method

.method public a()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public b()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public c()[B
    .locals 2

    iget-object v0, p0, Ld/e;->e:[B

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    iput-object v0, p0, Ld/e;->e:[B

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget-object v1, p0, Ld/e;->e:[B

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    :cond_0
    iget-object v0, p0, Ld/e;->e:[B

    return-object v0
.end method

.method public d()I
    .locals 1

    iget v0, p0, Ld/e;->b:I

    return v0
.end method

.method public e(I)B
    .locals 1

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    return p1
.end method

.method public f(I[BII)I
    .locals 1

    iget v0, p0, Ld/e;->d:I

    sub-int/2addr v0, p1

    invoke-static {p4, v0}, Ljava/lang/Math;->min(II)I

    move-result p4

    iget-object v0, p0, Ld/e;->e:[B

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v0, p2, p3, p4}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_0
    invoke-static {v0, p1, p2, p3, p4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :goto_0
    return p4
.end method

.method public g(I)J
    .locals 2

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-static {v0, p1}, Ld/s/g;->b(Ljava/nio/ByteBuffer;I)J

    move-result-wide v0

    return-wide v0
.end method

.method public h()Ld/n/e;
    .locals 1

    iget-object v0, p0, Ld/e;->a:Ld/n/e;

    return-object v0
.end method

.method protected final i()I
    .locals 1

    iget v0, p0, Ld/e;->g:I

    return v0
.end method

.method public j()Z
    .locals 2

    iget v0, p0, Ld/e;->b:I

    const/4 v1, 0x1

    and-int/2addr v0, v1

    if-lez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public k()V
    .locals 1

    sget-object v0, Ld/e$b;->c:Ld/e$b;

    iput-object v0, p0, Ld/e;->c:Ld/e$b;

    const/4 v0, 0x0

    iput-object v0, p0, Ld/e;->a:Ld/n/e;

    const/4 v0, 0x0

    iput v0, p0, Ld/e;->b:I

    return-void
.end method

.method public l()Z
    .locals 2

    iget v0, p0, Ld/e;->b:I

    const/4 v1, 0x2

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public m()Z
    .locals 2

    iget v0, p0, Ld/e;->b:I

    const/16 v1, 0x20

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public n()Z
    .locals 2

    iget-object v0, p0, Ld/e;->c:Ld/e$b;

    sget-object v1, Ld/e$b;->c:Ld/e$b;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public o()Z
    .locals 2

    iget v0, p0, Ld/e;->b:I

    const/16 v1, 0x40

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public p(B)Ld/e;
    .locals 2

    iget v0, p0, Ld/e;->g:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Ld/e;->g:I

    invoke-virtual {p0, v0, p1}, Ld/e;->r(IB)Ld/e;

    move-result-object p1

    return-object p1
.end method

.method public q(I)Ld/e;
    .locals 2

    iget v0, p0, Ld/e;->g:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Ld/e;->g:I

    int-to-byte p1, p1

    invoke-virtual {p0, v0, p1}, Ld/e;->r(IB)Ld/e;

    move-result-object p1

    return-object p1
.end method

.method protected r(IB)Ld/e;
    .locals 1

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1, p2}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    return-object p0
.end method

.method public s(Ljava/nio/ByteBuffer;)Ld/e;
    .locals 4

    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Ld/e;->g:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v1, p0, Ld/e;->g:I

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    add-int/2addr v1, v2

    iput v1, p0, Ld/e;->g:I

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    return-object p0
.end method

.method public t(Ljava/nio/ByteBuffer;II)Ld/e;
    .locals 2

    if-nez p1, :cond_0

    return-object p0

    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    add-int/2addr p3, p2

    invoke-virtual {p1, p3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p3

    invoke-virtual {p3, p2}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p0, p1}, Ld/e;->s(Ljava/nio/ByteBuffer;)Ld/e;

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    iget-object v1, p0, Ld/e;->c:Ld/e$b;

    const/4 v2, 0x0

    aput-object v1, v0, v2

    iget v1, p0, Ld/e;->d:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    iget v1, p0, Ld/e;->b:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    const-string v1, "#zmq.Msg{type=%s, size=%s, flags=%s}"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public u([B)Ld/e;
    .locals 2

    array-length v0, p1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Ld/e;->v([BII)Ld/e;

    move-result-object p1

    return-object p1
.end method

.method public v([BII)Ld/e;
    .locals 2

    if-nez p1, :cond_0

    return-object p0

    :cond_0
    iget-object v0, p0, Ld/e;->f:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Ld/e;->g:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v1, p0, Ld/e;->g:I

    add-int/2addr v1, p3

    iput v1, p0, Ld/e;->g:I

    invoke-virtual {v0, p1, p2, p3}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    return-object p0
.end method

.method public w(I)V
    .locals 1

    iget v0, p0, Ld/e;->b:I

    not-int p1, p1

    and-int/2addr p1, v0

    iput p1, p0, Ld/e;->b:I

    return-void
.end method

.method public x()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ld/e;->z(Ld/n/e;)Ld/e;

    return-void
.end method

.method public y(I)V
    .locals 1

    iget v0, p0, Ld/e;->b:I

    or-int/2addr p1, v0

    iput p1, p0, Ld/e;->b:I

    return-void
.end method

.method public z(Ld/n/e;)Ld/e;
    .locals 0

    iput-object p1, p0, Ld/e;->a:Ld/n/e;

    return-object p0
.end method
