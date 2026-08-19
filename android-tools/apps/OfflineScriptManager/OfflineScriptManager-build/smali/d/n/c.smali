.class public Ld/n/c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/q/a;


# instance fields
.field private final b:Ld/q/b;

.field private final c:Ld/q/a;

.field private d:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/d;Ld/q/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Ld/n/c;->c:Ld/q/a;

    invoke-virtual {p1}, Ld/n/d;->z0()Ld/q/b;

    move-result-object p1

    iput-object p1, p0, Ld/n/c;->b:Ld/q/b;

    return-void
.end method


# virtual methods
.method public final a(Ljava/nio/channels/SelectableChannel;)Ld/q/b$a;
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1, p0}, Ld/q/b;->h(Ljava/nio/channels/SelectableChannel;Ld/q/a;)Ld/q/b$a;

    move-result-object p1

    return-object p1
.end method

.method public final b()V
    .locals 1

    iget-object v0, p0, Ld/n/c;->c:Ld/q/a;

    invoke-interface {v0}, Ld/q/a;->b()V

    return-void
.end method

.method public final c(JI)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1, p2, p0, p3}, Ld/q/b;->a(JLd/q/a;I)V

    return-void
.end method

.method public final d(I)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p0, p1}, Ld/q/b;->c(Ld/q/a;I)V

    return-void
.end method

.method public final e()V
    .locals 1

    iget-object v0, p0, Ld/n/c;->c:Ld/q/a;

    invoke-interface {v0}, Ld/q/a;->e()V

    return-void
.end method

.method public final f()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/c;->d:Z

    return-void
.end method

.method public final g(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->m(Ld/q/b$a;)V

    return-void
.end method

.method public final h(I)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->c:Ld/q/a;

    invoke-interface {v0, p1}, Ld/q/a;->h(I)V

    return-void
.end method

.method public final i(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->n(Ld/q/b$a;)V

    return-void
.end method

.method public final j(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->o(Ld/q/b$a;)V

    return-void
.end method

.method public final k(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->p(Ld/q/b$a;)V

    return-void
.end method

.method public final l(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->q(Ld/q/b$a;)V

    return-void
.end method

.method public final m(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->r(Ld/q/b$a;)V

    return-void
.end method

.method public final n(Ld/q/b$a;)V
    .locals 1

    iget-object v0, p0, Ld/n/c;->b:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->s(Ld/q/b$a;)V

    return-void
.end method

.method public final o()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/c;->d:Z

    return-void
.end method

.method public final q()V
    .locals 1

    iget-object v0, p0, Ld/n/c;->c:Ld/q/a;

    invoke-interface {v0}, Ld/q/a;->q()V

    return-void
.end method

.method public final s()V
    .locals 1

    iget-object v0, p0, Ld/n/c;->c:Ld/q/a;

    invoke-interface {v0}, Ld/q/a;->s()V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Ld/n/c;->c:Ld/q/a;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
