.class public Llife/knowledge4/videotrimmer/h/b;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final a:Ljava/lang/String; = "b"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private static a(Lb/e/a/h/g;DZ)D
    .locals 15

    invoke-interface {p0}, Lb/e/a/h/g;->f()[J

    move-result-object v0

    array-length v0, v0

    new-array v1, v0, [D

    const/4 v2, 0x0

    const-wide/16 v3, 0x0

    const-wide/16 v5, 0x0

    move v7, v2

    move-wide v8, v3

    :goto_0
    invoke-interface {p0}, Lb/e/a/h/g;->w()[J

    move-result-object v10

    array-length v10, v10

    if-ge v7, v10, :cond_1

    invoke-interface {p0}, Lb/e/a/h/g;->w()[J

    move-result-object v10

    aget-wide v11, v10, v7

    invoke-interface {p0}, Lb/e/a/h/g;->f()[J

    move-result-object v10

    const-wide/16 v13, 0x1

    add-long/2addr v5, v13

    invoke-static {v10, v5, v6}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v10

    if-ltz v10, :cond_0

    invoke-interface {p0}, Lb/e/a/h/g;->f()[J

    move-result-object v10

    invoke-static {v10, v5, v6}, Ljava/util/Arrays;->binarySearch([JJ)I

    move-result v10

    aput-wide v8, v1, v10

    :cond_0
    long-to-double v10, v11

    invoke-interface {p0}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v12

    invoke-virtual {v12}, Lb/e/a/h/h;->g()J

    move-result-wide v12

    long-to-double v12, v12

    div-double/2addr v10, v12

    add-double/2addr v8, v10

    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    if-ge v2, v0, :cond_4

    aget-wide v5, v1, v2

    cmpl-double v7, v5, p1

    if-lez v7, :cond_3

    if-eqz p3, :cond_2

    return-wide v5

    :cond_2
    return-wide v3

    :cond_3
    add-int/lit8 v2, v2, 0x1

    move-wide v3, v5

    goto :goto_1

    :cond_4
    add-int/lit8 v0, v0, -0x1

    aget-wide v0, v1, v0

    return-wide v0
.end method

.method private static b(Ljava/io/File;Ljava/io/File;JJLlife/knowledge4/videotrimmer/g/c;)V
    .locals 22

    new-instance v0, Lb/e/a/f;

    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lb/e/a/f;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lb/e/a/h/j/a/a;->a(Lb/e/a/e;)Lb/e/a/h/d;

    move-result-object v0

    invoke-virtual {v0}, Lb/e/a/h/d;->g()Ljava/util/List;

    move-result-object v1

    new-instance v2, Ljava/util/LinkedList;

    invoke-direct {v2}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {v0, v2}, Lb/e/a/h/d;->i(Ljava/util/List;)V

    const-wide/16 v2, 0x3e8

    div-long v4, p2, v2

    long-to-double v4, v4

    div-long v2, p4, v2

    long-to-double v2, v2

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    const/4 v7, 0x0

    move v8, v7

    :cond_0
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    const/4 v10, 0x1

    if-eqz v9, :cond_2

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lb/e/a/h/g;

    invoke-interface {v9}, Lb/e/a/h/g;->f()[J

    move-result-object v11

    if-eqz v11, :cond_0

    invoke-interface {v9}, Lb/e/a/h/g;->f()[J

    move-result-object v11

    array-length v11, v11

    if-lez v11, :cond_0

    if-nez v8, :cond_1

    invoke-static {v9, v4, v5, v7}, Llife/knowledge4/videotrimmer/h/b;->a(Lb/e/a/h/g;DZ)D

    move-result-wide v4

    invoke-static {v9, v2, v3, v10}, Llife/knowledge4/videotrimmer/h/b;->a(Lb/e/a/h/g;DZ)D

    move-result-wide v2

    move v8, v10

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "The startTime has already been corrected by another track with SyncSample. Not Supported."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    move-object v12, v6

    check-cast v12, Lb/e/a/h/g;

    const-wide/16 v8, 0x0

    const-wide/16 v13, 0x0

    const-wide/high16 v15, -0x4010000000000000L    # -1.0

    const-wide/16 v17, -0x1

    move v6, v7

    move-wide/from16 v19, v15

    move-wide v15, v13

    move-wide/from16 v13, v17

    :goto_2
    invoke-interface {v12}, Lb/e/a/h/g;->w()[J

    move-result-object v11

    array-length v11, v11

    if-ge v6, v11, :cond_5

    invoke-interface {v12}, Lb/e/a/h/g;->w()[J

    move-result-object v11

    aget-wide v10, v11, v6

    cmpl-double v19, v15, v19

    if-lez v19, :cond_3

    cmpg-double v20, v15, v4

    if-gtz v20, :cond_3

    move-wide v13, v8

    :cond_3
    if-lez v19, :cond_4

    cmpg-double v19, v15, v2

    if-gtz v19, :cond_4

    move-wide/from16 v17, v8

    :cond_4
    long-to-double v10, v10

    invoke-interface {v12}, Lb/e/a/h/g;->z()Lb/e/a/h/h;

    move-result-object v19

    move-wide/from16 p3, v8

    invoke-virtual/range {v19 .. v19}, Lb/e/a/h/h;->g()J

    move-result-wide v7

    long-to-double v7, v7

    div-double/2addr v10, v7

    add-double v7, v15, v10

    const-wide/16 v9, 0x1

    move-wide/from16 v19, p3

    add-long v9, v19, v9

    add-int/lit8 v6, v6, 0x1

    move-wide/from16 v19, v15

    move-wide v15, v7

    move-wide v8, v9

    const/4 v7, 0x0

    const/4 v10, 0x1

    goto :goto_2

    :cond_5
    new-instance v6, Lb/e/a/h/l/a;

    const/4 v7, 0x1

    new-array v8, v7, [Lb/e/a/h/g;

    new-instance v9, Lb/e/a/h/l/c;

    move-object v11, v9

    move-wide/from16 v15, v17

    invoke-direct/range {v11 .. v16}, Lb/e/a/h/l/c;-><init>(Lb/e/a/h/g;JJ)V

    const/4 v10, 0x0

    aput-object v9, v8, v10

    invoke-direct {v6, v8}, Lb/e/a/h/l/a;-><init>([Lb/e/a/h/g;)V

    invoke-virtual {v0, v6}, Lb/e/a/h/d;->a(Lb/e/a/h/g;)V

    move/from16 v21, v10

    move v10, v7

    move/from16 v7, v21

    goto :goto_1

    :cond_6
    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_7

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->createNewFile()Z

    :cond_7
    new-instance v1, Lb/e/a/h/i/b;

    invoke-direct {v1}, Lb/e/a/h/i/b;-><init>()V

    invoke-virtual {v1, v0}, Lb/e/a/h/i/b;->b(Lb/e/a/h/d;)Lb/c/a/i/e;

    move-result-object v0

    new-instance v1, Ljava/io/FileOutputStream;

    move-object/from16 v2, p1

    invoke-direct {v1, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v3

    invoke-interface {v0, v3}, Lb/c/a/i/e;->h(Ljava/nio/channels/WritableByteChannel;)V

    invoke-virtual {v3}, Ljava/nio/channels/FileChannel;->close()V

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    move-object/from16 v1, p6

    invoke-interface {v1, v0}, Llife/knowledge4/videotrimmer/g/c;->m(Landroid/net/Uri;)V

    return-void
.end method

.method public static c(Ljava/io/File;Ljava/lang/String;JJLlife/knowledge4/videotrimmer/g/c;)V
    .locals 7

    new-instance v0, Ljava/text/SimpleDateFormat;

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v2, "yyyyMMdd_HHmmss"

    invoke-direct {v0, v2, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MP4_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ".mp4"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    sget-object v0, Llife/knowledge4/videotrimmer/h/b;->a:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Generated file path "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, p0

    move-wide v2, p2

    move-wide v4, p4

    move-object v6, p6

    invoke-static/range {v0 .. v6}, Llife/knowledge4/videotrimmer/h/b;->b(Ljava/io/File;Ljava/io/File;JJLlife/knowledge4/videotrimmer/g/c;)V

    return-void
.end method
