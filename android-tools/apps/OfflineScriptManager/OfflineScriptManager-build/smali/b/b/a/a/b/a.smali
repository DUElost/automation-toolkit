.class public Lb/b/a/a/b/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/b/a/a/b/b;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Lb/b/a/a/b/h;

.field private d:Lb/b/a/a/b/c;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    iput-object p1, p0, Lb/b/a/a/b/a;->a:Ljava/lang/String;

    iput-object p2, p0, Lb/b/a/a/b/a;->b:Ljava/lang/String;

    return-void
.end method

.method public static e()Ljava/lang/String;
    .locals 1

    const-string v0, "adb"

    return-object v0
.end method


# virtual methods
.method public a(Lb/b/a/a/b/h;)V
    .locals 1

    iput-object p1, p0, Lb/b/a/a/b/a;->c:Lb/b/a/a/b/h;

    new-instance p1, Lb/b/a/a/b/f;

    invoke-direct {p1}, Lb/b/a/a/b/f;-><init>()V

    iput-object p1, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/a;->a:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    iget-object v0, p0, Lb/b/a/a/b/a;->b:Ljava/lang/String;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->h(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    sget-object v0, Lb/b/a/a/b/g;->f:Lb/b/a/a/b/g;

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    iget-object p1, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-static {}, Lb/b/a/a/b/a;->e()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lb/b/a/a/b/c;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lb/b/a/a/b/a;->c:Lb/b/a/a/b/h;

    iget-object v0, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-virtual {p1, v0}, Lb/b/a/a/b/h;->b(Lb/b/a/a/b/c;)V

    return-void
.end method

.method public b()V
    .locals 3

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v0

    iget-object v2, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-interface {v2, v0, v1}, Lb/b/a/a/b/c;->m(J)V

    iget-object v2, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-interface {v2, v0, v1}, Lb/b/a/a/b/c;->n(J)V

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/g;->y(J)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aput-object v0, v2, v1

    iget-object v0, p0, Lb/b/a/a/b/a;->a:Ljava/lang/String;

    const/4 v1, 0x1

    aput-object v0, v2, v1

    const-string v0, "start time %s %s"

    invoke-static {v0, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public c()V
    .locals 6

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/g;->m()J

    move-result-wide v0

    iget-object v2, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-interface {v2, v0, v1}, Lb/b/a/a/b/c;->n(J)V

    iget-object v2, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-interface {v2}, Lb/b/a/a/b/c;->o()Lb/b/a/a/b/g;

    move-result-object v2

    sget-object v3, Lb/b/a/a/b/g;->f:Lb/b/a/a/b/g;

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-ne v2, v3, :cond_0

    iget-object v2, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    sget-object v3, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    invoke-interface {v2, v3}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    new-array v2, v5, [Ljava/lang/Object;

    iget-object v3, p0, Lb/b/a/a/b/a;->a:Ljava/lang/String;

    aput-object v3, v2, v4

    const-string v3, "%s pass"

    invoke-static {v3, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/g;->y(J)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v4

    const-string v0, "end time %s"

    invoke-static {v0, v2}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    sget-object v1, Lb/b/a/a/b/g;->e:Lb/b/a/a/b/g;

    invoke-interface {v0, v1}, Lb/b/a/a/b/c;->g(Lb/b/a/a/b/g;)V

    iget-object v0, p0, Lb/b/a/a/b/a;->c:Lb/b/a/a/b/h;

    invoke-virtual {v0, v1}, Lb/b/a/a/b/h;->o(Lb/b/a/a/b/g;)V

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/g;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lb/b/a/a/b/a;->d:Lb/b/a/a/b/c;

    invoke-interface {v0, p1}, Lb/b/a/a/b/c;->k(Ljava/lang/String;)V

    const/4 p1, 0x1

    new-array p1, p1, [Ljava/lang/Object;

    iget-object v0, p0, Lb/b/a/a/b/a;->a:Ljava/lang/String;

    const/4 v1, 0x0

    aput-object v0, p1, v1

    const-string v0, "%s fail"

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
