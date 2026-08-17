.class public abstract Lc/c/a/l/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field protected final a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "*>;",
            "Lc/c/a/l/b;",
            ">;"
        }
    .end annotation
.end field

.field protected b:Lc/c/a/l/b;

.field protected final c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "*>;",
            "Lc/c/a/l/b;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/lang/Character;

.field protected e:Lc/c/a/a$a;

.field protected final f:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Lc/c/a/k/d;",
            ">;"
        }
    .end annotation
.end field

.field protected g:Ljava/lang/Object;

.field private h:Lc/c/a/j/f;

.field private i:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    sget-object v0, Lc/c/a/a$a;->e:Lc/c/a/a$a;

    iput-object v0, p0, Lc/c/a/l/a;->e:Lc/c/a/a$a;

    new-instance v0, Lc/c/a/l/a$a;

    invoke-direct {v0, p0}, Lc/c/a/l/a$a;-><init>(Lc/c/a/l/a;)V

    iput-object v0, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lc/c/a/l/a;->i:Z

    return-void
.end method


# virtual methods
.method public final a()Lc/c/a/j/f;
    .locals 1

    iget-object v0, p0, Lc/c/a/l/a;->h:Lc/c/a/j/f;

    if-nez v0, :cond_0

    new-instance v0, Lc/c/a/j/f;

    invoke-direct {v0}, Lc/c/a/j/f;-><init>()V

    iput-object v0, p0, Lc/c/a/l/a;->h:Lc/c/a/j/f;

    :cond_0
    iget-object v0, p0, Lc/c/a/l/a;->h:Lc/c/a/j/f;

    return-object v0
.end method

.method public final b()Z
    .locals 1

    iget-boolean v0, p0, Lc/c/a/l/a;->i:Z

    return v0
.end method

.method public c(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 1

    invoke-virtual {p0, p1}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p1

    iget-object v0, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    const/4 v0, 0x0

    iput-object v0, p0, Lc/c/a/l/a;->g:Ljava/lang/Object;

    return-object p1
.end method

.method protected final d(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 4

    iput-object p1, p0, Lc/c/a/l/a;->g:Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    iget-object v0, p0, Lc/c/a/l/a;->g:Ljava/lang/Object;

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lc/c/a/k/d;

    return-object p1

    :cond_0
    if-nez p1, :cond_1

    iget-object v0, p0, Lc/c/a/l/a;->b:Lc/c/a/l/b;

    invoke-interface {v0, p1}, Lc/c/a/l/b;->a(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1

    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    iget-object v1, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :goto_0
    check-cast v0, Lc/c/a/l/b;

    invoke-interface {v0, p1}, Lc/c/a/l/b;->a(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p1

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Class;

    invoke-virtual {v2, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/l/b;

    invoke-interface {v0, p1}, Lc/c/a/l/b;->a(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1

    :cond_4
    invoke-virtual {v0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    goto :goto_1

    :cond_5
    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    :goto_1
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :goto_2
    return-object p1

    :cond_6
    new-instance p1, Lc/c/a/g/b;

    const-string v0, "Arrays of primitives are not fully supported."

    invoke-direct {p1, v0}, Lc/c/a/g/b;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected e(Lc/c/a/k/i;Ljava/util/Map;Ljava/lang/Boolean;)Lc/c/a/k/d;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lc/c/a/k/i;",
            "Ljava/util/Map<",
            "+",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/Boolean;",
            ")",
            "Lc/c/a/k/d;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v1, Lc/c/a/k/c;

    invoke-direct {v1, p1, v0, p3}, Lc/c/a/k/c;-><init>(Lc/c/a/k/i;Ljava/util/List;Ljava/lang/Boolean;)V

    iget-object p1, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    iget-object v2, p0, Lc/c/a/l/a;->g:Ljava/lang/Object;

    invoke-interface {p1, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    const/4 v2, 0x1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {p2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {p0, v3}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object v3

    invoke-virtual {p0, v4}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object v4

    instance-of v5, v3, Lc/c/a/k/g;

    const/4 v6, 0x0

    if-eqz v5, :cond_0

    move-object v5, v3

    check-cast v5, Lc/c/a/k/g;

    invoke-virtual {v5}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v5

    if-eqz v5, :cond_1

    :cond_0
    move v2, v6

    :cond_1
    instance-of v5, v4, Lc/c/a/k/g;

    if-eqz v5, :cond_2

    move-object v5, v4

    check-cast v5, Lc/c/a/k/g;

    invoke-virtual {v5}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v5

    if-eqz v5, :cond_3

    :cond_2
    move v2, v6

    :cond_3
    new-instance v5, Lc/c/a/k/f;

    invoke-direct {v5, v3, v4}, Lc/c/a/k/f;-><init>(Lc/c/a/k/d;Lc/c/a/k/d;)V

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    if-nez p3, :cond_6

    iget-object p1, p0, Lc/c/a/l/a;->e:Lc/c/a/a$a;

    sget-object p2, Lc/c/a/a$a;->e:Lc/c/a/a$a;

    if-eq p1, p2, :cond_5

    invoke-virtual {p1}, Lc/c/a/a$a;->a()Ljava/lang/Boolean;

    move-result-object p1

    goto :goto_1

    :cond_5
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    :goto_1
    invoke-virtual {v1, p1}, Lc/c/a/k/b;->g(Ljava/lang/Boolean;)V

    :cond_6
    return-object v1
.end method

.method protected f(Lc/c/a/k/i;Ljava/lang/String;)Lc/c/a/k/d;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lc/c/a/l/a;->g(Lc/c/a/k/i;Ljava/lang/String;Ljava/lang/Character;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method

.method protected g(Lc/c/a/k/i;Ljava/lang/String;Ljava/lang/Character;)Lc/c/a/k/d;
    .locals 6

    if-nez p3, :cond_0

    iget-object p3, p0, Lc/c/a/l/a;->d:Ljava/lang/Character;

    :cond_0
    move-object v5, p3

    new-instance p3, Lc/c/a/k/g;

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p3

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lc/c/a/k/g;-><init>(Lc/c/a/k/i;Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V

    return-object p3
.end method

.method protected h(Lc/c/a/k/i;Ljava/lang/Iterable;Ljava/lang/Boolean;)Lc/c/a/k/d;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lc/c/a/k/i;",
            "Ljava/lang/Iterable<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/Boolean;",
            ")",
            "Lc/c/a/k/d;"
        }
    .end annotation

    instance-of v0, p2, Ljava/util/List;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    goto :goto_0

    :cond_0
    const/16 v0, 0xa

    :goto_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v0, Lc/c/a/k/h;

    invoke-direct {v0, p1, v1, p3}, Lc/c/a/k/h;-><init>(Lc/c/a/k/i;Ljava/util/List;Ljava/lang/Boolean;)V

    iget-object p1, p0, Lc/c/a/l/a;->f:Ljava/util/Map;

    iget-object v2, p0, Lc/c/a/l/a;->g:Ljava/lang/Object;

    invoke-interface {p1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 p1, 0x1

    invoke-interface {p2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p0, v2}, Lc/c/a/l/a;->d(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object v2

    instance-of v3, v2, Lc/c/a/k/g;

    if-eqz v3, :cond_1

    move-object v3, v2

    check-cast v3, Lc/c/a/k/g;

    invoke-virtual {v3}, Lc/c/a/k/g;->f()Ljava/lang/Character;

    move-result-object v3

    if-eqz v3, :cond_2

    :cond_1
    const/4 p1, 0x0

    :cond_2
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_3
    if-nez p3, :cond_5

    iget-object p2, p0, Lc/c/a/l/a;->e:Lc/c/a/a$a;

    sget-object p3, Lc/c/a/a$a;->e:Lc/c/a/a$a;

    if-eq p2, p3, :cond_4

    invoke-virtual {p2}, Lc/c/a/a$a;->a()Ljava/lang/Boolean;

    move-result-object p1

    goto :goto_2

    :cond_4
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    :goto_2
    invoke-virtual {v0, p1}, Lc/c/a/k/b;->g(Ljava/lang/Boolean;)V

    :cond_5
    return-object v0
.end method

.method public i(Lc/c/a/a$a;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/a;->e:Lc/c/a/a$a;

    return-void
.end method

.method public j(Lc/c/a/a$c;)V
    .locals 0

    invoke-virtual {p1}, Lc/c/a/a$c;->b()Ljava/lang/Character;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/l/a;->d:Ljava/lang/Character;

    return-void
.end method

.method public k(Lc/c/a/j/f;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/a;->h:Lc/c/a/j/f;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lc/c/a/l/a;->i:Z

    return-void
.end method
