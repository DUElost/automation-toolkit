.class public Lc/c/a/l/d$b;
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
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$b;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 3

    check-cast p1, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    iget-object v0, p0, Lc/c/a/l/d$b;->a:Lc/c/a/l/d;

    sget-object v1, Lc/c/a/k/i;->p:Lc/c/a/k/i;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, v2}, Lc/c/a/l/a;->h(Lc/c/a/k/i;Ljava/lang/Iterable;Ljava/lang/Boolean;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
