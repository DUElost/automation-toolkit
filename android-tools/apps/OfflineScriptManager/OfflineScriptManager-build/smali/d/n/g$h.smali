.class final Ld/n/g$h;
.super Ld/n/g$e$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "h"
.end annotation


# instance fields
.field final synthetic a:Ld/n/g;


# direct methods
.method private constructor <init>(Ld/n/g;)V
    .locals 0

    iput-object p1, p0, Ld/n/g$h;->a:Ld/n/g;

    invoke-direct {p0}, Ld/n/g$e$a;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/g;Ld/n/g$h;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g$h;-><init>(Ld/n/g;)V

    return-void
.end method


# virtual methods
.method public a(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/n/g$h;->a:Ld/n/g;

    invoke-static {v0, p1}, Ld/n/g;->r(Ld/n/g;Ld/e;)Z

    move-result p1

    return p1
.end method

.method public b()Ld/e;
    .locals 1

    iget-object v0, p0, Ld/n/g$h;->a:Ld/n/g;

    invoke-static {v0}, Ld/n/g;->p(Ld/n/g;)Ld/e;

    move-result-object v0

    return-object v0
.end method
