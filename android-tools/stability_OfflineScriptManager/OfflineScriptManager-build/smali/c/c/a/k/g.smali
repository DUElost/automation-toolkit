.class public Lc/c/a/k/g;
.super Lc/c/a/k/d;
.source ""


# instance fields
.field private d:Ljava/lang/Character;

.field private e:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lc/c/a/k/i;Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V
    .locals 7

    const/4 v2, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-direct/range {v0 .. v6}, Lc/c/a/k/g;-><init>(Lc/c/a/k/i;ZLjava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V

    return-void
.end method

.method public constructor <init>(Lc/c/a/k/i;ZLjava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V
    .locals 0

    invoke-direct {p0, p1, p4, p5}, Lc/c/a/k/d;-><init>(Lc/c/a/k/i;Lc/c/a/g/a;Lc/c/a/g/a;)V

    const-string p1, "value in a Node is required."

    invoke-static {p3, p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iput-object p3, p0, Lc/c/a/k/g;->e:Ljava/lang/String;

    iput-object p6, p0, Lc/c/a/k/g;->d:Ljava/lang/Character;

    return-void
.end method


# virtual methods
.method public b()Lc/c/a/k/e;
    .locals 1

    sget-object v0, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    return-object v0
.end method

.method public f()Ljava/lang/Character;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/g;->d:Ljava/lang/Character;

    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/g;->e:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "<"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-class v1, Lc/c/a/k/g;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " (tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lc/c/a/k/d;->d()Lc/c/a/k/i;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", value="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lc/c/a/k/g;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ")>"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
