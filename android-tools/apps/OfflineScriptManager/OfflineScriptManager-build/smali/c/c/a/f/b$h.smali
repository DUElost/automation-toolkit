.class Lc/c/a/f/b$h;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/c/a/f/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/f/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "h"
.end annotation


# instance fields
.field private a:Z

.field final synthetic b:Lc/c/a/f/b;


# direct methods
.method public constructor <init>(Lc/c/a/f/b;Z)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p2, p0, Lc/c/a/f/b$h;->a:Z

    return-void
.end method


# virtual methods
.method public a()V
    .locals 8

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/e;

    const/4 v1, 0x0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    check-cast v0, Lc/c/a/h/e;

    invoke-virtual {v0}, Lc/c/a/h/e;->d()[Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v0}, Lc/c/a/h/e;->c()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    :cond_0
    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v2}, Lc/c/a/f/b;->o(Lc/c/a/f/b;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    const-string v5, "..."

    invoke-virtual {v2, v5, v3, v4, v4}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v2}, Lc/c/a/f/b;->X()V

    :cond_1
    invoke-virtual {v0}, Lc/c/a/h/e;->d()[Ljava/lang/Integer;

    move-result-object v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/h/e;->d()[Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v2, v5}, Lc/c/a/f/b;->p(Lc/c/a/f/b;[Ljava/lang/Integer;)Ljava/lang/String;

    move-result-object v2

    iget-object v5, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v5, v2}, Lc/c/a/f/b;->g0(Ljava/lang/String;)V

    :cond_2
    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-static {}, Lc/c/a/f/b;->s()Ljava/util/Map;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V

    invoke-static {v2, v5}, Lc/c/a/f/b;->r(Lc/c/a/f/b;Ljava/util/Map;)Ljava/util/Map;

    invoke-virtual {v0}, Lc/c/a/h/e;->c()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_3

    new-instance v2, Ljava/util/TreeSet;

    invoke-virtual {v0}, Lc/c/a/h/e;->c()Ljava/util/Map;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/util/TreeSet;-><init>(Ljava/util/Collection;)V

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v0}, Lc/c/a/h/e;->c()Ljava/util/Map;

    move-result-object v6

    invoke-interface {v6, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    iget-object v7, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v7}, Lc/c/a/f/b;->q(Lc/c/a/f/b;)Ljava/util/Map;

    move-result-object v7

    invoke-interface {v7, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v7, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v7, v5}, Lc/c/a/f/b;->t(Lc/c/a/f/b;Ljava/lang/String;)Ljava/lang/String;

    iget-object v7, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v7, v6}, Lc/c/a/f/b;->u(Lc/c/a/f/b;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iget-object v7, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v7, v5, v6}, Lc/c/a/f/b;->f0(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    iget-boolean v2, p0, Lc/c/a/f/b$h;->a:Z

    if-eqz v2, :cond_4

    invoke-virtual {v0}, Lc/c/a/h/e;->b()Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v2}, Lc/c/a/f/b;->c(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-nez v2, :cond_4

    invoke-virtual {v0}, Lc/c/a/h/e;->d()[Ljava/lang/Integer;

    move-result-object v2

    if-nez v2, :cond_4

    invoke-virtual {v0}, Lc/c/a/h/e;->c()Ljava/util/Map;

    move-result-object v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->d(Lc/c/a/f/b;)Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v3

    goto :goto_1

    :cond_4
    move v0, v4

    :goto_1
    if-nez v0, :cond_5

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    const-string v2, "---"

    invoke-virtual {v0, v2, v3, v4, v4}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->c(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    :cond_5
    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    new-instance v2, Lc/c/a/f/b$g;

    invoke-direct {v2, v0, v1}, Lc/c/a/f/b$g;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    goto :goto_2

    :cond_6
    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/n;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->d0()V

    iget-object v0, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    new-instance v2, Lc/c/a/f/b$r;

    invoke-direct {v2, v0, v1}, Lc/c/a/f/b$r;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    :goto_2
    invoke-static {v0, v2}, Lc/c/a/f/b;->j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;

    return-void

    :cond_7
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "expected DocumentStartEvent, but got "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lc/c/a/f/b$h;->b:Lc/c/a/f/b;

    invoke-static {v2}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0
.end method
