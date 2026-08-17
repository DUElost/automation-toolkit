.class public Ld/r/e;
.super Ld/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/e$a;
    }
.end annotation


# instance fields
.field private final A:Ld/r/a;

.field private B:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ld/s/a;",
            "Ld/r/e$a;",
            ">;"
        }
    .end annotation
.end field

.field private C:Ld/p/b;

.field private D:Z

.field private E:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    iput-object p1, p0, Ld/r/e;->B:Ljava/util/Map;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/r/e;->C:Ld/p/b;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/r/e;->D:Z

    invoke-static {}, Ld/s/e;->c()I

    move-result p1

    iput p1, p0, Ld/r/e;->E:I

    iget-object p1, p0, Ld/g;->e:Ld/f;

    const/16 p2, 0xb

    iput p2, p1, Ld/f;->j:I

    const/4 p2, 0x1

    iput-boolean p2, p1, Ld/f;->u:Z

    new-instance p1, Ld/r/a;

    invoke-direct {p1}, Ld/r/a;-><init>()V

    iput-object p1, p0, Ld/r/e;->A:Ld/r/a;

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    return-void
.end method

.method private r1(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/j;->y:Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/j;->y:Ljava/lang/String;

    sget-object v1, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    const/4 v1, 0x0

    iput-object v1, p0, Ld/j;->y:Ljava/lang/String;

    iget-object v1, p0, Ld/r/e;->B:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/r/e$a;

    goto :goto_0

    :cond_0
    const/4 v0, 0x5

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v1, p0, Ld/r/e;->E:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Ld/r/e;->E:I

    invoke-static {v0, v1}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    :goto_0
    invoke-virtual {p1, v0}, Ld/p/b;->M0(Ld/s/a;)V

    new-instance v1, Ld/r/e$a;

    const/4 v2, 0x1

    invoke-direct {v1, p0, p1, v2}, Ld/r/e$a;-><init>(Ld/r/e;Ld/p/b;Z)V

    iget-object p1, p0, Ld/r/e;->B:Ljava/util/Map;

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method protected k1(Ld/p/b;Z)V
    .locals 0

    invoke-direct {p0, p1}, Ld/r/e;->r1(Ld/p/b;)V

    iget-object p2, p0, Ld/r/e;->A:Ld/r/a;

    invoke-virtual {p2, p1}, Ld/r/a;->b(Ld/p/b;)V

    return-void
.end method

.method protected m1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/e;->B:Ljava/util/Map;

    invoke-virtual {p1}, Ld/p/b;->D0()Ld/s/a;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/r/e$a;

    iget-object v0, p0, Ld/r/e;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->d(Ld/p/b;)V

    iget-object v0, p0, Ld/r/e;->C:Ld/p/b;

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Ld/r/e;->C:Ld/p/b;

    :cond_0
    return-void
.end method

.method protected n1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/e;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->a(Ld/p/b;)V

    return-void
.end method

.method protected o1(Ld/e;)Z
    .locals 4

    iget-boolean v0, p0, Ld/r/e;->D:Z

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-nez v0, :cond_2

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    if-eqz v0, :cond_1

    iput-boolean v3, p0, Ld/r/e;->D:Z

    invoke-static {p1}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object p1

    iget-object v0, p0, Ld/r/e;->B:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/r/e$a;

    if-eqz p1, :cond_0

    invoke-static {p1}, Ld/r/e$a;->a(Ld/r/e$a;)Ld/p/b;

    move-result-object v0

    iput-object v0, p0, Ld/r/e;->C:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->z0()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1, v2}, Ld/r/e$a;->b(Ld/r/e$a;Z)V

    iput-object v1, p0, Ld/r/e;->C:Ld/p/b;

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x23

    :goto_0
    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v2

    :cond_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x41

    goto :goto_0

    :cond_1
    iput-boolean v3, p0, Ld/r/e;->D:Z

    return v3

    :cond_2
    invoke-virtual {p1, v3}, Ld/e;->w(I)V

    iput-boolean v2, p0, Ld/r/e;->D:Z

    iget-object v0, p0, Ld/r/e;->C:Ld/p/b;

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    if-nez v0, :cond_3

    iget-object p1, p0, Ld/r/e;->C:Ld/p/b;

    invoke-virtual {p1, v2}, Ld/p/b;->P0(Z)V

    iput-object v1, p0, Ld/r/e;->C:Ld/p/b;

    return v3

    :cond_3
    iget-object v0, p0, Ld/r/e;->C:Ld/p/b;

    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Ld/r/e;->C:Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_4
    iput-object v1, p0, Ld/r/e;->C:Ld/p/b;

    :cond_5
    return v3
.end method

.method protected p1(ILjava/lang/Object;)Z
    .locals 1

    const/16 v0, 0x3d

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1

    :cond_0
    check-cast p2, Ljava/lang/String;

    iput-object p2, p0, Ld/j;->y:Ljava/lang/String;

    const/4 p1, 0x1

    return p1
.end method

.method protected q1(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/r/e;->B:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    const/4 p1, 0x0

    goto :goto_0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/r/e$a;

    invoke-static {v1}, Ld/r/e$a;->a(Ld/r/e$a;)Ld/p/b;

    move-result-object v2

    if-ne v2, p1, :cond_0

    move-object p1, v1

    :goto_0
    const/4 v0, 0x1

    invoke-static {p1, v0}, Ld/r/e$a;->b(Ld/r/e$a;Z)V

    return-void
.end method
