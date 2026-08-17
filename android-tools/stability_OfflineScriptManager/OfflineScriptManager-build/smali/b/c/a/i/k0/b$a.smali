.class Lb/c/a/i/k0/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/c/a/i/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/c/a/i/k0/b;->b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lb/c/a/i/k0/b;

.field private final synthetic c:J

.field private final synthetic d:Ljava/nio/ByteBuffer;


# direct methods
.method constructor <init>(Lb/c/a/i/k0/b;JLjava/nio/ByteBuffer;)V
    .locals 0

    iput-object p1, p0, Lb/c/a/i/k0/b$a;->b:Lb/c/a/i/k0/b;

    iput-wide p2, p0, Lb/c/a/i/k0/b$a;->c:J

    iput-object p4, p0, Lb/c/a/i/k0/b$a;->d:Ljava/nio/ByteBuffer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/k0/b$a;->c:J

    return-wide v0
.end method

.method public b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
    .locals 0

    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "NotImplemented"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public getParent()Lb/c/a/i/e;
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/b$a;->b:Lb/c/a/i/k0/b;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    const-string v0, "----"

    return-object v0
.end method

.method public m(Lb/c/a/i/e;)V
    .locals 1

    sget-boolean v0, Lb/c/a/i/k0/b;->A:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lb/c/a/i/k0/b$a;->b:Lb/c/a/i/k0/b;

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/lang/AssertionError;

    const-string v0, "you cannot diswown this special box"

    invoke-direct {p1, v0}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw p1

    :cond_1
    :goto_0
    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 1

    iget-object v0, p0, Lb/c/a/i/k0/b$a;->d:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    iget-object v0, p0, Lb/c/a/i/k0/b$a;->d:Ljava/nio/ByteBuffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    return-void
.end method
