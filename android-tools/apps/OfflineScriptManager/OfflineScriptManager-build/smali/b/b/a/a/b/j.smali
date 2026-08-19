.class public Lb/b/a/a/b/j;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/b/b;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Lb/b/a/a/b/h;

.field private g:Lb/b/a/a/b/c;

.field private h:Z

.field private i:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lb/b/a/a/b/j;->h:Z

    iput-boolean v0, p0, Lb/b/a/a/b/j;->i:Z

    iput-object p1, p0, Lb/b/a/a/b/j;->c:Ljava/lang/String;

    iput-object p2, p0, Lb/b/a/a/b/j;->a:Ljava/lang/String;

    return-void
.end method

.method private e(Lb/b/a/a/b/c;Ljava/lang/String;)V
    .locals 9

    const-string v0, "\n"

    invoke-virtual {p2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {p1, p2}, Lb/b/a/a/b/c;->k(Ljava/lang/String;)V

    if-nez v1, :cond_0

    return-void

    :cond_0
    const-string p2, ""

    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    move-object v2, p2

    :goto_0
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    if-ge v3, v5, :cond_5

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const-string v6, "INSTRUMENTATION_PIC="

    invoke-virtual {v5, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    const/4 v7, -0x1

    if-eq v5, v7, :cond_2

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    add-int/lit8 v5, v5, 0x14

    invoke-virtual {v2, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    invoke-interface {p1, v2}, Lb/b/a/a/b/c;->d(Ljava/lang/String;)V

    :cond_1
    const/4 v4, 0x1

    :cond_2
    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const-string v8, "Caused by:"

    invoke-virtual {v5, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    if-eq v5, v7, :cond_3

    if-eqz v4, :cond_3

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-virtual {p2, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_1

    :cond_3
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_4
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    :cond_5
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_6

    invoke-interface {p1, p2}, Lb/b/a/a/b/c;->k(Ljava/lang/String;)V

    :cond_6
    return-void
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    const-string v0, "uiautomator"

    return-object v0
.end method


# virtual methods
.method public a(Lb/b/a/a/b/h;)V
    .locals 1

    iput-object p1, p0, Lb/b/a/a/b/j;->f:Lb/b/a/a/b/h;

    new-instance p1, Lb/b/a/a/b/f;

    invoke-direct {p1}, Lb/b/a/a/b/f;-><init>()V

    iput-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/j;->c:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/j;->d:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->j(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/j;->e:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->e(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/j;->a:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->h(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/j;->b:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->c(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    sget-object v0, Lb/b/a/a/b/g;->f:Lb/b/a/a/b/g;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-static {}, Lb/b/a/a/b/j;->f()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/j;->f:Lb/b/a/a/b/h;

    iget-object v0, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-virtual {p1, v0}, Lb/b/a/a/b/h;->b(Lb/b/a/a/b/c;)V

    return-void
.end method

.method public b()V
    .locals 4

    iget-boolean v0, p0, Lb/b/a/a/b/j;->h:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/b/a/a/b/j;->h:Z

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v1

    iget-object v3, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-interface {v3, v1, v2}, Lb/b/a/a/b/c;->m(J)V

    iget-object v3, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-interface {v3, v1, v2}, Lb/b/a/a/b/c;->n(J)V

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/g;->y(J)Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v3

    const-string v1, "start time %s"

    invoke-static {v1, v0}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public c()V
    .locals 6

    iget-boolean v0, p0, Lb/b/a/a/b/j;->i:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/b/a/a/b/j;->i:Z

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v1

    iget-object v3, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-interface {v3, v1, v2}, Lb/b/a/a/b/c;->n(J)V

    iget-object v3, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-interface {v3}, Lb/b/a/a/b/c;->o()Lb/b/a/a/b/g;

    move-result-object v3

    sget-object v4, Lb/b/a/a/b/g;->f:Lb/b/a/a/b/g;

    const/4 v5, 0x0

    if-ne v3, v4, :cond_1

    iget-object v3, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    sget-object v4, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    invoke-interface {v3, v4}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lb/b/a/a/b/j;->d:Ljava/lang/String;

    aput-object v4, v3, v5

    iget-object v4, p0, Lb/b/a/a/b/j;->e:Ljava/lang/String;

    aput-object v4, v3, v0

    const-string v4, "%s#%s pass"

    invoke-static {v4, v3}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/g;->y(J)Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v5

    const-string v1, "end time %s"

    invoke-static {v1, v0}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    sget-object v1, Lb/b/a/a/b/g;->e:Lb/b/a/a/b/g;

    invoke-interface {v0, v1}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    iget-object v0, p0, Lb/b/a/a/b/j;->f:Lb/b/a/a/b/h;

    invoke-virtual {v0, v1}, Lb/b/a/a/b/h;->o(Lb/b/a/a/b/g;)V

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/g;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lb/b/a/a/b/j;->g:Lb/b/a/a/b/c;

    invoke-direct {p0, v0, p1}, Lb/b/a/a/b/j;->e(Lb/b/a/a/b/c;Ljava/lang/String;)V

    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/Object;

    iget-object v0, p0, Lb/b/a/a/b/j;->d:Ljava/lang/String;

    const/4 v1, 0x0

    aput-object v0, p1, v1

    iget-object v0, p0, Lb/b/a/a/b/j;->e:Ljava/lang/String;

    const/4 v1, 0x1

    aput-object v0, p1, v1

    const-string v0, "%s#%s  fail"

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/b/j;->d:Ljava/lang/String;

    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/b/j;->b:Ljava/lang/String;

    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/b/j;->e:Ljava/lang/String;

    return-void
.end method
