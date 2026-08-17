.class public Lc/c/a/l/d$f;
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
    name = "f"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$f;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 3

    new-instance v0, Lc/c/a/k/i;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/Class;)V

    iget-object v1, p0, Lc/c/a/l/d$f;->a:Lc/c/a/l/d;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lc/c/a/l/d;->l(Ljava/lang/Class;Lc/c/a/k/i;)Lc/c/a/k/i;

    move-result-object v0

    check-cast p1, Ljava/lang/Enum;

    invoke-virtual {p1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v0, p1}, Lc/c/a/l/a;->f(Lc/c/a/k/i;Ljava/lang/String;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
