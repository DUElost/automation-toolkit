.class public abstract Lc/c/a/k/d;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:Lc/c/a/k/i;

.field private b:Lc/c/a/g/a;

.field protected c:Lc/c/a/g/a;


# direct methods
.method public constructor <init>(Lc/c/a/k/i;Lc/c/a/g/a;Lc/c/a/g/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p0, p1}, Lc/c/a/k/d;->e(Lc/c/a/k/i;)V

    return-void
.end method


# virtual methods
.method public a()Lc/c/a/g/a;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/d;->c:Lc/c/a/g/a;

    return-object v0
.end method

.method public abstract b()Lc/c/a/k/e;
.end method

.method public c()Lc/c/a/g/a;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/d;->b:Lc/c/a/g/a;

    return-object v0
.end method

.method public d()Lc/c/a/k/i;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/d;->a:Lc/c/a/k/i;

    return-object v0
.end method

.method public e(Lc/c/a/k/i;)V
    .locals 1

    const-string v0, "tag in a Node is required."

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iput-object p1, p0, Lc/c/a/k/d;->a:Lc/c/a/k/i;

    return-void
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final hashCode()I
    .locals 1

    invoke-super {p0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    return v0
.end method
