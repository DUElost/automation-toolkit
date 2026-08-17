.class public Lc/d/a$a;
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
    name = "a"
.end annotation


# instance fields
.field private final b:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final c:Ld/c;


# direct methods
.method protected constructor <init>(I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lc/d/a$a;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-static {p1}, Ld/l;->c(I)Ld/c;

    move-result-object p1

    iput-object p1, p0, Lc/d/a$a;->c:Ld/c;

    return-void
.end method

.method static synthetic a(Lc/d/a$a;)Ld/c;
    .locals 0

    iget-object p0, p0, Lc/d/a$a;->c:Ld/c;

    return-object p0
.end method


# virtual methods
.method public b(I)Lc/d/a$b;
    .locals 1

    new-instance v0, Lc/d/a$b;

    invoke-direct {v0, p0, p1}, Lc/d/a$b;-><init>(Lc/d/a$a;I)V

    return-object v0
.end method

.method public close()V
    .locals 0

    invoke-virtual {p0}, Lc/d/a$a;->e()V

    return-void
.end method

.method public e()V
    .locals 3

    iget-object v0, p0, Lc/d/a$a;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/d/a$a;->c:Ld/c;

    invoke-virtual {v0}, Ld/c;->s()V

    :cond_0
    return-void
.end method
