.class public Ld/l;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/l$a;
    }
.end annotation


# static fields
.field public static final a:[B

.field public static final b:[B

.field public static final c:Ljava/nio/charset/Charset;

.field public static final d:[B

.field public static final e:[B

.field public static final f:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/4 v0, 0x0

    new-array v1, v0, [B

    sput-object v1, Ld/l;->a:[B

    new-array v0, v0, [B

    sput-object v0, Ld/l;->b:[B

    const-string v0, "UTF-8"

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v1, "PAUSE"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    sput-object v1, Ld/l;->d:[B

    const-string v1, "RESUME"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    sput-object v1, Ld/l;->e:[B

    const-string v1, "TERMINATE"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Ld/l;->f:[B

    return-void
.end method

.method private static a(Ld/c;)V
    .locals 0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ld/c;->a()Z

    move-result p0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    invoke-direct {p0}, Ljava/lang/IllegalStateException;-><init>()V

    throw p0
.end method

.method public static b()Ld/c;
    .locals 1

    new-instance v0, Ld/c;

    invoke-direct {v0}, Ld/c;-><init>()V

    return-object v0
.end method

.method public static c(I)Ld/c;
    .locals 2

    if-ltz p0, :cond_0

    invoke-static {}, Ld/l;->b()Ld/c;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, v1, p0}, Ld/l;->d(Ld/c;II)V

    return-object v0

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "io_threads must not be negative"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static d(Ld/c;II)V
    .locals 0

    invoke-static {p0}, Ld/l;->a(Ld/c;)V

    invoke-virtual {p0, p1, p2}, Ld/c;->r(II)Z

    return-void
.end method
