.class final Ld/n/g$a;
.super Ld/n/g$e$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Ld/n/g;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>(Ld/n/g;)V
    .locals 0

    iput-object p1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-direct {p0}, Ld/n/g$e$a;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/g;Ld/n/g$a;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g$a;-><init>(Ld/n/g;)V

    return-void
.end method


# virtual methods
.method public a(Ld/e;)Z
    .locals 2

    iget-object v0, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {v0}, Ld/n/g;->v(Ld/n/g;)Ld/n/i/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Ld/n/i/a;->i(Ld/e;)Ld/e;

    move-result-object p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    iget-object v1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {v1}, Ld/n/g;->w(Ld/n/g;)Ld/n/e;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {v1}, Ld/n/g;->w(Ld/n/g;)Ld/n/e;

    move-result-object v1

    invoke-virtual {p1, v1}, Ld/e;->z(Ld/n/e;)Ld/e;

    :cond_1
    iget-object v1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {v1}, Ld/n/g;->x(Ld/n/g;)Ld/n/f;

    move-result-object v1

    invoke-virtual {v1, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {p1}, Ld/n/g;->y(Ld/n/g;)Ld/s/c;

    move-result-object p1

    const/16 v1, 0x23

    invoke-virtual {p1, v1}, Ld/s/c;->b(I)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Ld/n/g$a;->a:Ld/n/g;

    invoke-static {p1}, Ld/n/g;->k(Ld/n/g;)Ld/n/g$e;

    move-result-object v1

    invoke-static {p1, v1}, Ld/n/g;->l(Ld/n/g;Ld/n/g$e;)V

    :cond_2
    return v0

    :cond_3
    const/4 p1, 0x1

    return p1
.end method
