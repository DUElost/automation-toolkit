.class public Lc/c/a/d;
.super Ljava/lang/Object;
.source ""


# instance fields
.field protected final a:Lc/c/a/m/a;

.field private b:Ljava/lang/String;

.field protected c:Lc/c/a/l/c;

.field protected d:Lc/c/a/a;


# direct methods
.method public constructor <init>()V
    .locals 6

    new-instance v1, Lc/c/a/e/c;

    invoke-direct {v1}, Lc/c/a/e/c;-><init>()V

    new-instance v2, Lc/c/a/b;

    invoke-direct {v2}, Lc/c/a/b;-><init>()V

    new-instance v3, Lc/c/a/l/c;

    invoke-direct {v3}, Lc/c/a/l/c;-><init>()V

    new-instance v4, Lc/c/a/a;

    invoke-direct {v4}, Lc/c/a/a;-><init>()V

    new-instance v5, Lc/c/a/m/a;

    invoke-direct {v5}, Lc/c/a/m/a;-><init>()V

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lc/c/a/d;-><init>(Lc/c/a/e/b;Lc/c/a/b;Lc/c/a/l/c;Lc/c/a/a;Lc/c/a/m/a;)V

    return-void
.end method

.method public constructor <init>(Lc/c/a/e/b;Lc/c/a/b;Lc/c/a/l/c;Lc/c/a/a;Lc/c/a/m/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Lc/c/a/e/b;->b()Z

    move-result p2

    if-nez p2, :cond_0

    invoke-virtual {p3}, Lc/c/a/l/a;->a()Lc/c/a/j/f;

    move-result-object p2

    invoke-virtual {p1, p2}, Lc/c/a/e/b;->c(Lc/c/a/j/f;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p3}, Lc/c/a/l/a;->b()Z

    move-result p2

    if-nez p2, :cond_1

    invoke-virtual {p1}, Lc/c/a/e/b;->a()Lc/c/a/j/f;

    move-result-object p1

    invoke-virtual {p3, p1}, Lc/c/a/l/a;->k(Lc/c/a/j/f;)V

    :cond_1
    :goto_0
    invoke-virtual {p4}, Lc/c/a/a;->b()Lc/c/a/a$a;

    move-result-object p1

    invoke-virtual {p3, p1}, Lc/c/a/l/a;->i(Lc/c/a/a$a;)V

    invoke-virtual {p4}, Lc/c/a/a;->c()Lc/c/a/a$c;

    move-result-object p1

    invoke-virtual {p3, p1}, Lc/c/a/l/a;->j(Lc/c/a/a$c;)V

    invoke-virtual {p3}, Lc/c/a/l/a;->a()Lc/c/a/j/f;

    move-result-object p1

    invoke-virtual {p4}, Lc/c/a/a;->j()Z

    move-result p2

    invoke-virtual {p1, p2}, Lc/c/a/j/f;->e(Z)V

    iput-object p3, p0, Lc/c/a/d;->c:Lc/c/a/l/c;

    iput-object p4, p0, Lc/c/a/d;->d:Lc/c/a/a;

    iput-object p5, p0, Lc/c/a/d;->a:Lc/c/a/m/a;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Yaml:"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/d;->b:Ljava/lang/String;

    return-void
.end method

.method private d(Ljava/util/Iterator;Ljava/io/Writer;Lc/c/a/k/i;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Iterator<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/io/Writer;",
            "Lc/c/a/k/i;",
            ")V"
        }
    .end annotation

    new-instance v0, Lc/c/a/o/a;

    new-instance v1, Lc/c/a/f/b;

    iget-object v2, p0, Lc/c/a/d;->d:Lc/c/a/a;

    invoke-direct {v1, p2, v2}, Lc/c/a/f/b;-><init>(Ljava/io/Writer;Lc/c/a/a;)V

    iget-object p2, p0, Lc/c/a/d;->a:Lc/c/a/m/a;

    iget-object v2, p0, Lc/c/a/d;->d:Lc/c/a/a;

    invoke-direct {v0, v1, p2, v2, p3}, Lc/c/a/o/a;-><init>(Lc/c/a/f/a;Lc/c/a/m/a;Lc/c/a/a;Lc/c/a/k/i;)V

    :try_start_0
    invoke-virtual {v0}, Lc/c/a/o/a;->d()V

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lc/c/a/d;->c:Lc/c/a/l/c;

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    invoke-virtual {p2, p3}, Lc/c/a/l/a;->c(Ljava/lang/Object;)Lc/c/a/k/d;

    move-result-object p2

    invoke-virtual {v0, p2}, Lc/c/a/o/a;->e(Lc/c/a/k/d;)V

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lc/c/a/o/a;->b()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Lc/c/a/g/b;

    invoke-direct {p2, p1}, Lc/c/a/g/b;-><init>(Ljava/lang/Throwable;)V

    throw p2
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-virtual {p0, p1}, Lc/c/a/d;->b(Ljava/util/Iterator;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/util/Iterator;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Iterator<",
            "+",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    invoke-virtual {p0, p1, v0}, Lc/c/a/d;->c(Ljava/util/Iterator;Ljava/io/Writer;)V

    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public c(Ljava/util/Iterator;Ljava/io/Writer;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Iterator<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/io/Writer;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lc/c/a/d;->d:Lc/c/a/a;

    invoke-virtual {v0}, Lc/c/a/a;->d()Lc/c/a/k/i;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lc/c/a/d;->d(Ljava/util/Iterator;Ljava/io/Writer;Lc/c/a/k/i;)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/d;->b:Ljava/lang/String;

    return-object v0
.end method
