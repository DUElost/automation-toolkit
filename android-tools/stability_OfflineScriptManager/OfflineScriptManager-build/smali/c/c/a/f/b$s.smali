.class Lc/c/a/f/b$s;
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
    name = "s"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/f/b;


# direct methods
.method private constructor <init>(Lc/c/a/f/b;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$s;->a:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b$s;-><init>(Lc/c/a/f/b;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    iget-object v0, p0, Lc/c/a/f/b$s;->a:Lc/c/a/f/b;

    invoke-static {v0}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/o;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b$s;->a:Lc/c/a/f/b;

    invoke-virtual {v0}, Lc/c/a/f/b;->e0()V

    iget-object v0, p0, Lc/c/a/f/b$s;->a:Lc/c/a/f/b;

    new-instance v1, Lc/c/a/f/b$k;

    const/4 v2, 0x0

    invoke-direct {v1, v0, v2}, Lc/c/a/f/b$k;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    invoke-static {v0, v1}, Lc/c/a/f/b;->j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;

    return-void

    :cond_0
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "expected StreamStartEvent, but got "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lc/c/a/f/b$s;->a:Lc/c/a/f/b;

    invoke-static {v2}, Lc/c/a/f/b;->b(Lc/c/a/f/b;)Lc/c/a/h/f;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0
.end method
