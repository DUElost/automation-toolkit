.class public Lb/c/a/i/q;
.super Lb/e/a/b;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "moov"

    invoke-direct {p0, v0}, Lb/e/a/b;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public G()Lb/c/a/i/r;
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

    instance-of v2, v1, Lb/c/a/i/r;

    if-eqz v2, :cond_0

    check-cast v1, Lb/c/a/i/r;

    return-object v1
.end method
