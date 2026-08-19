.class enum Ld/r/d$g;
.super Ld/r/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4000
    name = null
.end annotation


# direct methods
.method varargs constructor <init>(Ljava/lang/String;I[Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Ld/r/d;-><init>(Ljava/lang/String;I[Ljava/lang/String;Ld/r/d;)V

    return-void
.end method


# virtual methods
.method c(Ld/c;II)Ld/j;
    .locals 1

    new-instance v0, Ld/r/h/c;

    invoke-direct {v0, p1, p2, p3}, Ld/r/h/c;-><init>(Ld/c;II)V

    return-object v0
.end method

.method public d(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;
    .locals 7

    new-instance v6, Ld/r/h/c$a;

    move-object v0, v6

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Ld/r/h/c$a;-><init>(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)V

    return-object v6
.end method
