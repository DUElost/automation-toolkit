.class public Lb/e/a/h/k/a;
.super Ljava/util/AbstractList;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/e/a/h/k/a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/AbstractList<",
        "Lb/e/a/h/f;",
        ">;"
    }
.end annotation


# static fields
.field private static final k:Lb/e/a/j/f;


# instance fields
.field b:Lb/c/a/i/e;

.field c:Lb/c/a/i/f0;

.field d:[Ljava/lang/ref/SoftReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/lang/ref/SoftReference<",
            "Ljava/nio/ByteBuffer;",
            ">;"
        }
    .end annotation
.end field

.field e:[I

.field f:[J

.field g:[J

.field h:[[J

.field i:Lb/c/a/i/v;

.field j:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/h/k/a;

    invoke-static {v0}, Lb/e/a/j/f;->a(Ljava/lang/Class;)Lb/e/a/j/f;

    move-result-object v0

    sput-object v0, Lb/e/a/h/k/a;->k:Lb/e/a/j/f;

    return-void
.end method

.method public constructor <init>(JLb/c/a/i/e;)V
    .locals 20

    move-object/from16 v0, p0

    move-wide/from16 v1, p1

    move-object/from16 v3, p3

    invoke-direct/range {p0 .. p0}, Ljava/util/AbstractList;-><init>()V

    const/4 v4, 0x0

    iput-object v4, v0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    iput-object v4, v0, Lb/e/a/h/k/a;->d:[Ljava/lang/ref/SoftReference;

    const/4 v5, 0x0

    iput v5, v0, Lb/e/a/h/k/a;->j:I

    iput-object v3, v0, Lb/e/a/h/k/a;->b:Lb/c/a/i/e;

    const-class v6, Lb/c/a/i/q;

    invoke-interface {v3, v6}, Lb/c/a/i/e;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/q;

    const-class v6, Lb/c/a/i/f0;

    invoke-virtual {v3, v6}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_a

    iget-object v3, v0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    if-eqz v3, :cond_9

    invoke-virtual {v3}, Lb/c/a/i/f0;->H()Lb/c/a/i/w;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/w;->G()Lb/c/a/i/c;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/c;->s()[J

    move-result-object v1

    iput-object v1, v0, Lb/e/a/h/k/a;->f:[J

    array-length v2, v1

    new-array v2, v2, [J

    iput-object v2, v0, Lb/e/a/h/k/a;->g:[J

    array-length v1, v1

    new-array v1, v1, [Ljava/lang/ref/SoftReference;

    iput-object v1, v0, Lb/e/a/h/k/a;->d:[Ljava/lang/ref/SoftReference;

    new-instance v2, Ljava/lang/ref/SoftReference;

    invoke-direct {v2, v4}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-static {v1, v2}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object v1, v0, Lb/e/a/h/k/a;->f:[J

    array-length v1, v1

    new-array v1, v1, [[J

    iput-object v1, v0, Lb/e/a/h/k/a;->h:[[J

    iget-object v1, v0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    invoke-virtual {v1}, Lb/c/a/i/f0;->H()Lb/c/a/i/w;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/w;->J()Lb/c/a/i/v;

    move-result-object v1

    iput-object v1, v0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    iget-object v1, v0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    invoke-virtual {v1}, Lb/c/a/i/f0;->H()Lb/c/a/i/w;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/w;->K()Lb/c/a/i/x;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/x;->u()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [Lb/c/a/i/x$a;

    invoke-interface {v1, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    move-object v3, v1

    check-cast v3, [Lb/c/a/i/x$a;

    aget-object v1, v3, v5

    invoke-virtual {v1}, Lb/c/a/i/x$a;->a()J

    move-result-wide v6

    invoke-virtual {v1}, Lb/c/a/i/x$a;->c()J

    move-result-wide v1

    invoke-static {v1, v2}, Lb/e/a/j/b;->a(J)I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lb/e/a/h/k/a;->size()I

    move-result v4

    const/4 v8, 0x1

    move v2, v5

    move v10, v2

    move v9, v8

    move v11, v9

    :cond_1
    add-int/2addr v2, v8

    int-to-long v12, v2

    cmp-long v12, v12, v6

    const/4 v15, -0x1

    if-nez v12, :cond_3

    array-length v6, v3

    if-le v6, v9, :cond_2

    add-int/lit8 v6, v9, 0x1

    aget-object v7, v3, v9

    invoke-virtual {v7}, Lb/c/a/i/x$a;->c()J

    move-result-wide v9

    invoke-static {v9, v10}, Lb/e/a/j/b;->a(J)I

    move-result v9

    invoke-virtual {v7}, Lb/c/a/i/x$a;->a()J

    move-result-wide v16

    move v10, v1

    move v1, v9

    move v9, v6

    move-wide/from16 v6, v16

    goto :goto_1

    :cond_2
    move v10, v1

    move v1, v15

    const-wide v6, 0x7fffffffffffffffL

    :cond_3
    :goto_1
    iget-object v12, v0, Lb/e/a/h/k/a;->h:[[J

    add-int/lit8 v16, v2, -0x1

    new-array v13, v10, [J

    aput-object v13, v12, v16

    add-int/2addr v11, v10

    if-le v11, v4, :cond_1

    add-int/2addr v2, v8

    new-array v1, v2, [I

    iput-object v1, v0, Lb/e/a/h/k/a;->e:[I

    aget-object v1, v3, v5

    invoke-virtual {v1}, Lb/c/a/i/x$a;->a()J

    move-result-wide v6

    invoke-virtual {v1}, Lb/c/a/i/x$a;->c()J

    move-result-wide v1

    invoke-static {v1, v2}, Lb/e/a/j/b;->a(J)I

    move-result v1

    move v2, v5

    move v11, v2

    move v9, v8

    move v10, v9

    :goto_2
    iget-object v12, v0, Lb/e/a/h/k/a;->e:[I

    add-int/lit8 v13, v2, 0x1

    aput v9, v12, v2

    move v2, v9

    int-to-long v8, v13

    cmp-long v8, v8, v6

    if-nez v8, :cond_5

    array-length v6, v3

    if-le v6, v10, :cond_4

    add-int/lit8 v6, v10, 0x1

    aget-object v7, v3, v10

    invoke-virtual {v7}, Lb/c/a/i/x$a;->c()J

    move-result-wide v8

    invoke-static {v8, v9}, Lb/e/a/j/b;->a(J)I

    move-result v8

    invoke-virtual {v7}, Lb/c/a/i/x$a;->a()J

    move-result-wide v9

    move v11, v1

    move v1, v8

    move-wide/from16 v18, v9

    move v10, v6

    move-wide/from16 v6, v18

    goto :goto_3

    :cond_4
    move v11, v1

    move v1, v15

    const-wide v6, 0x7fffffffffffffffL

    :cond_5
    :goto_3
    add-int v9, v2, v11

    if-le v9, v4, :cond_8

    iget-object v1, v0, Lb/e/a/h/k/a;->e:[I

    const v2, 0x7fffffff

    aput v2, v1, v13

    const-wide/16 v1, 0x0

    move-wide v3, v1

    const/4 v8, 0x1

    :goto_4
    int-to-long v6, v8

    iget-object v9, v0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    invoke-virtual {v9}, Lb/c/a/i/v;->s()J

    move-result-wide v9

    cmp-long v6, v6, v9

    if-lez v6, :cond_6

    return-void

    :cond_6
    :goto_5
    iget-object v6, v0, Lb/e/a/h/k/a;->e:[I

    aget v6, v6, v5

    if-eq v8, v6, :cond_7

    iget-object v6, v0, Lb/e/a/h/k/a;->g:[J

    add-int/lit8 v7, v5, -0x1

    aget-wide v9, v6, v7

    iget-object v11, v0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    add-int/lit8 v12, v8, -0x1

    invoke-virtual {v11, v12}, Lb/c/a/i/v;->v(I)J

    move-result-wide v13

    add-long/2addr v9, v13

    aput-wide v9, v6, v7

    iget-object v6, v0, Lb/e/a/h/k/a;->h:[[J

    aget-object v6, v6, v7

    iget-object v9, v0, Lb/e/a/h/k/a;->e:[I

    aget v7, v9, v7

    sub-int v7, v8, v7

    aput-wide v3, v6, v7

    iget-object v6, v0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    invoke-virtual {v6, v12}, Lb/c/a/i/v;->v(I)J

    move-result-wide v6

    add-long/2addr v3, v6

    add-int/lit8 v8, v8, 0x1

    goto :goto_4

    :cond_7
    add-int/lit8 v5, v5, 0x1

    move-wide v3, v1

    goto :goto_5

    :cond_8
    move v2, v13

    const/4 v8, 0x1

    goto :goto_2

    :cond_9
    new-instance v3, Ljava/lang/RuntimeException;

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "This MP4 does not contain track "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_a
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/c/a/i/f0;

    invoke-virtual {v6}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object v7

    invoke-virtual {v7}, Lb/c/a/i/g0;->A()J

    move-result-wide v7

    cmp-long v7, v7, v1

    if-nez v7, :cond_0

    iput-object v6, v0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    goto/16 :goto_0
.end method

.method static synthetic a()Lb/e/a/j/f;
    .locals 1

    sget-object v0, Lb/e/a/h/k/a;->k:Lb/e/a/j/f;

    return-object v0
.end method


# virtual methods
.method public b(I)Lb/e/a/h/f;
    .locals 4

    int-to-long v0, p1

    iget-object v2, p0, Lb/e/a/h/k/a;->i:Lb/c/a/i/v;

    invoke-virtual {v2}, Lb/c/a/i/v;->s()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    new-instance v0, Lb/e/a/h/k/a$a;

    invoke-direct {v0, p0, p1}, Lb/e/a/h/k/a$a;-><init>(Lb/e/a/h/k/a;I)V

    return-object v0

    :cond_0
    new-instance p1, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {p1}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw p1
.end method

.method declared-synchronized c(I)I
    .locals 3

    monitor-enter p0

    add-int/lit8 p1, p1, 0x1

    :try_start_0
    iget-object v0, p0, Lb/e/a/h/k/a;->e:[I

    iget v1, p0, Lb/e/a/h/k/a;->j:I

    aget v2, v0, v1

    if-lt p1, v2, :cond_0

    add-int/lit8 v2, v1, 0x1

    aget v2, v0, v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ge p1, v2, :cond_0

    monitor-exit p0

    return v1

    :cond_0
    :try_start_1
    aget v0, v0, v1

    if-ge p1, v0, :cond_2

    const/4 v0, 0x0

    iput v0, p0, Lb/e/a/h/k/a;->j:I

    :goto_0
    iget-object v0, p0, Lb/e/a/h/k/a;->e:[I

    iget v1, p0, Lb/e/a/h/k/a;->j:I

    add-int/lit8 v2, v1, 0x1

    aget v0, v0, v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-le v0, p1, :cond_1

    monitor-exit p0

    return v1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    :try_start_2
    iput v1, p0, Lb/e/a/h/k/a;->j:I

    goto :goto_0

    :cond_2
    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lb/e/a/h/k/a;->j:I

    :goto_1
    iget-object v0, p0, Lb/e/a/h/k/a;->e:[I

    iget v1, p0, Lb/e/a/h/k/a;->j:I

    add-int/lit8 v2, v1, 0x1

    aget v0, v0, v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-le v0, p1, :cond_3

    monitor-exit p0

    return v1

    :cond_3
    add-int/lit8 v1, v1, 0x1

    :try_start_3
    iput v1, p0, Lb/e/a/h/k/a;->j:I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public bridge synthetic get(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lb/e/a/h/k/a;->b(I)Lb/e/a/h/f;

    move-result-object p1

    return-object p1
.end method

.method public size()I
    .locals 2

    iget-object v0, p0, Lb/e/a/h/k/a;->c:Lb/c/a/i/f0;

    invoke-virtual {v0}, Lb/c/a/i/f0;->H()Lb/c/a/i/w;

    move-result-object v0

    invoke-virtual {v0}, Lb/c/a/i/w;->J()Lb/c/a/i/v;

    move-result-object v0

    invoke-virtual {v0}, Lb/c/a/i/v;->s()J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/b;->a(J)I

    move-result v0

    return v0
.end method
