.class public abstract Lc/c/a/k/b;
.super Lc/c/a/k/d;
.source ""


# instance fields
.field private d:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>(Lc/c/a/k/i;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Boolean;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lc/c/a/k/d;-><init>(Lc/c/a/k/i;Lc/c/a/g/a;Lc/c/a/g/a;)V

    iput-object p4, p0, Lc/c/a/k/b;->d:Ljava/lang/Boolean;

    return-void
.end method


# virtual methods
.method public f()Ljava/lang/Boolean;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/b;->d:Ljava/lang/Boolean;

    return-object v0
.end method

.method public g(Ljava/lang/Boolean;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/k/b;->d:Ljava/lang/Boolean;

    return-void
.end method
