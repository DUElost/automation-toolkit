.class public Ld/r/h/d;
.super Ld/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/h/d$a;
    }
.end annotation


# instance fields
.field private final A:Ld/r/a;

.field private final B:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private final C:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ld/s/a;",
            "Ld/r/h/d$a;",
            ">;"
        }
    .end annotation
.end field

.field private D:Ld/p/b;

.field private E:Z

.field private F:I

.field private G:Z

.field private H:Z

.field private I:Z

.field private J:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/j;-><init>(Ld/c;II)V

    const/4 p1, 0x0

    iput-object p1, p0, Ld/r/h/d;->D:Ld/p/b;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/r/h/d;->E:Z

    invoke-static {}, Ld/s/e;->c()I

    move-result p2

    iput p2, p0, Ld/r/h/d;->F:I

    iput-boolean p1, p0, Ld/r/h/d;->G:Z

    iput-boolean p1, p0, Ld/r/h/d;->H:Z

    iput-boolean p1, p0, Ld/r/h/d;->J:Z

    iget-object p2, p0, Ld/g;->e:Ld/f;

    const/4 p3, 0x6

    iput p3, p2, Ld/f;->j:I

    const/4 p3, 0x1

    iput-boolean p3, p2, Ld/f;->t:Z

    iput-boolean p1, p2, Ld/f;->u:Z

    new-instance p1, Ld/r/a;

    invoke-direct {p1}, Ld/r/a;-><init>()V

    iput-object p1, p0, Ld/r/h/d;->A:Ld/r/a;

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Ld/r/h/d;->B:Ljava/util/Set;

    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    iput-object p1, p0, Ld/r/h/d;->C:Ljava/util/Map;

    return-void
.end method

.method private r1(Ld/p/b;)Z
    .locals 5

    iget-object v0, p0, Ld/j;->y:Ljava/lang/String;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/j;->y:Ljava/lang/String;

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    const/4 v2, 0x0

    iput-object v2, p0, Ld/j;->y:Ljava/lang/String;

    iget-object v2, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ld/r/h/d$a;

    goto/16 :goto_0

    :cond_0
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->u:Z

    const/4 v2, 0x5

    const/4 v3, 0x0

    if-eqz v0, :cond_1

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v2, p0, Ld/r/h/d;->F:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ld/r/h/d;->F:I

    invoke-static {v0, v2}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Ld/p/b;->I0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_2

    return v3

    :cond_2
    invoke-virtual {v0}, Ld/e;->B()I

    move-result v4

    if-nez v4, :cond_3

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v2, p0, Ld/r/h/d;->F:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Ld/r/h/d;->F:I

    invoke-static {v0, v2}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    invoke-static {v0}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v0

    goto :goto_0

    :cond_3
    invoke-static {v0}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object v0

    iget-object v4, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v4, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    iget-boolean v4, p0, Ld/r/h/d;->J:Z

    if-nez v4, :cond_4

    return v3

    :cond_4
    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v3, p0, Ld/r/h/d;->F:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Ld/r/h/d;->F:I

    invoke-static {v2, v3}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-static {v2}, Ld/s/a;->b([B)Ld/s/a;

    move-result-object v2

    iget-object v3, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v3, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ld/r/h/d$a;

    invoke-static {v3}, Ld/r/h/d$a;->a(Ld/r/h/d$a;)Ld/p/b;

    move-result-object v4

    invoke-virtual {v4, v2}, Ld/p/b;->M0(Ld/s/a;)V

    iget-object v4, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v4, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v3}, Ld/r/h/d$a;->a(Ld/r/h/d$a;)Ld/p/b;

    move-result-object v2

    invoke-virtual {v2, v1}, Ld/p/b;->P0(Z)V

    :cond_5
    :goto_0
    invoke-virtual {p1, v0}, Ld/p/b;->M0(Ld/s/a;)V

    new-instance v2, Ld/r/h/d$a;

    invoke-direct {v2, p0, p1, v1}, Ld/r/h/d$a;-><init>(Ld/r/h/d;Ld/p/b;Z)V

    iget-object p1, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {p1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return v1
.end method


# virtual methods
.method public k1(Ld/p/b;Z)V
    .locals 0

    iget-boolean p2, p0, Ld/r/h/d;->I:Z

    if-eqz p2, :cond_0

    new-instance p2, Ld/e;

    invoke-direct {p2}, Ld/e;-><init>()V

    invoke-virtual {p1, p2}, Ld/p/b;->Q0(Ld/e;)Z

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_0
    invoke-direct {p0, p1}, Ld/r/h/d;->r1(Ld/p/b;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Ld/r/h/d;->A:Ld/r/a;

    invoke-virtual {p2, p1}, Ld/r/a;->b(Ld/p/b;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Ld/r/h/d;->B:Ljava/util/Set;

    invoke-interface {p2, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :goto_0
    return-void
.end method

.method public m1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/h/d;->B:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-virtual {p1}, Ld/p/b;->D0()Ld/s/a;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/r/h/d$a;

    iget-object v0, p0, Ld/r/h/d;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->d(Ld/p/b;)V

    iget-object v0, p0, Ld/r/h/d;->D:Ld/p/b;

    if-ne p1, v0, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Ld/r/h/d;->D:Ld/p/b;

    :cond_0
    return-void
.end method

.method public n1(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/h/d;->B:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/r/h/d;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->a(Ld/p/b;)V

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1}, Ld/r/h/d;->r1(Ld/p/b;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/r/h/d;->B:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Ld/r/h/d;->A:Ld/r/a;

    invoke-virtual {v0, p1}, Ld/r/a;->b(Ld/p/b;)V

    :cond_1
    :goto_0
    return-void
.end method

.method protected o1(Ld/e;)Z
    .locals 4

    iget-boolean v0, p0, Ld/r/h/d;->E:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    if-eqz v0, :cond_1

    iput-boolean v2, p0, Ld/r/h/d;->E:Z

    invoke-static {p1}, Ld/s/a;->a(Ld/e;)Ld/s/a;

    move-result-object p1

    iget-object v0, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/r/h/d$a;

    if-eqz p1, :cond_0

    invoke-static {p1}, Ld/r/h/d$a;->a(Ld/r/h/d$a;)Ld/p/b;

    move-result-object v0

    iput-object v0, p0, Ld/r/h/d;->D:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->z0()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1, v3}, Ld/r/h/d$a;->b(Ld/r/h/d$a;Z)V

    iput-object v1, p0, Ld/r/h/d;->D:Ld/p/b;

    iget-boolean p1, p0, Ld/r/h/d;->G:Z

    if-eqz p1, :cond_1

    iput-boolean v3, p0, Ld/r/h/d;->E:Z

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x23

    :goto_0
    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v3

    :cond_0
    iget-boolean p1, p0, Ld/r/h/d;->G:Z

    if-eqz p1, :cond_1

    iput-boolean v3, p0, Ld/r/h/d;->E:Z

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x41

    goto :goto_0

    :cond_1
    return v2

    :cond_2
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->u:Z

    if-eqz v0, :cond_3

    invoke-virtual {p1, v2}, Ld/e;->w(I)V

    :cond_3
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    iput-boolean v0, p0, Ld/r/h/d;->E:Z

    iget-object v0, p0, Ld/r/h/d;->D:Ld/p/b;

    if-eqz v0, :cond_6

    iget-boolean v0, p0, Ld/r/h/d;->H:Z

    if-eqz v0, :cond_4

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    if-nez v0, :cond_4

    iget-object p1, p0, Ld/r/h/d;->D:Ld/p/b;

    invoke-virtual {p1, v3}, Ld/p/b;->P0(Z)V

    iput-object v1, p0, Ld/r/h/d;->D:Ld/p/b;

    return v2

    :cond_4
    iget-object v0, p0, Ld/r/h/d;->D:Ld/p/b;

    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    move-result p1

    if-nez p1, :cond_5

    :goto_1
    iput-object v1, p0, Ld/r/h/d;->D:Ld/p/b;

    goto :goto_2

    :cond_5
    iget-boolean p1, p0, Ld/r/h/d;->E:Z

    if-nez p1, :cond_6

    iget-object p1, p0, Ld/r/h/d;->D:Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->B0()V

    goto :goto_1

    :cond_6
    :goto_2
    return v2
.end method

.method public p1(ILjava/lang/Object;)Z
    .locals 3

    const/4 v0, 0x1

    const/16 v1, 0x3d

    if-ne p1, v1, :cond_0

    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ld/j;->y:Ljava/lang/String;

    return v0

    :cond_0
    const/16 v1, 0x29

    const/4 v2, 0x0

    if-ne p1, v1, :cond_2

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/d;->H:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Ld/g;->e:Ld/f;

    iput-boolean v2, p1, Ld/f;->t:Z

    iput-boolean v0, p1, Ld/f;->u:Z

    :cond_1
    return v0

    :cond_2
    const/16 v1, 0x21

    if-ne p1, v1, :cond_3

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/d;->G:Z

    return v0

    :cond_3
    const/16 v1, 0x33

    if-ne p1, v1, :cond_4

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/d;->I:Z

    return v0

    :cond_4
    const/16 v1, 0x38

    if-ne p1, v1, :cond_5

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/d;->J:Z

    return v0

    :cond_5
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v2
.end method

.method public q1(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/r/h/d;->C:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/r/h/d$a;

    invoke-static {v1}, Ld/r/h/d$a;->a(Ld/r/h/d$a;)Ld/p/b;

    move-result-object v2

    if-ne v2, p1, :cond_0

    const/4 p1, 0x1

    invoke-static {v1, p1}, Ld/r/h/d$a;->b(Ld/r/h/d$a;Z)V

    :goto_0
    return-void
.end method

.method protected y0()V
    .locals 0

    invoke-super {p0}, Ld/j;->y0()V

    return-void
.end method
