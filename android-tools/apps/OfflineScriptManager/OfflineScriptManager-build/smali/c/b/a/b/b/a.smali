.class abstract Lc/b/a/b/b/a;
.super Lc/b/a/b/b/d;
.source ""

# interfaces
.implements Lc/b/a/a/c;


# instance fields
.field i:[Ljava/lang/Class;

.field j:[Ljava/lang/Class;


# direct methods
.method constructor <init>(ILjava/lang/String;Ljava/lang/Class;[Ljava/lang/Class;[Ljava/lang/String;[Ljava/lang/Class;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lc/b/a/b/b/d;-><init>(ILjava/lang/String;Ljava/lang/Class;)V

    iput-object p4, p0, Lc/b/a/b/b/a;->i:[Ljava/lang/Class;

    iput-object p6, p0, Lc/b/a/b/b/a;->j:[Ljava/lang/Class;

    return-void
.end method


# virtual methods
.method public l()[Ljava/lang/Class;
    .locals 1

    iget-object v0, p0, Lc/b/a/b/b/a;->j:[Ljava/lang/Class;

    if-nez v0, :cond_0

    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lc/b/a/b/b/f;->e(I)[Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lc/b/a/b/b/a;->j:[Ljava/lang/Class;

    :cond_0
    iget-object v0, p0, Lc/b/a/b/b/a;->j:[Ljava/lang/Class;

    return-object v0
.end method

.method public m()[Ljava/lang/Class;
    .locals 1

    iget-object v0, p0, Lc/b/a/b/b/a;->i:[Ljava/lang/Class;

    if-nez v0, :cond_0

    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lc/b/a/b/b/f;->e(I)[Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lc/b/a/b/b/a;->i:[Ljava/lang/Class;

    :cond_0
    iget-object v0, p0, Lc/b/a/b/b/a;->i:[Ljava/lang/Class;

    return-object v0
.end method
