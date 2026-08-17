.class Lc/c/a/f/b$o;
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
    name = "o"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/f/b;


# direct methods
.method private constructor <init>(Lc/c/a/f/b;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$o;->a:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b$o;-><init>(Lc/c/a/f/b;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 5

    iget-object v0, p0, Lc/c/a/f/b$o;->a:Lc/c/a/f/b;

    const-string v1, ":"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget-object v0, p0, Lc/c/a/f/b$o;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->e(Lc/c/a/f/b;)Lc/c/a/p/a;

    move-result-object v0

    new-instance v1, Lc/c/a/f/b$n;

    iget-object v3, p0, Lc/c/a/f/b$o;->a:Lc/c/a/f/b;

    const/4 v4, 0x0

    invoke-direct {v1, v3, v4}, Lc/c/a/f/b$n;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    invoke-virtual {v0, v1}, Lc/c/a/p/a;->b(Ljava/lang/Object;)V

    iget-object v0, p0, Lc/c/a/f/b$o;->a:Lc/c/a/f/b;

    const/4 v1, 0x1

    invoke-static {v0, v2, v2, v1, v2}, Lc/c/a/f/b;->f(Lc/c/a/f/b;ZZZZ)V

    return-void
.end method
