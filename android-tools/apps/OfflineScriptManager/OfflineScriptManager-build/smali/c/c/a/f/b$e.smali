.class Lc/c/a/f/b$e;
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
    name = "e"
.end annotation


# instance fields
.field private a:Z

.field final synthetic b:Lc/c/a/f/b;


# direct methods
.method public constructor <init>(Lc/c/a/f/b;Z)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p2, p0, Lc/c/a/f/b$e;->a:Z

    return-void
.end method


# virtual methods
.method public a()V
    .locals 5

    iget-boolean v0, p0, Lc/c/a/f/b$e;->a:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/l;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->h(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v1

    invoke-virtual {v1}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-static {v0, v1}, Lc/c/a/f/b;->g(Lc/c/a/f/b;Ljava/lang/Integer;)Ljava/lang/Integer;

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->e(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v1

    invoke-virtual {v1}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lc/c/a/f/d;

    invoke-static {v0, v1}, Lc/c/a/f/b;->j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    const-string v1, "-"

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->e(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v0

    new-instance v1, Lc/c/a/f/b$e;

    iget-object v4, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-direct {v1, v4, v3}, Lc/c/a/f/b$e;-><init>(Lc/c/a/f/b;Z)V

    invoke-virtual {v0, v1}, Lc/c/a/p/a;->b(Ljava/lang/Object;)V

    iget-object v0, p0, Lc/c/a/f/b$e;->b:Lc/c/a/f/b;

    invoke-static {v0, v3, v2, v3, v3}, Lc/c/a/f/b;->f(Lc/c/a/f/b;ZZZZ)V

    :goto_0
    return-void
.end method
