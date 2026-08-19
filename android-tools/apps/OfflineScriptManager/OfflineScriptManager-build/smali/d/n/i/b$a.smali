.class enum Ld/n/i/b$a;
.super Ld/n/i/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/i/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4000
    name = null
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/String;I)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Ld/n/i/b;-><init>(Ljava/lang/String;ILd/n/i/b;)V

    return-void
.end method


# virtual methods
.method public a(Ld/n/f;Ld/n/j/a;Ld/f;)Ld/n/i/a;
    .locals 1

    new-instance v0, Ld/n/i/c;

    invoke-direct {v0, p1, p2, p3}, Ld/n/i/c;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    return-object v0
.end method
