.class Lc/b/a/b/b/e;
.super Lc/b/a/b/b/a;
.source ""

# interfaces
.implements Lc/b/a/a/d/a;


# instance fields
.field k:Ljava/lang/Class;


# direct methods
.method constructor <init>(ILjava/lang/String;Ljava/lang/Class;[Ljava/lang/Class;[Ljava/lang/String;[Ljava/lang/Class;Ljava/lang/Class;)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lc/b/a/b/b/a;-><init>(ILjava/lang/String;Ljava/lang/Class;[Ljava/lang/Class;[Ljava/lang/String;[Ljava/lang/Class;)V

    iput-object p7, p0, Lc/b/a/b/b/e;->k:Ljava/lang/Class;

    return-void
.end method


# virtual methods
.method protected a(Lc/b/a/b/b/h;)Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {p0}, Lc/b/a/b/b/f;->i()I

    move-result v1

    invoke-virtual {p1, v1}, Lc/b/a/b/b/h;->e(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-boolean v1, p1, Lc/b/a/b/b/h;->b:Z

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lc/b/a/b/b/e;->n()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p1, v1}, Lc/b/a/b/b/h;->g(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_0
    iget-boolean v1, p1, Lc/b/a/b/b/h;->b:Z

    if-eqz v1, :cond_1

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    :cond_1
    invoke-virtual {p0}, Lc/b/a/b/b/f;->f()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p0}, Lc/b/a/b/b/f;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Lc/b/a/b/b/h;->f(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Lc/b/a/b/b/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Lc/b/a/b/b/a;->m()[Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lc/b/a/b/b/h;->a(Ljava/lang/StringBuffer;[Ljava/lang/Class;)V

    invoke-virtual {p0}, Lc/b/a/b/b/a;->l()[Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lc/b/a/b/b/h;->b(Ljava/lang/StringBuffer;[Ljava/lang/Class;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public n()Ljava/lang/Class;
    .locals 1

    iget-object v0, p0, Lc/b/a/b/b/e;->k:Ljava/lang/Class;

    if-nez v0, :cond_0

    const/4 v0, 0x6

    invoke-virtual {p0, v0}, Lc/b/a/b/b/f;->d(I)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lc/b/a/b/b/e;->k:Ljava/lang/Class;

    :cond_0
    iget-object v0, p0, Lc/b/a/b/b/e;->k:Ljava/lang/Class;

    return-object v0
.end method
