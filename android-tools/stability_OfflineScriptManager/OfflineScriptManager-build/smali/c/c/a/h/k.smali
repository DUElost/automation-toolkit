.class public final Lc/c/a/h/k;
.super Lc/c/a/h/j;
.source ""


# instance fields
.field private final b:Ljava/lang/String;

.field private final c:Ljava/lang/Character;

.field private final d:Ljava/lang/String;

.field private final e:Lc/c/a/h/g;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lc/c/a/h/g;Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;Ljava/lang/Character;)V
    .locals 0

    invoke-direct {p0, p1, p5, p6}, Lc/c/a/h/j;-><init>(Ljava/lang/String;Lc/c/a/g/a;Lc/c/a/g/a;)V

    iput-object p2, p0, Lc/c/a/h/k;->b:Ljava/lang/String;

    iput-object p3, p0, Lc/c/a/h/k;->e:Lc/c/a/h/g;

    iput-object p4, p0, Lc/c/a/h/k;->d:Ljava/lang/String;

    iput-object p7, p0, Lc/c/a/h/k;->c:Ljava/lang/Character;

    return-void
.end method


# virtual methods
.method protected a()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-super {p0}, Lc/c/a/h/j;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/h/k;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/h/k;->e:Lc/c/a/h/g;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", value="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/h/k;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public c()Lc/c/a/h/g;
    .locals 1

    iget-object v0, p0, Lc/c/a/h/k;->e:Lc/c/a/h/g;

    return-object v0
.end method

.method public d()Ljava/lang/Character;
    .locals 1

    iget-object v0, p0, Lc/c/a/h/k;->c:Ljava/lang/Character;

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/h/k;->b:Ljava/lang/String;

    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/h/k;->d:Ljava/lang/String;

    return-object v0
.end method
