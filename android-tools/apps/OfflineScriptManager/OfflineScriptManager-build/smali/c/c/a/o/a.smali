.class public final Lc/c/a/o/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private final a:Lc/c/a/f/a;

.field private final b:Lc/c/a/m/a;

.field private c:Z

.field private d:Z

.field private e:[Ljava/lang/Integer;

.field private f:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lc/c/a/k/d;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lc/c/a/k/d;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private i:I

.field private j:Ljava/lang/Boolean;

.field private k:Lc/c/a/k/i;


# direct methods
.method public constructor <init>(Lc/c/a/f/a;Lc/c/a/m/a;Lc/c/a/a;Lc/c/a/k/i;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    iput-object p2, p0, Lc/c/a/o/a;->b:Lc/c/a/m/a;

    invoke-virtual {p3}, Lc/c/a/a;->n()Z

    move-result p1

    iput-boolean p1, p0, Lc/c/a/o/a;->c:Z

    invoke-virtual {p3}, Lc/c/a/a;->m()Z

    move-result p1

    iput-boolean p1, p0, Lc/c/a/o/a;->d:Z

    invoke-virtual {p3}, Lc/c/a/a;->h()Lc/c/a/a$d;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p3}, Lc/c/a/a;->h()Lc/c/a/a$d;

    move-result-object p1

    invoke-virtual {p1}, Lc/c/a/a$d;->a()[Ljava/lang/Integer;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/o/a;->e:[Ljava/lang/Integer;

    :cond_0
    invoke-virtual {p3}, Lc/c/a/a;->g()Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/o/a;->f:Ljava/util/Map;

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Lc/c/a/o/a;->g:Ljava/util/Set;

    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    iput-object p1, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    const/4 p1, 0x0

    iput p1, p0, Lc/c/a/o/a;->i:I

    const/4 p1, 0x0

    iput-object p1, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    iput-object p4, p0, Lc/c/a/o/a;->k:Lc/c/a/k/i;

    return-void
.end method

.method private a(Lc/c/a/k/d;)V
    .locals 2

    invoke-virtual {p1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v0

    sget-object v1, Lc/c/a/k/e;->e:Lc/c/a/k/e;

    if-ne v0, v1, :cond_0

    check-cast p1, Lc/c/a/k/a;

    invoke-virtual {p1}, Lc/c/a/k/a;->f()Lc/c/a/k/d;

    move-result-object p1

    :cond_0
    iget-object v0, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-nez v0, :cond_4

    invoke-direct {p0}, Lc/c/a/o/a;->c()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lc/c/a/o/a$a;->a:[I

    invoke-virtual {p1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    goto :goto_2

    :cond_2
    check-cast p1, Lc/c/a/k/c;

    invoke-virtual {p1}, Lc/c/a/k/c;->h()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/f;

    invoke-virtual {v0}, Lc/c/a/k/f;->a()Lc/c/a/k/d;

    move-result-object v1

    invoke-virtual {v0}, Lc/c/a/k/f;->b()Lc/c/a/k/d;

    move-result-object v0

    invoke-direct {p0, v1}, Lc/c/a/o/a;->a(Lc/c/a/k/d;)V

    invoke-direct {p0, v0}, Lc/c/a/o/a;->a(Lc/c/a/k/d;)V

    goto :goto_0

    :cond_3
    check-cast p1, Lc/c/a/k/h;

    invoke-virtual {p1}, Lc/c/a/k/h;->h()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/d;

    invoke-direct {p0, v0}, Lc/c/a/o/a;->a(Lc/c/a/k/d;)V

    goto :goto_1

    :cond_4
    :goto_2
    return-void
.end method

.method private c()Ljava/lang/String;
    .locals 3

    iget v0, p0, Lc/c/a/o/a;->i:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lc/c/a/o/a;->i:I

    invoke-static {}, Ljava/text/NumberFormat;->getNumberInstance()Ljava/text/NumberFormat;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Ljava/text/NumberFormat;->setMinimumIntegerDigits(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/text/NumberFormat;->setGroupingUsed(Z)V

    iget v1, p0, Lc/c/a/o/a;->i:I

    int-to-long v1, v1

    invoke-virtual {v0, v1, v2}, Ljava/text/NumberFormat;->format(J)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "id"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private f(Lc/c/a/k/d;Lc/c/a/k/d;Ljava/lang/Object;)V
    .locals 11

    invoke-virtual {p1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object p2

    sget-object p3, Lc/c/a/k/e;->e:Lc/c/a/k/e;

    if-ne p2, p3, :cond_0

    check-cast p1, Lc/c/a/k/a;

    invoke-virtual {p1}, Lc/c/a/k/a;->f()Lc/c/a/k/d;

    move-result-object p1

    :cond_0
    iget-object p2, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    move-object v1, p2

    check-cast v1, Ljava/lang/String;

    iget-object p2, p0, Lc/c/a/o/a;->g:Ljava/util/Set;

    invoke-interface {p2, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p2

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    iget-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance p2, Lc/c/a/h/a;

    invoke-direct {p2, v1, p3, p3}, Lc/c/a/h/a;-><init>(Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;)V

    :goto_0
    invoke-interface {p1, p2}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    goto/16 :goto_3

    :cond_1
    iget-object p2, p0, Lc/c/a/o/a;->g:Ljava/util/Set;

    invoke-interface {p2, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    sget-object p2, Lc/c/a/o/a$a;->a:[I

    invoke-virtual {p1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    move-result v0

    aget p2, p2, v0

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-eq p2, v8, :cond_4

    const/4 v0, 0x3

    if-eq p2, v0, :cond_3

    iget-object p2, p0, Lc/c/a/o/a;->b:Lc/c/a/m/a;

    sget-object v0, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    invoke-virtual {p2, v0, p3, v8}, Lc/c/a/m/a;->c(Lc/c/a/k/e;Ljava/lang/String;Z)Lc/c/a/k/i;

    move-result-object p2

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-virtual {v0, p2}, Lc/c/a/k/i;->equals(Ljava/lang/Object;)Z

    move-result v3

    iget-object p2, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v7, Lc/c/a/h/i;

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-virtual {v0}, Lc/c/a/k/i;->b()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p1

    check-cast v0, Lc/c/a/k/b;

    invoke-virtual {v0}, Lc/c/a/k/b;->f()Ljava/lang/Boolean;

    move-result-object v6

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lc/c/a/h/i;-><init>(Ljava/lang/String;Ljava/lang/String;ZLc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Boolean;)V

    invoke-interface {p2, v7}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    check-cast p1, Lc/c/a/k/c;

    invoke-virtual {p1}, Lc/c/a/k/c;->h()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/f;

    invoke-virtual {v0}, Lc/c/a/k/f;->a()Lc/c/a/k/d;

    move-result-object v1

    invoke-virtual {v0}, Lc/c/a/k/f;->b()Lc/c/a/k/d;

    move-result-object v0

    invoke-direct {p0, v1, p1, p3}, Lc/c/a/o/a;->f(Lc/c/a/k/d;Lc/c/a/k/d;Ljava/lang/Object;)V

    invoke-direct {p0, v0, p1, v1}, Lc/c/a/o/a;->f(Lc/c/a/k/d;Lc/c/a/k/d;Ljava/lang/Object;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance p2, Lc/c/a/h/h;

    invoke-direct {p2, p3, p3}, Lc/c/a/h/h;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;)V

    goto :goto_0

    :cond_3
    move-object p2, p1

    check-cast p2, Lc/c/a/k/g;

    iget-object p3, p0, Lc/c/a/o/a;->b:Lc/c/a/m/a;

    sget-object v0, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    invoke-virtual {p2}, Lc/c/a/k/g;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3, v0, v2, v8}, Lc/c/a/m/a;->c(Lc/c/a/k/e;Ljava/lang/String;Z)Lc/c/a/k/i;

    move-result-object p3

    iget-object v2, p0, Lc/c/a/o/a;->b:Lc/c/a/m/a;

    invoke-virtual {p2}, Lc/c/a/k/g;->g()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v0, v3, v7}, Lc/c/a/m/a;->c(Lc/c/a/k/e;Ljava/lang/String;Z)Lc/c/a/k/i;

    move-result-object v0

    new-instance v3, Lc/c/a/h/g;

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v2

    invoke-virtual {v2, p3}, Lc/c/a/k/i;->equals(Ljava/lang/Object;)Z

    move-result p3

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v2

    invoke-virtual {v2, v0}, Lc/c/a/k/i;->equals(Ljava/lang/Object;)Z

    move-result v0

    invoke-direct {v3, p3, v0}, Lc/c/a/h/g;-><init>(ZZ)V

    new-instance p3, Lc/c/a/h/k;

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object p1

    invoke-virtual {p1}, Lc/c/a/k/i;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2}, Lc/c/a/k/g;->g()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual {p2}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v7

    move-object v0, p3

    invoke-direct/range {v0 .. v7}, Lc/c/a/h/k;-><init>(Ljava/lang/String;Ljava/lang/String;Lc/c/a/h/g;Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V

    iget-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    invoke-interface {p1, p3}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    goto :goto_3

    :cond_4
    move-object p2, p1

    check-cast p2, Lc/c/a/k/h;

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    iget-object v2, p0, Lc/c/a/o/a;->b:Lc/c/a/m/a;

    sget-object v3, Lc/c/a/k/e;->c:Lc/c/a/k/e;

    invoke-virtual {v2, v3, p3, v8}, Lc/c/a/m/a;->c(Lc/c/a/k/e;Ljava/lang/String;Z)Lc/c/a/k/i;

    move-result-object v2

    invoke-virtual {v0, v2}, Lc/c/a/k/i;->equals(Ljava/lang/Object;)Z

    move-result v3

    iget-object v9, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v10, Lc/c/a/h/m;

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-virtual {v0}, Lc/c/a/k/i;->b()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {p2}, Lc/c/a/k/b;->f()Ljava/lang/Boolean;

    move-result-object v6

    move-object v0, v10

    invoke-direct/range {v0 .. v6}, Lc/c/a/h/m;-><init>(Ljava/lang/String;Ljava/lang/String;ZLc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Boolean;)V

    invoke-interface {v9, v10}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    invoke-virtual {p2}, Lc/c/a/k/h;->h()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/d;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-direct {p0, v0, p1, v1}, Lc/c/a/o/a;->f(Lc/c/a/k/d;Lc/c/a/k/d;Ljava/lang/Object;)V

    add-int/2addr v7, v8

    goto :goto_2

    :cond_5
    iget-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance p2, Lc/c/a/h/l;

    invoke-direct {p2, p3, p3}, Lc/c/a/h/l;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;)V

    goto/16 :goto_0

    :goto_3
    return-void
.end method


# virtual methods
.method public b()V
    .locals 4

    iget-object v0, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    if-eqz v0, :cond_1

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1, v0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v2, Lc/c/a/h/n;

    const/4 v3, 0x0

    invoke-direct {v2, v3, v3}, Lc/c/a/h/n;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;)V

    invoke-interface {v0, v2}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    iput-object v1, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    :cond_0
    return-void

    :cond_1
    new-instance v0, Lc/c/a/o/b;

    const-string v1, "serializer is not opened"

    invoke-direct {v0, v1}, Lc/c/a/o/b;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public d()V
    .locals 3

    iget-object v0, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v1, Lc/c/a/h/o;

    const/4 v2, 0x0

    invoke-direct {v1, v2, v2}, Lc/c/a/h/o;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;)V

    invoke-interface {v0, v1}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    iput-object v0, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    return-void

    :cond_0
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1, v0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lc/c/a/o/b;

    const-string v1, "serializer is closed"

    invoke-direct {v0, v1}, Lc/c/a/o/b;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    new-instance v0, Lc/c/a/o/b;

    const-string v1, "serializer is already opened"

    invoke-direct {v0, v1}, Lc/c/a/o/b;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public e(Lc/c/a/k/d;)V
    .locals 8

    iget-object v0, p0, Lc/c/a/o/a;->j:Ljava/lang/Boolean;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v7, Lc/c/a/h/e;

    const/4 v2, 0x0

    const/4 v3, 0x0

    iget-boolean v4, p0, Lc/c/a/o/a;->c:Z

    iget-object v5, p0, Lc/c/a/o/a;->e:[Ljava/lang/Integer;

    iget-object v6, p0, Lc/c/a/o/a;->f:Ljava/util/Map;

    move-object v1, v7

    invoke-direct/range {v1 .. v6}, Lc/c/a/h/e;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;Z[Ljava/lang/Integer;Ljava/util/Map;)V

    invoke-interface {v0, v7}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    invoke-direct {p0, p1}, Lc/c/a/o/a;->a(Lc/c/a/k/d;)V

    iget-object v0, p0, Lc/c/a/o/a;->k:Lc/c/a/k/i;

    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, v0}, Lc/c/a/o/a;->f(Lc/c/a/k/d;Lc/c/a/k/d;Ljava/lang/Object;)V

    iget-object p1, p0, Lc/c/a/o/a;->a:Lc/c/a/f/a;

    new-instance v1, Lc/c/a/h/d;

    iget-boolean v2, p0, Lc/c/a/o/a;->d:Z

    invoke-direct {v1, v0, v0, v2}, Lc/c/a/h/d;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;Z)V

    invoke-interface {p1, v1}, Lc/c/a/f/a;->a(Lc/c/a/h/f;)V

    iget-object p1, p0, Lc/c/a/o/a;->g:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->clear()V

    iget-object p1, p0, Lc/c/a/o/a;->h:Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->clear()V

    const/4 p1, 0x0

    iput p1, p0, Lc/c/a/o/a;->i:I

    return-void

    :cond_1
    new-instance p1, Lc/c/a/o/b;

    const-string v0, "serializer is closed"

    invoke-direct {p1, v0}, Lc/c/a/o/b;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    new-instance p1, Lc/c/a/o/b;

    const-string v0, "serializer is not opened"

    invoke-direct {p1, v0}, Lc/c/a/o/b;-><init>(Ljava/lang/String;)V

    throw p1
.end method
