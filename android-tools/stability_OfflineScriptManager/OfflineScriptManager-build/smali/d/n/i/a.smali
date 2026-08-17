.class public abstract Ld/n/i/a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/a$b;
    }
.end annotation


# instance fields
.field protected final a:Ld/f;

.field private b:Ld/s/a;

.field private c:Ld/s/a;

.field public final d:Ld/n/e;

.field public final e:Ld/n/e;

.field protected final f:Ld/n/f;

.field private final g:Ld/n/j/a;

.field protected h:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method protected constructor <init>(Ld/n/f;Ld/n/j/a;Ld/f;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ld/n/e;

    invoke-direct {v0}, Ld/n/e;-><init>()V

    iput-object v0, p0, Ld/n/i/a;->d:Ld/n/e;

    new-instance v0, Ld/n/e;

    invoke-direct {v0}, Ld/n/e;-><init>()V

    iput-object v0, p0, Ld/n/i/a;->e:Ld/n/e;

    iput-object p1, p0, Ld/n/i/a;->f:Ld/n/f;

    iput-object p3, p0, Ld/n/i/a;->a:Ld/f;

    iput-object p2, p0, Ld/n/i/a;->g:Ld/n/j/a;

    return-void
.end method

.method static synthetic a(Ld/n/i/a;[B)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/i/a;->v([B)V

    return-void
.end method

.method private v([B)V
    .locals 0

    invoke-static {p1}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object p1

    iput-object p1, p0, Ld/n/i/a;->b:Ld/s/a;

    return-void
.end method

.method private w([B)V
    .locals 3

    invoke-static {p1}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    iput-object v0, p0, Ld/n/i/a;->c:Ld/s/a;

    iget-object v0, p0, Ld/n/i/a;->d:Ld/n/e;

    new-instance v1, Ljava/lang/String;

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-direct {v1, p1, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    const-string p1, "User-Id"

    invoke-virtual {v0, p1, v1}, Ld/n/e;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected final b(Ljava/nio/ByteBuffer;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p3, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p3

    invoke-virtual {p0, p1, p2, p3}, Ld/n/i/a;->c(Ljava/nio/ByteBuffer;Ljava/lang/String;[B)V

    return-void
.end method

.method protected final c(Ljava/nio/ByteBuffer;Ljava/lang/String;[B)V
    .locals 2

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    array-length v0, p2

    if-nez p3, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    array-length v1, p3

    :goto_0
    int-to-byte v0, v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-static {p1, v1}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    if-eqz p3, :cond_1

    invoke-virtual {p1, p3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    :cond_1
    return-void
.end method

.method protected final d(Ld/e;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p3, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p3

    invoke-virtual {p0, p1, p2, p3}, Ld/n/i/a;->e(Ld/e;Ljava/lang/String;[B)V

    return-void
.end method

.method protected final e(Ld/e;Ljava/lang/String;[B)V
    .locals 2

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    array-length v0, p2

    if-nez p3, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    array-length v1, p3

    :goto_0
    int-to-byte v0, v0

    invoke-virtual {p1, v0}, Ld/e;->p(B)Ld/e;

    invoke-virtual {p1, p2}, Ld/e;->u([B)Ld/e;

    invoke-static {p1, v1}, Ld/s/g;->e(Ld/e;I)Ld/e;

    if-eqz p3, :cond_1

    invoke-virtual {p1, p3}, Ld/e;->u([B)Ld/e;

    :cond_1
    return-void
.end method

.method protected final f(Ld/e;Ljava/lang/String;)V
    .locals 1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    int-to-byte v0, v0

    invoke-virtual {p1, v0}, Ld/e;->p(B)Ld/e;

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p2

    invoke-virtual {p1, p2}, Ld/e;->u([B)Ld/e;

    return-void
.end method

.method protected g(Ljava/nio/ByteBuffer;[BII)Z
    .locals 5

    array-length v0, p2

    const/4 v1, 0x0

    if-le p4, v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    move v3, v0

    move v2, v1

    :goto_0
    if-lt v2, p4, :cond_1

    goto :goto_2

    :cond_1
    add-int v3, v2, p3

    invoke-virtual {p1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    aget-byte v4, p2, v2

    if-ne v3, v4, :cond_2

    move v3, v0

    goto :goto_1

    :cond_2
    move v3, v1

    :goto_1
    if-nez v3, :cond_3

    :goto_2
    return v3

    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method protected h(Ld/e;Ljava/lang/String;Z)Z
    .locals 5

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v1, p3

    const/4 v2, 0x0

    if-ge v0, v1, :cond_0

    return v2

    :cond_0
    const/4 v0, 0x1

    if-eqz p3, :cond_2

    invoke-virtual {p1, v2}, Ld/e;->e(I)B

    move-result v1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v1, v3, :cond_1

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1

    :cond_2
    :goto_0
    move v1, v0

    :goto_1
    if-eqz v1, :cond_6

    move v3, p3

    :goto_2
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v4

    if-lt v3, v4, :cond_3

    goto :goto_4

    :cond_3
    invoke-virtual {p1, v3}, Ld/e;->e(I)B

    move-result v1

    sub-int v4, v3, p3

    invoke-virtual {p2, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v1, v4, :cond_4

    move v1, v0

    goto :goto_3

    :cond_4
    move v1, v2

    :goto_3
    if-nez v1, :cond_5

    goto :goto_4

    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_6
    :goto_4
    return v1
.end method

.method public i(Ld/e;)Ld/e;
    .locals 0

    return-object p1
.end method

.method public j()V
    .locals 0

    return-void
.end method

.method public k(Ld/e;)Ld/e;
    .locals 0

    return-object p1
.end method

.method public final l()Ld/s/a;
    .locals 1

    iget-object v0, p0, Ld/n/i/a;->c:Ld/s/a;

    return-object v0
.end method

.method public abstract m(Ld/e;)I
.end method

.method protected final n(Ljava/nio/ByteBuffer;IZ)I
    .locals 1

    if-eqz p3, :cond_0

    iget-object p3, p0, Ld/n/i/a;->d:Ld/n/e;

    goto :goto_0

    :cond_0
    iget-object p3, p0, Ld/n/i/a;->e:Ld/n/e;

    :goto_0
    new-instance v0, Ld/n/i/a$a;

    invoke-direct {v0, p0}, Ld/n/i/a$a;-><init>(Ld/n/i/a;)V

    invoke-virtual {p3, p1, p2, v0}, Ld/n/e;->c(Ljava/nio/ByteBuffer;ILd/n/e$a;)I

    move-result p1

    return p1
.end method

.method protected final o(Ld/e;IZ)I
    .locals 0

    invoke-virtual {p1}, Ld/e;->a()Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p0, p1, p2, p3}, Ld/n/i/a;->n(Ljava/nio/ByteBuffer;IZ)I

    move-result p1

    return p1
.end method

.method public final p()Ld/e;
    .locals 4

    new-instance v0, Ld/e;

    iget-object v1, p0, Ld/n/i/a;->b:Ld/s/a;

    const/4 v2, 0x0

    if-nez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Ld/s/a;->e()I

    move-result v1

    :goto_0
    invoke-direct {v0, v1}, Ld/e;-><init>(I)V

    iget-object v1, p0, Ld/n/i/a;->b:Ld/s/a;

    invoke-virtual {v1}, Ld/s/a;->d()[B

    move-result-object v1

    iget-object v3, p0, Ld/n/i/a;->b:Ld/s/a;

    invoke-virtual {v3}, Ld/s/a;->e()I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Ld/e;->v([BII)Ld/e;

    const/16 v1, 0x40

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    return-object v0
.end method

.method public abstract q(Ld/e;)I
.end method

.method protected r(Ljava/lang/String;[B)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method protected final s(Ljava/lang/String;)V
    .locals 3

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return-void
.end method

.method protected final t()I
    .locals 9

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x7

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/4 v4, 0x6

    const v5, 0x9523e34

    const/4 v6, 0x1

    if-lt v3, v1, :cond_6

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/e;

    invoke-virtual {v1}, Ld/e;->B()I

    move-result v1

    if-lez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "NULL I: ZAP handler sent malformed reply message in address delimiter frame "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    :goto_1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {p0, v0}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v5

    :cond_0
    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/e;

    invoke-virtual {v1}, Ld/e;->B()I

    move-result v1

    const/4 v3, 0x3

    if-ne v1, v3, :cond_5

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/e;

    const-string v7, "1.0"

    invoke-virtual {p0, v1, v7, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_4

    :cond_1
    const/4 v1, 0x2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ld/e;

    invoke-virtual {v7}, Ld/e;->B()I

    move-result v7

    if-ne v7, v6, :cond_4

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ld/e;

    const-string v8, "1"

    invoke-virtual {p0, v7, v8, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v7

    if-nez v7, :cond_2

    goto :goto_3

    :cond_2
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/e;

    invoke-virtual {v1}, Ld/e;->B()I

    move-result v1

    if-eq v1, v3, :cond_3

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "NULL I: ZAP handler rejected client authentication "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    goto :goto_1

    :cond_3
    new-instance v1, Ljava/lang/String;

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ld/e;

    invoke-virtual {v3}, Ld/e;->c()[B

    move-result-object v3

    sget-object v5, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-direct {v1, v3, v5}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    iput-object v1, p0, Ld/n/i/a;->h:Ljava/lang/String;

    const/4 v1, 0x5

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/e;

    invoke-virtual {v1}, Ld/e;->c()[B

    move-result-object v1

    invoke-direct {p0, v1}, Ld/n/i/a;->w([B)V

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/e;

    invoke-virtual {p0, v0, v2, v6}, Ld/n/i/a;->o(Ld/e;IZ)I

    move-result v0

    return v0

    :cond_4
    :goto_3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "NULL I: ZAP handler sent bad request ID "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_2

    :cond_5
    :goto_4
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "NULL I: ZAP handler sent bad version number "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    goto/16 :goto_1

    :cond_6
    iget-object v7, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v7}, Ld/n/f;->Q0()Ld/e;

    move-result-object v7

    if-nez v7, :cond_7

    iget-object v0, p0, Ld/n/i/a;->f:Ld/n/f;

    iget-object v0, v0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v0}, Ld/s/c;->a()I

    move-result v0

    return v0

    :cond_7
    invoke-virtual {v7}, Ld/e;->d()I

    move-result v8

    and-int/2addr v8, v6

    if-ge v3, v4, :cond_8

    move v6, v2

    :cond_8
    if-ne v8, v6, :cond_9

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "NULL I: ZAP handler sent incomplete reply message "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_2

    :cond_9
    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0
.end method

.method protected final u(Ld/n/i/b;Z)V
    .locals 6

    new-instance v0, Ld/e;

    invoke-direct {v0}, Ld/e;-><init>()V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    iget-object v2, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v2, v0}, Ld/n/f;->U0(Ld/e;)Z

    new-instance v0, Ld/e;

    const/4 v2, 0x3

    invoke-direct {v0, v2}, Ld/e;-><init>(I)V

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v3, "1.0"

    invoke-virtual {v3, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    invoke-virtual {v0, v3}, Ld/e;->u([B)Ld/e;

    iget-object v3, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v3, v0}, Ld/n/f;->U0(Ld/e;)Z

    new-instance v0, Ld/e;

    invoke-direct {v0, v1}, Ld/e;-><init>(I)V

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    const-string v3, "1"

    invoke-virtual {v3, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    invoke-virtual {v0, v3}, Ld/e;->u([B)Ld/e;

    iget-object v3, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v3, v0}, Ld/n/f;->U0(Ld/e;)Z

    new-instance v0, Ld/e;

    iget-object v3, p0, Ld/n/i/a;->a:Ld/f;

    iget-object v3, v3, Ld/f;->D:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-direct {v0, v3}, Ld/e;-><init>(I)V

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    iget-object v3, p0, Ld/n/i/a;->a:Ld/f;

    iget-object v3, v3, Ld/f;->D:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    invoke-virtual {v0, v3}, Ld/e;->u([B)Ld/e;

    iget-object v3, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v3, v0}, Ld/n/f;->U0(Ld/e;)Z

    iget-object v0, p0, Ld/n/i/a;->g:Ld/n/j/a;

    invoke-virtual {v0}, Ld/n/j/a;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    new-instance v3, Ld/e;

    array-length v4, v0

    invoke-direct {v3, v4}, Ld/e;-><init>(I)V

    invoke-virtual {v3, v1}, Ld/e;->y(I)V

    invoke-virtual {v3, v0}, Ld/e;->u([B)Ld/e;

    iget-object v0, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v0, v3}, Ld/n/f;->U0(Ld/e;)Z

    new-instance v0, Ld/e;

    iget-object v3, p0, Ld/n/i/a;->a:Ld/f;

    iget-byte v3, v3, Ld/f;->d:B

    invoke-direct {v0, v3}, Ld/e;-><init>(I)V

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    iget-object v3, p0, Ld/n/i/a;->a:Ld/f;

    iget-object v4, v3, Ld/f;->e:[B

    const/4 v5, 0x0

    iget-byte v3, v3, Ld/f;->d:B

    invoke-virtual {v0, v4, v5, v3}, Ld/e;->v([BII)Ld/e;

    iget-object v3, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v3, v0}, Ld/n/f;->U0(Ld/e;)Z

    new-instance v0, Ld/e;

    invoke-virtual {p1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-direct {v0, v3}, Ld/e;-><init>(I)V

    invoke-virtual {p1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    invoke-virtual {v0, p1}, Ld/e;->u([B)Ld/e;

    if-eqz p2, :cond_0

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    :cond_0
    iget-object p1, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {p1, v0}, Ld/n/f;->U0(Ld/e;)Z

    return-void
.end method

.method protected final x(I)Ljava/lang/String;
    .locals 0

    iget-object p1, p0, Ld/n/i/a;->a:Ld/f;

    iget p1, p1, Ld/f;->j:I

    invoke-static {p1}, Ld/r/d;->g(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public abstract y()Ld/n/i/a$b;
.end method

.method public abstract z()I
.end method
