.class public final Lc/c/a/h/e;
.super Lc/c/a/h/f;
.source ""


# instance fields
.field private final a:Z

.field private final b:[Ljava/lang/Integer;

.field private final c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lc/c/a/g/a;Lc/c/a/g/a;Z[Ljava/lang/Integer;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lc/c/a/g/a;",
            "Lc/c/a/g/a;",
            "Z[",
            "Ljava/lang/Integer;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Lc/c/a/h/f;-><init>(Lc/c/a/g/a;Lc/c/a/g/a;)V

    iput-boolean p3, p0, Lc/c/a/h/e;->a:Z

    iput-object p4, p0, Lc/c/a/h/e;->b:[Ljava/lang/Integer;

    iput-object p5, p0, Lc/c/a/h/e;->c:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public b()Z
    .locals 1

    iget-boolean v0, p0, Lc/c/a/h/e;->a:Z

    return v0
.end method

.method public c()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lc/c/a/h/e;->c:Ljava/util/Map;

    return-object v0
.end method

.method public d()[Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lc/c/a/h/e;->b:[Ljava/lang/Integer;

    return-object v0
.end method
