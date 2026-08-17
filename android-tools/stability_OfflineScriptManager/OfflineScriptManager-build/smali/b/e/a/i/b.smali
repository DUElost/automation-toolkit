.class public abstract Lb/e/a/i/b;
.super Lb/e/a/c;
.source ""


# static fields
.field private static final synthetic p:Lc/b/a/a/a$a;

.field private static final synthetic q:Lc/b/a/a/a$a;

.field private static final synthetic r:Lc/b/a/a/a$a;

.field private static final synthetic s:Lc/b/a/a/a$a;


# instance fields
.field m:I

.field n:I

.field o:[B


# direct methods
.method static constructor <clinit>()V
    .locals 0

    invoke-static {}, Lb/e/a/i/b;->k()V

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lb/e/a/c;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method private static synthetic k()V
    .locals 10

    new-instance v8, Lc/b/a/b/b/b;

    const-class v0, Lb/e/a/i/b;

    const-string v1, "AbstractTrackEncryptionBox.java"

    invoke-direct {v8, v1, v0}, Lc/b/a/b/b/b;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    const-string v1, "1"

    const-string v2, "getDefaultAlgorithmId"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "int"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const-string v9, "method-execution"

    const/16 v1, 0x18

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setDefaultAlgorithmId"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, "int"

    const-string v5, "defaultAlgorithmId"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x1c

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getDefaultIvSize"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "int"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/i/b;->p:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setDefaultIvSize"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, "int"

    const-string v5, "defaultIvSize"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x24

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getDefault_KID"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.util.UUID"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x28

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/i/b;->q:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setDefault_KID"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, "java.util.UUID"

    const-string v5, "uuid"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x2e

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "equals"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, "java.lang.Object"

    const-string v5, "o"

    const-string v6, ""

    const-string v7, "boolean"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x4c

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/i/b;->r:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "hashCode"

    const-string v3, "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "int"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x5a

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/i/b;->s:Lc/b/a/a/a$a;

    return-void
.end method


# virtual methods
.method public c(Ljava/nio/ByteBuffer;)V
    .locals 1

    invoke-virtual {p0, p1}, Lb/e/a/c;->o(Ljava/nio/ByteBuffer;)J

    invoke-static {p1}, Lb/c/a/e;->j(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/b;->m:I

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/b;->n:I

    const/16 v0, 0x10

    new-array v0, v0, [B

    iput-object v0, p0, Lb/e/a/i/b;->o:[B

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    return-void
.end method

.method protected d(Ljava/nio/ByteBuffer;)V
    .locals 1

    invoke-virtual {p0, p1}, Lb/e/a/c;->r(Ljava/nio/ByteBuffer;)V

    iget v0, p0, Lb/e/a/i/b;->m:I

    invoke-static {p1, v0}, Lb/c/a/f;->f(Ljava/nio/ByteBuffer;I)V

    iget v0, p0, Lb/e/a/i/b;->n:I

    invoke-static {p1, v0}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget-object v0, p0, Lb/e/a/i/b;->o:[B

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    return-void
.end method

.method protected e()J
    .locals 2

    const-wide/16 v0, 0x18

    return-wide v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    sget-object v0, Lb/e/a/i/b;->r:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0, p1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_5

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    check-cast p1, Lb/e/a/i/b;

    iget v2, p0, Lb/e/a/i/b;->m:I

    iget v3, p1, Lb/e/a/i/b;->m:I

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    iget v2, p0, Lb/e/a/i/b;->n:I

    iget v3, p1, Lb/e/a/i/b;->n:I

    if-eq v2, v3, :cond_3

    return v1

    :cond_3
    iget-object v2, p0, Lb/e/a/i/b;->o:[B

    iget-object p1, p1, Lb/e/a/i/b;->o:[B

    invoke-static {v2, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p1

    if-nez p1, :cond_4

    return v1

    :cond_4
    return v0

    :cond_5
    :goto_0
    return v1
.end method

.method public hashCode()I
    .locals 2

    sget-object v0, Lb/e/a/i/b;->s:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget v0, p0, Lb/e/a/i/b;->m:I

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/b;->n:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-object v1, p0, Lb/e/a/i/b;->o:[B

    if-eqz v1, :cond_0

    invoke-static {v1}, Ljava/util/Arrays;->hashCode([B)I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    add-int/2addr v0, v1

    return v0
.end method

.method public s()I
    .locals 2

    sget-object v0, Lb/e/a/i/b;->p:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget v0, p0, Lb/e/a/i/b;->n:I

    return v0
.end method

.method public u()Ljava/util/UUID;
    .locals 6

    sget-object v0, Lb/e/a/i/b;->q:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-object v0, p0, Lb/e/a/i/b;->o:[B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->BIG_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    new-instance v1, Ljava/util/UUID;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v2

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v4

    invoke-direct {v1, v2, v3, v4, v5}, Ljava/util/UUID;-><init>(JJ)V

    return-object v1
.end method
