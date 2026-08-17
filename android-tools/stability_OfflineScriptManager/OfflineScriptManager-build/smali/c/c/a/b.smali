.class public Lc/c/a/b;
.super Ljava/lang/Object;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 2

    new-instance v0, Lc/c/a/c;

    const-class v1, Ljava/lang/Object;

    invoke-direct {v0, v1}, Lc/c/a/c;-><init>(Ljava/lang/Class;)V

    invoke-direct {p0, v0}, Lc/c/a/b;-><init>(Lc/c/a/c;)V

    return-void
.end method

.method public constructor <init>(Lc/c/a/c;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
