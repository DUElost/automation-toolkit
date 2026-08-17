.class Lb/e/a/h/i/b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/c/a/i/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/e/a/h/i/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;>;"
        }
    .end annotation
.end field

.field c:Lb/c/a/i/e;

.field d:J


# direct methods
.method private constructor <init>(Lb/e/a/h/i/b;Lb/e/a/h/d;Ljava/util/Map;J)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lb/e/a/h/d;",
            "Ljava/util/Map<",
            "Lb/e/a/h/g;",
            "[I>;J)V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, v0, Lb/e/a/h/i/b$b;->b:Ljava/util/List;

    move-wide/from16 v2, p4

    iput-wide v2, v0, Lb/e/a/h/i/b$b;->d:J

    invoke-virtual/range {p2 .. p2}, Lb/e/a/h/d;->g()Ljava/util/List;

    new-instance v2, Ljava/util/ArrayList;

    invoke-interface/range {p3 .. p3}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    new-instance v3, Lb/e/a/h/i/b$b$a;

    invoke-direct {v3, v0}, Lb/e/a/h/i/b$b$a;-><init>(Lb/e/a/h/i/b$b;)V

    invoke-static {v2, v3}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-nez v7, :cond_5

    :goto_1
    const/4 v6, 0x0

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_0
    :goto_2
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-nez v8, :cond_3

    if-nez v6, :cond_1

    return-void

    :cond_1
    invoke-interface {v3, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v8

    invoke-interface {v1, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [I

    aget v9, v7, v8

    invoke-interface {v4, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-interface {v5, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Double;

    invoke-virtual {v7}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v11

    move v7, v10

    :goto_3
    add-int v13, v10, v9

    if-lt v7, v13, :cond_2

    iget-object v7, v0, Lb/e/a/h/i/b$b;->b:Ljava/util/List;

    invoke-interface {v6}, Lb/e/a/h/g;->g()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9, v10, v13}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v9

    invoke-interface {v7, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v8, v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {v3, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {v4, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v11, v12}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v7

    invoke-interface {v5, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    invoke-interface {v6}, Lb/e/a/h/g;->w()[J

    move-result-object v13

    aget-wide v14, v13, v7

    long-to-double v13, v14

    invoke-interface {v6}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v15

    move/from16 p2, v8

    move/from16 p1, v9

    invoke-virtual {v15}, Lb/e/a/h/h;->g()J

    move-result-wide v8

    long-to-double v8, v8

    div-double/2addr v13, v8

    add-double/2addr v11, v13

    add-int/lit8 v7, v7, 0x1

    move/from16 v9, p1

    move/from16 v8, p2

    goto :goto_3

    :cond_3
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lb/e/a/h/g;

    if-eqz v6, :cond_4

    invoke-interface {v5, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Double;

    invoke-virtual {v9}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v9

    invoke-interface {v5, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Double;

    invoke-virtual {v11}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v11

    cmpg-double v9, v9, v11

    if-gez v9, :cond_0

    :cond_4
    invoke-interface {v3, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Integer;

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    invoke-interface {v1, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, [I

    array-length v10, v10

    if-ge v9, v10, :cond_0

    move-object v6, v8

    goto/16 :goto_2

    :cond_5
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lb/e/a/h/g;

    const/4 v8, 0x0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v3, v7, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v4, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-wide/16 v8, 0x0

    invoke-static {v8, v9}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v8

    invoke-interface {v5, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0
.end method

.method synthetic constructor <init>(Lb/e/a/h/i/b;Lb/e/a/h/d;Ljava/util/Map;JLb/e/a/h/i/b$b;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lb/e/a/h/i/b$b;-><init>(Lb/e/a/h/i/b;Lb/e/a/h/d;Ljava/util/Map;J)V

    return-void
.end method

.method private d(J)Z
    .locals 2

    const-wide/16 v0, 0x8

    add-long/2addr p1, v0

    const-wide v0, 0x100000000L

    cmp-long p1, p1, v0

    if-gez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method


# virtual methods
.method public a()J
    .locals 4

    iget-wide v0, p0, Lb/e/a/h/i/b$b;->d:J

    const-wide/16 v2, 0x10

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public b(Lb/e/a/e;Ljava/nio/ByteBuffer;JLb/c/a/b;)V
    .locals 0

    return-void
.end method

.method public c()J
    .locals 7

    const-wide/16 v0, 0x10

    move-object v2, p0

    :goto_0
    instance-of v3, v2, Lb/c/a/i/b;

    if-nez v3, :cond_0

    return-wide v0

    :cond_0
    move-object v3, v2

    check-cast v3, Lb/c/a/i/b;

    invoke-interface {v3}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v4

    invoke-interface {v4}, Lb/c/a/i/e;->e()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-nez v5, :cond_1

    goto :goto_2

    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/c/a/i/b;

    if-ne v2, v5, :cond_2

    :goto_2
    invoke-interface {v3}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v2

    goto :goto_0

    :cond_2
    invoke-interface {v5}, Lb/c/a/i/b;->a()J

    move-result-wide v5

    add-long/2addr v0, v5

    goto :goto_1
.end method

.method public getParent()Lb/c/a/i/e;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/i/b$b;->c:Lb/c/a/i/e;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    const-string v0, "mdat"

    return-object v0
.end method

.method public m(Lb/c/a/i/e;)V
    .locals 0

    iput-object p1, p0, Lb/e/a/h/i/b$b;->c:Lb/c/a/i/e;

    return-void
.end method

.method public t(Ljava/nio/channels/WritableByteChannel;)V
    .locals 11

    const/16 v0, 0x10

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {p0}, Lb/e/a/h/i/b$b;->a()J

    move-result-wide v1

    invoke-direct {p0, v1, v2}, Lb/e/a/h/i/b$b;->d(J)Z

    move-result v3

    const-wide/16 v4, 0x1

    if-eqz v3, :cond_0

    invoke-static {v0, v1, v2}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    goto :goto_0

    :cond_0
    invoke-static {v0, v4, v5}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    :goto_0
    const-string v3, "mdat"

    invoke-static {v3}, Lb/c/a/d;->F(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-direct {p0, v1, v2}, Lb/e/a/h/i/b$b;->d(J)Z

    move-result v3

    if-eqz v3, :cond_1

    const/16 v1, 0x8

    new-array v1, v1, [B

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    goto :goto_1

    :cond_1
    invoke-static {v0, v1, v2}, Lb/c/a/f;->i(Ljava/nio/ByteBuffer;J)V

    :goto_1
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    invoke-static {}, Lb/e/a/h/i/b;->a()Lb/e/a/j/f;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "About to write "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v2, p0, Lb/e/a/h/i/b$b;->d:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    iget-object v0, p0, Lb/e/a/h/i/b$b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const-wide/16 v1, 0x0

    move-wide v6, v1

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_2

    return-void

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_3
    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-nez v8, :cond_4

    goto :goto_2

    :cond_4
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lb/e/a/h/f;

    invoke-interface {v8, p1}, Lb/e/a/h/f;->b(Ljava/nio/channels/WritableByteChannel;)V

    invoke-interface {v8}, Lb/e/a/h/f;->a()J

    move-result-wide v8

    add-long/2addr v1, v8

    const-wide/32 v8, 0x100000

    cmp-long v10, v1, v8

    if-lez v10, :cond_3

    sub-long/2addr v1, v8

    add-long/2addr v6, v4

    invoke-static {}, Lb/e/a/h/i/b;->a()Lb/e/a/j/f;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, "Written "

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v10, "MB"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Lb/e/a/j/f;->b(Ljava/lang/String;)V

    goto :goto_3
.end method
