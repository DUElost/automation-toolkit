.class Lc/c/a/l/a$a;
.super Ljava/util/IdentityHashMap;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/l/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/IdentityHashMap<",
        "Ljava/lang/Object;",
        "Lc/c/a/k/d;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>(Lc/c/a/l/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/util/IdentityHashMap;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;Lc/c/a/k/d;)Lc/c/a/k/d;
    .locals 1

    new-instance v0, Lc/c/a/k/a;

    invoke-direct {v0, p2}, Lc/c/a/k/a;-><init>(Lc/c/a/k/d;)V

    invoke-super {p0, p1, v0}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lc/c/a/k/d;

    return-object p1
.end method

.method public bridge synthetic put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p2, Lc/c/a/k/d;

    invoke-virtual {p0, p1, p2}, Lc/c/a/l/a$a;->a(Ljava/lang/Object;Lc/c/a/k/d;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
