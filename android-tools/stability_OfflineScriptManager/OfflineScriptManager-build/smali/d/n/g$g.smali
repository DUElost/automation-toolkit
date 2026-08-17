.class final Ld/n/g$g;
.super Ld/n/g$e$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "g"
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

    iput-object p1, p0, Ld/n/g$g;->a:Ld/n/g;

    invoke-direct {p0}, Ld/n/g$e$a;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/g;Ld/n/g$g;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g$g;-><init>(Ld/n/g;)V

    return-void
.end method


# virtual methods
.method public b()Ld/e;
    .locals 2

    iget-object v0, p0, Ld/n/g$g;->a:Ld/n/g;

    invoke-static {v0}, Ld/n/g;->x(Ld/n/g;)Ld/n/f;

    move-result-object v0

    invoke-virtual {v0}, Ld/n/f;->O0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v1, p0, Ld/n/g$g;->a:Ld/n/g;

    invoke-static {v1}, Ld/n/g;->v(Ld/n/g;)Ld/n/i/a;

    move-result-object v1

    invoke-virtual {v1, v0}, Ld/n/i/a;->k(Ld/e;)Ld/e;

    move-result-object v0

    return-object v0
.end method
