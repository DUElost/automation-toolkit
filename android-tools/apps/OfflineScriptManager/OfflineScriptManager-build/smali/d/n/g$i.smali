.class final Ld/n/g$i;
.super Ld/n/g$e$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "i"
.end annotation


# instance fields
.field final synthetic a:Ld/n/g;


# direct methods
.method private constructor <init>(Ld/n/g;)V
    .locals 0

    iput-object p1, p0, Ld/n/g$i;->a:Ld/n/g;

    invoke-direct {p0}, Ld/n/g$e$a;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/g;Ld/n/g$i;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g$i;-><init>(Ld/n/g;)V

    return-void
.end method


# virtual methods
.method public a(Ld/e;)Z
    .locals 2

    iget-object v0, p0, Ld/n/g$i;->a:Ld/n/g;

    invoke-static {v0}, Ld/n/g;->x(Ld/n/g;)Ld/n/f;

    move-result-object v0

    invoke-virtual {v0, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Ld/n/g$i;->a:Ld/n/g;

    invoke-static {v0}, Ld/n/g;->m(Ld/n/g;)Ld/n/g$e;

    move-result-object v1

    invoke-static {v0, v1}, Ld/n/g;->l(Ld/n/g;Ld/n/g$e;)V

    :cond_0
    return p1
.end method
