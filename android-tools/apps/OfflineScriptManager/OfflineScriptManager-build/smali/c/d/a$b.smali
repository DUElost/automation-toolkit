.class public Lc/d/a$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/d/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "b"
.end annotation


# instance fields
.field private final b:Ld/c;

.field private final c:Ld/j;

.field private final d:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method protected constructor <init>(Lc/d/a$a;I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lc/d/a$b;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-static {p1}, Lc/d/a$a;->a(Lc/d/a$a;)Ld/c;

    move-result-object p1

    iput-object p1, p0, Lc/d/a$b;->b:Ld/c;

    invoke-virtual {p1, p2}, Ld/c;->g(I)Ld/j;

    move-result-object p1

    iput-object p1, p0, Lc/d/a$b;->c:Ld/j;

    return-void
.end method

.method private b()V
    .locals 2

    iget-object v0, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {v0}, Ld/j;->P0()I

    move-result v0

    if-eqz v0, :cond_1

    const/16 v1, 0x23

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance v1, Lc/d/b;

    invoke-direct {v1, v0}, Lc/d/b;-><init>(I)V

    throw v1

    :cond_1
    :goto_0
    return-void
.end method

.method private s(ILjava/lang/Object;)Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {v1, p1, p2}, Ld/j;->g1(ILjava/lang/Object;)Z

    move-result p1

    iget-object p2, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {p2}, Ld/j;->P0()I

    move-result p2
    :try_end_0
    .catch Ld/k$a; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v1, 0x16

    if-eq p2, v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    and-int/2addr p1, v0

    return p1

    :catch_0
    return v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {v0, p1}, Ld/j;->O0(Ljava/lang/String;)Z

    move-result p1

    invoke-direct {p0}, Lc/d/a$b;->b()V

    return p1
.end method

.method public close()V
    .locals 3

    iget-object v0, p0, Lc/d/a$b;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {v0}, Ld/j;->close()V

    :cond_0
    return-void
.end method

.method public e(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lc/d/a;->a:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lc/d/a$b;->h([BI)Z

    move-result p1

    return p1
.end method

.method public h([BI)Z
    .locals 1

    new-instance v0, Ld/e;

    invoke-direct {v0, p1}, Ld/e;-><init>([B)V

    iget-object p1, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {p1, v0, p2}, Ld/j;->f1(Ld/e;I)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-direct {p0}, Lc/d/a$b;->b()V

    const/4 p1, 0x0

    return p1
.end method

.method public m(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lc/d/a;->a:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lc/d/a$b;->h([BI)Z

    move-result p1

    return p1
.end method

.method public q(I)Z
    .locals 1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const/16 v0, 0x17

    invoke-direct {p0, v0, p1}, Lc/d/a$b;->s(ILjava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/d/a$b;->c:Ld/j;

    invoke-virtual {v0}, Ld/j;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
