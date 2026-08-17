.class Ld/n/i/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/e$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ld/n/i/a;->n(Ljava/nio/ByteBuffer;IZ)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ld/n/i/a;


# direct methods
.method constructor <init>(Ld/n/i/a;)V
    .locals 0

    iput-object p1, p0, Ld/n/i/a$a;->a:Ld/n/i/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;[BLjava/lang/String;)I
    .locals 2

    const-string v0, "Identity"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/i/a$a;->a:Ld/n/i/a;

    iget-object v1, v0, Ld/n/i/a;->a:Ld/f;

    iget-boolean v1, v1, Ld/f;->t:Z

    if-eqz v1, :cond_0

    invoke-static {v0, p2}, Ld/n/i/a;->a(Ld/n/i/a;[B)V

    goto :goto_0

    :cond_0
    const-string v0, "Socket-Type"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Ld/n/i/a$a;->a:Ld/n/i/a;

    iget-object p1, p1, Ld/n/i/a;->a:Ld/f;

    iget p1, p1, Ld/f;->j:I

    invoke-static {p1, p3}, Ld/r/d;->a(ILjava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    const/16 p1, 0x16

    return p1

    :cond_1
    iget-object p3, p0, Ld/n/i/a$a;->a:Ld/n/i/a;

    invoke-virtual {p3, p1, p2}, Ld/n/i/a;->r(Ljava/lang/String;[B)I

    move-result p1

    const/4 p2, -0x1

    if-ne p1, p2, :cond_2

    return p2

    :cond_2
    :goto_0
    const/4 p1, 0x0

    return p1
.end method
