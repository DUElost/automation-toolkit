.class public Ld/r/g/f;
.super Ld/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/g/f$a;,
        Ld/r/g/f$b;
    }
.end annotation


# static fields
.field private static final H:Ld/r/g/b$a;

.field private static final I:Ld/r/g/b$a;


# instance fields
.field private final A:Ld/r/g/b;

.field private final B:Ld/r/g/a;

.field private C:Z

.field private D:Z

.field private E:Z

.field private final F:Ljava/util/Deque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Deque<",
            "Ld/s/a;",
            ">;"
        }
    .end annotation
.end field

.field private final G:Ljava/util/Deque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Deque<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ld/r/g/f$a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ld/r/g/f$a;-><init>(Ld/r/g/f$a;)V

    sput-object v0, Ld/r/g/f;->H:Ld/r/g/b$a;

    new-instance v0, Ld/r/g/f$b;

    invoke-direct {v0, v1}, Ld/r/g/f$b;-><init>(Ld/r/g/f$b;)V

    sput-object v0, Ld/r/g/f;->I:Ld/r/g/b$a;

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/16 p2, 0x9

    iput p2, p1, Ld/f;->j:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/r/g/f;->C:Z

    iput-boolean p1, p0, Ld/r/g/f;->D:Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/r/g/f;->E:Z

    new-instance p1, Ld/r/g/b;

    invoke-direct {p1}, Ld/r/g/b;-><init>()V

    iput-object p1, p0, Ld/r/g/f;->A:Ld/r/g/b;

    new-instance p1, Ld/r/g/a;

    invoke-direct {p1}, Ld/r/g/a;-><init>()V

    iput-object p1, p0, Ld/r/g/f;->B:Ld/r/g/a;

    new-instance p1, Ljava/util/ArrayDeque;

    invoke-direct {p1}, Ljava/util/ArrayDeque;-><init>()V

    iput-object p1, p0, Ld/r/g/f;->F:Ljava/util/Deque;

    new-instance p1, Ljava/util/ArrayDeque;

    invoke-direct {p1}, Ljava/util/ArrayDeque;-><init>()V

    iput-object p1, p0, Ld/r/g/f;->G:Ljava/util/Deque;

    return-void
.end method

.method static synthetic r1(Ld/r/g/f;[BI)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/r/g/f;->u1([BI)V

    return-void
.end method

.method static synthetic s1(Ld/r/g/f;Ld/p/b;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/r/g/f;->t1(Ld/p/b;)V

    return-void
.end method

.method private t1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->e(Ld/p/b;)V

    return-void
.end method

.method private u1([BI)V
    .locals 3

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget v0, v0, Ld/f;->j:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    add-int/lit8 v0, p2, 0x1

    new-array v0, v0, [B

    const/4 v2, 0x0

    aput-byte v2, v0, v2

    invoke-static {p1, v2, v0, v1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object p1, p0, Ld/r/g/f;->F:Ljava/util/Deque;

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object p2

    invoke-interface {p1, p2}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Ld/r/g/f;->G:Ljava/util/Deque;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {p1, p2}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 1

    iget-object v0, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->b(Ld/p/b;)V

    if-eqz p2, :cond_0

    iget-object p2, p0, Ld/r/g/f;->A:Ld/r/g/b;

    invoke-virtual {p2, p1}, Ld/r/g/b;->c(Ld/p/b;)Z

    :cond_0
    invoke-virtual {p0, p1}, Ld/r/g/f;->n1(Ld/p/b;)V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/g/f;->A:Ld/r/g/b;

    sget-object v1, Ld/r/g/f;->I:Ld/r/g/b$a;

    invoke-virtual {v0, p1, v1, p0}, Ld/r/g/b;->h(Ld/p/b;Ld/r/g/b$a;Ld/r/g/f;)Z

    iget-object v0, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->h(Ld/p/b;)V

    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 5

    :cond_0
    :goto_0
    invoke-virtual {p1}, Ld/p/b;->I0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Ld/e;->B()I

    move-result v1

    if-lez v1, :cond_5

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ld/e;->e(I)B

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v0, v1}, Ld/e;->e(I)B

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_5

    :cond_2
    invoke-virtual {v0, v1}, Ld/e;->e(I)B

    move-result v2

    if-nez v2, :cond_3

    iget-object v2, p0, Ld/r/g/f;->A:Ld/r/g/b;

    invoke-virtual {v2, v0, p1}, Ld/r/g/b;->g(Ld/e;Ld/p/b;)Z

    move-result v2

    goto :goto_1

    :cond_3
    iget-object v2, p0, Ld/r/g/f;->A:Ld/r/g/b;

    invoke-virtual {v2, v0, p1}, Ld/r/g/b;->a(Ld/e;Ld/p/b;)Z

    move-result v2

    :goto_1
    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget v3, v3, Ld/f;->j:I

    const/16 v4, 0x9

    if-ne v3, v4, :cond_0

    if-nez v2, :cond_4

    invoke-virtual {v0, v1}, Ld/e;->e(I)B

    move-result v2

    if-lez v2, :cond_0

    iget-boolean v2, p0, Ld/r/g/f;->C:Z

    if-eqz v2, :cond_0

    :cond_4
    iget-object v2, p0, Ld/r/g/f;->F:Ljava/util/Deque;

    invoke-static {v0}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Ld/r/g/f;->G:Ljava/util/Deque;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_5
    iget-object v1, p0, Ld/r/g/f;->F:Ljava/util/Deque;

    invoke-static {v0}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Ld/r/g/f;->G:Ljava/util/Deque;

    invoke-virtual {v0}, Ld/e;->d()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method protected o1(Ld/e;)Z
    .locals 5

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    iget-boolean v1, p0, Ld/r/g/f;->D:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Ld/r/g/f;->A:Ld/r/g/b;

    invoke-virtual {p1}, Ld/e;->a()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v3

    sget-object v4, Ld/r/g/f;->H:Ld/r/g/b$a;

    invoke-virtual {v1, v2, v3, v4, p0}, Ld/r/g/b;->e(Ljava/nio/ByteBuffer;ILd/r/g/b$a;Ld/r/g/f;)V

    :cond_0
    iget-boolean v1, p0, Ld/r/g/f;->E:Z

    if-nez v1, :cond_2

    iget-object v1, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v1}, Ld/r/g/a;->c()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x23

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    goto :goto_1

    :cond_2
    :goto_0
    iget-object v1, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v1, p1}, Ld/r/g/a;->g(Ld/e;)Z

    move-result p1

    if-eqz p1, :cond_4

    if-nez v0, :cond_3

    iget-object p1, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {p1}, Ld/r/g/a;->i()V

    :cond_3
    iput-boolean v0, p0, Ld/r/g/f;->D:Z

    const/4 p1, 0x1

    return p1

    :cond_4
    :goto_1
    const/4 p1, 0x0

    return p1
.end method

.method public p1(ILjava/lang/Object;)Z
    .locals 2

    const/4 v0, 0x1

    const/16 v1, 0x28

    if-ne p1, v1, :cond_0

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/g/f;->C:Z

    goto :goto_0

    :cond_0
    const/16 v1, 0x45

    if-ne p1, v1, :cond_1

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    xor-int/2addr p1, v0

    iput-boolean p1, p0, Ld/r/g/f;->E:Z

    :goto_0
    return v0

    :cond_1
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method protected q1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/f;->B:Ld/r/g/a;

    invoke-virtual {v0, p1}, Ld/r/g/a;->a(Ld/p/b;)V

    return-void
.end method
