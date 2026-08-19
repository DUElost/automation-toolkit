.class public Lc/c/a/e/c;
.super Lc/c/a/e/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lc/c/a/e/c$c;,
        Lc/c/a/e/c$b;,
        Lc/c/a/e/c$d;,
        Lc/c/a/e/c$a;
    }
.end annotation


# instance fields
.field private final g:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lc/c/a/k/i;",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private final h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Lc/c/a/c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    const-class v0, Ljava/lang/Object;

    invoke-direct {p0, v0}, Lc/c/a/e/c;-><init>(Ljava/lang/Class;)V

    return-void
.end method

.method public constructor <init>(Lc/c/a/c;)V
    .locals 3

    invoke-direct {p0}, Lc/c/a/e/d;-><init>()V

    const-string v0, "Root type must be provided."

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/e/b;->b:Ljava/util/Map;

    const/4 v1, 0x0

    new-instance v2, Lc/c/a/e/c$d;

    invoke-direct {v2, p0}, Lc/c/a/e/c$d;-><init>(Lc/c/a/e/c;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-class v0, Ljava/lang/Object;

    invoke-virtual {p1}, Lc/c/a/c;->b()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lc/c/a/k/i;

    invoke-virtual {p1}, Lc/c/a/c;->b()Ljava/lang/Class;

    move-result-object v1

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/Class;)V

    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/e/c;->g:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/e/c;->h:Ljava/util/Map;

    iget-object v0, p0, Lc/c/a/e/b;->a:Ljava/util/Map;

    sget-object v1, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    new-instance v2, Lc/c/a/e/c$b;

    invoke-direct {v2, p0}, Lc/c/a/e/c$b;-><init>(Lc/c/a/e/c;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/e/b;->a:Ljava/util/Map;

    sget-object v1, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    new-instance v2, Lc/c/a/e/c$a;

    invoke-direct {v2, p0}, Lc/c/a/e/c$a;-><init>(Lc/c/a/e/c;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/e/b;->a:Ljava/util/Map;

    sget-object v1, Lc/c/a/k/e;->c:Lc/c/a/k/e;

    new-instance v2, Lc/c/a/e/c$c;

    invoke-direct {v2, p0}, Lc/c/a/e/c$c;-><init>(Lc/c/a/e/c;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0, p1}, Lc/c/a/e/c;->d(Lc/c/a/c;)Lc/c/a/c;

    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lc/c/a/c;

    invoke-static {p1}, Lc/c/a/e/c;->e(Ljava/lang/Class;)Ljava/lang/Class;

    invoke-direct {v0, p1}, Lc/c/a/c;-><init>(Ljava/lang/Class;)V

    invoke-direct {p0, v0}, Lc/c/a/e/c;-><init>(Lc/c/a/c;)V

    return-void
.end method

.method private static e(Ljava/lang/Class;)Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    const-string v0, "Root class must be provided."

    invoke-static {p0, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    return-object p0
.end method


# virtual methods
.method public d(Lc/c/a/c;)Lc/c/a/c;
    .locals 3

    const-string v0, "TypeDescription is required."

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    invoke-virtual {p1}, Lc/c/a/c;->a()Lc/c/a/k/i;

    move-result-object v0

    iget-object v1, p0, Lc/c/a/e/c;->g:Ljava/util/Map;

    invoke-virtual {p1}, Lc/c/a/c;->b()Ljava/lang/Class;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/e/c;->h:Ljava/util/Map;

    invoke-virtual {p1}, Lc/c/a/c;->b()Ljava/lang/Class;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lc/c/a/c;

    return-object p1
.end method
