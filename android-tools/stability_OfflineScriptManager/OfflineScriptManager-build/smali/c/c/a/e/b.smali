.class public abstract Lc/c/a/e/b;
.super Ljava/lang/Object;
.source ""


# instance fields
.field protected final a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lc/c/a/k/e;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field protected final b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lc/c/a/k/i;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lc/c/a/j/f;

.field private d:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lc/c/a/k/e;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    iput-object v0, p0, Lc/c/a/e/b;->a:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/e/b;->b:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lc/c/a/e/b;->d:Z

    return-void
.end method


# virtual methods
.method public final a()Lc/c/a/j/f;
    .locals 1

    iget-object v0, p0, Lc/c/a/e/b;->c:Lc/c/a/j/f;

    if-nez v0, :cond_0

    new-instance v0, Lc/c/a/j/f;

    invoke-direct {v0}, Lc/c/a/j/f;-><init>()V

    iput-object v0, p0, Lc/c/a/e/b;->c:Lc/c/a/j/f;

    :cond_0
    iget-object v0, p0, Lc/c/a/e/b;->c:Lc/c/a/j/f;

    return-object v0
.end method

.method public final b()Z
    .locals 1

    iget-boolean v0, p0, Lc/c/a/e/b;->d:Z

    return v0
.end method

.method public c(Lc/c/a/j/f;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/e/b;->c:Lc/c/a/j/f;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lc/c/a/e/b;->d:Z

    return-void
.end method
