.class final Lc/c/a/m/b;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private final a:Lc/c/a/k/i;

.field private final b:Ljava/util/regex/Pattern;


# direct methods
.method public constructor <init>(Lc/c/a/k/i;Ljava/util/regex/Pattern;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lc/c/a/m/b;->a:Lc/c/a/k/i;

    iput-object p2, p0, Lc/c/a/m/b;->b:Ljava/util/regex/Pattern;

    return-void
.end method


# virtual methods
.method public a()Ljava/util/regex/Pattern;
    .locals 1

    iget-object v0, p0, Lc/c/a/m/b;->b:Ljava/util/regex/Pattern;

    return-object v0
.end method

.method public b()Lc/c/a/k/i;
    .locals 1

    iget-object v0, p0, Lc/c/a/m/b;->a:Lc/c/a/k/i;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Tuple tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/m/b;->a:Lc/c/a/k/i;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, " regexp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/m/b;->b:Ljava/util/regex/Pattern;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
