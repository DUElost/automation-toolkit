.class Lcom/ape/offlinescriptmanager/utils/m/b$b;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/m/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field final synthetic b:Lcom/ape/offlinescriptmanager/utils/m/b;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/b;Lcom/ape/offlinescriptmanager/utils/m/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/b$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/b;)V

    return-void
.end method

.method private a(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->j(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->o(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private b(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->d(Lcom/ape/offlinescriptmanager/utils/m/b;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "value"

    invoke-interface {p1, v1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    return-void

    :cond_1
    new-instance v1, Lb/b/a/a/c/a;

    invoke-direct {v1, v0, p1}, Lb/b/a/a/c/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object p1

    invoke-virtual {p1, v1}, Lb/b/a/a/c/j;->h(Lb/b/a/a/c/a;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object p1

    invoke-virtual {p1, v1}, Lb/b/a/a/c/d;->h(Lb/b/a/a/c/a;)V

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    invoke-virtual {p1, v1}, Lb/b/a/a/c/i;->h(Lb/b/a/a/c/a;)V

    :cond_4
    :goto_0
    return-void
.end method

.method private c(Lorg/xml/sax/Attributes;)V
    .locals 3

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    const-string v0, "."

    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-lt v1, v2, :cond_1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/c/e;->l(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/c/i;->q(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/b/a/a/c/e;->l(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lb/b/a/a/c/i;->q(Ljava/lang/String;)V

    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->o(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->k(Ljava/lang/String;)V

    goto :goto_1

    :cond_5
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->p(Ljava/lang/String;)V

    :cond_6
    :goto_1
    return-void
.end method

.method private d(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/d;->m(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private e(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->p(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->m(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->r(Ljava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private f(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->q(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private g(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->r(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->n(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->s(Ljava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private h(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lb/b/a/a/c/e;->o(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lb/b/a/a/c/i;->t(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method

.method private i(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->s(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->p(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->u(Ljava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private j(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/f;

    invoke-direct {v1}, Lb/b/a/a/c/f;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->g(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/f;)Lb/b/a/a/c/f;

    if-eqz p1, :cond_5

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->k(Ljava/lang/String;)V

    const-string v0, "times"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->b(I)V

    const-string v0, "testTimeOut"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->o(I)V

    :cond_0
    const-string v0, "testpointRegressionTimes"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->n(I)V

    :cond_1
    const-string v0, "taskRegressionType"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->m(I)V

    :cond_2
    const-string v0, "caseRegressionType"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/c/f;->j(I)V

    :cond_3
    const-string v0, "stopWhenFail"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_5

    const-string v0, "false"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object p1

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Lb/b/a/a/c/f;->l(Z)V

    goto :goto_1

    :cond_4
    const-string v0, "true"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object p1

    const/4 v0, 0x1

    goto :goto_0

    :cond_5
    :goto_1
    return-void
.end method

.method private k(Lorg/xml/sax/Attributes;)V
    .locals 3

    const-string v0, "type"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "times"

    invoke-interface {p1, v1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/b;->k(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/j;)Lb/b/a/a/c/j;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/b;->m(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/e;)Lb/b/a/a/c/e;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/b;->o(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/d;)Lb/b/a/a/c/d;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/b;->q(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/i;)Lb/b/a/a/c/i;

    const-string v1, "adb"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/d;

    invoke-direct {v1}, Lb/b/a/a/c/d;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->o(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/d;)Lb/b/a/a/c/d;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/d;->n(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->n(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/d;

    move-result-object p1

    goto/16 :goto_0

    :cond_0
    const-string v1, "uiautomator"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/j;

    invoke-direct {v1}, Lb/b/a/a/c/j;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->k(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/j;)Lb/b/a/a/c/j;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/j;->u(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/c/f;->i()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/c/j;->t(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->j(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/j;

    move-result-object p1

    goto :goto_0

    :cond_1
    const-string v1, "robotium"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/e;

    invoke-direct {v1}, Lb/b/a/a/c/e;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->m(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/e;)Lb/b/a/a/c/e;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/e;->r(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/c/f;->i()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/c/e;->q(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->l(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/e;

    move-result-object p1

    goto :goto_0

    :cond_2
    const-string v1, "uiautomator2"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/i;

    invoke-direct {v1}, Lb/b/a/a/c/i;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->q(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/i;)Lb/b/a/a/c/i;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/i;->w(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lb/b/a/a/c/f;->i()I

    move-result v0

    invoke-virtual {p1, v0}, Lb/b/a/a/c/i;->v(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->p(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/i;

    move-result-object p1

    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->h(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/h;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->h(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/h;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/c/h;->c(Lb/b/a/a/c/c;)V

    :cond_3
    return-void

    :cond_4
    const/4 p1, 0x1

    new-array p1, p1, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object v0, p1, v1

    const-string v0, "task xml have type = %s unknown"

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/utils/b;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method private l(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    new-instance v1, Lb/b/a/a/c/h;

    invoke-direct {v1}, Lb/b/a/a/c/h;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->i(Lcom/ape/offlinescriptmanager/utils/m/b;Lb/b/a/a/c/h;)Lb/b/a/a/c/h;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/b;->h(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/c/h;->h(Ljava/lang/String;)V

    const-string v0, "times"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->h(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/h;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    invoke-virtual {v0, p1}, Lb/b/a/a/c/h;->b(I)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/b;->f(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/f;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/b;->h(Lcom/ape/offlinescriptmanager/utils/m/b;)Lb/b/a/a/c/h;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/c/f;->c(Lb/b/a/a/c/h;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public characters([CII)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lorg/xml/sax/helpers/DefaultHandler;->characters([CII)V

    return-void
.end method

.method public endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    const-string p1, "attribute"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/utils/m/b;->e(Lcom/ape/offlinescriptmanager/utils/m/b;Z)Z

    :cond_0
    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 0

    const-string p1, "runtask"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->j(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_0

    :cond_0
    const-string p1, "testpoint"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->l(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_0

    :cond_1
    const-string p1, "testcase"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->k(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_0

    :cond_2
    const-string p1, "device"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->e(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_0

    :cond_3
    const-string p1, "jar"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->f(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_4
    const-string p1, "apk"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->a(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_5
    const-string p1, "package"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->h(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_6
    const-string p1, "class"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->c(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_7
    const-string p1, "method"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->g(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_8
    const-string p1, "runner"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_9

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->i(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_9
    const-string p1, "arg"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_a

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_a
    const-string p1, "attribute"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/b$b;->b:Lcom/ape/offlinescriptmanager/utils/m/b;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/utils/m/b;->e(Lcom/ape/offlinescriptmanager/utils/m/b;Z)Z

    goto :goto_0

    :cond_b
    const-string p1, "cmd"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_c

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/b$b;->d(Lorg/xml/sax/Attributes;)V

    :cond_c
    :goto_0
    return-void
.end method
