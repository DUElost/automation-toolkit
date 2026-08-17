.class Lcom/ape/offlinescriptmanager/utils/m/d$b;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/m/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/utils/m/d;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/d;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/d;Lcom/ape/offlinescriptmanager/utils/m/d$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/d$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/d;)V

    return-void
.end method

.method private a(Lorg/xml/sax/Attributes;)V
    .locals 2

    if-eqz p1, :cond_0

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getQName(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(I)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->d(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/e;

    move-result-object v0

    invoke-virtual {v0, v1, p1}, Lb/b/a/a/e/e;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private b(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    new-instance v1, Lb/b/a/a/e/a;

    invoke-direct {v1}, Lb/b/a/a/e/a;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->o(Lcom/ape/offlinescriptmanager/utils/m/d;Lb/b/a/a/e/a;)Lb/b/a/a/e/a;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->n(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/e/a;->d(Ljava/lang/String;)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->f(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/d;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->f(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/d;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->n(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/a;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/e/d;->a(Lb/b/a/a/e/a;)V

    :cond_1
    return-void
.end method

.method private c(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    new-instance v1, Lb/b/a/a/e/b;

    invoke-direct {v1}, Lb/b/a/a/e/b;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->s(Lcom/ape/offlinescriptmanager/utils/m/d;Lb/b/a/a/e/b;)Lb/b/a/a/e/b;

    if-eqz p1, :cond_b

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/e/b;->c(Ljava/lang/String;)V

    const-string v0, "value"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "@@"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    const-string v0, "@@localnumber1"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->t(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p1, v0}, Lb/b/a/a/e/b;->d(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_0
    const-string v0, "@@localnumber2"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->u(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const-string v0, "@@remotenumber1"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->v(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    const-string v0, "@@devicebnumber1"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->w(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_3
    const-string v0, "@@devicebnumber2"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->x(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_4
    const-string v0, "@@EmailAccount"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->g(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_5
    const-string v0, "@@EmailPassword"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->i(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_6
    const-string v0, "@@GoogleAccount"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->j(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_7
    const-string v0, "@@GooglePassword"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->k(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_8
    const-string v0, "@@WifiAccount"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->l(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_9
    const-string v0, "@@WifiPassword"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->m(Lcom/ape/offlinescriptmanager/utils/m/d;)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_a
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/e/b;->d(Ljava/lang/String;)V

    :cond_b
    :goto_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->p(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/c;

    move-result-object p1

    if-eqz p1, :cond_c

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->p(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/c;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->r(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/b;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/e/c;->a(Lb/b/a/a/e/b;)V

    :cond_c
    return-void
.end method

.method private d(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    new-instance v1, Lb/b/a/a/e/c;

    invoke-direct {v1}, Lb/b/a/a/e/c;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->q(Lcom/ape/offlinescriptmanager/utils/m/d;Lb/b/a/a/e/c;)Lb/b/a/a/e/c;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->p(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/e/c;->d(Ljava/lang/String;)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->n(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/a;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->n(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/a;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->p(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/c;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/e/a;->a(Lb/b/a/a/e/c;)V

    :cond_1
    return-void
.end method

.method private e(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    new-instance v1, Lb/b/a/a/e/d;

    invoke-direct {v1}, Lb/b/a/a/e/d;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->h(Lcom/ape/offlinescriptmanager/utils/m/d;Lb/b/a/a/e/d;)Lb/b/a/a/e/d;

    if-eqz p1, :cond_0

    const-string v0, "appPackageName"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->f(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/d;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/e/d;->e(Ljava/lang/String;)V

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->d(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/e;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/d;->d(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/e;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->f(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/d;

    move-result-object v0

    invoke-virtual {p1, v0}, Lb/b/a/a/e/e;->b(Lb/b/a/a/e/d;)V

    :cond_1
    return-void
.end method

.method private f(Lorg/xml/sax/Attributes;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    new-instance v1, Lb/b/a/a/e/e;

    invoke-direct {v1}, Lb/b/a/a/e/e;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->e(Lcom/ape/offlinescriptmanager/utils/m/d;Lb/b/a/a/e/e;)Lb/b/a/a/e/e;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/d;->d(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/e;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/b/a/a/e/e;->g(Ljava/lang/String;)V

    const-string v0, "TakeScreenshot"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a:Lcom/ape/offlinescriptmanager/utils/m/d;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/d;->d(Lcom/ape/offlinescriptmanager/utils/m/d;)Lb/b/a/a/e/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lb/b/a/a/e/e;->h(Ljava/lang/String;)V

    :cond_0
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

    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 0

    const-string p1, "TestSet"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->f(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_0
    const-string p1, "TestPackage"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->e(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_1
    const-string p1, "TestCase"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->b(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_2
    const-string p1, "TestMethod"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->d(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_3
    const-string p1, "TestData"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->c(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_4
    const-string p1, "SIM"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/d$b;->a(Lorg/xml/sax/Attributes;)V

    :cond_5
    :goto_0
    return-void
.end method
