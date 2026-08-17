.class public final Ld/e$a;
.super Ld/e;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "a"
.end annotation


# instance fields
.field private final h:Ljava/io/ByteArrayOutputStream;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ld/e;-><init>()V

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object v0, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    return-void
.end method


# virtual methods
.method public B()I
    .locals 1

    iget-object v0, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v0

    return v0
.end method

.method public D()Ld/e;
    .locals 3

    new-instance v0, Ld/e;

    iget-object v1, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Ld/e;-><init>(Ld/e;Ljava/io/ByteArrayOutputStream;Ld/e;)V

    return-object v0
.end method

.method protected r(IB)Ld/e;
    .locals 0

    iget-object p1, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p1, p2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    return-object p0
.end method

.method public t(Ljava/nio/ByteBuffer;II)Ld/e;
    .locals 3

    if-nez p1, :cond_0

    return-object p0

    :cond_0
    move v0, p2

    :goto_0
    add-int v1, p2, p3

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Ld/e;->i()I

    move-result p1

    add-int/2addr p1, p3

    invoke-virtual {p0, p1}, Ld/e;->A(I)V

    return-object p0

    :cond_1
    iget-object v1, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/io/ByteArrayOutputStream;->write(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method public v([BII)Ld/e;
    .locals 1

    if-nez p1, :cond_0

    return-object p0

    :cond_0
    iget-object v0, p0, Ld/e$a;->h:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    invoke-virtual {p0}, Ld/e;->i()I

    move-result p1

    add-int/2addr p1, p3

    invoke-virtual {p0, p1}, Ld/e;->A(I)V

    return-object p0
.end method

.method public y(I)V
    .locals 0

    invoke-super {p0, p1}, Ld/e;->y(I)V

    return-void
.end method
