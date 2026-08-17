.class public Lc/c/a/l/d$j;
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
    name = "j"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/l/d;


# direct methods
.method protected constructor <init>(Lc/c/a/l/d;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/l/d$j;->a:Lc/c/a/l/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lc/c/a/k/d;
    .locals 2

    iget-object p1, p0, Lc/c/a/l/d$j;->a:Lc/c/a/l/d;

    sget-object v0, Lc/c/a/k/i;->n:Lc/c/a/k/i;

    const-string v1, "null"

    invoke-virtual {p1, v0, v1}, Lc/c/a/l/a;->f(Lc/c/a/k/i;Ljava/lang/String;)Lc/c/a/k/d;

    move-result-object p1

    return-object p1
.end method
