.class public Lc/c/a/k/a;
.super Lc/c/a/k/d;
.source ""


# instance fields
.field private d:Lc/c/a/k/d;


# direct methods
.method public constructor <init>(Lc/c/a/k/d;)V
    .locals 3

    invoke-virtual {p1}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-virtual {p1}, Lc/c/a/k/d;->c()Lc/c/a/g/a;

    move-result-object v1

    invoke-virtual {p1}, Lc/c/a/k/d;->a()Lc/c/a/g/a;

    move-result-object v2

    invoke-direct {p0, v0, v1, v2}, Lc/c/a/k/d;-><init>(Lc/c/a/k/i;Lc/c/a/g/a;Lc/c/a/g/a;)V

    iput-object p1, p0, Lc/c/a/k/a;->d:Lc/c/a/k/d;

    return-void
.end method


# virtual methods
.method public b()Lc/c/a/k/e;
    .locals 1

    sget-object v0, Lc/c/a/k/e;->e:Lc/c/a/k/e;

    return-object v0
.end method

.method public f()Lc/c/a/k/d;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/a;->d:Lc/c/a/k/d;

    return-object v0
.end method
