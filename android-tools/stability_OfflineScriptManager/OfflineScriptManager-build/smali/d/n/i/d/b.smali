.class public Ld/n/i/d/b;
.super Ld/n/i/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/d/b$a;
    }
.end annotation


# static fields
.field private static synthetic v:[I


# instance fields
.field private i:Ld/n/i/d/b$a;

.field private final j:[B

.field private final k:[B

.field private final l:[B

.field private final m:[B

.field private final n:[B

.field private o:[B

.field private p:[B

.field private final q:[B

.field private r:J

.field private s:J

.field private final t:Ld/n/i/d/a;

.field private final u:Ld/s/c;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/f;)V
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0, p1}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    sget-object v0, Ld/n/i/d/a$a;->e:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    new-array v0, v0, [B

    iput-object v0, p0, Ld/n/i/d/b;->o:[B

    const/16 v0, 0x60

    new-array v0, v0, [B

    iput-object v0, p0, Ld/n/i/d/b;->p:[B

    sget-object v0, Ld/n/i/d/a$a;->h:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    new-array v0, v0, [B

    iput-object v0, p0, Ld/n/i/d/b;->q:[B

    sget-object v0, Ld/n/i/d/b$a;->b:Ld/n/i/d/b$a;

    iput-object v0, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    const-wide/16 v0, 0x1

    iput-wide v0, p0, Ld/n/i/d/b;->r:J

    iput-wide v0, p0, Ld/n/i/d/b;->s:J

    iget-object v0, p1, Ld/f;->G:[B

    iput-object v0, p0, Ld/n/i/d/b;->j:[B

    iget-object v0, p1, Ld/f;->H:[B

    iput-object v0, p0, Ld/n/i/d/b;->k:[B

    iget-object v0, p1, Ld/f;->I:[B

    iput-object v0, p0, Ld/n/i/d/b;->n:[B

    new-instance v0, Ld/n/i/d/a;

    invoke-direct {v0}, Ld/n/i/d/a;-><init>()V

    iput-object v0, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    invoke-virtual {v0}, Ld/n/i/d/a;->f()[[B

    move-result-object v0

    const/4 v1, 0x0

    aget-object v1, v0, v1

    iput-object v1, p0, Ld/n/i/d/b;->l:[B

    const/4 v1, 0x1

    aget-object v0, v0, v1

    iput-object v0, p0, Ld/n/i/d/b;->m:[B

    iget-object p1, p1, Ld/f;->P:Ld/s/c;

    iput-object p1, p0, Ld/n/i/d/b;->u:Ld/s/c;

    return-void
.end method

.method static synthetic A()[I
    .locals 3

    sget-object v0, Ld/n/i/d/b;->v:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/i/d/b$a;->values()[Ld/n/i/d/b$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/i/d/b$a;->g:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/i/d/b$a;->f:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/i/d/b$a;->e:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/i/d/b$a;->c:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/i/d/b$a;->b:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/i/d/b$a;->d:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    sput-object v0, Ld/n/i/d/b;->v:[I

    return-object v0
.end method

.method private B(Ld/e;)I
    .locals 3

    iget-object v0, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    sget-object v1, Ld/n/i/d/b$a;->c:Ld/n/i/d/b$a;

    const v2, 0x9523e34

    if-eq v0, v1, :cond_0

    sget-object v1, Ld/n/i/d/b$a;->e:Ld/n/i/d/b$a;

    if-eq v0, v1, :cond_0

    return v2

    :cond_0
    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x7

    if-ge v0, v1, :cond_1

    return v2

    :cond_1
    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Ld/e;->e(I)B

    move-result v0

    invoke-virtual {p1}, Ld/e;->B()I

    move-result p1

    sub-int/2addr p1, v1

    if-le v0, p1, :cond_2

    return v2

    :cond_2
    sget-object p1, Ld/n/i/d/b$a;->f:Ld/n/i/d/b$a;

    iput-object p1, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    const/4 p1, 0x0

    return p1
.end method

.method private C(Ld/e;)I
    .locals 12

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const v1, 0x9523e34

    const/16 v2, 0x1e

    if-ge v0, v2, :cond_0

    return v1

    :cond_0
    sget-object v0, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v3

    add-int/2addr v2, v3

    const/16 v3, 0xe

    sub-int/2addr v2, v3

    sget-object v4, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    sget-object v10, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit16 v4, v4, 0x100

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit8 v4, v4, 0x10

    add-int/lit16 v4, v4, 0x100

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    sub-int v0, v2, v0

    invoke-virtual {p1, v6, v3, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v3, "CurveZMQREADY---"

    invoke-virtual {v3, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v8, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v0, 0x8

    const/4 v3, 0x6

    invoke-virtual {p1, v8, v3, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    invoke-static {p1, v3}, Ld/s/g;->c(Ld/e;I)J

    move-result-wide v3

    iput-wide v3, p0, Ld/n/i/d/b;->s:J

    iget-object v4, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    iget-object v9, p0, Ld/n/i/d/b;->q:[B

    move-object v5, v11

    move v7, v2

    invoke-virtual/range {v4 .. v9}, Ld/n/i/d/a;->i(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    move-result p1

    if-eqz p1, :cond_1

    return v1

    :cond_1
    invoke-virtual {v11, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result p1

    const/4 v0, 0x0

    invoke-virtual {p0, v11, p1, v0}, Ld/n/i/a;->n(Ljava/nio/ByteBuffer;IZ)I

    move-result p1

    if-nez p1, :cond_2

    sget-object v0, Ld/n/i/d/b$a;->g:Ld/n/i/d/b$a;

    iput-object v0, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    :cond_2
    return p1
.end method

.method private D(Ld/e;)I
    .locals 10

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const v1, 0x9523e34

    const/16 v2, 0xa8

    if-eq v0, v2, :cond_0

    const-string p1, "CURVE I: server HELLO is not correct size"

    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v1

    :cond_0
    sget-object v0, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    sget-object v0, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v2

    add-int/lit16 v2, v2, 0x80

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    sget-object v2, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v3

    const/16 v4, 0x90

    add-int/2addr v3, v4

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v5

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {v5, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    const/16 v2, 0x18

    invoke-virtual {p1, v5, v2, v4}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v3, "WELCOME-"

    invoke-virtual {v3, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v2, 0x8

    const/16 v3, 0x10

    invoke-virtual {p1, v6, v2, v3}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    iget-object v2, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->capacity()I

    move-result p1

    iget-object v7, p0, Ld/n/i/d/b;->n:[B

    iget-object v8, p0, Ld/n/i/d/b;->m:[B

    move-object v3, v9

    move-object v4, v5

    move v5, p1

    invoke-virtual/range {v2 .. v8}, Ld/n/i/d/a;->g(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result p1

    if-eqz p1, :cond_1

    return v1

    :cond_1
    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result p1

    invoke-virtual {v9, p1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object p1, p0, Ld/n/i/d/b;->o:[B

    invoke-virtual {v9, p1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/i/d/b;->p:[B

    invoke-virtual {v9, p1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    iget-object v0, p0, Ld/n/i/d/b;->q:[B

    iget-object v1, p0, Ld/n/i/d/b;->o:[B

    iget-object v2, p0, Ld/n/i/d/b;->m:[B

    invoke-virtual {p1, v0, v1, v2}, Ld/n/i/d/a;->c([B[B[B)I

    sget-object p1, Ld/n/i/d/b$a;->d:Ld/n/i/d/b$a;

    iput-object p1, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    const/4 p1, 0x0

    return p1
.end method

.method private E(Ld/e;)I
    .locals 11

    sget-object v0, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v1}, Ld/n/i/d/a$a;->a()I

    move-result v1

    add-int/lit8 v1, v1, 0x40

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v8, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v8}, Ld/n/i/d/a$a;->a()I

    move-result v1

    const/16 v9, 0x50

    add-int/2addr v1, v9

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v10

    sget-object v1, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v2, "CurveZMQHELLO---"

    invoke-virtual {v2, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Ld/n/i/d/b;->r:J

    invoke-static {v0, v1, v2}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v4

    iget-object v6, p0, Ld/n/i/d/b;->n:[B

    iget-object v7, p0, Ld/n/i/d/b;->m:[B

    move-object v2, v10

    move-object v5, v0

    invoke-virtual/range {v1 .. v7}, Ld/n/i/d/a;->d(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v1

    if-eqz v1, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    const-string v1, "HELLO"

    invoke-virtual {p0, p1, v1}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Ld/e;->q(I)Ld/e;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ld/e;->q(I)Ld/e;

    const/16 v2, 0x48

    new-array v2, v2, [B

    invoke-virtual {p1, v2}, Ld/e;->u([B)Ld/e;

    iget-object v2, p0, Ld/n/i/d/b;->l:[B

    invoke-virtual {p1, v2}, Ld/e;->u([B)Ld/e;

    const/16 v2, 0x10

    const/16 v3, 0x8

    invoke-virtual {p1, v0, v2, v3}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    invoke-virtual {v8}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-virtual {p1, v10, v0, v9}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    iget-wide v2, p0, Ld/n/i/d/b;->r:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    iput-wide v2, p0, Ld/n/i/d/b;->r:J

    return v1
.end method

.method private F(Ld/e;)I
    .locals 23

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    sget-object v2, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v3

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v11, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit8 v4, v4, 0x40

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    sget-object v12, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit8 v4, v4, 0x50

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v13

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v4, v0, Ld/n/i/d/b;->l:[B

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/b;->n:[B

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    sget-object v14, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v4, "VOUCH---"

    invoke-virtual {v4, v14}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    const/16 v15, 0x10

    invoke-virtual {v4, v15}, Ld/n/i/d/a;->k(I)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v7

    iget-object v9, v0, Ld/n/i/d/b;->o:[B

    iget-object v10, v0, Ld/n/i/d/b;->k:[B

    move-object v5, v13

    move-object v8, v3

    invoke-virtual/range {v4 .. v10}, Ld/n/i/d/a;->d(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v4

    const/4 v5, -0x1

    if-ne v4, v5, :cond_0

    return v5

    :cond_0
    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit16 v4, v4, 0x80

    add-int/lit16 v4, v4, 0x100

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v6

    add-int/lit16 v6, v6, 0x90

    add-int/lit16 v6, v6, 0x100

    invoke-static {v6}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v7

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v7, v0, Ld/n/i/d/b;->j:[B

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v7, 0x18

    invoke-virtual {v3, v7}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v7

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v4, v3}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v3

    add-int/lit8 v3, v3, 0x50

    invoke-virtual {v13, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v3

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v7

    invoke-virtual {v3, v7}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v4, v13}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    iget-object v3, v0, Ld/n/i/a;->a:Ld/f;

    iget v3, v3, Ld/f;->j:I

    invoke-virtual {v0, v3}, Ld/n/i/a;->x(I)Ljava/lang/String;

    move-result-object v3

    const-string v7, "Socket-Type"

    invoke-virtual {v0, v4, v7, v3}, Ld/n/i/a;->b(Ljava/nio/ByteBuffer;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v3, v0, Ld/n/i/a;->a:Ld/f;

    iget v7, v3, Ld/f;->j:I

    const/4 v9, 0x3

    if-eq v7, v9, :cond_1

    const/4 v9, 0x5

    if-eq v7, v9, :cond_1

    const/4 v9, 0x6

    if-ne v7, v9, :cond_2

    :cond_1
    iget-object v3, v3, Ld/f;->e:[B

    const-string v7, "Identity"

    invoke-virtual {v0, v4, v7, v3}, Ld/n/i/a;->c(Ljava/nio/ByteBuffer;Ljava/lang/String;[B)V

    :cond_2
    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    const-string v7, "CurveZMQINITIATE"

    invoke-virtual {v7, v14}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v7

    invoke-virtual {v2, v7}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v9, v0, Ld/n/i/d/b;->r:J

    invoke-static {v2, v9, v10}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    iget-object v7, v0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    iget-object v9, v0, Ld/n/i/d/b;->o:[B

    iget-object v10, v0, Ld/n/i/d/b;->m:[B

    move-object/from16 v16, v7

    move-object/from16 v17, v6

    move-object/from16 v18, v4

    move/from16 v19, v3

    move-object/from16 v20, v2

    move-object/from16 v21, v9

    move-object/from16 v22, v10

    invoke-virtual/range {v16 .. v22}, Ld/n/i/d/a;->d(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v4

    if-ne v4, v5, :cond_3

    return v5

    :cond_3
    const-string v4, "INITIATE"

    invoke-virtual {v0, v1, v4}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v4, v0, Ld/n/i/d/b;->p:[B

    invoke-virtual {v1, v4}, Ld/e;->u([B)Ld/e;

    invoke-virtual {v1, v2, v15, v8}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v4

    sub-int/2addr v3, v4

    invoke-virtual {v1, v6, v2, v3}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    iget-wide v1, v0, Ld/n/i/d/b;->r:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, v0, Ld/n/i/d/b;->r:J

    const/4 v1, 0x0

    return v1
.end method


# virtual methods
.method public i(Ld/e;)Ld/e;
    .locals 12

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/16 v1, 0x21

    const/4 v2, 0x0

    const v3, 0x9523e34

    if-ge v0, v1, :cond_0

    const-string p1, "CURVE I: invalid CURVE server, sent malformed command"

    :goto_0
    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    :goto_1
    iget-object p1, p0, Ld/n/i/d/b;->u:Ld/s/c;

    invoke-virtual {p1, v3}, Ld/s/c;->c(I)V

    return-object v2

    :cond_0
    const-string v0, "MESSAGE"

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_1

    const-string p1, "CURVE I: invalid CURVE server, did not send MESSAGE"

    goto :goto_0

    :cond_1
    sget-object v0, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v4, "CurveZMQMESSAGES"

    invoke-virtual {v4, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v8, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v0, 0x8

    invoke-virtual {p1, v8, v0, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    invoke-static {p1, v0}, Ld/s/g;->c(Ld/e;I)J

    move-result-wide v4

    iget-wide v6, p0, Ld/n/i/d/b;->s:J

    cmp-long v0, v4, v6

    if-gtz v0, :cond_2

    goto :goto_1

    :cond_2
    iput-wide v4, p0, Ld/n/i/d/b;->s:J

    sget-object v0, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v5

    add-int/2addr v4, v5

    const/16 v5, 0x10

    add-int/lit8 v10, v4, -0x10

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-virtual {v6, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    sub-int/2addr v0, v5

    invoke-virtual {p1, v6, v5, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    iget-object v4, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    iget-object v9, p0, Ld/n/i/d/b;->q:[B

    move-object v5, v11

    move v7, v10

    invoke-virtual/range {v4 .. v9}, Ld/n/i/d/a;->i(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    move-result p1

    if-nez p1, :cond_4

    new-instance p1, Ld/e;

    sub-int/2addr v10, v1

    sget-object v0, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v2

    sub-int/2addr v10, v2

    invoke-direct {p1, v10}, Ld/e;-><init>(I)V

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {v11, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/2addr v2, v1

    if-eqz v2, :cond_3

    invoke-virtual {p1, v1}, Ld/e;->y(I)V

    :cond_3
    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    add-int/2addr v0, v1

    invoke-virtual {v11, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p1, v11}, Ld/e;->s(Ljava/nio/ByteBuffer;)Ld/e;

    return-object p1

    :cond_4
    const-string p1, "CURVE I: connection key used for MESSAGE is wrong"

    goto/16 :goto_0
.end method

.method public k(Ld/e;)Ld/e;
    .locals 11

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    int-to-byte v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    sget-object v3, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v3}, Ld/n/i/d/a$a;->a()I

    move-result v3

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v4, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v5, "CurveZMQMESSAGEC"

    invoke-virtual {v5, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v4, p0, Ld/n/i/d/b;->r:J

    invoke-static {v3, v4, v5}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    sget-object v4, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v5

    add-int/2addr v5, v2

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v6

    add-int v10, v5, v6

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v5

    invoke-virtual {v6, v5, v0}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v0

    add-int/2addr v0, v2

    invoke-virtual {v6, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    invoke-virtual {p1, v6, v1, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    iget-object v4, p0, Ld/n/i/d/b;->t:Ld/n/i/d/a;

    iget-object v9, p0, Ld/n/i/d/b;->q:[B

    move-object v5, p1

    move v7, v10

    move-object v8, v3

    invoke-virtual/range {v4 .. v9}, Ld/n/i/d/a;->a(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    new-instance v0, Ld/e;

    add-int/lit8 v1, v10, 0x10

    sget-object v2, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v4

    sub-int/2addr v1, v4

    invoke-direct {v0, v1}, Ld/e;-><init>(I)V

    const-string v1, "MESSAGE"

    invoke-virtual {p0, v0, v1}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/16 v1, 0x8

    const/16 v4, 0x10

    invoke-virtual {v0, v3, v4, v1}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v1

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    sub-int/2addr v10, v2

    invoke-virtual {v0, p1, v1, v10}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    iget-wide v1, p0, Ld/n/i/d/b;->r:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ld/n/i/d/b;->r:J

    return-object v0
.end method

.method public m(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/d/b;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const/16 p1, 0x23

    goto :goto_1

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/d/b;->F(Ld/e;)I

    move-result p1

    if-nez p1, :cond_2

    sget-object v0, Ld/n/i/d/b$a;->e:Ld/n/i/d/b$a;

    :goto_0
    iput-object v0, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    goto :goto_1

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/d/b;->E(Ld/e;)I

    move-result p1

    if-nez p1, :cond_2

    sget-object v0, Ld/n/i/d/b$a;->c:Ld/n/i/d/b$a;

    goto :goto_0

    :cond_2
    :goto_1
    return p1
.end method

.method public q(Ld/e;)I
    .locals 4

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x1

    const/16 v2, 0x8

    if-lt v0, v2, :cond_0

    const-string v2, "WELCOME"

    invoke-virtual {p0, p1, v2, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Ld/n/i/d/b;->D(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 v2, 0x6

    if-lt v0, v2, :cond_1

    const-string v3, "READY"

    invoke-virtual {p0, p1, v3, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-direct {p0, p1}, Ld/n/i/d/b;->C(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_1
    if-lt v0, v2, :cond_2

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0, p1}, Ld/n/i/d/b;->B(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_2
    const p1, 0x9523e34

    :goto_0
    return p1
.end method

.method public y()Ld/n/i/a$b;
    .locals 2

    iget-object v0, p0, Ld/n/i/d/b;->i:Ld/n/i/d/b$a;

    sget-object v1, Ld/n/i/d/b$a;->g:Ld/n/i/d/b$a;

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    return-object v0

    :cond_0
    sget-object v1, Ld/n/i/d/b$a;->f:Ld/n/i/d/b$a;

    if-ne v0, v1, :cond_1

    sget-object v0, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    return-object v0

    :cond_1
    sget-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    return-object v0
.end method

.method public z()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
