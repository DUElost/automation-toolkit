.class public abstract Lb/c/a/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/c/a/b;


# static fields
.field private static b:Ljava/util/logging/Logger;


# instance fields
.field a:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/nio/ByteBuffer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/c/a/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lb/c/a/a;->b:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lb/c/a/a$a;

    invoke-direct {v0, p0}, Lb/c/a/a$a;-><init>(Lb/c/a/a;)V

    iput-object v0, p0, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    return-void
.end method


# virtual methods
.method public a(Lb/e/a/e;Lb/c/a/i/e;)Lb/c/a/i/b;
    .locals 16

    move-object/from16 v6, p0

    move-object/from16 v1, p1

    move-object/from16 v0, p2

    invoke-interface/range {p1 .. p1}, Lb/e/a/e;->l()J

    move-result-wide v2

    iget-object v4, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v4

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Ljava/nio/Buffer;->limit(I)Ljava/nio/Buffer;

    :goto_0
    iget-object v4, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/nio/ByteBuffer;

    invoke-interface {v1, v4}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    move-result v4

    if-ne v4, v5, :cond_6

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-static {v2}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    const-wide/16 v7, 0x8

    cmp-long v4, v2, v7

    const-wide/16 v9, 0x1

    const/4 v11, 0x0

    if-gez v4, :cond_0

    cmp-long v4, v2, v9

    if-lez v4, :cond_0

    sget-object v0, Lb/c/a/a;->b:Ljava/util/logging/Logger;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v4, "Plausibility check failed: size < 8 (size = "

    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v2, "). Stop parsing!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->severe(Ljava/lang/String;)V

    return-object v11

    :cond_0
    iget-object v4, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/nio/ByteBuffer;

    invoke-static {v4}, Lb/c/a/e;->b(Ljava/nio/ByteBuffer;)Ljava/lang/String;

    move-result-object v4

    cmp-long v9, v2, v9

    const-wide/16 v12, 0x10

    const/16 v10, 0x10

    if-nez v9, :cond_1

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v10}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-interface {v1, v2}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-virtual {v2, v5}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v2, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    invoke-static {v2}, Lb/c/a/e;->m(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    sub-long/2addr v2, v12

    goto :goto_1

    :cond_1
    const-wide/16 v14, 0x0

    cmp-long v5, v2, v14

    if-nez v5, :cond_2

    invoke-interface/range {p1 .. p1}, Lb/e/a/e;->size()J

    move-result-wide v2

    invoke-interface/range {p1 .. p1}, Lb/e/a/e;->l()J

    move-result-wide v7

    :cond_2
    sub-long/2addr v2, v7

    :goto_1
    const-string v5, "uuid"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    iget-object v5, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/nio/ByteBuffer;

    iget-object v7, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v7}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/nio/ByteBuffer;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->limit()I

    move-result v7

    add-int/2addr v7, v10

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v5, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/nio/ByteBuffer;

    invoke-interface {v1, v5}, Lb/e/a/e;->y(Ljava/nio/ByteBuffer;)I

    new-array v5, v10, [B

    iget-object v7, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v7}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/nio/ByteBuffer;

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->position()I

    move-result v7

    sub-int/2addr v7, v10

    :goto_2
    iget-object v8, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v8}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/nio/ByteBuffer;

    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->position()I

    move-result v8

    if-lt v7, v8, :cond_3

    sub-long/2addr v2, v12

    move-wide v7, v2

    move-object v11, v5

    goto :goto_3

    :cond_3
    iget-object v8, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v8}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/nio/ByteBuffer;

    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->position()I

    move-result v8

    sub-int/2addr v8, v10

    sub-int v8, v7, v8

    iget-object v9, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v9}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/nio/ByteBuffer;

    invoke-virtual {v9, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v9

    aput-byte v9, v5, v8

    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    :cond_4
    move-wide v7, v2

    :goto_3
    instance-of v2, v0, Lb/c/a/i/b;

    if-eqz v2, :cond_5

    move-object v2, v0

    check-cast v2, Lb/c/a/i/b;

    invoke-interface {v2}, Lb/c/a/i/b;->getType()Ljava/lang/String;

    move-result-object v2

    goto :goto_4

    :cond_5
    const-string v2, ""

    :goto_4
    invoke-virtual {v6, v4, v11, v2}, Lb/c/a/a;->b(Ljava/lang/String;[BLjava/lang/String;)Lb/c/a/i/b;

    move-result-object v9

    invoke-interface {v9, v0}, Lb/c/a/i/b;->m(Lb/c/a/i/e;)V

    iget-object v0, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    iget-object v0, v6, Lb/c/a/a;->a:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Ljava/nio/ByteBuffer;

    move-object v0, v9

    move-object/from16 v1, p1

    move-wide v3, v7

    move-object/from16 v5, p0

    invoke-interface/range {v0 .. v5}, Lb/c/a/i/b;->b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V

    return-object v9

    :cond_6
    if-ltz v4, :cond_7

    goto/16 :goto_0

    :cond_7
    invoke-interface {v1, v2, v3}, Lb/e/a/e;->u(J)V

    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method public abstract b(Ljava/lang/String;[BLjava/lang/String;)Lb/c/a/i/b;
.end method
