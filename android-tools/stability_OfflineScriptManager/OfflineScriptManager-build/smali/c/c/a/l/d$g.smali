.class public Lc/c/a/l/d$g;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/c/a/l/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/l/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "g"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$g;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 4

    move-object v0, p1

    check-cast v0, Ljava/util/Iterator;

    iget-object v1, p0, Lc/c/a/l/d$g;->a:Lc/c/a/l/d;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    sget-object v2, Lc/c/a/k/i;->p:Lc/c/a/k/i;

    invoke-virtual {v1, p1, v2}, Lc/c/a/l/d;->l(Ljava/lang/Class;Lc/c/a/k/i;)Lc/c/a/k/i;

    move-result-object p1

    new-instance v2, Lc/c/a/l/d$a;

    iget-object v3, p0, Lc/c/a/l/d$g;->a:Lc/c/a/l/d;

    invoke-direct {v2, v3, v0}, Lc/c/a/l/d$a;-><init>(Lc/c/a/l/d;Ljava/util/Iterator;)V

    const/4 v0, 0x0

    invoke-virtual {v1, p1, v2, v0}, Lc/c/a/l/a;->h(Lc/c/a/k/i;Ljava/lang/Iterable;Ljava/lang/Boolean;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
