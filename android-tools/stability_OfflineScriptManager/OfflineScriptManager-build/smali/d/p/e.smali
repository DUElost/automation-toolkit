.class public Ld/p/e;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/p/d;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ld/e;",
        ">",
        "Ljava/lang/Object;",
        "Ld/p/d<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private a:Z

.field private final b:Ld/p/a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/a<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ld/p/a;

    invoke-direct {v0}, Ld/p/a;-><init>()V

    iput-object v0, p0, Ld/p/e;->b:Ld/p/a;

    return-void
.end method


# virtual methods
.method public bridge synthetic a()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Ld/p/e;->f()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic b(Ljava/lang/Object;Z)V
    .locals 0

    check-cast p1, Ld/e;

    invoke-virtual {p0, p1, p2}, Ld/p/e;->i(Ld/e;Z)V

    return-void
.end method

.method public c()Z
    .locals 2

    iget-object v0, p0, Ld/p/e;->b:Ld/p/a;

    invoke-virtual {v0}, Ld/p/a;->a()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v1, 0x0

    iput-boolean v1, p0, Ld/p/e;->a:Z

    :cond_0
    return v0
.end method

.method public bridge synthetic d()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Ld/p/e;->g()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic e()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Ld/p/e;->h()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method public f()Ld/e;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Ld/p/e;->b:Ld/p/a;

    invoke-virtual {v0}, Ld/p/a;->b()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method public flush()Z
    .locals 1

    iget-boolean v0, p0, Ld/p/e;->a:Z

    return v0
.end method

.method public g()Ld/e;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    invoke-virtual {p0}, Ld/p/e;->c()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Ld/p/e;->b:Ld/p/a;

    invoke-virtual {v0}, Ld/p/a;->c()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method public h()Ld/e;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    const/4 v0, 0x0

    return-object v0
.end method

.method public i(Ld/e;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;Z)V"
        }
    .end annotation

    iget-object p2, p0, Ld/p/e;->b:Ld/p/a;

    invoke-virtual {p2, p1}, Ld/p/a;->d(Ld/e;)V

    return-void
.end method
