.class Lcom/ape/offlinescriptmanager/utils/m/f$b;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/m/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/utils/m/f;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/f;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/f;Lcom/ape/offlinescriptmanager/utils/m/f$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/f$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/f;)V

    return-void
.end method

.method private a(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    :goto_0
    invoke-virtual {v0, p1}, Lb/b/a/a/d/e;->p(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method private b(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->f(Lcom/ape/offlinescriptmanager/utils/m/f;)Z

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
    new-instance v1, Lb/b/a/a/d/b;

    invoke-direct {v1, v0, p1}, Lb/b/a/a/d/b;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object p1

    invoke-interface {p1, v1}, Lb/b/a/a/d/c;->f(Lb/b/a/a/d/b;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object p1

    :goto_0
    invoke-virtual {p1, v1}, Lb/b/a/a/d/g;->f(Lb/b/a/a/d/b;)V

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object p1

    goto :goto_0

    :cond_4
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object p1

    goto :goto_0

    :cond_5
    :goto_1
    return-void
.end method

.method private c(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/j;->o(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    :goto_0
    invoke-virtual {v0, p1}, Lb/b/a/a/d/e;->q(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method

.method private d(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->g(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->g(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/a;->o(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private e(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->j(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/d;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->j(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/d;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/d;->o(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private f(Lorg/xml/sax/Attributes;)V
    .locals 2

    const-string v0, "content"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->d(Lcom/ape/offlinescriptmanager/utils/m/f;)I

    move-result v0

    const/4 v1, 0x1

    if-ne v1, v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    :goto_0
    invoke-virtual {v0, p1}, Lb/b/a/a/d/h;->g(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    const/4 v0, 0x2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->d(Lcom/ape/offlinescriptmanager/utils/m/f;)I

    move-result v1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->r(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x3

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->d(Lcom/ape/offlinescriptmanager/utils/m/f;)I

    move-result v1

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object v0

    invoke-interface {v0, p1}, Lb/b/a/a/d/c;->g(Ljava/lang/String;)V

    :cond_2
    :goto_1
    return-void
.end method

.method private g(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object v0

    invoke-interface {v0, p1}, Lb/b/a/a/d/c;->c(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private h(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/j;->p(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private i(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/j;->q(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    :goto_0
    invoke-virtual {v0, p1}, Lb/b/a/a/d/e;->s(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method

.method private j(Lorg/xml/sax/Attributes;)V
    .locals 1

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    :goto_0
    invoke-virtual {v0, p1}, Lb/b/a/a/d/e;->r(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method private k(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/h;

    invoke-direct {v1}, Lb/b/a/a/d/h;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->s(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/h;)Lb/b/a/a/d/h;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->r(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/h;->p(Ljava/lang/String;)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->r(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/f;->q(Lb/b/a/a/d/h;)V

    :cond_1
    return-void
.end method

.method private l(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/f;

    invoke-direct {v1}, Lb/b/a/a/d/f;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->o(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/f;)Lb/b/a/a/d/f;

    if-eqz p1, :cond_5

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/d/f;->o(Ljava/lang/String;)V

    const-string v0, "times"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/d/f;->w(I)V

    const-string v0, "testpointRegressionTimes"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/d/f;->u(I)V

    :cond_0
    const-string v0, "taskRegressionType"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/d/f;->s(I)V

    :cond_1
    const-string v0, "caseRegressionType"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Lb/b/a/a/d/f;->m(I)V

    :cond_2
    const-string v0, "takeScreenshot"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    const-string v1, "false"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Lb/b/a/a/d/f;->r(Z)V

    goto :goto_1

    :cond_3
    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v0

    const/4 v1, 0x1

    goto :goto_0

    :cond_4
    :goto_1
    const-string v0, "testTimeOut"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    invoke-virtual {v0, p1}, Lb/b/a/a/d/f;->v(I)V

    :cond_5
    return-void
.end method

.method private m(Lorg/xml/sax/Attributes;)V
    .locals 3

    const-string v0, "type"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "times"

    invoke-interface {p1, v1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/f;->u(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/c;)Lb/b/a/a/d/c;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/f;->w(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/j;)Lb/b/a/a/d/j;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/f;->y(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/e;)Lb/b/a/a/d/e;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1, v2}, Lcom/ape/offlinescriptmanager/utils/m/f;->A(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/i;)Lb/b/a/a/d/i;

    const-string v1, "adb"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/a;

    invoke-direct {v1}, Lb/b/a/a/d/a;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->h(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/a;)Lb/b/a/a/d/a;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->g(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/g;->m(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->g(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/a;

    move-result-object v0

    :goto_0
    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->u(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/c;)Lb/b/a/a/d/c;

    goto/16 :goto_1

    :cond_0
    const-string v1, "local"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/d;

    invoke-direct {v1}, Lb/b/a/a/d/d;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->k(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/d;)Lb/b/a/a/d/d;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->j(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/d;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/g;->m(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->j(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/d;

    move-result-object v0

    goto :goto_0

    :cond_1
    const-string v1, "uiautomator"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/j;

    invoke-direct {v1}, Lb/b/a/a/d/j;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->w(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/j;)Lb/b/a/a/d/j;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/g;->m(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->v(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/j;

    move-result-object v0

    goto :goto_0

    :cond_2
    const-string v1, "robotium"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/e;

    invoke-direct {v1}, Lb/b/a/a/d/e;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->y(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/e;)Lb/b/a/a/d/e;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/g;->m(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->x(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/e;

    move-result-object v0

    goto :goto_0

    :cond_3
    const-string v1, "uiautomator2"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/i;

    invoke-direct {v1}, Lb/b/a/a/d/i;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->A(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/i;)Lb/b/a/a/d/i;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/d/g;->m(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->z(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/i;

    move-result-object v0

    goto/16 :goto_0

    :cond_4
    :goto_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object p1

    if-nez p1, :cond_5

    return-void

    :cond_5
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->l(Lcom/ape/offlinescriptmanager/utils/m/f;)Z

    move-result p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object p1

    goto :goto_2

    :cond_6
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->r(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->r(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object p1

    :goto_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->t(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/c;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/h;->l(Lb/b/a/a/d/c;)V

    :cond_7
    return-void
.end method

.method private n(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    new-instance v1, Lb/b/a/a/d/h;

    invoke-direct {v1}, Lb/b/a/a/d/h;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->q(Lcom/ape/offlinescriptmanager/utils/m/f;Lb/b/a/a/d/h;)Lb/b/a/a/d/h;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/d/h;->p(Ljava/lang/String;)V

    const-string v0, "times"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    invoke-virtual {v0, p1}, Lb/b/a/a/d/h;->q(I)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/f;->n(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/f;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/f;->p(Lcom/ape/offlinescriptmanager/utils/m/f;)Lb/b/a/a/d/h;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/d/f;->a(Lb/b/a/a/d/h;)V

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

    const-string p1, "proviouspoint"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 p3, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1, p3}, Lcom/ape/offlinescriptmanager/utils/m/f;->m(Lcom/ape/offlinescriptmanager/utils/m/f;Z)Z

    goto :goto_0

    :cond_0
    const-string p1, "attribute"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1, p3}, Lcom/ape/offlinescriptmanager/utils/m/f;->i(Lcom/ape/offlinescriptmanager/utils/m/f;Z)Z

    :cond_1
    :goto_0
    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 0

    const-string p1, "task"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->l(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_1

    :cond_0
    const-string p1, "testpoint"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 p3, 0x1

    if-eqz p1, :cond_1

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->n(Lorg/xml/sax/Attributes;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1, p3}, Lcom/ape/offlinescriptmanager/utils/m/f;->e(Lcom/ape/offlinescriptmanager/utils/m/f;I)I

    goto/16 :goto_1

    :cond_1
    const-string p1, "testcase"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->m(Lorg/xml/sax/Attributes;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    const/4 p2, 0x3

    :goto_0
    invoke-static {p1, p2}, Lcom/ape/offlinescriptmanager/utils/m/f;->e(Lcom/ape/offlinescriptmanager/utils/m/f;I)I

    goto/16 :goto_1

    :cond_2
    const-string p1, "description"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->f(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_1

    :cond_3
    const-string p1, "device"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->g(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_1

    :cond_4
    const-string p1, "jar"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->h(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_1

    :cond_5
    const-string p1, "apk"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a(Lorg/xml/sax/Attributes;)V

    goto/16 :goto_1

    :cond_6
    const-string p1, "package"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->j(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_7
    const-string p1, "class"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->c(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_8
    const-string p1, "method"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_9

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->i(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_9
    const-string p1, "arg"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_a

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->b(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_a
    const-string p1, "attribute"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1, p3}, Lcom/ape/offlinescriptmanager/utils/m/f;->i(Lcom/ape/offlinescriptmanager/utils/m/f;Z)Z

    goto :goto_1

    :cond_b
    const-string p1, "cmd"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_c

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->d(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_c
    const-string p1, "command"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_d

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->e(Lorg/xml/sax/Attributes;)V

    goto :goto_1

    :cond_d
    const-string p1, "proviouspoint"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_e

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/f$b;->k(Lorg/xml/sax/Attributes;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    invoke-static {p1, p3}, Lcom/ape/offlinescriptmanager/utils/m/f;->m(Lcom/ape/offlinescriptmanager/utils/m/f;Z)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/f$b;->a:Lcom/ape/offlinescriptmanager/utils/m/f;

    const/4 p2, 0x2

    goto/16 :goto_0

    :cond_e
    :goto_1
    return-void
.end method
