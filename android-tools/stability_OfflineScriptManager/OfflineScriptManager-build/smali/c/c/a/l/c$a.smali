.class public Lc/c/a/l/c$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/c/a/l/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/l/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/c;


# direct methods
.method protected constructor <init>(Lc/c/a/l/c;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/c$a;->a:Lc/c/a/l/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lc/c/a/l/c$a;->a:Lc/c/a/l/c;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1}, Lc/c/a/l/c;->n(Ljava/lang/Class;)Ljava/util/Set;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lc/c/a/l/c;->o(Ljava/util/Set;Ljava/lang/Object;)Lc/c/a/k/c;

    move-result-object p1
    :try_end_0
    .catch Ljava/beans/IntrospectionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    new-instance v0, Lc/c/a/g/b;

    invoke-direct {v0, p1}, Lc/c/a/g/b;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method
