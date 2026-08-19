.class public Lc/c/a/l/d$i;
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
    name = "i"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$i;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 3

    iget-object v0, p0, Lc/c/a/l/d$i;->a:Lc/c/a/l/d;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    invoke-virtual {v0, v1, v2}, Lc/c/a/l/d;->l(Ljava/lang/Class;Lc/c/a/k/i;)Lc/c/a/k/i;

    move-result-object v1

    check-cast p1, Ljava/util/Map;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, v2}, Lc/c/a/l/a;->e(Lc/c/a/k/i;Ljava/util/Map;Ljava/lang/Boolean;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
