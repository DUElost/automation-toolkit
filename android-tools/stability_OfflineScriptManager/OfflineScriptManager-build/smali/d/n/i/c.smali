.class Ld/n/i/c;
.super Ld/n/i/a;
.source ""


# instance fields
.field private i:Z

.field private j:Z

.field private k:Z

.field private l:Z

.field private m:Z

.field private n:Z

.field private o:Z


# direct methods
.method constructor <init>(Ld/n/f;Ld/n/j/a;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    iget-object p2, p3, Ld/f;->D:Ljava/lang/String;

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p2

    if-lez p2, :cond_0

    invoke-virtual {p1}, Ld/n/f;->V0()I

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/n/i/c;->m:Z

    :cond_0
    return-void
.end method

.method private A(Ld/e;)I
    .locals 3

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const v1, 0x9523e34

    const/4 v2, 0x7

    if-ge v0, v2, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Ld/e;->e(I)B

    move-result v0

    invoke-virtual {p1}, Ld/e;->B()I

    move-result p1

    sub-int/2addr p1, v2

    if-le v0, p1, :cond_1

    return v1

    :cond_1
    const/4 p1, 0x1

    iput-boolean p1, p0, Ld/n/i/c;->l:Z

    const/4 p1, 0x0

    return p1
.end method

.method private B(Ld/e;)I
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/i/c;->k:Z

    const/4 v0, 0x6

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->o(Ld/e;IZ)I

    move-result p1

    return p1
.end method


# virtual methods
.method public m(Ld/e;)I
    .locals 5

    iget-boolean v0, p0, Ld/n/i/c;->i:Z

    const/16 v1, 0x23

    if-nez v0, :cond_7

    iget-boolean v0, p0, Ld/n/i/c;->j:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-boolean v0, p0, Ld/n/i/c;->m:Z

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Ld/n/i/c;->o:Z

    if-nez v0, :cond_3

    iget-boolean v0, p0, Ld/n/i/c;->n:Z

    if-eqz v0, :cond_1

    return v1

    :cond_1
    sget-object v0, Ld/n/i/b;->b:Ld/n/i/b;

    invoke-virtual {p0, v0, v2}, Ld/n/i/a;->u(Ld/n/i/b;Z)V

    iput-boolean v3, p0, Ld/n/i/c;->n:Z

    invoke-virtual {p0}, Ld/n/i/a;->t()I

    move-result v0

    if-eqz v0, :cond_2

    return v0

    :cond_2
    iput-boolean v3, p0, Ld/n/i/c;->o:Z

    :cond_3
    iget-boolean v0, p0, Ld/n/i/c;->o:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Ld/n/i/a;->h:Ljava/lang/String;

    const-string v1, "200"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->h:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iput-boolean v3, p0, Ld/n/i/c;->j:Z

    return v2

    :cond_4
    const-string v0, "READY"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->a:Ld/f;

    iget v0, v0, Ld/f;->j:I

    invoke-virtual {p0, v0}, Ld/n/i/a;->x(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Socket-Type"

    invoke-virtual {p0, p1, v1, v0}, Ld/n/i/a;->d(Ld/e;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->a:Ld/f;

    iget v1, v0, Ld/f;->j:I

    const/4 v4, 0x3

    if-eq v1, v4, :cond_5

    const/4 v4, 0x5

    if-eq v1, v4, :cond_5

    const/4 v4, 0x6

    if-ne v1, v4, :cond_6

    :cond_5
    iget-object v0, v0, Ld/f;->e:[B

    const-string v1, "Identity"

    invoke-virtual {p0, p1, v1, v0}, Ld/n/i/a;->e(Ld/e;Ljava/lang/String;[B)V

    :cond_6
    iput-boolean v3, p0, Ld/n/i/c;->i:Z

    return v2

    :cond_7
    :goto_0
    return v1
.end method

.method public q(Ld/e;)I
    .locals 5

    iget-boolean v0, p0, Ld/n/i/c;->k:Z

    const v1, 0x9523e34

    if-nez v0, :cond_3

    iget-boolean v0, p0, Ld/n/i/c;->l:Z

    if-eqz v0, :cond_0

    goto :goto_2

    :cond_0
    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v2, 0x1

    const/4 v3, 0x6

    if-lt v0, v3, :cond_1

    const-string v4, "READY"

    invoke-virtual {p0, p1, v4, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-direct {p0, p1}, Ld/n/i/c;->B(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_1
    if-lt v0, v3, :cond_2

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0, p1}, Ld/n/i/c;->A(Ld/e;)I

    move-result p1

    :goto_0
    return p1

    :cond_2
    const-string p1, "NULL I: client sent invalid NULL handshake (not READY) "

    :goto_1
    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v1

    :cond_3
    :goto_2
    const-string p1, "NULL I: client sent invalid NULL handshake (duplicate READY)"

    goto :goto_1
.end method

.method public y()Ld/n/i/a$b;
    .locals 6

    iget-boolean v0, p0, Ld/n/i/c;->i:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    iget-boolean v3, p0, Ld/n/i/c;->j:Z

    if-nez v3, :cond_0

    move v3, v1

    goto :goto_0

    :cond_0
    move v3, v2

    :goto_0
    iget-boolean v4, p0, Ld/n/i/c;->k:Z

    if-nez v4, :cond_1

    iget-boolean v5, p0, Ld/n/i/c;->l:Z

    if-nez v5, :cond_1

    goto :goto_1

    :cond_1
    move v1, v2

    :goto_1
    if-eqz v0, :cond_2

    if-eqz v4, :cond_2

    sget-object v0, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    return-object v0

    :cond_2
    if-eqz v3, :cond_3

    if-eqz v1, :cond_3

    sget-object v0, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    return-object v0

    :cond_3
    sget-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    return-object v0
.end method

.method public z()I
    .locals 2

    iget-boolean v0, p0, Ld/n/i/c;->o:Z

    if-eqz v0, :cond_0

    const v0, 0x9523dfb

    return v0

    :cond_0
    invoke-virtual {p0}, Ld/n/i/a;->t()I

    move-result v0

    if-nez v0, :cond_1

    const/4 v1, 0x1

    iput-boolean v1, p0, Ld/n/i/c;->o:Z

    :cond_1
    return v0
.end method
