.class public Ld/n/h/g/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/h/e;


# instance fields
.field private final a:Ljava/nio/ByteBuffer;

.field protected b:Ld/e;


# direct methods
.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iput-object p1, p0, Ld/n/h/g/a;->a:Ljava/nio/ByteBuffer;

    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    iput-object p1, p0, Ld/n/h/g/a;->b:Ld/e;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public b()Ld/e;
    .locals 1

    iget-object v0, p0, Ld/n/h/g/a;->b:Ld/e;

    return-object v0
.end method

.method public c(Ljava/nio/ByteBuffer;ILd/s/f;)Ld/n/h/e$a$a;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/nio/ByteBuffer;",
            "I",
            "Ld/s/f<",
            "Ljava/lang/Integer;",
            ">;)",
            "Ld/n/h/e$a$a;"
        }
    .end annotation

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p3, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    new-instance p3, Ld/e;

    invoke-direct {p3, p2}, Ld/e;-><init>(I)V

    iput-object p3, p0, Ld/n/h/g/a;->b:Ld/e;

    invoke-virtual {p3, p1}, Ld/e;->s(Ljava/nio/ByteBuffer;)Ld/e;

    sget-object p1, Ld/n/h/e$a$a;->c:Ld/n/h/e$a$a;

    return-object p1
.end method

.method public d()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Ld/n/h/g/a;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/h/g/a;->a:Ljava/nio/ByteBuffer;

    return-object v0
.end method
