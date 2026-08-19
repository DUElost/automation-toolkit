.class public Lc/c/a/l/c;
.super Lc/c/a/l/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lc/c/a/l/c$a;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lc/c/a/l/d;-><init>()V

    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    new-instance v1, Lc/c/a/l/c$a;

    invoke-direct {v1, p0}, Lc/c/a/l/c$a;-><init>(Lc/c/a/l/c;)V

    const/4 v2, 0x0

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private q(Ljava/lang/Class;Lc/c/a/k/d;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Lc/c/a/k/d;",
            ")V"
        }
    .end annotation

    invoke-virtual {p2}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lc/c/a/k/i;->c(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-class v0, Ljava/lang/Enum;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lc/c/a/k/i;->o:Lc/c/a/k/i;

    goto :goto_0

    :cond_0
    sget-object p1, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    :goto_0
    invoke-virtual {p2, p1}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    :cond_1
    return-void
.end method


# virtual methods
.method protected m(Lc/c/a/j/e;Lc/c/a/k/d;Ljava/lang/Object;)V
    .locals 3

    invoke-virtual {p1}, Lc/c/a/j/e;->c()[Ljava/lang/Class;

    move-result-object p1

    if-eqz p1, :cond_5

    invoke-virtual {p2}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v0

    sget-object v1, Lc/c/a/k/e;->c:Lc/c/a/k/e;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_2

    aget-object p1, p1, v2

    check-cast p2, Lc/c/a/k/h;

    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_0

    check-cast p3, [Ljava/lang/Object;

    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p3

    goto :goto_0

    :cond_0
    check-cast p3, Ljava/lang/Iterable;

    :goto_0
    invoke-interface {p3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p3

    invoke-virtual {p2}, Lc/c/a/k/h;->h()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_1
    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/d;

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v1

    sget-object v2, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    if-ne v1, v2, :cond_1

    sget-object v1, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    invoke-virtual {v0, v1}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    goto :goto_1

    :cond_2
    instance-of v0, p3, Ljava/util/Set;

    if-eqz v0, :cond_4

    aget-object p1, p1, v2

    check-cast p2, Lc/c/a/k/c;

    invoke-virtual {p2}, Lc/c/a/k/c;->h()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    check-cast p3, Ljava/util/Set;

    invoke-interface {p3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_3
    :goto_2
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lc/c/a/k/f;

    invoke-virtual {v1}, Lc/c/a/k/f;->a()Lc/c/a/k/d;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {v1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v0

    sget-object v2, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    if-ne v0, v2, :cond_3

    sget-object v0, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    invoke-virtual {v1, v0}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    goto :goto_2

    :cond_4
    instance-of p3, p3, Ljava/util/Map;

    if-eqz p3, :cond_5

    aget-object p3, p1, v2

    const/4 v0, 0x1

    aget-object p1, p1, v0

    check-cast p2, Lc/c/a/k/c;

    invoke-virtual {p2}, Lc/c/a/k/c;->h()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_3
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/k/f;

    invoke-virtual {v0}, Lc/c/a/k/f;->a()Lc/c/a/k/d;

    move-result-object v1

    invoke-direct {p0, p3, v1}, Lc/c/a/l/c;->q(Ljava/lang/Class;Lc/c/a/k/d;)V

    invoke-virtual {v0}, Lc/c/a/k/f;->b()Lc/c/a/k/d;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lc/c/a/l/c;->q(Ljava/lang/Class;Lc/c/a/k/d;)V

    goto :goto_3

    :cond_5
    return-void
.end method

.method protected n(Ljava/lang/Class;)Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/util/Set<",
            "Lc/c/a/j/e;",
            ">;"
        }
    .end annotation

    invoke-virtual {p0}, Lc/c/a/l/a;->a()Lc/c/a/j/f;

    move-result-object v0

    invoke-virtual {v0, p1}, Lc/c/a/j/f;->b(Ljava/lang/Class;)Ljava/util/Set;

    move-result-object p1

    return-object p1
.end method

.method protected o(Ljava/util/Set;Ljava/lang/Object;)Lc/c/a/k/c;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Lc/c/a/j/e;",
            ">;",
            "Ljava/lang/Object;",
            ")",
            "Lc/c/a/k/c;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v1, p0, Lc/c/a/l/d;->j:Ljava/util/Map;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lc/c/a/k/i;

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance v1, Lc/c/a/k/i;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-direct {v1, v2}, Lc/c/a/k/i;-><init>(Ljava/lang/Class;)V

    :goto_0
    new-instance v2, Lc/c/a/k/c;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v0, v3}, Lc/c/a/k/c;-><init>(Lc/c/a/k/i;Ljava/util/List;Ljava/lang/Boolean;)V

    iget-object v1, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    invoke-interface {v1, p2, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lc/c/a/j/e;

    invoke-virtual {v4, p2}, Lc/c/a/j/e;->b(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    if-nez v5, :cond_1

    move-object v6, v3

    goto :goto_2

    :cond_1
    iget-object v6, p0, Lc/c/a/l/d;->j:Ljava/util/Map;

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lc/c/a/k/i;

    :goto_2
    invoke-virtual {p0, p2, v4, v5, v6}, Lc/c/a/l/c;->p(Ljava/lang/Object;Lc/c/a/j/e;Ljava/lang/Object;Lc/c/a/k/i;)Lc/c/a/k/f;

    move-result-object v4

    if-nez v4, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v4}, Lc/c/a/k/f;->a()Lc/c/a/k/d;

    move-result-object v5

    check-cast v5, Lc/c/a/k/g;

    invoke-virtual {v5}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v5

    const/4 v6, 0x0

    if-eqz v5, :cond_3

    move v1, v6

    :cond_3
    invoke-virtual {v4}, Lc/c/a/k/f;->b()Lc/c/a/k/d;

    move-result-object v5

    instance-of v7, v5, Lc/c/a/k/g;

    if-eqz v7, :cond_4

    check-cast v5, Lc/c/a/k/g;

    invoke-virtual {v5}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v5

    if-eqz v5, :cond_5

    :cond_4
    move v1, v6

    :cond_5
    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_6
    iget-object p1, p0, Lc/c/a/l/a;->e:Lc/c/a/a$a;

    sget-object p2, Lc/c/a/a$a;->e:Lc/c/a/a$a;

    if-eq p1, p2, :cond_7

    invoke-virtual {p1}, Lc/c/a/a$a;->a()Ljava/lang/Boolean;

    move-result-object p1

    goto :goto_3

    :cond_7
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    :goto_3
    invoke-virtual {v2, p1}, Lc/c/a/k/b;->g(Ljava/lang/Boolean;)V

    return-object v2
.end method

.method protected p(Ljava/lang/Object;Lc/c/a/j/e;Ljava/lang/Object;Lc/c/a/k/i;)Lc/c/a/k/f;
    .locals 2

    invoke-virtual {p2}, Lc/c/a/j/e;->d()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p1

    check-cast p1, Lc/c/a/k/g;

    iget-object v0, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    invoke-interface {v0, p3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    invoke-virtual {p0, p3}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object v1

    if-eqz p3, :cond_2

    if-nez v0, :cond_2

    invoke-virtual {v1}, Lc/c/a/k/d;->b()Lc/c/a/k/e;

    move-result-object v0

    if-nez p4, :cond_2

    sget-object p4, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    if-ne v0, p4, :cond_0

    instance-of p2, p3, Ljava/lang/Enum;

    if-eqz p2, :cond_2

    sget-object p2, Lc/c/a/k/i;->o:Lc/c/a/k/i;

    invoke-virtual {v1, p2}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    goto :goto_0

    :cond_0
    sget-object p4, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    if-ne v0, p4, :cond_1

    invoke-virtual {p2}, Lc/c/a/j/e;->e()Ljava/lang/Class;

    move-result-object p4

    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    if-ne p4, v0, :cond_1

    instance-of p4, p3, Ljava/util/Map;

    if-nez p4, :cond_1

    invoke-virtual {v1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object p4

    sget-object v0, Lc/c/a/k/i;->f:Lc/c/a/k/i;

    invoke-virtual {p4, v0}, Lc/c/a/k/i;->equals(Ljava/lang/Object;)Z

    move-result p4

    if-nez p4, :cond_1

    sget-object p4, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    invoke-virtual {v1, p4}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    :cond_1
    invoke-virtual {p0, p2, v1, p3}, Lc/c/a/l/c;->m(Lc/c/a/j/e;Lc/c/a/k/d;Ljava/lang/Object;)V

    :cond_2
    :goto_0
    new-instance p2, Lc/c/a/k/f;

    invoke-direct {p2, p1, v1}, Lc/c/a/k/f;-><init>(Lc/c/a/k/d;Lc/c/a/k/d;)V

    return-object p2
.end method
