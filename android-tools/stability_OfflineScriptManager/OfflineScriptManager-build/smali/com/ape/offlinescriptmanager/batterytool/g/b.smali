.class public Lcom/ape/offlinescriptmanager/batterytool/g/b;
.super Lcom/ape/offlinescriptmanager/batterytool/g/a;
.source ""


# instance fields
.field A:D

.field B:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/a$a;",
            ">;>;"
        }
    .end annotation
.end field

.field C:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/a$a;",
            ">;"
        }
    .end annotation
.end field

.field D:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/a$a;",
            ">;"
        }
    .end annotation
.end field

.field E:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field F:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private G:Landroid/os/Handler;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "HandlerLeak"
        }
    .end annotation
.end field

.field private h:Landroid/content/Context;

.field private i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/String;

.field l:Landroid/database/Cursor;

.field m:Landroid/database/Cursor;

.field n:Landroid/database/Cursor;

.field o:Landroid/database/Cursor;

.field p:Landroid/database/Cursor;

.field q:Landroid/database/Cursor;

.field private r:Z

.field s:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/a$a;",
            ">;"
        }
    .end annotation
.end field

.field private t:Landroid/content/SharedPreferences;

.field private u:Landroid/content/SharedPreferences;

.field private v:Ljava/lang/String;

.field private w:Lcom/ape/offlinescriptmanager/utils/e;

.field x:Ljava/text/DecimalFormat;

.field y:D

.field z:D


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;ZZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;-><init>(Landroid/content/Context;Ljava/lang/String;ZZ)V

    const-string p2, "1"

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j:Ljava/lang/String;

    const-string p2, "10"

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k:Ljava/lang/String;

    const/4 p2, 0x0

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->o:Landroid/database/Cursor;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->p:Landroid/database/Cursor;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    const/4 p2, 0x0

    iput-boolean p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    new-instance p2, Ljava/text/DecimalFormat;

    const-string p3, "#.00"

    invoke-direct {p2, p3}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    new-instance p1, Lcom/ape/offlinescriptmanager/utils/e;

    invoke-direct {p1}, Lcom/ape/offlinescriptmanager/utils/e;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    new-instance p1, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {p2}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p0, p2}, Lcom/ape/offlinescriptmanager/batterytool/g/b$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/b;Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->G:Landroid/os/Handler;

    return-void
.end method

.method static synthetic f(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic g(Lcom/ape/offlinescriptmanager/batterytool/g/b;ILjava/lang/String;)Lorg/achartengine/h/d;
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n(ILjava/lang/String;)Lorg/achartengine/h/d;

    move-result-object p0

    return-object p0
.end method

.method static synthetic h(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->v:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic i(Lcom/ape/offlinescriptmanager/batterytool/g/b;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    return p1
.end method

.method static synthetic j(Lcom/ape/offlinescriptmanager/batterytool/g/b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j:Ljava/lang/String;

    return-object p0
.end method

.method private k(Ljava/lang/String;)J
    .locals 8

    const-string v0, "s"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    aget-object v1, p1, v0

    const-string v2, "m"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    aget-object p1, p1, v0

    invoke-virtual {p1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x1

    aget-object v2, p1, v1

    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    aget-object v4, p1, v0

    const-string v5, "h"

    invoke-virtual {v4, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    const-wide/16 v6, 0x3c

    if-eqz v4, :cond_0

    aget-object p1, p1, v0

    invoke-virtual {p1, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    aget-object v1, p1, v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    mul-long/2addr v4, v6

    add-long/2addr v2, v4

    aget-object p1, p1, v0

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    mul-long/2addr v0, v6

    goto :goto_0

    :cond_0
    aget-object p1, p1, v0

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    :goto_0
    mul-long/2addr v0, v6

    add-long/2addr v2, v0

    goto :goto_1

    :cond_1
    aget-object p1, p1, v0

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    :goto_1
    return-wide v2
.end method

.method private m()V
    .locals 7

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v2, Lcom/ape/offlinescriptmanager/database/c;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/c;->b:[Ljava/lang/String;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-string v6, "time ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/h;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/h;->b:[Ljava/lang/String;

    const-string v6, "time ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/f;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/f;->b:[Ljava/lang/String;

    const-string v6, "_id ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/e;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/e;->b:[Ljava/lang/String;

    const-string v6, "_id ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->o:Landroid/database/Cursor;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/b;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/b;->b:[Ljava/lang/String;

    const-string v6, "_id ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->p:Landroid/database/Cursor;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/d;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/d;->b:[Ljava/lang/String;

    const-string v6, "_id ASC"

    move-object v1, v0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    return-void
.end method

.method private n(ILjava/lang/String;)Lorg/achartengine/h/d;
    .locals 21

    move-object/from16 v0, p0

    new-instance v1, Lorg/achartengine/h/d;

    invoke-direct {v1}, Lorg/achartengine/h/d;-><init>()V

    const/4 v1, 0x3

    new-array v2, v1, [I

    fill-array-data v2, :array_0

    new-array v1, v1, [Lorg/achartengine/f/d;

    sget-object v3, Lorg/achartengine/f/d;->f:Lorg/achartengine/f/d;

    const/4 v4, 0x0

    aput-object v3, v1, v4

    sget-object v3, Lorg/achartengine/f/d;->d:Lorg/achartengine/f/d;

    const/4 v5, 0x1

    aput-object v3, v1, v5

    sget-object v3, Lorg/achartengine/f/d;->e:Lorg/achartengine/f/d;

    const/4 v6, 0x2

    aput-object v3, v1, v6

    invoke-static {v2, v1}, Lcom/ape/offlinescriptmanager/utils/g;->a([I[Lorg/achartengine/f/d;)Lorg/achartengine/h/d;

    move-result-object v1

    invoke-virtual {v1, v5}, Lorg/achartengine/h/b;->X(Z)V

    const v2, -0xbbbbbc

    invoke-virtual {v1, v2}, Lorg/achartengine/h/d;->b1(I)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Every "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-object/from16 v3, p2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "% used time chart"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    iget-wide v11, v2, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    sub-int/2addr v3, v5

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    iget-wide v13, v2, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-wide v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    mul-double v17, v2, v6

    const-string v9, "Time"

    const-string v10, "UsedTime"

    const-wide/16 v15, 0x0

    const/high16 v19, -0x1000000

    const/high16 v20, -0x1000000

    move-object v7, v1

    invoke-static/range {v7 .. v20}, Lcom/ape/offlinescriptmanager/utils/g;->F(Lorg/achartengine/h/d;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;DDDDII)V

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Lorg/achartengine/h/b;->N(I)V

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Lorg/achartengine/h/d;->l1(I)V

    const/4 v3, 0x5

    invoke-virtual {v1, v3}, Lorg/achartengine/h/d;->t1(I)V

    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    iget-wide v6, v3, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v8

    sub-int/2addr v8, v5

    invoke-interface {v3, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    iget-wide v8, v3, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    invoke-static {v6, v7, v8, v9, v2}, Lorg/achartengine/j/b;->b(DDI)Ljava/util/List;

    move-result-object v3

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v3}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Double;

    invoke-virtual {v7}, Ljava/lang/Double;->isNaN()Z

    move-result v8

    if-eqz v8, :cond_0

    invoke-interface {v6, v7}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-le v3, v2, :cond_3

    const-wide/high16 v2, 0x3ff0000000000000L    # 1.0

    iget-object v7, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v7, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-virtual {v1, v2, v3, v7}, Lorg/achartengine/h/d;->d0(DLjava/lang/String;)V

    :goto_1
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v2

    if-ge v4, v2, :cond_2

    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Double;

    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    iget-object v7, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    double-to-int v8, v2

    sub-int/2addr v8, v5

    invoke-interface {v7, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-virtual {v1, v2, v3, v7}, Lorg/achartengine/h/d;->d0(DLjava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Renderer "

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v9, " is:"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v2, "::::"

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v2, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_2
    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    int-to-double v2, v2

    iget-object v4, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v6

    sub-int/2addr v6, v5

    invoke-interface {v4, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v1, v2, v3, v4}, Lorg/achartengine/h/d;->d0(DLjava/lang/String;)V

    goto :goto_3

    :cond_3
    :goto_2
    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v4, v2, :cond_4

    add-int/lit8 v2, v4, 0x1

    int-to-double v5, v2

    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v1, v5, v6, v3}, Lorg/achartengine/h/d;->d0(DLjava/lang/String;)V

    move v4, v2

    goto :goto_2

    :cond_4
    :goto_3
    return-object v1

    nop

    :array_0
    .array-data 4
        -0x10000
        -0xffff01
        -0xff0100
    .end array-data
.end method


# virtual methods
.method protected c(Ljava/lang/Boolean;)V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    if-eqz v0, :cond_2

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_2
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->o:Landroid/database/Cursor;

    if-eqz v0, :cond_3

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->o:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_3
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->p:Landroid/database/Cursor;

    if-eqz v0, :cond_4

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->p:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_4
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    if-eqz v0, :cond_5

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_5
    invoke-super {p0, p1}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->c(Ljava/lang/Boolean;)V

    new-instance p1, Lcom/ape/offlinescriptmanager/utils/a;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/ape/offlinescriptmanager/utils/a;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x1

    const-string v1, "com.ape.offlinescriptmanager.pref"

    const-string v2, "export_battery_finish"

    invoke-virtual {p1, v1, v2, v0}, Lcom/ape/offlinescriptmanager/utils/a;->h(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l([Ljava/lang/Void;)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method protected varargs l([Ljava/lang/Void;)Ljava/lang/Boolean;
    .locals 32

    move-object/from16 v1, p0

    invoke-direct/range {p0 .. p0}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    :cond_0
    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d:Ljava/lang/String;

    const-string v4, "battery"

    invoke-direct {v0, v2, v3, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/c;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d:Ljava/lang/String;

    invoke-static {v0, v4}, Lcom/ape/offlinescriptmanager/utils/g;->l(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->v:Ljava/lang/String;

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const-string v2, "xuhang_data"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->u:Landroid/content/SharedPreferences;

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const-string v2, "circle_data"

    invoke-virtual {v0, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->l:Landroid/database/Cursor;

    invoke-virtual {v0, v2}, Lcom/ape/offlinescriptmanager/utils/e;->b(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v0

    const/4 v2, 0x2

    const/4 v4, 0x1

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    if-lez v5, :cond_2

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v6, v2

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/ape/offlinescriptmanager/batterytool/f/b;

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/b;->c()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lcom/ape/offlinescriptmanager/utils/g;->o(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v3, v6, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/b;->a()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v4, v6, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/b;->b()D

    move-result-wide v7

    invoke-static {v7, v8}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v2, v6, v7}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v6, v4

    goto :goto_0

    :cond_1
    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v6, v5, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v5, v6, v7}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->clear()V

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_2
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->m:Landroid/database/Cursor;

    invoke-virtual {v0, v5}, Lcom/ape/offlinescriptmanager/utils/e;->f(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    if-lez v5, :cond_4

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v6, v2

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/ape/offlinescriptmanager/batterytool/f/d;

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/d;->b()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lcom/ape/offlinescriptmanager/utils/g;->o(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v3, v6, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/d;->c()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v4, v6, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v7}, Lcom/ape/offlinescriptmanager/batterytool/f/d;->a()D

    move-result-wide v7

    invoke-static {v7, v8}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v2, v6, v7}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v6, v4

    goto :goto_1

    :cond_3
    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v6, v5, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iget-object v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v5, v6, v7}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->clear()V

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_4
    const-wide/16 v5, 0x0

    iput-wide v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->o:Landroid/database/Cursor;

    invoke-virtual {v0, v7}, Lcom/ape/offlinescriptmanager/utils/e;->d(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v7

    const-string v10, "Lower limit"

    const-string v11, "% used time"

    const-string v12, "Every "

    const-string v13, "Upper limit"

    const-wide v14, 0x3fe3333333333333L    # 0.6

    const-wide v16, 0x3ff6666666666666L    # 1.4

    if-eqz v7, :cond_8

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_8

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Lcom/ape/offlinescriptmanager/batterytool/f/c;

    iget-wide v8, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-virtual/range {v19 .. v19}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v1, v5}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v2

    long-to-double v2, v2

    add-double/2addr v8, v2

    iput-wide v8, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    const/4 v2, 0x2

    const/4 v3, 0x0

    goto :goto_2

    :cond_5
    iget-wide v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v0

    int-to-double v8, v0

    div-double/2addr v2, v8

    iput-wide v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    mul-double v2, v2, v16

    iput-wide v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->z:D

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    invoke-virtual {v0, v2, v3}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    iget-wide v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    mul-double/2addr v2, v14

    iput-wide v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->A:D

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    invoke-virtual {v5, v2, v3}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v5, 0x0

    const/4 v8, 0x2

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/ape/offlinescriptmanager/batterytool/f/c;

    add-int/2addr v5, v4

    new-instance v14, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v14, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    invoke-virtual {v9}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v15

    move-object/from16 v20, v7

    invoke-direct {v1, v15}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v6

    long-to-double v6, v6

    iput-wide v6, v14, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    int-to-double v6, v5

    iput-wide v6, v14, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v6, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v6, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v6, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-virtual {v9}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v6, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v6, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    move v15, v5

    iget-wide v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->z:D

    iput-wide v4, v6, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    iget-wide v4, v14, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iput-wide v4, v6, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v4, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    iget-wide v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->A:D

    iput-wide v5, v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    iget-wide v5, v14, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iput-wide v5, v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v9}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v1, v5, v8, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v9}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    invoke-virtual {v1, v5, v8, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v9}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->b()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x2

    invoke-virtual {v1, v5, v8, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v4, 0x3

    invoke-virtual {v1, v4, v8, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v4, 0x4

    invoke-virtual {v1, v4, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/lit8 v8, v8, 0x1

    move v5, v15

    move-object/from16 v7, v20

    const/4 v4, 0x1

    const-wide v14, 0x3fe3333333333333L    # 0.6

    goto/16 :goto_3

    :cond_6
    move-object/from16 v20, v7

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    invoke-interface {v3, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    invoke-interface {v3, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v4, 0x7f0f0051

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v8, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    iget-wide v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-virtual {v3, v5, v6}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x1

    invoke-virtual {v1, v5, v8, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v8, v5

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v6, 0x7f0f0053

    invoke-virtual {v3, v6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v4, v8, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v1, v5, v8, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v8, v5

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v3, 0x7f0f0052

    invoke-virtual {v0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v4, v8, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v1, v5, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iput-boolean v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    const/4 v2, 0x5

    iput v2, v0, Landroid/os/Message;->what:I

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->G:Landroid/os/Handler;

    invoke-virtual {v2, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    :goto_4
    iget-boolean v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    if-eqz v0, :cond_7

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v0, v2, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    const-wide/high16 v23, 0x4014000000000000L    # 5.0

    const-wide/high16 v25, 0x3ff0000000000000L    # 1.0

    const-wide/high16 v27, 0x4020000000000000L    # 8.0

    const-wide/high16 v29, 0x4037000000000000L    # 23.0

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->j:Ljava/lang/String;

    move-object/from16 v21, v0

    move-object/from16 v22, v2

    move-object/from16 v31, v3

    invoke-virtual/range {v21 .. v31}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c(Ljxl/write/WritableSheet;DDDDLjava/lang/String;)V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface/range {v20 .. v20}, Ljava/util/List;->clear()V

    goto :goto_5

    :cond_7
    :try_start_0
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/TimeUnit;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_4

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_4

    :cond_8
    :goto_5
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    invoke-virtual {v0, v2}, Lcom/ape/offlinescriptmanager/utils/e;->e(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v2

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const-wide/16 v3, 0x0

    iput-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    if-eqz v2, :cond_c

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_c

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/ape/offlinescriptmanager/batterytool/f/c;

    iget-wide v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v8

    long-to-double v8, v8

    add-double/2addr v4, v8

    iput-wide v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    goto :goto_6

    :cond_9
    iget-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    int-to-double v5, v0

    div-double/2addr v3, v5

    iput-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    mul-double v3, v3, v16

    iput-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->z:D

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    invoke-virtual {v0, v3, v4}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v0

    iget-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    const-wide v5, 0x3fe3333333333333L    # 0.6

    mul-double/2addr v3, v5

    iput-wide v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->A:D

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    invoke-virtual {v5, v3, v4}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x2

    :goto_7
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_a

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/ape/offlinescriptmanager/batterytool/f/c;

    const/4 v7, 0x1

    add-int/2addr v5, v7

    new-instance v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v9, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    invoke-virtual {v8}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v14

    invoke-direct {v1, v14}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v14

    long-to-double v14, v14

    iput-wide v14, v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    int-to-double v14, v5

    iput-wide v14, v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v14, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v14, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "usedHelper00 x:"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-object v15, v8

    iget-wide v7, v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    invoke-virtual {v14, v7, v8}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v7, "::"

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v7

    const-string v8, "%~"

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    aget-object v7, v7, v8

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    iget-object v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->F:Ljava/util/List;

    invoke-virtual {v15}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v8

    invoke-interface {v7, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v7, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v7, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    move-object v8, v4

    move v14, v5

    iget-wide v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->z:D

    iput-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    iget-wide v4, v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iput-wide v4, v7, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    invoke-direct {v4, v1}, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/g/a;)V

    move-object v5, v8

    iget-wide v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->A:D

    iput-wide v7, v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    iget-wide v7, v9, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iput-wide v7, v4, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-object v7, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    invoke-interface {v7, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v15}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->a()Ljava/lang/String;

    move-result-object v4

    const/4 v7, 0x0

    invoke-virtual {v1, v7, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v15}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->c()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k(Ljava/lang/String;)J

    move-result-wide v7

    invoke-static {v7, v8}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    const/4 v7, 0x1

    invoke-virtual {v1, v7, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v15}, Lcom/ape/offlinescriptmanager/batterytool/f/c;->b()Ljava/lang/String;

    move-result-object v4

    const/4 v8, 0x2

    invoke-virtual {v1, v8, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v4, 0x3

    invoke-virtual {v1, v4, v6, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v4, 0x4

    invoke-virtual {v1, v4, v6, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/lit8 v6, v6, 0x1

    move-object v4, v5

    move v5, v14

    goto/16 :goto_7

    :cond_a
    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->C:Ljava/util/List;

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    invoke-interface {v4, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->s:Ljava/util/List;

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v8, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->B:Ljava/util/List;

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->D:Ljava/util/List;

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->E:Ljava/util/List;

    invoke-interface {v4, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v5, 0x7f0f0051

    invoke-virtual {v4, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v1, v5, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->x:Ljava/text/DecimalFormat;

    iget-wide v8, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->y:D

    invoke-virtual {v4, v8, v9}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v4

    const/4 v7, 0x1

    invoke-virtual {v1, v7, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v6, v7

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v8, 0x7f0f0053

    invoke-virtual {v4, v8}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v5, v6, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v1, v7, v6, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v6, v7

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v4, 0x7f0f0052

    invoke-virtual {v0, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v5, v6, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v1, v7, v6, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iput-boolean v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    const/4 v3, 0x4

    iput v3, v0, Landroid/os/Message;->what:I

    iget-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->G:Landroid/os/Handler;

    invoke-virtual {v3, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    :goto_8
    iget-boolean v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->r:Z

    if-eqz v0, :cond_b

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->f:Ljxl/write/WritableSheet;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v0, v3, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v8, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v9, v8, Lcom/ape/offlinescriptmanager/batterytool/g/c;->f:Ljxl/write/WritableSheet;

    const-wide/high16 v10, 0x4014000000000000L    # 5.0

    const-wide/high16 v12, 0x3ff0000000000000L    # 1.0

    const-wide/high16 v14, 0x4020000000000000L    # 8.0

    const-wide/high16 v16, 0x4037000000000000L    # 23.0

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->k:Ljava/lang/String;

    move-object/from16 v18, v0

    invoke-virtual/range {v8 .. v18}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c(Ljxl/write/WritableSheet;DDDDLjava/lang/String;)V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface {v2}, Ljava/util/List;->clear()V

    goto :goto_9

    :cond_b
    :try_start_1
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0x1f4

    invoke-virtual {v0, v3, v4}, Ljava/util/concurrent/TimeUnit;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_8

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_8

    :cond_c
    :goto_9
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->n:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->p:Landroid/database/Cursor;

    invoke-virtual {v0, v2}, Lcom/ape/offlinescriptmanager/utils/e;->a(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_e

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v3, 0x2

    :goto_a
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_d

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/ape/offlinescriptmanager/batterytool/f/a;

    invoke-virtual {v4}, Lcom/ape/offlinescriptmanager/batterytool/f/a;->a()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v1, v6, v3, v5}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v4}, Lcom/ape/offlinescriptmanager/batterytool/f/a;->b()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    invoke-virtual {v1, v5, v3, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/2addr v3, v5

    goto :goto_a

    :cond_d
    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v3, v2, Lcom/ape/offlinescriptmanager/batterytool/g/c;->g:Ljxl/write/WritableSheet;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v2, v3, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->clear()V

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_e
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->w:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->q:Landroid/database/Cursor;

    invoke-virtual {v0, v2}, Lcom/ape/offlinescriptmanager/utils/e;->c(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v0

    const/4 v2, 0x6

    const/4 v3, 0x0

    if-eqz v0, :cond_11

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_11

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move-object v6, v3

    const/4 v5, 0x2

    :goto_b
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_10

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lb/b/a/a/b/h;

    invoke-virtual {v8}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v9

    const-string v10, "startbattery"

    invoke-interface {v9, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-virtual {v8}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v10

    const-string v11, "stopbattery"

    invoke-interface {v10, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    invoke-virtual {v8}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v11

    const-string v12, "regression"

    invoke-interface {v11, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    const-string v12, "%"

    if-eqz v6, :cond_f

    invoke-virtual {v8}, Lb/b/a/a/b/h;->g()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6}, Lb/b/a/a/b/h;->g()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_f

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    if-lez v13, :cond_f

    add-int/lit8 v5, v5, -0x1

    invoke-virtual {v6}, Lb/b/a/a/b/h;->h()Ljava/util/Map;

    move-result-object v9

    const-string v13, "startbattery"

    invoke-interface {v9, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-virtual {v8}, Lb/b/a/a/b/h;->e()J

    move-result-wide v13

    invoke-static {v13, v14}, Lcom/ape/offlinescriptmanager/utils/g;->n(J)Ljava/lang/String;

    move-result-object v13

    const/4 v14, 0x3

    invoke-virtual {v1, v14, v5, v13}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->e()J

    move-result-wide v13

    invoke-virtual {v6}, Lb/b/a/a/b/h;->i()J

    move-result-wide v15

    sub-long/2addr v13, v15

    invoke-static {v13, v14}, Lcom/ape/offlinescriptmanager/utils/g;->j(J)Ljava/lang/String;

    move-result-object v13

    const/4 v14, 0x4

    invoke-virtual {v1, v14, v5, v13}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v1, v2, v5, v13}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v13, 0x7

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    sub-int/2addr v10, v9

    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v1, v13, v5, v9}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/16 v9, 0x8

    invoke-virtual {v1, v9, v5, v11}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v8

    invoke-virtual {v8}, Lb/b/a/a/b/g;->a()Ljava/lang/String;

    move-result-object v8

    const/4 v7, 0x1

    invoke-virtual {v1, v7, v5, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    goto/16 :goto_c

    :cond_f
    const/4 v7, 0x1

    invoke-virtual {v8}, Lb/b/a/a/b/h;->g()Ljava/lang/String;

    move-result-object v6

    const/4 v13, 0x0

    invoke-virtual {v1, v13, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->j()Lb/b/a/a/b/g;

    move-result-object v6

    invoke-virtual {v6}, Lb/b/a/a/b/g;->a()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v7, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->i()J

    move-result-wide v13

    invoke-static {v13, v14}, Lcom/ape/offlinescriptmanager/utils/g;->n(J)Ljava/lang/String;

    move-result-object v6

    const/4 v13, 0x2

    invoke-virtual {v1, v13, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->e()J

    move-result-wide v13

    invoke-static {v13, v14}, Lcom/ape/offlinescriptmanager/utils/g;->n(J)Ljava/lang/String;

    move-result-object v6

    const/4 v13, 0x3

    invoke-virtual {v1, v13, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    invoke-virtual {v8}, Lb/b/a/a/b/h;->e()J

    move-result-wide v13

    invoke-virtual {v8}, Lb/b/a/a/b/h;->i()J

    move-result-wide v15

    sub-long/2addr v13, v15

    invoke-static {v13, v14}, Lcom/ape/offlinescriptmanager/utils/g;->j(J)Ljava/lang/String;

    move-result-object v6

    const/4 v13, 0x4

    invoke-virtual {v1, v13, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v13, 0x5

    invoke-virtual {v1, v13, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v10}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v2, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/4 v6, 0x7

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    sub-int/2addr v10, v9

    invoke-static {v10}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v1, v6, v5, v9}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const/16 v6, 0x8

    invoke-virtual {v1, v6, v5, v11}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    move-object v6, v8

    const/4 v7, 0x1

    :goto_c
    add-int/2addr v5, v7

    goto/16 :goto_b

    :cond_10
    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v5, v4, Lcom/ape/offlinescriptmanager/batterytool/g/c;->i:Ljxl/write/WritableSheet;

    iget-object v6, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v4, v5, v6}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->clear()V

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_11
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->u:Landroid/content/SharedPreferences;

    const-string v4, "xuhang_count"

    const/4 v5, 0x1

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    const/16 v4, 0xb

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "current count is :----------------"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    const/4 v5, 0x0

    :goto_d
    if-ge v5, v0, :cond_1a

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "current a is :----------------"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    const/4 v7, 0x1

    if-lt v5, v7, :cond_12

    mul-int/lit8 v6, v5, 0xb

    add-int/lit8 v8, v5, 0x1

    add-int/2addr v6, v8

    iget-object v9, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v10, 0x7f0f02cd

    invoke-virtual {v9, v10}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v9

    new-array v10, v7, [Ljava/lang/Object;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    const/4 v11, 0x0

    aput-object v8, v10, v11

    invoke-static {v9, v10}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v11, v6, v8}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    goto :goto_e

    :cond_12
    move v6, v7

    :goto_e
    move v8, v6

    const/4 v6, 0x0

    :goto_f
    if-ge v6, v4, :cond_19

    add-int/lit8 v8, v8, 0x1

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "current v is: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v10, " z is: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    const-string v9, ""

    packed-switch v6, :pswitch_data_0

    move-object v10, v9

    move-object v11, v10

    move-object v12, v11

    move-object v13, v12

    move-object v14, v13

    move-object v15, v14

    goto/16 :goto_11

    :pswitch_0
    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v11, 0x7f0f02d3

    invoke-virtual {v10, v11}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    const/4 v11, 0x0

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "videocamera_start_time"

    const-string v12, "videocamera_end_time"

    const-string v13, "videocamera_start_percentage"

    const-string v14, "videocamera_end_percentage"

    const-string v15, "videocamera_start_temperature"

    const-string v16, "videocamera_end_temperature"

    goto/16 :goto_10

    :pswitch_1
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02bc

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "music_start_time"

    const-string v12, "music_end_time"

    const-string v13, "music_start_percentage"

    const-string v14, "music_end_percentage"

    const-string v15, "music_start_temperature"

    const-string v16, "music_end_temperature"

    goto/16 :goto_10

    :pswitch_2
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02b4

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "download_start_time"

    const-string v12, "download_end_time"

    const-string v13, "download_start_percentage"

    const-string v14, "download_end_percentage"

    const-string v15, "download_start_temperature"

    const-string v16, "download_end_temperature"

    goto/16 :goto_10

    :pswitch_3
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02b5

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "music_ebook_start_time"

    const-string v12, "music_ebook_end_time"

    const-string v13, "music_ebook_start_percentage"

    const-string v14, "music_ebook_end_percentage"

    const-string v15, "music_ebook_start_temperature"

    const-string v16, "music_ebook_end_temperature"

    goto/16 :goto_10

    :pswitch_4
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02ad

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "camera_start_time"

    const-string v12, "camera_end_time"

    const-string v13, "camera_start_percentage"

    const-string v14, "camera_end_percentage"

    const-string v15, "camera_start_temperature"

    const-string v16, "camera_end_temperature"

    goto/16 :goto_10

    :pswitch_5
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02d0

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "video_start_time"

    const-string v12, "video_end_time"

    const-string v13, "video_start_percentage"

    const-string v14, "video_end_percentage"

    const-string v15, "video_start_temperature"

    const-string v16, "video_end_temperature"

    goto/16 :goto_10

    :pswitch_6
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02c6

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "tdgame_start_time"

    const-string v12, "tdgame_end_time"

    const-string v13, "tdgame_start_percentage"

    const-string v14, "tdgame_end_percentage"

    const-string v15, "tdgame_start_temperature"

    const-string v16, "tdgame_end_temperature"

    goto :goto_10

    :pswitch_7
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02be

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "playvideo_start_time"

    const-string v12, "playvideo_end_time"

    const-string v13, "playvideo_start_percentage"

    const-string v14, "playvideo_end_percentage"

    const-string v15, "playvideo_start_temperature"

    const-string v16, "playvideo_end_temperature"

    goto :goto_10

    :pswitch_8
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02a8

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "browseweb_start_time"

    const-string v12, "browseweb_end_time"

    const-string v13, "browseweb_start_percentage"

    const-string v14, "browseweb_end_percentage"

    const-string v15, "browseweb_start_temperature"

    const-string v16, "browseweb_end_temperature"

    goto :goto_10

    :pswitch_9
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02ac

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "call_times_start_time"

    const-string v12, "call_times_end_time"

    const-string v13, "call_times_start_percentage"

    const-string v14, "call_times_end_percentage"

    const-string v15, "call_times_start_temperature"

    const-string v16, "call_times_end_temperature"

    goto :goto_10

    :pswitch_a
    const/4 v11, 0x0

    iget-object v10, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    const v12, 0x7f0f02a9

    invoke-virtual {v10, v12}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v1, v11, v8, v10}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    const-string v10, "call_start_time"

    const-string v12, "call_end_time"

    const-string v13, "call_start_percentage"

    const-string v14, "call_end_percentage"

    const-string v15, "call_start_temperature"

    const-string v16, "call_end_temperature"

    :goto_10
    move-object/from16 v11, v16

    :goto_11
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "start time string : "

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/ape/offlinescriptmanager/utils/i;->b(Ljava/lang/String;)V

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v10, v5, 0x1

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v4, v7, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const v7, 0x7f0f0253

    const/4 v2, 0x1

    if-eqz v4, :cond_13

    goto :goto_12

    :cond_13
    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v4, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    :goto_12
    invoke-virtual {v1, v2, v8, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v4, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x2

    if-eqz v2, :cond_14

    goto :goto_13

    :cond_14
    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v2, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_13
    invoke-virtual {v1, v4, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x0

    invoke-interface {v2, v12, v13}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    if-eqz v2, :cond_15

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v12, 0x3

    goto :goto_14

    :cond_15
    const/4 v12, 0x3

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v2, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_14
    invoke-virtual {v1, v12, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    const/4 v14, 0x0

    invoke-interface {v2, v13, v14}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    if-eqz v2, :cond_16

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v13, 0x4

    goto :goto_15

    :cond_16
    const/4 v13, 0x4

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v2, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_15
    invoke-virtual {v1, v13, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v15, 0x0

    invoke-interface {v2, v4, v15}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v2

    cmpl-float v4, v2, v15

    if-eqz v4, :cond_17

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x5

    goto :goto_16

    :cond_17
    const/4 v4, 0x5

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v2, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_16
    invoke-virtual {v1, v4, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->t:Landroid/content/SharedPreferences;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v4, v15}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v2

    cmpl-float v4, v2, v15

    if-eqz v4, :cond_18

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x6

    goto :goto_17

    :cond_18
    const/4 v4, 0x6

    iget-object v2, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->h:Landroid/content/Context;

    invoke-virtual {v2, v7}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_17
    invoke-virtual {v1, v4, v8, v2}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a(IILjava/lang/String;)V

    add-int/lit8 v6, v6, 0x1

    move v2, v4

    const/16 v4, 0xb

    const/4 v7, 0x1

    goto/16 :goto_f

    :cond_19
    move v4, v2

    const/4 v12, 0x3

    const/4 v13, 0x4

    const/4 v14, 0x0

    add-int/lit8 v5, v5, 0x1

    const/16 v4, 0xb

    goto/16 :goto_d

    :cond_1a
    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->h:Ljxl/write/WritableSheet;

    iget-object v4, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-virtual {v0, v2, v4}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d(Ljxl/write/WritableSheet;Ljava/util/List;)V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b()V

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/batterytool/g/c;->a()V

    iput-object v3, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->i:Lcom/ape/offlinescriptmanager/batterytool/g/c;

    iget-object v0, v1, Lcom/ape/offlinescriptmanager/batterytool/g/b;->v:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b(Ljava/lang/String;)V

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
