.class public Lb/e/a/j/h;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final j:Lb/e/a/j/h;

.field public static final k:Lb/e/a/j/h;

.field public static final l:Lb/e/a/j/h;

.field public static final m:Lb/e/a/j/h;


# instance fields
.field a:D

.field b:D

.field c:D

.field d:D

.field e:D

.field f:D

.field g:D

.field h:D

.field i:D


# direct methods
.method static constructor <clinit>()V
    .locals 39

    new-instance v19, Lb/e/a/j/h;

    move-object/from16 v0, v19

    const-wide/high16 v1, 0x3ff0000000000000L    # 1.0

    const-wide/16 v3, 0x0

    const-wide/16 v5, 0x0

    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    const-wide/16 v9, 0x0

    const-wide/16 v11, 0x0

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v15, 0x0

    const-wide/16 v17, 0x0

    invoke-direct/range {v0 .. v18}, Lb/e/a/j/h;-><init>(DDDDDDDDD)V

    sput-object v19, Lb/e/a/j/h;->j:Lb/e/a/j/h;

    new-instance v0, Lb/e/a/j/h;

    move-object/from16 v20, v0

    const-wide/16 v21, 0x0

    const-wide/high16 v23, 0x3ff0000000000000L    # 1.0

    const-wide/high16 v25, -0x4010000000000000L    # -1.0

    const-wide/16 v27, 0x0

    const-wide/16 v29, 0x0

    const-wide/16 v31, 0x0

    const-wide/high16 v33, 0x3ff0000000000000L    # 1.0

    const-wide/16 v35, 0x0

    const-wide/16 v37, 0x0

    invoke-direct/range {v20 .. v38}, Lb/e/a/j/h;-><init>(DDDDDDDDD)V

    sput-object v0, Lb/e/a/j/h;->k:Lb/e/a/j/h;

    new-instance v0, Lb/e/a/j/h;

    move-object v1, v0

    const-wide/high16 v2, -0x4010000000000000L    # -1.0

    const-wide/16 v4, 0x0

    const-wide/16 v6, 0x0

    const-wide/high16 v8, -0x4010000000000000L    # -1.0

    const-wide/16 v10, 0x0

    const-wide/16 v12, 0x0

    const-wide/high16 v14, 0x3ff0000000000000L    # 1.0

    const-wide/16 v16, 0x0

    const-wide/16 v18, 0x0

    invoke-direct/range {v1 .. v19}, Lb/e/a/j/h;-><init>(DDDDDDDDD)V

    sput-object v0, Lb/e/a/j/h;->l:Lb/e/a/j/h;

    new-instance v0, Lb/e/a/j/h;

    move-object/from16 v20, v0

    const-wide/high16 v23, -0x4010000000000000L    # -1.0

    const-wide/high16 v25, 0x3ff0000000000000L    # 1.0

    invoke-direct/range {v20 .. v38}, Lb/e/a/j/h;-><init>(DDDDDDDDD)V

    sput-object v0, Lb/e/a/j/h;->m:Lb/e/a/j/h;

    return-void
.end method

.method public constructor <init>(DDDDDDDDD)V
    .locals 3

    move-object v0, p0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    move-wide v1, p9

    iput-wide v1, v0, Lb/e/a/j/h;->a:D

    move-wide v1, p11

    iput-wide v1, v0, Lb/e/a/j/h;->b:D

    move-wide/from16 v1, p13

    iput-wide v1, v0, Lb/e/a/j/h;->c:D

    move-wide v1, p1

    iput-wide v1, v0, Lb/e/a/j/h;->d:D

    move-wide v1, p3

    iput-wide v1, v0, Lb/e/a/j/h;->e:D

    move-wide v1, p5

    iput-wide v1, v0, Lb/e/a/j/h;->f:D

    move-wide v1, p7

    iput-wide v1, v0, Lb/e/a/j/h;->g:D

    move-wide/from16 v1, p15

    iput-wide v1, v0, Lb/e/a/j/h;->h:D

    move-wide/from16 v1, p17

    iput-wide v1, v0, Lb/e/a/j/h;->i:D

    return-void
.end method

.method public static a(Ljava/nio/ByteBuffer;)Lb/e/a/j/h;
    .locals 18

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v0

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v2

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->c(Ljava/nio/ByteBuffer;)D

    move-result-wide v4

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v6

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v8

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->c(Ljava/nio/ByteBuffer;)D

    move-result-wide v10

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v12

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->d(Ljava/nio/ByteBuffer;)D

    move-result-wide v14

    invoke-static/range {p0 .. p0}, Lb/c/a/e;->c(Ljava/nio/ByteBuffer;)D

    move-result-wide v16

    invoke-static/range {v0 .. v17}, Lb/e/a/j/h;->b(DDDDDDDDD)Lb/e/a/j/h;

    move-result-object v0

    return-object v0
.end method

.method public static b(DDDDDDDDD)Lb/e/a/j/h;
    .locals 20

    move-wide/from16 v1, p0

    move-wide/from16 v3, p2

    move-wide/from16 v9, p4

    move-wide/from16 v5, p6

    move-wide/from16 v7, p8

    move-wide/from16 v11, p10

    move-wide/from16 v15, p12

    move-wide/from16 v17, p14

    move-wide/from16 v13, p16

    new-instance v19, Lb/e/a/j/h;

    move-object/from16 v0, v19

    invoke-direct/range {v0 .. v18}, Lb/e/a/j/h;-><init>(DDDDDDDDD)V

    return-object v19
.end method


# virtual methods
.method public c(Ljava/nio/ByteBuffer;)V
    .locals 2

    iget-wide v0, p0, Lb/e/a/j/h;->d:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->e:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->a:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->a(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->f:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->g:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->b:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->a(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->h:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->i:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->b(Ljava/nio/ByteBuffer;D)V

    iget-wide v0, p0, Lb/e/a/j/h;->c:D

    invoke-static {p1, v0, v1}, Lb/c/a/f;->a(Ljava/nio/ByteBuffer;D)V

    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_b

    const-class v2, Lb/e/a/j/h;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    check-cast p1, Lb/e/a/j/h;

    iget-wide v2, p1, Lb/e/a/j/h;->d:D

    iget-wide v4, p0, Lb/e/a/j/h;->d:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_2

    return v1

    :cond_2
    iget-wide v2, p1, Lb/e/a/j/h;->e:D

    iget-wide v4, p0, Lb/e/a/j/h;->e:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_3

    return v1

    :cond_3
    iget-wide v2, p1, Lb/e/a/j/h;->f:D

    iget-wide v4, p0, Lb/e/a/j/h;->f:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_4

    return v1

    :cond_4
    iget-wide v2, p1, Lb/e/a/j/h;->g:D

    iget-wide v4, p0, Lb/e/a/j/h;->g:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_5

    return v1

    :cond_5
    iget-wide v2, p1, Lb/e/a/j/h;->h:D

    iget-wide v4, p0, Lb/e/a/j/h;->h:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_6

    return v1

    :cond_6
    iget-wide v2, p1, Lb/e/a/j/h;->i:D

    iget-wide v4, p0, Lb/e/a/j/h;->i:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_7

    return v1

    :cond_7
    iget-wide v2, p1, Lb/e/a/j/h;->a:D

    iget-wide v4, p0, Lb/e/a/j/h;->a:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_8

    return v1

    :cond_8
    iget-wide v2, p1, Lb/e/a/j/h;->b:D

    iget-wide v4, p0, Lb/e/a/j/h;->b:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result v2

    if-eqz v2, :cond_9

    return v1

    :cond_9
    iget-wide v2, p1, Lb/e/a/j/h;->c:D

    iget-wide v4, p0, Lb/e/a/j/h;->c:D

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Double;->compare(DD)I

    move-result p1

    if-eqz p1, :cond_a

    return v1

    :cond_a
    return v0

    :cond_b
    :goto_0
    return v1
.end method

.method public hashCode()I
    .locals 7

    iget-wide v0, p0, Lb/e/a/j/h;->a:D

    invoke-static {v0, v1}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v0

    const/16 v2, 0x20

    ushr-long v3, v0, v2

    xor-long/2addr v0, v3

    long-to-int v0, v0

    iget-wide v3, p0, Lb/e/a/j/h;->b:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->c:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->d:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->e:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->f:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->g:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->h:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v5, v3, v2

    xor-long/2addr v3, v5

    long-to-int v1, v3

    add-int/2addr v0, v1

    iget-wide v3, p0, Lb/e/a/j/h;->i:D

    invoke-static {v3, v4}, Ljava/lang/Double;->doubleToLongBits(D)J

    move-result-wide v3

    mul-int/lit8 v0, v0, 0x1f

    ushr-long v1, v3, v2

    xor-long/2addr v1, v3

    long-to-int v1, v1

    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    sget-object v0, Lb/e/a/j/h;->j:Lb/e/a/j/h;

    invoke-virtual {p0, v0}, Lb/e/a/j/h;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Rotate 0\u00b0"

    return-object v0

    :cond_0
    sget-object v0, Lb/e/a/j/h;->k:Lb/e/a/j/h;

    invoke-virtual {p0, v0}, Lb/e/a/j/h;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "Rotate 90\u00b0"

    return-object v0

    :cond_1
    sget-object v0, Lb/e/a/j/h;->l:Lb/e/a/j/h;

    invoke-virtual {p0, v0}, Lb/e/a/j/h;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "Rotate 180\u00b0"

    return-object v0

    :cond_2
    sget-object v0, Lb/e/a/j/h;->m:Lb/e/a/j/h;

    invoke-virtual {p0, v0}, Lb/e/a/j/h;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "Rotate 270\u00b0"

    return-object v0

    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Matrix{u="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lb/e/a/j/h;->a:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", v="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->b:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", w="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->c:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", a="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->d:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", b="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->e:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", c="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->f:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", d="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->g:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", tx="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->h:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ", ty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/e/a/j/h;->i:D

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
