.class public Lc/c/a/l/d$d;
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
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$d;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 3

    check-cast p1, [B

    invoke-static {p1}, Lc/c/a/i/a/a/a;->a([B)[C

    move-result-object p1

    iget-object v0, p0, Lc/c/a/l/d$d;->a:Lc/c/a/l/d;

    sget-object v1, Lc/c/a/k/i;->i:Lc/c/a/k/i;

    invoke-static {p1}, Ljava/lang/String;->valueOf([C)Ljava/lang/String;

    move-result-object p1

    const/16 v2, 0x7c

    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lc/c/a/l/a;->g(Lc/c/a/k/i;Ljava/lang/String;Ljava/lang/Character;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
