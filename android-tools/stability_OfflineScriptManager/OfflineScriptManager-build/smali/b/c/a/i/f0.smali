.class public Lb/c/a/i/f0;
.super Lb/e/a/b;
.source ""


# instance fields
.field private m:Lb/c/a/i/w;


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "trak"

    invoke-direct {p0, v0}, Lb/e/a/b;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public G()Lb/c/a/i/n;
    .locals 3

    invoke-virtual {p0}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v0, 0x0

    return-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    instance-of v2, v1, Lb/c/a/i/n;

    if-eqz v2, :cond_0

    check-cast v1, Lb/c/a/i/n;

    return-object v1
.end method

.method public H()Lb/c/a/i/w;
    .locals 1

    iget-object v0, p0, Lb/c/a/i/f0;->m:Lb/c/a/i/w;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lb/c/a/i/f0;->G()Lb/c/a/i/n;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lb/c/a/i/n;->I()Lb/c/a/i/p;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lb/c/a/i/p;->G()Lb/c/a/i/w;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/f0;->m:Lb/c/a/i/w;

    return-object v0

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public I()Lb/c/a/i/g0;
    .locals 3

    invoke-virtual {p0}, Lb/e/a/d;->e()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    const/4 v0, 0x0

    return-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    instance-of v2, v1, Lb/c/a/i/g0;

    if-eqz v2, :cond_0

    check-cast v1, Lb/c/a/i/g0;

    return-object v1
.end method
