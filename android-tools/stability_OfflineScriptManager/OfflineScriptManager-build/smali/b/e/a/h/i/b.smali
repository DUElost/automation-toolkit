.class public Lb/e/a/h/i/b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/e/a/h/i/b$b;
    }
.end annotation


# static fields
.field private static f:Lb/e/a/j/f;


# instance fields
.field a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "Lb/c/a/i/a0;",
            ">;"
        }
    .end annotation
.end field

.field b:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lb/g/a/a/a;",
            ">;"
        }
    .end annotation
.end field

.field c:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lb/e/a/h/g;",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;>;"
        }
    .end annotation
.end field

.field d:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lb/e/a/h/g;",
            "[J>;"
        }
    .end annotation
.end field

.field private e:Lb/e/a/h/i/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/h/i/b;

    invoke-static {v0}, Lb/e/a/j/f;->a(Ljava/lang/Class;)Lb/e/a/j/f;

    move-result-object v0

    sput-object v0, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lb/e/a/h/i/b;->b:Ljava/util/Set;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lb/e/a/h/i/b;->c:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lb/e/a/h/i/b;->d:Ljava/util/HashMap;

    return-void
.end method

.method static synthetic a()Lb/e/a/j/f;
    .locals 1

    sget-object v0, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    return-object v0
.end method

.method private static v([J)J
    .locals 6

    array-length v0, p0

    const-wide/16 v1, 0x0

    const/4 v3, 0x0

    :goto_0
    if-lt v3, v0, :cond_0

    return-wide v1

    :cond_0
    aget-wide v4, p0, v3

    add-long/2addr v1, v4

    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method


# virtual methods
.method public b(Lb/e/a/h/d;)Lb/c/a/i/e;
    .locals 11

    iget-object v0, p0, Lb/e/a/h/i/b;->e:Lb/e/a/h/i/c;

    if-nez v0, :cond_0

    new-instance v0, Lb/e/a/h/i/a;

    const-wide/high16 v1, 0x4000000000000000L    # 2.0

    invoke-direct {v0, v1, v2}, Lb/e/a/h/i/a;-><init>(D)V

    iput-object v0, p0, Lb/e/a/h/i/b;->e:Lb/e/a/h/i/c;

    :cond_0
    sget-object v0, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Creating movie "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    invoke-virtual {p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_a

    new-instance v1, Lb/e/a/d;

    invoke-direct {v1}, Lb/e/a/d;-><init>()V

    invoke-virtual {p0, p1}, Lb/e/a/h/i/b;->f(Lb/e/a/h/d;)Lb/c/a/i/k;

    move-result-object v0

    invoke-virtual {v1, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    new-instance v6, Ljava/util/HashMap;

    invoke-direct {v6}, Ljava/util/HashMap;-><init>()V

    invoke-virtual {p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_9

    invoke-virtual {p0, p1, v6}, Lb/e/a/h/i/b;->g(Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/q;

    move-result-object v0

    invoke-virtual {v1, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    const-string v3, "trak/mdia/minf/stbl/stsz"

    invoke-static {v0, v3}, Lb/e/a/j/j;->b(Lb/c/a/i/b;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    const-wide/16 v3, 0x0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    move-wide v7, v3

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_8

    sget-object v0, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    const-string v3, "About to create mdat"

    invoke-virtual {v0, v3}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    new-instance v0, Lb/e/a/h/i/b$b;

    const/4 v9, 0x0

    move-object v3, v0

    move-object v4, p0

    move-object v5, p1

    invoke-direct/range {v3 .. v9}, Lb/e/a/h/i/b$b;-><init>(Lb/e/a/h/i/b;Lb/e/a/h/d;Ljava/util/Map;JLb/e/a/h/i/b$b;)V

    invoke-virtual {v1, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    sget-object p1, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    const-string v3, "mdat crated"

    invoke-virtual {p1, v3}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    invoke-virtual {v0}, Lb/e/a/h/i/b$b;->c()J

    move-result-wide v3

    iget-object p1, p0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lb/e/a/h/i/b;->b:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_4
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/g/a/a/a;

    invoke-virtual {v0}, Lb/e/a/a;->a()J

    move-result-wide v3

    const-wide/16 v5, 0x2c

    add-long/2addr v3, v5

    move-object v6, v0

    :goto_5
    move-object v5, v6

    check-cast v5, Lb/c/a/i/b;

    invoke-interface {v5}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v7

    invoke-interface {v7}, Lb/c/a/i/e;->e()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_6
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_2

    goto :goto_7

    :cond_2
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/c/a/i/b;

    if-ne v5, v6, :cond_5

    :goto_7
    instance-of v5, v7, Lb/c/a/i/b;

    if-nez v5, :cond_4

    invoke-virtual {v0}, Lb/g/a/a/a;->u()[J

    move-result-object v5

    move v6, v2

    :goto_8
    array-length v7, v5

    if-lt v6, v7, :cond_3

    invoke-virtual {v0, v5}, Lb/g/a/a/a;->v([J)V

    goto :goto_4

    :cond_3
    aget-wide v7, v5, v6

    add-long/2addr v7, v3

    aput-wide v7, v5, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_8

    :cond_4
    move-object v6, v7

    goto :goto_5

    :cond_5
    invoke-interface {v5}, Lb/c/a/i/b;->a()J

    move-result-wide v9

    add-long/2addr v3, v9

    goto :goto_6

    :cond_6
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lb/c/a/i/a0;

    invoke-virtual {p1}, Lb/c/a/i/a0;->s()[J

    move-result-object v9

    move p1, v2

    :goto_9
    array-length v0, v9

    if-lt p1, v0, :cond_7

    goto :goto_3

    :cond_7
    aget-wide v6, v9, p1

    add-long/2addr v6, v3

    aput-wide v6, v9, p1

    add-int/lit8 p1, p1, 0x1

    goto :goto_9

    :cond_8
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/v;

    invoke-virtual {v3}, Lb/c/a/i/v;->w()[J

    move-result-object v3

    invoke-static {v3}, Lb/e/a/h/i/b;->v([J)J

    move-result-wide v3

    add-long/2addr v7, v3

    goto/16 :goto_2

    :cond_9
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/e/a/h/g;

    invoke-virtual {p0, v0}, Lb/e/a/h/i/b;->s(Lb/e/a/h/g;)[I

    move-result-object v4

    invoke-interface {v6, v0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_1

    :cond_a
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/e/a/h/g;

    invoke-interface {v1}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0, v1, v3}, Lb/e/a/h/i/b;->u(Lb/e/a/h/g;Ljava/util/List;)Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    new-array v5, v4, [J

    :goto_a
    if-lt v2, v4, :cond_b

    iget-object v2, p0, Lb/e/a/h/i/b;->d:Ljava/util/HashMap;

    invoke-virtual {v2, v1, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    :cond_b
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/e/a/h/f;

    invoke-interface {v6}, Lb/e/a/h/f;->a()J

    move-result-wide v6

    aput-wide v6, v5, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_a
.end method

.method protected c(Lb/e/a/h/l/b;Lb/c/a/i/w;[I)V
    .locals 16

    move-object/from16 v0, p2

    move-object/from16 v1, p3

    new-instance v2, Lb/g/a/a/b;

    invoke-direct {v2}, Lb/g/a/a/b;-><init>()V

    const-string v3, "cenc"

    invoke-virtual {v2, v3}, Lb/g/a/a/b;->y(Ljava/lang/String;)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lb/e/a/c;->p(I)V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/l/b;->n()Ljava/util/List;

    move-result-object v3

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/l/b;->p()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    new-array v6, v4, [S

    const/4 v7, 0x0

    :goto_0
    if-lt v7, v4, :cond_0

    invoke-virtual {v2, v6}, Lb/g/a/a/b;->B([S)V

    goto :goto_1

    :cond_0
    invoke-interface {v3, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lb/g/b/a/a;

    invoke-virtual {v8}, Lb/g/b/a/a;->b()I

    move-result v8

    int-to-short v8, v8

    aput-short v8, v6, v7

    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_1
    const/16 v4, 0x8

    invoke-virtual {v2, v4}, Lb/g/a/a/b;->z(I)V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    invoke-virtual {v2, v4}, Lb/g/a/a/b;->A(I)V

    :goto_1
    new-instance v4, Lb/g/a/a/a;

    invoke-direct {v4}, Lb/g/a/a/a;-><init>()V

    new-instance v6, Lb/e/a/i/c/a;

    invoke-direct {v6}, Lb/e/a/i/c/a;-><init>()V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/l/b;->p()Z

    move-result v7

    invoke-virtual {v6, v7}, Lb/e/a/i/a;->z(Z)V

    invoke-virtual {v6, v3}, Lb/e/a/i/a;->y(Ljava/util/List;)V

    invoke-virtual {v6}, Lb/e/a/i/a;->u()I

    move-result v7

    int-to-long v7, v7

    array-length v9, v1

    new-array v9, v9, [J

    const/4 v10, 0x0

    const/4 v11, 0x0

    :goto_2
    array-length v12, v1

    if-lt v10, v12, :cond_2

    invoke-virtual {v4, v9}, Lb/g/a/a/a;->v([J)V

    invoke-virtual {v0, v2}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {v0, v4}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {v0, v6}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    move-object/from16 v12, p0

    iget-object v0, v12, Lb/e/a/h/i/b;->b:Ljava/util/Set;

    invoke-interface {v0, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void

    :cond_2
    move-object/from16 v12, p0

    aput-wide v7, v9, v10

    const/4 v13, 0x0

    :goto_3
    aget v14, v1, v10

    if-lt v13, v14, :cond_3

    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    :cond_3
    add-int/lit8 v14, v11, 0x1

    invoke-interface {v3, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lb/g/b/a/a;

    invoke-virtual {v11}, Lb/g/b/a/a;->b()I

    move-result v11

    move-object v15, v6

    int-to-long v5, v11

    add-long/2addr v7, v5

    add-int/lit8 v13, v13, 0x1

    move v11, v14

    move-object v6, v15

    goto :goto_3
.end method

.method protected d(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 1

    invoke-interface {p1}, Lb/e/a/h/g;->d()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lb/c/a/i/d;

    invoke-direct {v0}, Lb/c/a/i/d;-><init>()V

    invoke-virtual {v0, p1}, Lb/c/a/i/d;->v(Ljava/util/List;)V

    invoke-virtual {p2, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    :cond_0
    return-void
.end method

.method protected e(Lb/e/a/h/g;Lb/e/a/h/d;)Lb/c/a/i/b;
    .locals 12

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Lb/c/a/i/j;

    invoke-direct {v0}, Lb/c/a/i/j;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lb/e/a/c;->q(I)V

    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0, v9}, Lb/c/a/i/j;->u(Ljava/util/List;)V

    new-instance p1, Lb/c/a/i/i;

    invoke-direct {p1}, Lb/c/a/i/i;-><init>()V

    invoke-virtual {p1, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-object p1

    :cond_0
    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/e/a/h/c;

    new-instance v11, Lb/c/a/i/j$a;

    invoke-virtual {v1}, Lb/e/a/h/c;->c()D

    move-result-wide v2

    invoke-virtual {p2}, Lb/e/a/h/d;->e()J

    move-result-wide v4

    long-to-double v4, v4

    mul-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v3

    invoke-virtual {v1}, Lb/e/a/h/c;->b()J

    move-result-wide v5

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v2

    invoke-virtual {v2}, Lb/e/a/h/h;->g()J

    move-result-wide v7

    mul-long/2addr v5, v7

    invoke-virtual {v1}, Lb/e/a/h/c;->d()J

    move-result-wide v7

    div-long/2addr v5, v7

    invoke-virtual {v1}, Lb/e/a/h/c;->a()D

    move-result-wide v7

    move-object v1, v11

    move-object v2, v0

    invoke-direct/range {v1 .. v8}, Lb/c/a/i/j$a;-><init>(Lb/c/a/i/j;JJD)V

    invoke-interface {v9, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method protected f(Lb/e/a/h/d;)Lb/c/a/i/k;
    .locals 4

    new-instance p1, Ljava/util/LinkedList;

    invoke-direct {p1}, Ljava/util/LinkedList;-><init>()V

    const-string v0, "mp42"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v0, "iso6"

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "avc1"

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v1, "isom"

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lb/c/a/i/k;

    const-wide/16 v2, 0x1

    invoke-direct {v1, v0, v2, v3, p1}, Lb/c/a/i/k;-><init>(Ljava/lang/String;JLjava/util/List;)V

    return-object v1
.end method

.method protected g(Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/q;
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/d;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;)",
            "Lb/c/a/i/q;"
        }
    .end annotation

    new-instance v0, Lb/c/a/i/q;

    invoke-direct {v0}, Lb/c/a/i/q;-><init>()V

    new-instance v1, Lb/c/a/i/r;

    invoke-direct {v1}, Lb/c/a/i/r;-><init>()V

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1, v2}, Lb/c/a/i/r;->B(Ljava/util/Date;)V

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1, v2}, Lb/c/a/i/r;->E(Ljava/util/Date;)V

    invoke-virtual/range {p1 .. p1}, Lb/e/a/h/d;->c()Lb/e/a/j/h;

    move-result-object v2

    invoke-virtual {v1, v2}, Lb/c/a/i/r;->D(Lb/e/a/j/h;)V

    invoke-virtual/range {p0 .. p1}, Lb/e/a/h/i/b;->t(Lb/e/a/h/d;)J

    move-result-wide v2

    invoke-virtual/range {p1 .. p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    const-wide/16 v7, 0x0

    :cond_0
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-nez v9, :cond_5

    invoke-virtual {v1, v7, v8}, Lb/c/a/i/r;->C(J)V

    invoke-virtual {v1, v2, v3}, Lb/c/a/i/r;->G(J)V

    invoke-virtual/range {p1 .. p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    const-wide/16 v5, 0x0

    :cond_1
    :goto_1
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_4

    const-wide/16 v2, 0x1

    add-long/2addr v5, v2

    invoke-virtual {v1, v5, v6}, Lb/c/a/i/r;->F(J)V

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual/range {p1 .. p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual/range {p0 .. p1}, Lb/e/a/h/i/b;->r(Lb/e/a/h/d;)Lb/c/a/i/b;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    :cond_2
    return-object v0

    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/e/a/h/g;

    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move-object/from16 v12, p2

    invoke-virtual {v10, v1, v11, v12}, Lb/e/a/h/i/b;->q(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/f0;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_2

    :cond_4
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move-object/from16 v12, p2

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/h/g;

    invoke-interface {v2}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->h()J

    move-result-wide v3

    cmp-long v3, v5, v3

    if-gez v3, :cond_1

    invoke-interface {v2}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v2

    invoke-virtual {v2}, Lb/e/a/h/h;->h()J

    move-result-wide v2

    move-wide v5, v2

    goto :goto_1

    :cond_5
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move-object/from16 v12, p2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lb/e/a/h/g;

    invoke-interface {v9}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v13

    if-eqz v13, :cond_8

    invoke-interface {v9}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v13

    invoke-interface {v13}, Ljava/util/List;->isEmpty()Z

    move-result v13

    if-eqz v13, :cond_6

    goto :goto_4

    :cond_6
    const-wide/16 v13, 0x0

    invoke-interface {v9}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_3
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-nez v9, :cond_7

    long-to-double v5, v2

    mul-double/2addr v13, v5

    double-to-long v5, v13

    goto :goto_5

    :cond_7
    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/e/a/h/c;

    invoke-virtual {v5}, Lb/e/a/h/c;->c()D

    move-result-wide v5

    double-to-long v5, v5

    long-to-double v5, v5

    add-double/2addr v13, v5

    goto :goto_3

    :cond_8
    :goto_4
    invoke-interface {v9}, Lb/e/a/h/g;->k()J

    move-result-wide v5

    mul-long/2addr v5, v2

    invoke-interface {v9}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v9

    invoke-virtual {v9}, Lb/e/a/h/h;->g()J

    move-result-wide v13

    div-long/2addr v5, v13

    :goto_5
    cmp-long v9, v5, v7

    if-lez v9, :cond_0

    move-wide v7, v5

    goto/16 :goto_0
.end method

.method protected h(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 1

    invoke-interface {p1}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lb/c/a/i/t;

    invoke-direct {v0}, Lb/c/a/i/t;-><init>()V

    invoke-interface {p1}, Lb/e/a/h/g;->A()Ljava/util/List;

    move-result-object p1

    invoke-virtual {v0, p1}, Lb/c/a/i/t;->u(Ljava/util/List;)V

    invoke-virtual {p2, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    :cond_0
    return-void
.end method

.method protected i(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/b;
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/g;",
            "Lb/e/a/h/d;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;)",
            "Lb/c/a/i/b;"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p3

    new-instance v3, Lb/c/a/i/w;

    invoke-direct {v3}, Lb/c/a/i/w;-><init>()V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->l(Lb/e/a/h/g;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->o(Lb/e/a/h/g;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->d(Lb/e/a/h/g;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->m(Lb/e/a/h/g;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->h(Lb/e/a/h/g;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v2, v3}, Lb/e/a/h/i/b;->k(Lb/e/a/h/g;Ljava/util/Map;Lb/c/a/i/w;)V

    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->n(Lb/e/a/h/g;Lb/c/a/i/w;)V

    move-object/from16 v4, p2

    invoke-virtual {v0, v1, v4, v2, v3}, Lb/e/a/h/i/b;->j(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;Lb/c/a/i/w;)V

    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->o()Ljava/util/Map;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_7

    invoke-interface {v4}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_1

    instance-of v4, v1, Lb/e/a/h/l/b;

    if-eqz v4, :cond_0

    move-object v4, v1

    check-cast v4, Lb/e/a/h/l/b;

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    invoke-virtual {v0, v4, v3, v2}, Lb/e/a/h/i/b;->c(Lb/e/a/h/l/b;Lb/c/a/i/w;[I)V

    :cond_0
    invoke-virtual {v0, v1, v3}, Lb/e/a/h/i/b;->p(Lb/e/a/h/g;Lb/c/a/i/w;)V

    sget-object v2, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "done with stbl for track_"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v1

    invoke-virtual {v1}, Lb/e/a/h/h;->h()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    return-object v3

    :cond_1
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    move-object v7, v4

    check-cast v7, Ljava/util/Map$Entry;

    new-instance v8, Lb/e/a/i/d/d/e;

    invoke-direct {v8}, Lb/e/a/i/d/d/e;-><init>()V

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v8, v4}, Lb/e/a/i/d/d/e;->x(Ljava/lang/String;)V

    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/List;

    invoke-virtual {v8, v5}, Lb/e/a/i/d/d/e;->w(Ljava/util/List;)V

    new-instance v9, Lb/e/a/i/d/d/f;

    invoke-direct {v9}, Lb/e/a/i/d/d/f;-><init>()V

    invoke-virtual {v9, v4}, Lb/e/a/i/d/d/f;->v(Ljava/lang/String;)V

    const/4 v4, 0x0

    const/4 v10, 0x0

    move-object v11, v4

    move v12, v10

    :goto_2
    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lt v12, v4, :cond_2

    invoke-virtual {v3, v8}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {v3, v9}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_1

    :cond_2
    move v4, v10

    move v5, v4

    :goto_3
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/util/List;

    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v13

    if-lt v4, v13, :cond_5

    const-wide/16 v13, 0x1

    if-eqz v11, :cond_4

    invoke-virtual {v11}, Lb/e/a/i/d/d/f$a;->a()I

    move-result v4

    if-eq v4, v5, :cond_3

    goto :goto_4

    :cond_3
    invoke-virtual {v11}, Lb/e/a/i/d/d/f$a;->b()J

    move-result-wide v4

    add-long/2addr v4, v13

    invoke-virtual {v11, v4, v5}, Lb/e/a/i/d/d/f$a;->c(J)V

    goto :goto_5

    :cond_4
    :goto_4
    new-instance v4, Lb/e/a/i/d/d/f$a;

    invoke-direct {v4, v13, v14, v5}, Lb/e/a/i/d/d/f$a;-><init>(JI)V

    invoke-virtual {v9}, Lb/e/a/i/d/d/f;->s()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object v11, v4

    :goto_5
    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    :cond_5
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/util/List;

    invoke-interface {v13, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lb/e/a/i/d/d/b;

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->o()Ljava/util/Map;

    move-result-object v14

    invoke-interface {v14, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, [J

    int-to-long v14, v12

    invoke-static {v13, v14, v15}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v13

    if-ltz v13, :cond_6

    add-int/lit8 v5, v4, 0x1

    :cond_6
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_7
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lb/e/a/i/d/d/b;

    invoke-virtual {v7}, Lb/e/a/i/d/d/b;->b()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v4, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/List;

    if-nez v8, :cond_8

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v4, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_8
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/e/a/i/d/d/b;

    invoke-interface {v8, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0
.end method

.method protected j(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;Lb/c/a/i/w;)V
    .locals 23
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/g;",
            "Lb/e/a/h/d;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;",
            "Lb/c/a/i/w;",
            ")V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p3

    iget-object v3, v0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    invoke-interface {v3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_6

    const-wide/16 v3, 0x0

    sget-object v5, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "Calculating chunk offsets for track_"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface/range {p1 .. p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v7

    invoke-virtual {v7}, Lb/e/a/h/h;->h()J

    move-result-wide v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    new-instance v5, Ljava/util/ArrayList;

    invoke-interface/range {p3 .. p3}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    new-instance v6, Lb/e/a/h/i/b$a;

    invoke-direct {v6, v0}, Lb/e/a/h/i/b$a;-><init>(Lb/e/a/h/i/b;)V

    invoke-static {v5, v6}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    new-instance v6, Ljava/util/HashMap;

    invoke-direct {v6}, Ljava/util/HashMap;-><init>()V

    new-instance v7, Ljava/util/HashMap;

    invoke-direct {v7}, Ljava/util/HashMap;-><init>()V

    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    const/4 v11, 0x0

    if-nez v10, :cond_5

    move-wide v12, v3

    :goto_1
    const/4 v3, 0x0

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_2
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-nez v4, :cond_2

    if-nez v3, :cond_0

    goto/16 :goto_4

    :cond_0
    iget-object v4, v0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    invoke-interface {v4, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lb/c/a/i/c;

    invoke-virtual {v4}, Lb/c/a/i/c;->s()[J

    move-result-object v9

    const/4 v10, 0x1

    new-array v10, v10, [J

    aput-wide v12, v10, v11

    invoke-static {v9, v10}, Lb/e/a/j/i;->a([J[J)[J

    move-result-object v9

    invoke-virtual {v4, v9}, Lb/c/a/i/c;->u([J)V

    invoke-interface {v6, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [I

    aget v9, v9, v4

    invoke-interface {v7, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v14

    invoke-interface {v8, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Double;

    invoke-virtual {v10}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v15

    invoke-interface {v3}, Lb/e/a/h/g;->w()[J

    move-result-object v17

    move v10, v14

    :goto_3
    add-int v11, v14, v9

    if-lt v10, v11, :cond_1

    add-int/lit8 v4, v4, 0x1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v6, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v7, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static/range {v15 .. v16}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-interface {v8, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v11, 0x0

    goto :goto_1

    :cond_1
    iget-object v11, v0, Lb/e/a/h/i/b;->d:Ljava/util/HashMap;

    invoke-virtual {v11, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [J

    aget-wide v18, v11, v10

    add-long v12, v12, v18

    move/from16 v18, v4

    move-object v11, v5

    aget-wide v4, v17, v10

    long-to-double v4, v4

    invoke-interface {v3}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v19

    move-object/from16 v22, v11

    move-wide/from16 v20, v12

    invoke-virtual/range {v19 .. v19}, Lb/e/a/h/h;->g()J

    move-result-wide v11

    long-to-double v11, v11

    div-double/2addr v4, v11

    add-double/2addr v15, v4

    add-int/lit8 v10, v10, 0x1

    move/from16 v4, v18

    move-wide/from16 v12, v20

    move-object/from16 v5, v22

    goto :goto_3

    :cond_2
    move-object/from16 v22, v5

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lb/e/a/h/g;

    if-eqz v3, :cond_3

    invoke-interface {v8, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Double;

    invoke-virtual {v5}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v14

    invoke-interface {v8, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Double;

    invoke-virtual {v5}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v16

    cmpg-double v5, v14, v16

    if-gez v5, :cond_4

    :cond_3
    invoke-interface {v6, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, [I

    array-length v9, v9

    if-ge v5, v9, :cond_4

    move-object v3, v4

    :cond_4
    move-object/from16 v5, v22

    const/4 v11, 0x0

    goto/16 :goto_2

    :cond_5
    move-object/from16 v22, v5

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/e/a/h/g;

    const/4 v10, 0x0

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-interface {v6, v5, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-interface {v7, v5, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-wide/16 v10, 0x0

    invoke-static {v10, v11}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v10

    invoke-interface {v8, v5, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v10, v0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    new-instance v11, Lb/c/a/i/a0;

    invoke-direct {v11}, Lb/c/a/i/a0;-><init>()V

    invoke-interface {v10, v5, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object/from16 v5, v22

    goto/16 :goto_0

    :cond_6
    :goto_4
    iget-object v2, v0, Lb/e/a/h/i/b;->a:Ljava/util/Map;

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    move-object/from16 v2, p4

    invoke-virtual {v2, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-void
.end method

.method protected k(Lb/e/a/h/g;Ljava/util/Map;Lb/c/a/i/w;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/g;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;",
            "Lb/c/a/i/w;",
            ")V"
        }
    .end annotation

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [I

    new-instance p2, Lb/c/a/i/x;

    invoke-direct {p2}, Lb/c/a/i/x;-><init>()V

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {p2, v0}, Lb/c/a/i/x;->v(Ljava/util/List;)V

    const-wide/32 v0, -0x80000000

    const/4 v2, 0x0

    :goto_0
    array-length v3, p1

    if-lt v2, v3, :cond_0

    invoke-virtual {p3, p2}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-void

    :cond_0
    aget v3, p1, v2

    int-to-long v3, v3

    cmp-long v3, v0, v3

    if-eqz v3, :cond_1

    invoke-virtual {p2}, Lb/c/a/i/x;->u()Ljava/util/List;

    move-result-object v0

    new-instance v1, Lb/c/a/i/x$a;

    add-int/lit8 v3, v2, 0x1

    int-to-long v4, v3

    aget v3, p1, v2

    int-to-long v6, v3

    const-wide/16 v8, 0x1

    move-object v3, v1

    invoke-direct/range {v3 .. v9}, Lb/c/a/i/x$a;-><init>(JJJ)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    aget v0, p1, v2

    int-to-long v0, v0

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method protected l(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 0

    invoke-interface {p1}, Lb/e/a/h/g;->x()Lb/c/a/i/u;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-void
.end method

.method protected m(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 1

    invoke-interface {p1}, Lb/e/a/h/g;->f()[J

    move-result-object p1

    if-eqz p1, :cond_0

    array-length v0, p1

    if-lez v0, :cond_0

    new-instance v0, Lb/c/a/i/d0;

    invoke-direct {v0}, Lb/c/a/i/d0;-><init>()V

    invoke-virtual {v0, p1}, Lb/c/a/i/d0;->u([J)V

    invoke-virtual {p2, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    :cond_0
    return-void
.end method

.method protected n(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 2

    new-instance v0, Lb/c/a/i/v;

    invoke-direct {v0}, Lb/c/a/i/v;-><init>()V

    iget-object v1, p0, Lb/e/a/h/i/b;->d:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [J

    invoke-virtual {v0, p1}, Lb/c/a/i/v;->x([J)V

    invoke-virtual {p2, v0}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-void
.end method

.method protected o(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 10

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Lb/e/a/h/g;->w()[J

    move-result-object p1

    array-length v1, p1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-lt v3, v1, :cond_0

    new-instance p1, Lb/c/a/i/e0;

    invoke-direct {p1}, Lb/c/a/i/e0;-><init>()V

    invoke-virtual {p1, v0}, Lb/c/a/i/e0;->v(Ljava/util/List;)V

    invoke-virtual {p2, p1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    return-void

    :cond_0
    aget-wide v4, p1, v3

    const-wide/16 v6, 0x1

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lb/c/a/i/e0$a;->b()J

    move-result-wide v8

    cmp-long v8, v8, v4

    if-nez v8, :cond_1

    invoke-virtual {v2}, Lb/c/a/i/e0$a;->a()J

    move-result-wide v4

    add-long/2addr v4, v6

    invoke-virtual {v2, v4, v5}, Lb/c/a/i/e0$a;->c(J)V

    goto :goto_1

    :cond_1
    new-instance v2, Lb/c/a/i/e0$a;

    invoke-direct {v2, v6, v7, v4, v5}, Lb/c/a/i/e0$a;-><init>(JJ)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method protected p(Lb/e/a/h/g;Lb/c/a/i/w;)V
    .locals 1

    invoke-interface {p1}, Lb/e/a/h/g;->i()Lb/c/a/i/b0;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Lb/e/a/h/g;->i()Lb/c/a/i/b0;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    :cond_0
    return-void
.end method

.method protected q(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/f0;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/g;",
            "Lb/e/a/h/d;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;)",
            "Lb/c/a/i/f0;"
        }
    .end annotation

    new-instance v0, Lb/c/a/i/f0;

    invoke-direct {v0}, Lb/c/a/i/f0;-><init>()V

    new-instance v1, Lb/c/a/i/g0;

    invoke-direct {v1}, Lb/c/a/i/g0;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lb/c/a/i/g0;->G(Z)V

    invoke-virtual {v1, v2}, Lb/c/a/i/g0;->I(Z)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->f()Lb/e/a/j/h;

    move-result-object v3

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->K(Lb/e/a/j/h;)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->b()I

    move-result v3

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->D(I)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->a()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->E(Ljava/util/Date;)V

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_1

    :cond_0
    const-wide/16 v3, 0x0

    invoke-interface {p1}, Lb/e/a/h/g;->c()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_1

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v5

    invoke-virtual {v5}, Lb/e/a/h/h;->g()J

    move-result-wide v5

    mul-long/2addr v3, v5

    goto :goto_2

    :cond_1
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/e/a/h/c;

    invoke-virtual {v6}, Lb/e/a/h/c;->c()D

    move-result-wide v6

    double-to-long v6, v6

    add-long/2addr v3, v6

    goto :goto_0

    :cond_2
    :goto_1
    invoke-interface {p1}, Lb/e/a/h/g;->k()J

    move-result-wide v3

    invoke-virtual {p0, p2}, Lb/e/a/h/i/b;->t(Lb/e/a/h/d;)J

    move-result-wide v5

    mul-long/2addr v3, v5

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v5

    invoke-virtual {v5}, Lb/e/a/h/h;->g()J

    move-result-wide v5

    div-long/2addr v3, v5

    :goto_2
    invoke-virtual {v1, v3, v4}, Lb/c/a/i/g0;->F(J)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->c()D

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lb/c/a/i/g0;->H(D)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->j()D

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lb/c/a/i/g0;->O(D)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->e()I

    move-result v3

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->J(I)V

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->L(Ljava/util/Date;)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->h()J

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lb/c/a/i/g0;->M(J)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v3

    invoke-virtual {v3}, Lb/e/a/h/h;->i()F

    move-result v3

    invoke-virtual {v1, v3}, Lb/c/a/i/g0;->N(F)V

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {p0, p1, p2}, Lb/e/a/h/i/b;->e(Lb/e/a/h/g;Lb/e/a/h/d;)Lb/c/a/i/b;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    new-instance v1, Lb/c/a/i/n;

    invoke-direct {v1}, Lb/c/a/i/n;-><init>()V

    invoke-virtual {v0, v1}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    new-instance v3, Lb/c/a/i/o;

    invoke-direct {v3}, Lb/c/a/i/o;-><init>()V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v4

    invoke-virtual {v4}, Lb/e/a/h/h;->a()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Lb/c/a/i/o;->y(Ljava/util/Date;)V

    invoke-interface {p1}, Lb/e/a/h/g;->k()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Lb/c/a/i/o;->z(J)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v4

    invoke-virtual {v4}, Lb/e/a/h/h;->g()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Lb/c/a/i/o;->B(J)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v4

    invoke-virtual {v4}, Lb/e/a/h/h;->d()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lb/c/a/i/o;->A(Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    new-instance v3, Lb/c/a/i/l;

    invoke-direct {v3}, Lb/c/a/i/l;-><init>()V

    invoke-virtual {v1, v3}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lb/c/a/i/l;->v(Ljava/lang/String;)V

    new-instance v3, Lb/c/a/i/p;

    invoke-direct {v3}, Lb/c/a/i/p;-><init>()V

    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "vide"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    new-instance v4, Lb/c/a/i/h0;

    invoke-direct {v4}, Lb/c/a/i/h0;-><init>()V

    :goto_3
    invoke-virtual {v3, v4}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    goto :goto_4

    :cond_3
    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "soun"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    new-instance v4, Lb/c/a/i/z;

    invoke-direct {v4}, Lb/c/a/i/z;-><init>()V

    goto :goto_3

    :cond_4
    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "text"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    new-instance v4, Lb/c/a/i/s;

    invoke-direct {v4}, Lb/c/a/i/s;-><init>()V

    goto :goto_3

    :cond_5
    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "subt"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    new-instance v4, Lb/c/a/i/c0;

    invoke-direct {v4}, Lb/c/a/i/c0;-><init>()V

    goto :goto_3

    :cond_6
    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "hint"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    new-instance v4, Lb/c/a/i/m;

    invoke-direct {v4}, Lb/c/a/i/m;-><init>()V

    goto :goto_3

    :cond_7
    invoke-interface {p1}, Lb/e/a/h/g;->r()Ljava/lang/String;

    move-result-object v4

    const-string v5, "sbtl"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    new-instance v4, Lb/c/a/i/s;

    invoke-direct {v4}, Lb/c/a/i/s;-><init>()V

    goto :goto_3

    :cond_8
    :goto_4
    new-instance v4, Lb/c/a/i/g;

    invoke-direct {v4}, Lb/c/a/i/g;-><init>()V

    new-instance v5, Lb/c/a/i/h;

    invoke-direct {v5}, Lb/c/a/i/h;-><init>()V

    invoke-virtual {v4, v5}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    new-instance v6, Lb/c/a/i/f;

    invoke-direct {v6}, Lb/c/a/i/f;-><init>()V

    invoke-virtual {v6, v2}, Lb/e/a/c;->p(I)V

    invoke-virtual {v5, v6}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {v3, v4}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {p0, p1, p2, p3}, Lb/e/a/h/i/b;->i(Lb/e/a/h/g;Lb/e/a/h/d;Ljava/util/Map;)Lb/c/a/i/b;

    move-result-object p2

    invoke-virtual {v3, p2}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    invoke-virtual {v1, v3}, Lb/e/a/d;->v(Lb/c/a/i/b;)V

    sget-object p2, Lb/e/a/h/i/b;->f:Lb/e/a/j/f;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string v1, "done with trak for track_"

    invoke-direct {p3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {p1}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object p1

    invoke-virtual {p1}, Lb/e/a/h/h;->h()J

    move-result-wide v1

    invoke-virtual {p3, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    return-object v0
.end method

.method protected r(Lb/e/a/h/d;)Lb/c/a/i/b;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method s(Lb/e/a/h/g;)[I
    .locals 11

    iget-object v0, p0, Lb/e/a/h/i/b;->e:Lb/e/a/h/i/c;

    invoke-interface {v0, p1}, Lb/e/a/h/i/c;->a(Lb/e/a/h/g;)[J

    move-result-object v0

    array-length v1, v0

    new-array v1, v1, [I

    const/4 v2, 0x0

    :goto_0
    array-length v3, v0

    if-lt v2, v3, :cond_0

    return-object v1

    :cond_0
    aget-wide v3, v0, v2

    const-wide/16 v5, 0x1

    sub-long/2addr v3, v5

    array-length v7, v0

    add-int/lit8 v8, v2, 0x1

    if-ne v7, v8, :cond_1

    invoke-interface {p1}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    int-to-long v5, v5

    goto :goto_1

    :cond_1
    aget-wide v9, v0, v8

    sub-long v5, v9, v5

    :goto_1
    sub-long/2addr v5, v3

    invoke-static {v5, v6}, Lb/e/a/j/b;->a(J)I

    move-result v3

    aput v3, v1, v2

    move v2, v8

    goto :goto_0
.end method

.method public t(Lb/e/a/h/d;)J
    .locals 4

    invoke-virtual {p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/e/a/h/g;

    invoke-interface {v0}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v0

    invoke-virtual {v0}, Lb/e/a/h/h;->g()J

    move-result-wide v0

    invoke-virtual {p1}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    return-wide v0

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/h/g;

    invoke-interface {v2}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v2

    invoke-virtual {v2}, Lb/e/a/h/h;->g()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lb/e/a/j/g;->b(JJ)J

    move-result-wide v0

    goto :goto_0
.end method

.method protected u(Lb/e/a/h/g;Ljava/util/List;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/g;",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;)",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/i/b;->c:Ljava/util/HashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    return-object p1
.end method
