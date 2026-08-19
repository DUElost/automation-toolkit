.class public Lb/e/a/h/l/a;
.super Lb/e/a/h/a;
.source ""


# static fields
.field private static i:Lb/e/a/j/f;


# instance fields
.field e:[Lb/e/a/h/g;

.field f:Lb/c/a/i/u;

.field g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation
.end field

.field h:[J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/h/l/a;

    invoke-static {v0}, Lb/e/a/j/f;->a(Ljava/lang/Class;)Lb/e/a/j/f;

    move-result-object v0

    sput-object v0, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    return-void
.end method

.method public varargs constructor <init>([Lb/e/a/h/g;)V
    .locals 7

    invoke-static {p1}, Lb/e/a/h/l/a;->a([Lb/e/a/h/g;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lb/e/a/h/a;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v0, p1

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-lt v2, v0, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/e/a/h/l/a;->g:Ljava/util/List;

    array-length v3, p1

    move v0, v1

    :goto_1
    if-lt v0, v3, :cond_2

    array-length v2, p1

    move v0, v1

    move v3, v0

    :goto_2
    if-lt v0, v2, :cond_1

    new-array v0, v3, [J

    iput-object v0, p0, Lb/e/a/h/l/a;->h:[J

    array-length v4, p1

    move v0, v1

    move v2, v0

    :goto_3
    if-lt v0, v4, :cond_0

    return-void

    :cond_0
    aget-object v3, p1, v0

    invoke-interface {v3}, Lb/e/a/h/g;->w()[J

    move-result-object v3

    iget-object v5, p0, Lb/e/a/h/l/a;->h:[J

    array-length v6, v3

    invoke-static {v3, v1, v5, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v3, v3

    add-int/2addr v2, v3

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    :cond_1
    aget-object v4, p1, v0

    invoke-interface {v4}, Lb/e/a/h/g;->w()[J

    move-result-object v4

    array-length v4, v4

    add-int/2addr v3, v4

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_2
    aget-object v2, p1, v0

    iget-object v4, p0, Lb/e/a/h/l/a;->g:Ljava/util/List;

    invoke-interface {v2}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v2

    invoke-interface {v4, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    aget-object v3, p1, v2

    iget-object v4, p0, Lb/e/a/h/l/a;->f:Lb/c/a/i/u;

    if-nez v4, :cond_4

    new-instance v4, Lb/c/a/i/u;

    invoke-direct {v4}, Lb/c/a/i/u;-><init>()V

    iput-object v4, p0, Lb/e/a/h/l/a;->f:Lb/c/a/i/u;

    invoke-interface {v3}, Lb/e/a/h/g;->x()Lb/c/a/i/u;

    move-result-object v3

    const-class v5, Lb/c/a/i/k0/c;

    invoke-virtual {v3, v5}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/b;

    invoke-virtual {v4, v3}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_4

    :cond_4
    invoke-interface {v3}, Lb/e/a/h/g;->x()Lb/c/a/i/u;

    move-result-object v3

    invoke-direct {p0, v4, v3}, Lb/e/a/h/l/a;->m(Lb/c/a/i/u;Lb/c/a/i/u;)Lb/c/a/i/u;

    move-result-object v3

    iput-object v3, p0, Lb/e/a/h/l/a;->f:Lb/c/a/i/u;

    :goto_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public static varargs a([Lb/e/a/h/g;)Ljava/lang/String;
    .locals 6

    array-length v0, p0

    const/4 v1, 0x0

    const-string v2, ""

    move v3, v1

    :goto_0
    if-lt v3, v0, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result p0

    add-int/lit8 p0, p0, -0x3

    invoke-virtual {v2, v1, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    aget-object v4, p0, v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v5, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v4}, Lb/e/a/h/g;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " + "

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method private b(Lb/c/a/i/k0/b;Lb/c/a/i/k0/b;)Lb/c/a/i/k0/b;
    .locals 7

    new-instance v0, Lb/c/a/i/k0/b;

    invoke-virtual {p2}, Lb/e/a/b;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lb/c/a/i/k0/b;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->G()J

    move-result-wide v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->G()J

    move-result-wide v3

    cmp-long v1, v1, v3

    const/4 v2, 0x0

    if-nez v1, :cond_9

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->G()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/b;->R(J)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->H()J

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->H()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_8

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->H()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/b;->S(J)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->I()J

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->I()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_7

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->I()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/b;->T(J)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->J()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->J()I

    move-result v3

    if-ne v1, v3, :cond_6

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->J()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->U(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->L()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->L()I

    move-result v3

    if-ne v1, v3, :cond_5

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->L()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->W(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->K()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->K()I

    move-result v3

    if-ne v1, v3, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->K()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->V(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->M()J

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->M()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->M()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/b;->X(J)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->N()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->N()I

    move-result v3

    if-ne v1, v3, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->N()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->Y(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->O()J

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->O()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->O()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/b;->Z(J)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->P()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->P()I

    move-result v3

    if-ne v1, v3, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->P()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->a0(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->Q()[B

    move-result-object v1

    invoke-virtual {p2}, Lb/c/a/i/k0/b;->Q()[B

    move-result-object v3

    invoke-static {v1, v3}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/b;->Q()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/b;->b0([B)V

    invoke-virtual {p1}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {p2}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v1, v3, :cond_3

    invoke-virtual {p1}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-virtual {p2}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_2

    :cond_1
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/b;

    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    new-instance v5, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v5}, Ljava/io/ByteArrayOutputStream;-><init>()V

    :try_start_0
    invoke-static {v4}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v6

    invoke-interface {v1, v6}, Lb/c/a/i/b;->t(Ljava/nio/channels/WritableByteChannel;)V

    invoke-static {v5}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v6

    invoke-interface {v3, v6}, Lb/c/a/i/b;->t(Ljava/nio/channels/WritableByteChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    invoke-static {v4, v5}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v4

    if-eqz v4, :cond_2

    :goto_1
    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_0

    :cond_2
    invoke-interface {v1}, Lb/c/a/i/b;->getType()Ljava/lang/String;

    move-result-object v4

    const-string v5, "esds"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Lb/c/a/i/b;->getType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    move-object v4, v1

    check-cast v4, Lb/e/a/i/d/b;

    check-cast v3, Lb/e/a/i/d/b;

    invoke-virtual {v4}, Lb/e/a/i/d/b;->v()Lb/e/a/i/d/c/h;

    move-result-object v5

    invoke-virtual {v3}, Lb/e/a/i/d/b;->v()Lb/e/a/i/d/c/h;

    move-result-object v3

    invoke-direct {p0, v5, v3}, Lb/e/a/h/l/a;->e(Lb/e/a/i/d/c/b;Lb/e/a/i/d/c/b;)Lb/e/a/i/d/c/h;

    move-result-object v3

    invoke-virtual {v4, v3}, Lb/e/a/i/d/a;->u(Lb/e/a/i/d/c/b;)V

    goto :goto_1

    :catch_0
    move-exception p1

    sget-object p2, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    invoke-virtual {p1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/j/f;->d(Ljava/lang/String;)V

    return-object v2

    :cond_3
    :goto_2
    return-object v0

    :cond_4
    return-object v2

    :cond_5
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "ChannelCount differ"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    :cond_6
    return-object v2

    :cond_7
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "BytesPerSample differ"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    :cond_8
    return-object v2

    :cond_9
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "BytesPerFrame differ"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2
.end method

.method private e(Lb/e/a/i/d/c/b;Lb/e/a/i/d/c/b;)Lb/e/a/i/d/c/h;
    .locals 7

    instance-of v0, p1, Lb/e/a/i/d/c/h;

    const/4 v1, 0x0

    if-eqz v0, :cond_16

    instance-of v0, p2, Lb/e/a/i/d/c/h;

    if-eqz v0, :cond_16

    check-cast p1, Lb/e/a/i/d/c/h;

    check-cast p2, Lb/e/a/i/d/c/h;

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->o()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->o()I

    move-result v2

    if-eq v0, v2, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->p()I

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->p()I

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->h()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->h()I

    move-result v2

    if-eq v0, v2, :cond_1

    return-object v1

    :cond_1
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->i()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->i()I

    move-result v2

    if-eq v0, v2, :cond_2

    return-object v1

    :cond_2
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->r()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->r()I

    move-result v2

    if-eq v0, v2, :cond_3

    return-object v1

    :cond_3
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->s()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->s()I

    move-result v2

    if-eq v0, v2, :cond_4

    return-object v1

    :cond_4
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->k()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->k()I

    move-result v2

    if-eq v0, v2, :cond_5

    return-object v1

    :cond_5
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->m()I

    move-result v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->m()I

    move-result v2

    if-eq v0, v2, :cond_6

    return-object v1

    :cond_6
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->n()I

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->n()I

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->q()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_7

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->q()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->q()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_7
    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->q()Ljava/lang/String;

    :goto_0
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v0

    if-eqz v0, :cond_8

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_11

    goto :goto_1

    :cond_8
    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v0

    if-eqz v0, :cond_11

    :goto_1
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->g()Lb/e/a/i/d/c/e;

    move-result-object v2

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->g()Lb/e/a/i/d/c/a;

    move-result-object v3

    if-eqz v3, :cond_9

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->g()Lb/e/a/i/d/c/a;

    move-result-object v3

    if-eqz v3, :cond_9

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->g()Lb/e/a/i/d/c/a;

    move-result-object v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->g()Lb/e/a/i/d/c/a;

    move-result-object v4

    invoke-virtual {v3, v4}, Lb/e/a/i/d/c/a;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    return-object v1

    :cond_9
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->h()J

    move-result-wide v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->h()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-eqz v3, :cond_a

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->h()J

    move-result-wide v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->h()J

    move-result-wide v5

    add-long/2addr v3, v5

    const-wide/16 v5, 0x2

    div-long/2addr v3, v5

    invoke-virtual {v0, v3, v4}, Lb/e/a/i/d/c/e;->q(J)V

    :cond_a
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->i()I

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->i()I

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->j()Lb/e/a/i/d/c/f;

    move-result-object v3

    if-eqz v3, :cond_b

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->j()Lb/e/a/i/d/c/f;

    move-result-object v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->j()Lb/e/a/i/d/c/f;

    move-result-object v4

    invoke-virtual {v3, v4}, Lb/e/a/i/d/c/f;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    goto :goto_2

    :cond_b
    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->j()Lb/e/a/i/d/c/f;

    move-result-object v3

    if-eqz v3, :cond_c

    :goto_2
    return-object v1

    :cond_c
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->k()J

    move-result-wide v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->k()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-eqz v3, :cond_d

    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->k()J

    move-result-wide v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->k()J

    move-result-wide v5

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/e/a/i/d/c/e;->r(J)V

    :cond_d
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->m()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->m()Ljava/util/List;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    return-object v1

    :cond_e
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->l()I

    move-result v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->l()I

    move-result v4

    if-eq v3, v4, :cond_f

    return-object v1

    :cond_f
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->n()I

    move-result v3

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->n()I

    move-result v4

    if-eq v3, v4, :cond_10

    return-object v1

    :cond_10
    invoke-virtual {v0}, Lb/e/a/i/d/c/e;->o()I

    move-result v0

    invoke-virtual {v2}, Lb/e/a/i/d/c/e;->o()I

    move-result v2

    if-eq v0, v2, :cond_11

    return-object v1

    :cond_11
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->j()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_12

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->j()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->j()Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    goto :goto_3

    :cond_12
    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->j()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_13

    :goto_3
    return-object v1

    :cond_13
    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->l()Lb/e/a/i/d/c/n;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {p1}, Lb/e/a/i/d/c/h;->l()Lb/e/a/i/d/c/n;

    move-result-object v0

    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->l()Lb/e/a/i/d/c/n;

    move-result-object p2

    invoke-virtual {v0, p2}, Lb/e/a/i/d/c/n;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_15

    goto :goto_4

    :cond_14
    invoke-virtual {p2}, Lb/e/a/i/d/c/h;->l()Lb/e/a/i/d/c/n;

    move-result-object p2

    if-eqz p2, :cond_15

    :goto_4
    return-object v1

    :cond_15
    return-object p1

    :cond_16
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "I can only merge ESDescriptors"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v1
.end method

.method private h(Lb/c/a/i/k0/c;Lb/c/a/i/k0/c;)Lb/c/a/i/k0/c;
    .locals 2

    invoke-interface {p1}, Lb/c/a/i/b;->getType()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2}, Lb/c/a/i/b;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    instance-of v0, p1, Lb/c/a/i/k0/d;

    if-eqz v0, :cond_1

    instance-of v0, p2, Lb/c/a/i/k0/d;

    if-eqz v0, :cond_1

    check-cast p1, Lb/c/a/i/k0/d;

    check-cast p2, Lb/c/a/i/k0/d;

    invoke-direct {p0, p1, p2}, Lb/e/a/h/l/a;->q(Lb/c/a/i/k0/d;Lb/c/a/i/k0/d;)Lb/c/a/i/k0/d;

    move-result-object p1

    return-object p1

    :cond_1
    instance-of v0, p1, Lb/c/a/i/k0/b;

    if-eqz v0, :cond_2

    instance-of v0, p2, Lb/c/a/i/k0/b;

    if-eqz v0, :cond_2

    check-cast p1, Lb/c/a/i/k0/b;

    check-cast p2, Lb/c/a/i/k0/b;

    invoke-direct {p0, p1, p2}, Lb/e/a/h/l/a;->b(Lb/c/a/i/k0/b;Lb/c/a/i/k0/b;)Lb/c/a/i/k0/b;

    move-result-object p1

    return-object p1

    :cond_2
    return-object v1
.end method

.method private m(Lb/c/a/i/u;Lb/c/a/i/u;)Lb/c/a/i/u;
    .locals 5

    const-class v0, Lb/c/a/i/k0/c;

    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    :try_start_0
    invoke-static {v1}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v3

    invoke-virtual {p1, v3}, Lb/c/a/i/u;->t(Ljava/nio/channels/WritableByteChannel;)V

    invoke-static {v2}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v3

    invoke-virtual {p2, v3}, Lb/c/a/i/u;->t(Ljava/nio/channels/WritableByteChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    invoke-static {v2, v1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p1, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/k0/c;

    invoke-virtual {p2, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/k0/c;

    invoke-direct {p0, v1, v3}, Lb/e/a/h/l/a;->h(Lb/c/a/i/k0/c;Lb/c/a/i/k0/c;)Lb/c/a/i/k0/c;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {v1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p2

    invoke-virtual {p1, p2}, Lb/e/a/d;->E(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    new-instance v1, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Cannot merge "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, " and "

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_1
    :goto_0
    return-object p1

    :catch_0
    move-exception p1

    sget-object p2, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    invoke-virtual {p1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method private q(Lb/c/a/i/k0/d;Lb/c/a/i/k0/d;)Lb/c/a/i/k0/d;
    .locals 7

    new-instance v0, Lb/c/a/i/k0/d;

    invoke-direct {v0}, Lb/c/a/i/k0/d;-><init>()V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v1

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v3

    cmpl-double v1, v1, v3

    const/4 v2, 0x0

    if-nez v1, :cond_a

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/d;->R(D)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->G()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/d;->N(Ljava/lang/String;)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->H()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->H()I

    move-result v3

    if-ne v1, v3, :cond_9

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->H()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/d;->O(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->I()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->I()I

    move-result v3

    if-ne v1, v3, :cond_8

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->I()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/d;->P(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->J()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->J()I

    move-result v3

    if-ne v1, v3, :cond_7

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->J()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/d;->Q(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->M()I

    move-result v1

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->M()I

    move-result v3

    if-ne v1, v3, :cond_6

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->M()I

    move-result v1

    invoke-virtual {v0, v1}, Lb/c/a/i/k0/d;->T(I)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->L()D

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->L()D

    move-result-wide v5

    cmpl-double v1, v3, v5

    if-nez v1, :cond_5

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->L()D

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/d;->S(D)V

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v3

    invoke-virtual {p2}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v5

    cmpl-double v1, v3, v5

    if-nez v1, :cond_4

    invoke-virtual {p1}, Lb/c/a/i/k0/d;->K()D

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lb/c/a/i/k0/d;->R(D)V

    invoke-virtual {p1}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {p2}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v1, v3, :cond_3

    invoke-virtual {p1}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-virtual {p2}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_2

    :cond_1
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/b;

    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    new-instance v5, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v5}, Ljava/io/ByteArrayOutputStream;-><init>()V

    :try_start_0
    invoke-static {v4}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v6

    invoke-interface {v1, v6}, Lb/c/a/i/b;->t(Ljava/nio/channels/WritableByteChannel;)V

    invoke-static {v5}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v6

    invoke-interface {v3, v6}, Lb/c/a/i/b;->t(Ljava/nio/channels/WritableByteChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    invoke-static {v4, v5}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v4

    if-eqz v4, :cond_2

    :goto_1
    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_0

    :cond_2
    instance-of v4, v1, Lb/e/a/i/d/a;

    if-eqz v4, :cond_0

    instance-of v4, v3, Lb/e/a/i/d/a;

    if-eqz v4, :cond_0

    move-object v4, v1

    check-cast v4, Lb/e/a/i/d/a;

    invoke-virtual {v4}, Lb/e/a/i/d/a;->s()Lb/e/a/i/d/c/b;

    move-result-object v5

    check-cast v3, Lb/e/a/i/d/a;

    invoke-virtual {v3}, Lb/e/a/i/d/a;->s()Lb/e/a/i/d/c/b;

    move-result-object v3

    invoke-direct {p0, v5, v3}, Lb/e/a/h/l/a;->e(Lb/e/a/i/d/c/b;Lb/e/a/i/d/c/b;)Lb/e/a/i/d/c/h;

    move-result-object v3

    invoke-virtual {v4, v3}, Lb/e/a/i/d/a;->u(Lb/e/a/i/d/c/b;)V

    goto :goto_1

    :catch_0
    move-exception p1

    sget-object p2, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    invoke-virtual {p1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/j/f;->d(Ljava/lang/String;)V

    return-object v2

    :cond_3
    :goto_2
    return-object v0

    :cond_4
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "horizontal resolution differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_5
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "vert resolution differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_6
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "width differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_7
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "height differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_8
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "frame count differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_9
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "Depth differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2

    :cond_a
    sget-object p1, Lb/e/a/h/l/a;->i:Lb/e/a/j/f;

    const-string p2, "Horizontal Resolution differs"

    invoke-virtual {p1, p2}, Lb/e/a/j/f;->c(Ljava/lang/String;)V

    return-object v2
.end method


# virtual methods
.method public A()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/c/a/i/t$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iget-object v2, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v3, v2

    :goto_0
    if-lt v1, v3, :cond_0

    return-object v0

    :cond_0
    aget-object v4, v2, v1

    invoke-interface {v4}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public close()V
    .locals 4

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-lt v2, v1, :cond_0

    return-void

    :cond_0
    aget-object v3, v0, v2

    invoke-interface {v3}, Ljava/io/Closeable;->close()V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public d()Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/c/a/i/d$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->d()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->d()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iget-object v2, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v3, v2

    move v4, v1

    :goto_0
    if-lt v4, v3, :cond_4

    new-instance v5, Ljava/util/LinkedList;

    invoke-direct {v5}, Ljava/util/LinkedList;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    return-object v5

    :cond_0
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v7, v0

    check-cast v7, [I

    array-length v8, v7

    move v0, v1

    :goto_2
    if-lt v0, v8, :cond_1

    goto :goto_1

    :cond_1
    aget v2, v7, v0

    invoke-virtual {v5}, Ljava/util/LinkedList;->isEmpty()Z

    move-result v3

    const/4 v4, 0x1

    if-nez v3, :cond_3

    invoke-virtual {v5}, Ljava/util/LinkedList;->getLast()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/d$a;

    invoke-virtual {v3}, Lb/c/a/i/d$a;->b()I

    move-result v3

    if-eq v3, v2, :cond_2

    goto :goto_3

    :cond_2
    invoke-virtual {v5}, Ljava/util/LinkedList;->getLast()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/c/a/i/d$a;

    invoke-virtual {v2}, Lb/c/a/i/d$a;->a()I

    move-result v3

    add-int/2addr v3, v4

    invoke-virtual {v2, v3}, Lb/c/a/i/d$a;->c(I)V

    goto :goto_4

    :cond_3
    :goto_3
    new-instance v3, Lb/c/a/i/d$a;

    invoke-direct {v3, v4, v2}, Lb/c/a/i/d$a;-><init>(II)V

    invoke-virtual {v5, v3}, Ljava/util/LinkedList;->add(Ljava/lang/Object;)Z

    :goto_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_4
    aget-object v5, v2, v4

    invoke-interface {v5}, Lb/e/a/h/g;->d()Ljava/util/List;

    move-result-object v5

    invoke-static {v5}, Lb/c/a/i/d;->s(Ljava/util/List;)[I

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    const/4 v0, 0x0

    return-object v0
.end method

.method public f()[J
    .locals 15

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->f()[J

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->f()[J

    move-result-object v0

    array-length v0, v0

    if-lez v0, :cond_5

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v2, v0

    move v3, v1

    move v4, v3

    :goto_0
    if-lt v3, v2, :cond_3

    new-array v5, v4, [J

    const-wide/16 v2, 0x0

    iget-object v6, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    array-length v7, v6

    move v0, v1

    move v4, v0

    :goto_1
    if-lt v0, v7, :cond_0

    return-object v5

    :cond_0
    aget-object v8, v6, v0

    invoke-interface {v8}, Lb/e/a/h/g;->f()[J

    move-result-object v9

    if-eqz v9, :cond_2

    invoke-interface {v8}, Lb/e/a/h/g;->f()[J

    move-result-object v9

    array-length v10, v9

    move v11, v1

    :goto_2
    if-lt v11, v10, :cond_1

    goto :goto_3

    :cond_1
    aget-wide v12, v9, v11

    add-int/lit8 v14, v4, 0x1

    add-long/2addr v12, v2

    aput-wide v12, v5, v4

    add-int/lit8 v11, v11, 0x1

    move v4, v14

    goto :goto_2

    :cond_2
    :goto_3
    invoke-interface {v8}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v8

    int-to-long v8, v8

    add-long/2addr v2, v8

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_3
    aget-object v5, v0, v3

    invoke-interface {v5}, Lb/e/a/h/g;->f()[J

    move-result-object v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Lb/e/a/h/g;->f()[J

    move-result-object v5

    array-length v5, v5

    goto :goto_4

    :cond_4
    move v5, v1

    :goto_4
    add-int/2addr v4, v5

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_5
    const/4 v0, 0x0

    return-object v0
.end method

.method public g()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/l/a;->g:Ljava/util/List;

    return-object v0
.end method

.method public i()Lb/c/a/i/b0;
    .locals 2

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->i()Lb/c/a/i/b0;

    move-result-object v0

    return-object v0
.end method

.method public r()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public declared-synchronized w()[J
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lb/e/a/h/l/a;->h:[J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public x()Lb/c/a/i/u;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/l/a;->f:Lb/c/a/i/u;

    return-object v0
.end method

.method public z()Lb/e/a/h/h;
    .locals 2

    iget-object v0, p0, Lb/e/a/h/l/a;->e:[Lb/e/a/h/g;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v0

    return-object v0
.end method
