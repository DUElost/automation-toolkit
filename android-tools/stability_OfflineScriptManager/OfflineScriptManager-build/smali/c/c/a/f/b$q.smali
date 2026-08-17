.class Lc/c/a/f/b$q;
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
    name = "q"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/f/b;


# direct methods
.method private constructor <init>(Lc/c/a/f/b;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b$q;-><init>(Lc/c/a/f/b;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 4

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/l;

    const-string v1, ","

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->h(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v3

    invoke-virtual {v3}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-static {v0, v3}, Lc/c/a/f/b;->g(Lc/c/a/f/b;Ljava/lang/Integer;)Ljava/lang/Integer;

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->i(Lc/c/a/f/b;)I

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->c(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-virtual {v0, v1, v2, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    const-string v1, "]"

    invoke-virtual {v0, v1, v2, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->m(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    :cond_1
    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->e(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v1

    invoke-virtual {v1}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lc/c/a/f/d;

    invoke-static {v0, v1}, Lc/c/a/f/b;->j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-virtual {v0, v1, v2, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->c(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->k(Lc/c/a/f/b;)I

    move-result v0

    iget-object v1, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v1}, Lc/c/a/f/b;->l(Lc/c/a/f/b;)I

    move-result v1

    if-gt v0, v1, :cond_3

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->m(Lc/c/a/f/b;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    :cond_4
    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->e(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v0

    new-instance v1, Lc/c/a/f/b$q;

    iget-object v3, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    invoke-direct {v1, v3}, Lc/c/a/f/b$q;-><init>(Lc/c/a/f/b;)V

    invoke-virtual {v0, v1}, Lc/c/a/p/a;->b(Ljava/lang/Object;)V

    iget-object v0, p0, Lc/c/a/f/b$q;->a:Lc/c/a/f/b;

    const/4 v1, 0x1

    invoke-static {v0, v2, v1, v2, v2}, Lc/c/a/f/b;->f(Lc/c/a/f/b;ZZZZ)V

    :goto_0
    return-void
.end method
