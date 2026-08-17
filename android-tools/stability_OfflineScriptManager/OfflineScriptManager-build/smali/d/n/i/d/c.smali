.class public Ld/n/i/d/c;
.super Ld/n/i/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/d/c$a;
    }
.end annotation


# static fields
.field private static synthetic t:[I


# instance fields
.field private i:J

.field private j:J

.field private final k:[B

.field private final l:[B

.field private final m:[B

.field private n:[B

.field private o:[B

.field private final p:[B

.field private q:Ld/n/i/d/c$a;

.field private final r:Ld/n/i/d/a;

.field private final s:Ld/s/c;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/f;Ld/n/j/a;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    sget-object p1, Ld/n/i/d/a$a;->e:Ld/n/i/d/a$a;

    invoke-virtual {p1}, Ld/n/i/d/a$a;->a()I

    move-result p1

    new-array p1, p1, [B

    iput-object p1, p0, Ld/n/i/d/c;->n:[B

    sget-object p1, Ld/n/i/d/a$a;->h:Ld/n/i/d/a$a;

    invoke-virtual {p1}, Ld/n/i/d/a$a;->a()I

    move-result p1

    new-array p1, p1, [B

    iput-object p1, p0, Ld/n/i/d/c;->p:[B

    sget-object p1, Ld/n/i/d/c$a;->b:Ld/n/i/d/c$a;

    iput-object p1, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    const-wide/16 p1, 0x1

    iput-wide p1, p0, Ld/n/i/d/c;->i:J

    iput-wide p1, p0, Ld/n/i/d/c;->j:J

    iget-object p1, p3, Ld/f;->H:[B

    iput-object p1, p0, Ld/n/i/d/c;->k:[B

    new-instance p1, Ld/n/i/d/a;

    invoke-direct {p1}, Ld/n/i/d/a;-><init>()V

    iput-object p1, p0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {p1}, Ld/n/i/d/a;->f()[[B

    move-result-object p1

    const/4 p2, 0x0

    aget-object p2, p1, p2

    iput-object p2, p0, Ld/n/i/d/c;->l:[B

    const/4 p2, 0x1

    aget-object p1, p1, p2

    iput-object p1, p0, Ld/n/i/d/c;->m:[B

    iget-object p1, p3, Ld/f;->P:Ld/s/c;

    iput-object p1, p0, Ld/n/i/d/c;->s:Ld/s/c;

    return-void
.end method

.method static synthetic A()[I
    .locals 3

    sget-object v0, Ld/n/i/d/c;->t:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/i/d/c$a;->values()[Ld/n/i/d/c$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/i/d/c$a;->i:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/16 v2, 0x8

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/i/d/c$a;->h:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x7

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/i/d/c$a;->b:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/i/d/c$a;->d:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/i/d/c$a;->e:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/i/d/c$a;->g:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    sget-object v1, Ld/n/i/d/c$a;->f:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    :try_start_7
    sget-object v1, Ld/n/i/d/c$a;->c:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_7
    .catch Ljava/lang/NoSuchFieldError; {:try_start_7 .. :try_end_7} :catch_7

    :catch_7
    sput-object v0, Ld/n/i/d/c;->t:[I

    return-object v0
.end method

.method private B(Ld/e;)I
    .locals 12

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const v1, 0x9523e34

    const/16 v2, 0xc8

    if-eq v0, v2, :cond_0

    const-string p1, "CURVE I: client HELLO is not correct size"

    :goto_0
    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v1

    :cond_0
    const-string v0, "HELLO"

    const/4 v2, 0x1

    invoke-virtual {p0, p1, v0, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_1

    const-string p1, "CURVE I: client HELLO has invalid command name"

    goto :goto_0

    :cond_1
    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Ld/e;->e(I)B

    move-result v0

    const/4 v3, 0x7

    invoke-virtual {p1, v3}, Ld/e;->e(I)B

    move-result v3

    if-ne v0, v2, :cond_4

    if-eqz v3, :cond_2

    goto :goto_1

    :cond_2
    iget-object v0, p0, Ld/n/i/d/c;->n:[B

    sget-object v2, Ld/n/i/d/a$a;->e:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    const/16 v3, 0x50

    const/4 v4, 0x0

    invoke-virtual {p1, v3, v0, v4, v2}, Ld/e;->f(I[BII)I

    sget-object v0, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    sget-object v0, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    add-int/lit8 v0, v0, 0x40

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    sget-object v0, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v2

    add-int/2addr v2, v3

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v5, "CurveZMQHELLO---"

    invoke-virtual {v5, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-virtual {v9, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v2, 0x8

    const/16 v5, 0x70

    invoke-virtual {p1, v9, v5, v2}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    invoke-static {p1, v5}, Ld/s/g;->c(Ld/e;I)J

    move-result-wide v10

    iput-wide v10, p0, Ld/n/i/d/c;->j:J

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-virtual {v7, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    const/16 v0, 0x78

    invoke-virtual {p1, v7, v0, v3}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    iget-object v5, p0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v8

    iget-object v10, p0, Ld/n/i/d/c;->n:[B

    iget-object v11, p0, Ld/n/i/d/c;->k:[B

    invoke-virtual/range {v5 .. v11}, Ld/n/i/d/a;->g(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "CURVE I: cannot open client HELLO -- wrong server key?"

    goto/16 :goto_0

    :cond_3
    sget-object p1, Ld/n/i/d/c$a;->c:Ld/n/i/d/c$a;

    iput-object p1, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    return v4

    :cond_4
    :goto_1
    const-string p1, "CURVE I: client HELLO has unknown version number"

    goto/16 :goto_0
.end method

.method private C(Ld/e;)I
    .locals 24

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p1 .. p1}, Ld/e;->B()I

    move-result v2

    const v3, 0x9523e34

    const/16 v4, 0x101

    if-ge v2, v4, :cond_0

    const-string v1, "CURVE I: client INITIATE is not correct size"

    :goto_0
    invoke-virtual {v0, v1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v3

    :cond_0
    const/4 v2, 0x1

    const-string v4, "INITIATE"

    invoke-virtual {v0, v1, v4, v2}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v1, "CURVE I: client INITIATE has invalid command name"

    goto :goto_0

    :cond_1
    sget-object v2, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    sget-object v4, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v5

    add-int/lit8 v5, v5, 0x40

    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v11

    sget-object v12, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v5

    const/16 v13, 0x50

    add-int/2addr v5, v13

    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v5

    invoke-virtual {v7, v5}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    const/16 v5, 0x19

    invoke-virtual {v1, v7, v5, v13}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    sget-object v14, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v5, "COOKIE--"

    invoke-virtual {v5, v14}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v5

    invoke-virtual {v9, v5}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v5, 0x9

    const/16 v15, 0x10

    invoke-virtual {v1, v9, v5, v15}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    iget-object v5, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v8

    iget-object v10, v0, Ld/n/i/d/c;->o:[B

    move-object v6, v11

    invoke-virtual/range {v5 .. v10}, Ld/n/i/d/a;->n(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    move-result v5

    if-eqz v5, :cond_2

    const-string v1, "CURVE I: cannot open client INITIATE cookie"

    goto :goto_0

    :cond_2
    iget-object v5, v0, Ld/n/i/d/c;->n:[B

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v6

    const/16 v7, 0x20

    invoke-virtual {v0, v11, v5, v6, v7}, Ld/n/i/a;->g(Ljava/nio/ByteBuffer;[BII)Z

    move-result v5

    if-eqz v5, :cond_b

    iget-object v5, v0, Ld/n/i/d/c;->m:[B

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v6

    add-int/2addr v6, v7

    invoke-virtual {v0, v11, v5, v6, v7}, Ld/n/i/a;->g(Ljava/nio/ByteBuffer;[BII)Z

    move-result v5

    if-nez v5, :cond_3

    goto/16 :goto_3

    :cond_3
    invoke-virtual/range {p1 .. p1}, Ld/e;->B()I

    move-result v5

    const/16 v6, 0x71

    sub-int/2addr v5, v6

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v8

    add-int/2addr v5, v8

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v8

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v9

    add-int/lit16 v9, v9, 0x80

    add-int/lit16 v9, v9, 0x100

    invoke-static {v9}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v10

    add-int/lit16 v10, v10, 0x90

    add-int/lit16 v10, v10, 0x100

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v11

    sub-int v11, v5, v11

    invoke-virtual {v1, v10, v6, v11}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    const-string v6, "CurveZMQINITIATE"

    invoke-virtual {v6, v14}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v6

    invoke-virtual {v8, v6}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v6, 0x8

    const/16 v11, 0x69

    invoke-virtual {v1, v8, v11, v6}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    move-object/from16 v23, v14

    invoke-static {v1, v11}, Ld/s/g;->c(Ld/e;I)J

    move-result-wide v13

    iput-wide v13, v0, Ld/n/i/d/c;->j:J

    iget-object v1, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    iget-object v11, v0, Ld/n/i/d/c;->n:[B

    iget-object v13, v0, Ld/n/i/d/c;->m:[B

    move-object/from16 v16, v1

    move-object/from16 v17, v9

    move-object/from16 v18, v10

    move/from16 v19, v5

    move-object/from16 v20, v8

    move-object/from16 v21, v11

    move-object/from16 v22, v13

    invoke-virtual/range {v16 .. v22}, Ld/n/i/d/a;->g(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v1

    if-eqz v1, :cond_4

    const-string v1, "CURVE I: cannot open client INITIATE"

    goto/16 :goto_0

    :cond_4
    const/16 v1, 0x180

    new-array v1, v1, [B

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v8

    invoke-virtual {v9, v8}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v9, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v8

    add-int/lit8 v8, v8, 0x40

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v10

    const/16 v6, 0x50

    add-int/2addr v10, v6

    invoke-static {v10}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-virtual {v12}, Ld/n/i/d/a$a;->a()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v11

    add-int/lit8 v11, v11, 0x30

    add-int/2addr v11, v6

    invoke-virtual {v9, v11}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v6

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v11

    add-int/lit8 v11, v11, 0x30

    invoke-virtual {v6, v11}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v10, v9}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    const-string v6, "VOUCH---"

    move-object/from16 v11, v23

    invoke-virtual {v6, v11}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v6

    add-int/2addr v6, v7

    add-int/2addr v6, v15

    invoke-virtual {v9, v6}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v6

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v11

    add-int/2addr v11, v7

    invoke-virtual {v6, v11}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v2, v9}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    iget-object v6, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v10}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v19

    iget-object v11, v0, Ld/n/i/d/c;->m:[B

    move-object/from16 v16, v6

    move-object/from16 v17, v8

    move-object/from16 v18, v10

    move-object/from16 v20, v2

    move-object/from16 v21, v1

    move-object/from16 v22, v11

    invoke-virtual/range {v16 .. v22}, Ld/n/i/d/a;->g(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v2

    if-eqz v2, :cond_5

    const-string v1, "CURVE I: cannot open client INITIATE vouch"

    goto/16 :goto_0

    :cond_5
    iget-object v2, v0, Ld/n/i/d/c;->n:[B

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v6

    invoke-virtual {v0, v8, v2, v6, v7}, Ld/n/i/a;->g(Ljava/nio/ByteBuffer;[BII)Z

    move-result v2

    if-nez v2, :cond_6

    const-string v1, "CURVE I: invalid handshake from client (public key)"

    goto/16 :goto_0

    :cond_6
    iget-object v2, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    iget-object v3, v0, Ld/n/i/d/c;->p:[B

    iget-object v6, v0, Ld/n/i/d/c;->n:[B

    iget-object v7, v0, Ld/n/i/d/c;->m:[B

    invoke-virtual {v2, v3, v6, v7}, Ld/n/i/d/a;->c([B[B[B)I

    iget-object v2, v0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {v2}, Ld/n/f;->V0()I

    move-result v2

    if-nez v2, :cond_a

    invoke-direct {v0, v1}, Ld/n/i/d/c;->G([B)V

    invoke-virtual/range {p0 .. p0}, Ld/n/i/a;->t()I

    move-result v1

    if-nez v1, :cond_8

    iget-object v1, v0, Ld/n/i/a;->h:Ljava/lang/String;

    const-string v2, "200"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    goto :goto_1

    :cond_7
    sget-object v1, Ld/n/i/d/c$a;->g:Ld/n/i/d/c$a;

    goto :goto_2

    :cond_8
    const/16 v2, 0x23

    if-ne v1, v2, :cond_9

    sget-object v1, Ld/n/i/d/c$a;->e:Ld/n/i/d/c$a;

    goto :goto_2

    :cond_9
    const/4 v1, -0x1

    return v1

    :cond_a
    :goto_1
    sget-object v1, Ld/n/i/d/c$a;->f:Ld/n/i/d/c$a;

    :goto_2
    iput-object v1, v0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    const/4 v1, 0x0

    invoke-virtual {v9, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v9, v5}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v4}, Ld/n/i/d/a$a;->a()I

    move-result v2

    add-int/lit16 v2, v2, 0x80

    invoke-virtual {v0, v9, v2, v1}, Ld/n/i/a;->n(Ljava/nio/ByteBuffer;IZ)I

    move-result v1

    return v1

    :cond_b
    :goto_3
    const-string v1, "CURVE I: client INITIATE cookie is not valid"

    goto/16 :goto_0
.end method

.method private D(Ld/e;)I
    .locals 1

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->h:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

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

    move-result v2

    add-int/lit16 v2, v2, 0x100

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v7, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v7}, Ld/n/i/d/a$a;->a()I

    move-result v2

    const/16 v8, 0x10

    add-int/2addr v2, v8

    add-int/lit16 v2, v2, 0x100

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    invoke-virtual {v1}, Ld/n/i/d/a$a;->a()I

    move-result v1

    invoke-virtual {v3, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/i/a;->a:Ld/f;

    iget v1, v1, Ld/f;->j:I

    invoke-virtual {p0, v1}, Ld/n/i/a;->x(I)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Socket-Type"

    invoke-virtual {p0, v3, v2, v1}, Ld/n/i/a;->b(Ljava/nio/ByteBuffer;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Ld/n/i/a;->a:Ld/f;

    iget v2, v1, Ld/f;->j:I

    const/4 v4, 0x3

    if-eq v2, v4, :cond_0

    const/4 v4, 0x5

    if-eq v2, v4, :cond_0

    const/4 v4, 0x6

    if-ne v2, v4, :cond_1

    :cond_0
    iget-object v1, v1, Ld/f;->e:[B

    const-string v2, "Identity"

    invoke-virtual {p0, v3, v2, v1}, Ld/n/i/a;->c(Ljava/nio/ByteBuffer;Ljava/lang/String;[B)V

    :cond_1
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->position()I

    move-result v10

    sget-object v1, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v2, "CurveZMQREADY---"

    invoke-virtual {v2, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v1, p0, Ld/n/i/d/c;->i:J

    invoke-static {v0, v1, v2}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    iget-object v6, p0, Ld/n/i/d/c;->p:[B

    move-object v2, v9

    move v4, v10

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Ld/n/i/d/a;->a(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    const-string v1, "READY"

    invoke-virtual {p0, p1, v1}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/16 v1, 0x8

    invoke-virtual {p1, v0, v8, v1}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    invoke-virtual {v7}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-virtual {v7}, Ld/n/i/d/a$a;->a()I

    move-result v1

    sub-int/2addr v10, v1

    invoke-virtual {p1, v9, v0, v10}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    iget-wide v0, p0, Ld/n/i/d/c;->i:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ld/n/i/d/c;->i:J

    const/4 p1, 0x0

    return p1
.end method

.method private F(Ld/e;)I
    .locals 22

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    sget-object v2, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v3

    invoke-static {v3}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v10, Ld/n/i/d/a$a;->c:Ld/n/i/d/a$a;

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit8 v4, v4, 0x40

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    sget-object v11, Ld/n/i/d/a$a;->d:Ld/n/i/d/a$a;

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v4

    add-int/lit8 v4, v4, 0x50

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v12

    sget-object v13, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v4, "COOKIE--"

    invoke-virtual {v4, v13}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    const/16 v14, 0x10

    invoke-virtual {v4, v14}, Ld/n/i/d/a;->k(I)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v4, v0, Ld/n/i/d/c;->n:[B

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/c;->m:[B

    invoke-virtual {v6, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v4, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    sget-object v5, Ld/n/i/d/a$a;->g:Ld/n/i/d/a$a;

    invoke-virtual {v5}, Ld/n/i/d/a$a;->a()I

    move-result v5

    invoke-virtual {v4, v5}, Ld/n/i/d/a;->k(I)[B

    move-result-object v4

    iput-object v4, v0, Ld/n/i/d/c;->o:[B

    iget-object v4, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v7

    iget-object v9, v0, Ld/n/i/d/c;->o:[B

    move-object v5, v12

    move-object v8, v3

    invoke-virtual/range {v4 .. v9}, Ld/n/i/d/a;->l(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B)I

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v4

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result v5

    add-int/lit16 v5, v5, 0x80

    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v5

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v6

    const/16 v7, 0x90

    add-int/2addr v6, v7

    invoke-static {v6}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    const-string v8, "WELCOME-"

    invoke-virtual {v8, v13}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v8, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v2}, Ld/n/i/d/a$a;->a()I

    move-result v2

    const/16 v9, 0x8

    sub-int/2addr v2, v9

    invoke-virtual {v8, v2}, Ld/n/i/d/a;->k(I)[B

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v10}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {v5, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v2, v0, Ld/n/i/d/c;->l:[B

    invoke-virtual {v5, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v2, 0x18

    invoke-virtual {v3, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v5, v3}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v2

    add-int/lit8 v2, v2, 0x50

    invoke-virtual {v12, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v2

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v5, v12}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    iget-object v15, v0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v18

    iget-object v2, v0, Ld/n/i/d/c;->n:[B

    iget-object v3, v0, Ld/n/i/d/c;->k:[B

    move-object/from16 v16, v6

    move-object/from16 v17, v5

    move-object/from16 v19, v4

    move-object/from16 v20, v2

    move-object/from16 v21, v3

    invoke-virtual/range {v15 .. v21}, Ld/n/i/d/a;->d(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[B[B)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_0

    return v3

    :cond_0
    const-string v2, "WELCOME"

    invoke-virtual {v0, v1, v2}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    invoke-virtual {v1, v4, v9, v14}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    invoke-virtual {v11}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-virtual {v1, v6, v2, v7}, Ld/e;->t(Ljava/nio/ByteBuffer;II)Ld/e;

    const/4 v1, 0x0

    return v1
.end method

.method private G([B)V
    .locals 3

    sget-object v0, Ld/n/i/b;->d:Ld/n/i/b;

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ld/n/i/a;->u(Ld/n/i/b;Z)V

    new-instance v0, Ld/e;

    sget-object v1, Ld/n/i/d/a$a;->e:Ld/n/i/d/a$a;

    invoke-virtual {v1}, Ld/n/i/d/a$a;->a()I

    move-result v2

    invoke-direct {v0, v2}, Ld/e;-><init>(I)V

    invoke-virtual {v1}, Ld/n/i/d/a$a;->a()I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2, v1}, Ld/e;->v([BII)Ld/e;

    iget-object p1, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {p1, v0}, Ld/n/f;->U0(Ld/e;)Z

    return-void
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

    const-string p1, "CURVE I: invalid CURVE client, sent malformed command"

    :goto_0
    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    :goto_1
    iget-object p1, p0, Ld/n/i/d/c;->s:Ld/s/c;

    invoke-virtual {p1, v3}, Ld/s/c;->c(I)V

    return-object v2

    :cond_0
    const-string v0, "MESSAGE"

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_1

    const-string p1, "CURVE I: invalid CURVE client, did not send MESSAGE"

    goto :goto_0

    :cond_1
    sget-object v0, Ld/n/i/d/a$a;->b:Ld/n/i/d/a$a;

    invoke-virtual {v0}, Ld/n/i/d/a$a;->a()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    const-string v4, "CurveZMQMESSAGEC"

    invoke-virtual {v4, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    invoke-virtual {v8, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    const/16 v0, 0x8

    invoke-virtual {p1, v8, v0, v0}, Ld/e;->C(Ljava/nio/ByteBuffer;II)V

    invoke-static {p1, v0}, Ld/s/g;->c(Ld/e;I)J

    move-result-wide v4

    iget-wide v6, p0, Ld/n/i/d/c;->j:J

    cmp-long v0, v4, v6

    if-gtz v0, :cond_2

    goto :goto_1

    :cond_2
    iput-wide v4, p0, Ld/n/i/d/c;->j:J

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

    iget-object v4, p0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    iget-object v9, p0, Ld/n/i/d/c;->p:[B

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

    const-string v5, "CurveZMQMESSAGES"

    invoke-virtual {v5, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v4, p0, Ld/n/i/d/c;->i:J

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

    iget-object v4, p0, Ld/n/i/d/c;->r:Ld/n/i/d/a;

    iget-object v9, p0, Ld/n/i/d/c;->p:[B

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

    iget-wide v1, p0, Ld/n/i/d/c;->i:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ld/n/i/d/c;->i:J

    return-object v0
.end method

.method public m(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/d/c;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    const/4 v1, 0x5

    if-eq v0, v1, :cond_1

    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    const/16 p1, 0x23

    goto :goto_1

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/d/c;->D(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/d/c$a;->h:Ld/n/i/d/c$a;

    :goto_0
    iput-object v0, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    goto :goto_1

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/d/c;->E(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/d/c$a;->i:Ld/n/i/d/c$a;

    goto :goto_0

    :cond_2
    invoke-direct {p0, p1}, Ld/n/i/d/c;->F(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/d/c$a;->d:Ld/n/i/d/c$a;

    goto :goto_0

    :cond_3
    :goto_1
    return p1
.end method

.method public q(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/d/c;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const-string p1, "CURVE I: invalid handshake command"

    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    const p1, 0x9523e34

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/d/c;->C(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/d/c;->B(Ld/e;)I

    move-result p1

    :goto_0
    return p1
.end method

.method public y()Ld/n/i/a$b;
    .locals 2

    iget-object v0, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    sget-object v1, Ld/n/i/d/c$a;->i:Ld/n/i/d/c$a;

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    return-object v0

    :cond_0
    sget-object v1, Ld/n/i/d/c$a;->h:Ld/n/i/d/c$a;

    if-ne v0, v1, :cond_1

    sget-object v0, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    return-object v0

    :cond_1
    sget-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    return-object v0
.end method

.method public z()I
    .locals 3

    iget-object v0, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    sget-object v1, Ld/n/i/d/c$a;->e:Ld/n/i/d/c$a;

    if-eq v0, v1, :cond_0

    const v0, 0x9523dfb

    return v0

    :cond_0
    invoke-virtual {p0}, Ld/n/i/a;->t()I

    move-result v0

    if-nez v0, :cond_2

    iget-object v1, p0, Ld/n/i/a;->h:Ljava/lang/String;

    const-string v2, "200"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Ld/n/i/d/c$a;->f:Ld/n/i/d/c$a;

    goto :goto_0

    :cond_1
    sget-object v1, Ld/n/i/d/c$a;->g:Ld/n/i/d/c$a;

    :goto_0
    iput-object v1, p0, Ld/n/i/d/c;->q:Ld/n/i/d/c$a;

    :cond_2
    return v0
.end method
