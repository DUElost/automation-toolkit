.class public Ld/n/e;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/e$a;
    }
.end annotation


# instance fields
.field private final a:Ljava/util/Properties;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    iput-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    return-void
.end method

.method private a(Ljava/nio/ByteBuffer;II)[B
    .locals 2

    new-array v0, p3, [B

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    const/4 p2, 0x0

    invoke-virtual {p1, v0, p2, p3}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    return-object v0
.end method


# virtual methods
.method public final b()Z
    .locals 1

    iget-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->isEmpty()Z

    move-result v0

    return v0
.end method

.method public final c(Ljava/nio/ByteBuffer;ILd/n/e$a;)I
    .locals 6

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    :goto_0
    const/4 v1, 0x1

    if-gt v0, v1, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    add-int/2addr p2, v1

    add-int/lit8 v0, v0, -0x1

    if-ge v0, v2, :cond_1

    goto :goto_1

    :cond_1
    new-instance v1, Ljava/lang/String;

    invoke-direct {p0, p1, p2, v2}, Ld/n/e;->a(Ljava/nio/ByteBuffer;II)[B

    move-result-object v3

    sget-object v4, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-direct {v1, v3, v4}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    add-int/2addr p2, v2

    sub-int/2addr v0, v2

    const/4 v2, 0x4

    if-ge v0, v2, :cond_2

    goto :goto_1

    :cond_2
    invoke-static {p1, p2}, Ld/s/g;->a(Ljava/nio/ByteBuffer;I)I

    move-result v3

    add-int/2addr p2, v2

    add-int/lit8 v0, v0, -0x4

    if-ge v0, v3, :cond_4

    :goto_1
    if-lez v0, :cond_3

    const p1, 0x9523e34

    return p1

    :cond_3
    const/4 p1, 0x0

    return p1

    :cond_4
    invoke-direct {p0, p1, p2, v3}, Ld/n/e;->a(Ljava/nio/ByteBuffer;II)[B

    move-result-object v2

    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v2, v4}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    add-int/2addr p2, v3

    sub-int/2addr v0, v3

    if-eqz p3, :cond_5

    invoke-interface {p3, v1, v2, v5}, Ld/n/e$a;->a(Ljava/lang/String;[BLjava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_5

    return v2

    :cond_5
    invoke-virtual {p0, v1, v5}, Ld/n/e;->d(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1, p2}, Ljava/util/Properties;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;

    return-void
.end method

.method public final e(Ld/n/e;)V
    .locals 1

    iget-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    iget-object p1, p1, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->putAll(Ljava/util/Map;)V

    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 2

    if-ne p0, p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    :cond_1
    instance-of v1, p1, Ld/n/e;

    if-nez v1, :cond_2

    return v0

    :cond_2
    check-cast p1, Ld/n/e;

    iget-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    iget-object p1, p1, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0, p1}, Ljava/util/Properties;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0}, Ljava/util/Properties;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Metadata="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ld/n/e;->a:Ljava/util/Properties;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
