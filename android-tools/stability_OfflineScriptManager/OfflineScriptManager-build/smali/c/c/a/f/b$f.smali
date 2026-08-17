.class Lc/c/a/f/b$f;
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
    name = "f"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/f/b;


# direct methods
.method private constructor <init>(Lc/c/a/f/b;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b$f;-><init>(Lc/c/a/f/b;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 4

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/d;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    check-cast v0, Lc/c/a/h/d;

    invoke-virtual {v0}, Lc/c/a/h/d;->b()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    const/4 v2, 0x1

    const-string v3, "..."

    invoke-virtual {v0, v3, v2, v1, v1}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->X()V

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->J()V

    iget-object v0, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    new-instance v2, Lc/c/a/f/b$h;

    invoke-direct {v2, v0, v1}, Lc/c/a/f/b$h;-><init>(Lc/c/a/f/b;Z)V

    invoke-static {v0, v2}, Lc/c/a/f/b;->j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;

    return-void

    :cond_1
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "expected DocumentEndEvent, but got "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lc/c/a/f/b$f;->a:Lc/c/a/f/b;

    invoke-static {v2}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0
.end method
