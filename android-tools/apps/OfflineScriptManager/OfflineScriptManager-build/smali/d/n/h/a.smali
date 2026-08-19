.class public abstract Ld/n/h/a;
.super Ld/n/h/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/h/a$a;,
        Ld/n/h/a$b;,
        Ld/n/h/a$c;,
        Ld/n/h/a$d;
    }
.end annotation


# instance fields
.field protected final h:J

.field protected i:Ld/e;

.field protected final j:Ld/n/h/e$a;

.field protected final k:Ld/n/h/e$a;

.field protected final l:Ld/n/h/e$a;

.field protected final m:Ld/n/h/e$a;

.field private final n:Ld/o/a;


# direct methods
.method public constructor <init>(Ld/s/c;IJLd/o/a;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/h/b;-><init>(Ld/s/c;I)V

    new-instance p1, Ld/n/h/a$d;

    const/4 p2, 0x0

    invoke-direct {p1, p0, p2}, Ld/n/h/a$d;-><init>(Ld/n/h/a;Ld/n/h/a$d;)V

    iput-object p1, p0, Ld/n/h/a;->j:Ld/n/h/e$a;

    new-instance p1, Ld/n/h/a$a;

    invoke-direct {p1, p0, p2}, Ld/n/h/a$a;-><init>(Ld/n/h/a;Ld/n/h/a$a;)V

    iput-object p1, p0, Ld/n/h/a;->k:Ld/n/h/e$a;

    new-instance p1, Ld/n/h/a$b;

    invoke-direct {p1, p0, p2}, Ld/n/h/a$b;-><init>(Ld/n/h/a;Ld/n/h/a$b;)V

    iput-object p1, p0, Ld/n/h/a;->l:Ld/n/h/e$a;

    new-instance p1, Ld/n/h/a$c;

    invoke-direct {p1, p0, p2}, Ld/n/h/a$c;-><init>(Ld/n/h/a;Ld/n/h/a$c;)V

    iput-object p1, p0, Ld/n/h/a;->m:Ld/n/h/e$a;

    iput-wide p3, p0, Ld/n/h/a;->h:J

    iput-object p5, p0, Ld/n/h/a;->n:Ld/o/a;

    return-void
.end method


# virtual methods
.method public b()Ld/e;
    .locals 1

    iget-object v0, p0, Ld/n/h/a;->i:Ld/e;

    return-object v0
.end method

.method protected h(I)Ld/e;
    .locals 1

    iget-object v0, p0, Ld/n/h/a;->n:Ld/o/a;

    invoke-interface {v0, p1}, Ld/o/a;->a(I)Ld/e;

    move-result-object p1

    return-object p1
.end method

.method protected abstract i()Ld/n/h/e$a$a;
.end method

.method protected abstract j()Ld/n/h/e$a$a;
.end method

.method protected abstract k()Ld/n/h/e$a$a;
.end method

.method protected abstract l()Ld/n/h/e$a$a;
.end method

.method protected final m(J)Ld/n/h/e$a$a;
    .locals 4

    iget-wide v0, p0, Ld/n/h/a;->h:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    const v3, 0x9523dd2

    if-ltz v2, :cond_0

    cmp-long v0, p1, v0

    if-lez v0, :cond_0

    invoke-virtual {p0, v3}, Ld/n/h/b;->e(I)V

    sget-object p1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    return-object p1

    :cond_0
    const-wide/32 v0, 0x7fffffff

    cmp-long v0, p1, v0

    if-lez v0, :cond_1

    invoke-virtual {p0, v3}, Ld/n/h/b;->e(I)V

    sget-object p1, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    return-object p1

    :cond_1
    long-to-int p1, p1

    invoke-virtual {p0, p1}, Ld/n/h/a;->h(I)Ld/e;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/a;->i:Ld/e;

    sget-object p1, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    return-object p1
.end method
