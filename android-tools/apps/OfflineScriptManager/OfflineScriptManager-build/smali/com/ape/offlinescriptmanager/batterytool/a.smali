.class public Lcom/ape/offlinescriptmanager/batterytool/a;
.super Landroidx/fragment/app/Fragment;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/batterytool/a$e;,
        Lcom/ape/offlinescriptmanager/batterytool/a$d;,
        Lcom/ape/offlinescriptmanager/batterytool/a$f;
    }
.end annotation


# instance fields
.field private Z:Landroid/content/SharedPreferences;

.field private a0:Landroid/content/SharedPreferences$Editor;

.field private b0:Lorg/achartengine/g/c;

.field private c0:Lorg/achartengine/g/d;

.field private d0:Lorg/achartengine/b;

.field private e0:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/f/b;",
            ">;"
        }
    .end annotation
.end field

.field public f0:Landroid/database/Cursor;

.field public g0:Landroid/database/Cursor;

.field private h0:Landroid/content/Context;

.field private i0:Lcom/ape/offlinescriptmanager/utils/e;

.field private j0:Landroid/widget/ListView;

.field private k0:Landroid/widget/Switch;

.field private l0:Landroid/content/CursorLoader;

.field private m0:Landroid/content/CursorLoader;

.field private n0:Landroid/os/Looper;

.field private o0:Lcom/ape/offlinescriptmanager/batterytool/a$f;

.field private p0:Landroid/database/ContentObserver;

.field private q0:Landroid/database/ContentObserver;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/a$d;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/batterytool/a$d;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->p0:Landroid/database/ContentObserver;

    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/a$e;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/batterytool/a$e;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->q0:Landroid/database/ContentObserver;

    return-void
.end method

.method static synthetic l1(Lcom/ape/offlinescriptmanager/batterytool/a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->u1()V

    return-void
.end method

.method static synthetic m1(Lcom/ape/offlinescriptmanager/batterytool/a;)Landroid/content/SharedPreferences$Editor;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->a0:Landroid/content/SharedPreferences$Editor;

    return-object p0
.end method

.method static synthetic n1(Lcom/ape/offlinescriptmanager/batterytool/a;)Lcom/ape/offlinescriptmanager/batterytool/a$f;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->o0:Lcom/ape/offlinescriptmanager/batterytool/a$f;

    return-object p0
.end method

.method static synthetic o1(Lcom/ape/offlinescriptmanager/batterytool/a;)Lorg/achartengine/b;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->d0:Lorg/achartengine/b;

    return-object p0
.end method

.method static synthetic p1(Lcom/ape/offlinescriptmanager/batterytool/a;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->j0:Landroid/widget/ListView;

    return-object p0
.end method

.method private q1()Lorg/achartengine/h/d;
    .locals 22

    move-object/from16 v0, p0

    new-instance v1, Lorg/achartengine/h/d;

    invoke-direct {v1}, Lorg/achartengine/h/d;-><init>()V

    const/4 v1, 0x1

    new-array v2, v1, [I

    const v3, -0xff01

    const/4 v4, 0x0

    aput v3, v2, v4

    new-array v3, v1, [Lorg/achartengine/f/d;

    sget-object v1, Lorg/achartengine/f/d;->d:Lorg/achartengine/f/d;

    aput-object v1, v3, v4

    const v4, -0xff0100

    const/4 v5, 0x2

    const/4 v6, -0x1

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-static/range {v2 .. v7}, Lcom/ape/offlinescriptmanager/utils/g;->b([I[Lorg/achartengine/f/d;IIIF)Lorg/achartengine/h/d;

    move-result-object v1

    const v2, 0x7f0f005b

    invoke-virtual {v0, v2}, Landroidx/fragment/app/Fragment;->D(I)Ljava/lang/String;

    move-result-object v9

    const v2, 0x7f0f02f5

    invoke-virtual {v0, v2}, Landroidx/fragment/app/Fragment;->D(I)Ljava/lang/String;

    move-result-object v10

    const v2, 0x7f0f02f6

    invoke-virtual {v0, v2}, Landroidx/fragment/app/Fragment;->D(I)Ljava/lang/String;

    move-result-object v11

    const-wide/16 v12, 0x0

    const-wide/16 v14, 0x0

    const-wide/16 v16, 0x0

    const-wide v18, 0x405b800000000000L    # 110.0

    const/high16 v20, -0x1000000

    const/high16 v21, -0x1000000

    move-object v8, v1

    invoke-static/range {v8 .. v21}, Lcom/ape/offlinescriptmanager/utils/g;->F(Lorg/achartengine/h/d;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;DDDDII)V

    return-object v1
.end method

.method private u1()V
    .locals 6

    :try_start_0
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->r1()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->i0:Lcom/ape/offlinescriptmanager/utils/e;

    invoke-virtual {v1, v0}, Lcom/ape/offlinescriptmanager/utils/e;->b(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->e0:Ljava/util/List;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->c0:Lorg/achartengine/g/d;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    invoke-virtual {v0, v1}, Lorg/achartengine/g/d;->e(Lorg/achartengine/g/e;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    invoke-virtual {v0}, Lorg/achartengine/g/e;->b()V

    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->e0:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->e0:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/ape/offlinescriptmanager/batterytool/f/b;

    invoke-virtual {v2}, Lcom/ape/offlinescriptmanager/batterytool/f/b;->c()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    long-to-double v2, v2

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->e0:Ljava/util/List;

    invoke-interface {v4, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/ape/offlinescriptmanager/batterytool/f/b;

    invoke-virtual {v4}, Lcom/ape/offlinescriptmanager/batterytool/f/b;->a()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    int-to-double v4, v4

    invoke-virtual {v1, v2, v3, v4, v5}, Lorg/achartengine/g/e;->a(DD)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->c0:Lorg/achartengine/g/d;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    invoke-virtual {v0, v1}, Lorg/achartengine/g/d;->a(Lorg/achartengine/g/e;)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/a$b;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/batterytool/a$b;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    if-eqz v0, :cond_2

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_2
    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    if-eqz v1, :cond_3

    invoke-interface {v1}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_3

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    :cond_3
    throw v0
.end method


# virtual methods
.method public Y(Landroid/os/Bundle;)V
    .locals 4

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "viking flag ----------------enter percentage onCreate"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->Y(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/e;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/utils/e;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->i0:Lcom/ape/offlinescriptmanager/utils/e;

    const-string v0, "update_data"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->Z:Landroid/content/SharedPreferences;

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->a0:Landroid/content/SharedPreferences$Editor;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object v0, Lcom/ape/offlinescriptmanager/database/c;->a:Landroid/net/Uri;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->p0:Landroid/database/ContentObserver;

    const/4 v3, 0x1

    invoke-virtual {p1, v0, v3, v2}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object v0, Lcom/ape/offlinescriptmanager/database/f;->a:Landroid/net/Uri;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->q0:Landroid/database/ContentObserver;

    invoke-virtual {p1, v0, v3, v2}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    new-instance p1, Landroid/os/HandlerThread;

    const-string v0, "percentage"

    invoke-direct {p1, v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;I)V

    invoke-virtual {p1}, Landroid/os/HandlerThread;->start()V

    invoke-virtual {p1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->n0:Landroid/os/Looper;

    new-instance p1, Lcom/ape/offlinescriptmanager/batterytool/a$f;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->n0:Landroid/os/Looper;

    invoke-direct {p1, p0, v0}, Lcom/ape/offlinescriptmanager/batterytool/a$f;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->o0:Lcom/ape/offlinescriptmanager/batterytool/a$f;

    return-void
.end method

.method public c0(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 4

    sget-object p2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string p3, "viking flag ----enter percentage onCreateView"

    invoke-virtual {p2, p3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    const p2, 0x7f0c0082

    const/4 p3, 0x0

    const/4 v0, 0x0

    invoke-virtual {p1, p2, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f0900fd

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/LinearLayout;

    new-instance p3, Lorg/achartengine/g/c;

    const-string v1, "Battery Percentage"

    invoke-direct {p3, v1}, Lorg/achartengine/g/c;-><init>(Ljava/lang/String;)V

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    new-instance p3, Lorg/achartengine/g/d;

    invoke-direct {p3}, Lorg/achartengine/g/d;-><init>()V

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->c0:Lorg/achartengine/g/d;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->b0:Lorg/achartengine/g/c;

    invoke-virtual {p3, v1}, Lorg/achartengine/g/d;->a(Lorg/achartengine/g/e;)V

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->c0:Lorg/achartengine/g/d;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->q1()Lorg/achartengine/h/d;

    move-result-object v2

    const-string v3, "H:mm"

    invoke-static {p3, v1, v2, v3}, Lorg/achartengine/a;->b(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;

    move-result-object p3

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->d0:Lorg/achartengine/b;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->u1()V

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->d0:Lorg/achartengine/b;

    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    mul-int/lit8 v2, v2, 0x2

    div-int/lit8 v2, v2, 0x3

    const/4 v3, -0x1

    invoke-direct {v1, v3, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {p2, p3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const p2, 0x7f090100

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->j0:Landroid/widget/ListView;

    const/4 p3, 0x1

    invoke-virtual {p2, p3}, Landroid/widget/ListView;->setItemsCanFocus(Z)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->j0:Landroid/widget/ListView;

    invoke-virtual {p2, v0}, Landroid/widget/ListView;->setVerticalScrollBarEnabled(Z)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->v1()V

    const p2, 0x7f09008e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Switch;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->k0:Landroid/widget/Switch;

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->t1()V

    return-object p1
.end method

.method public d0()V
    .locals 2

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "viking flag ----------------enter percentage onDestroy"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->l0:Landroid/content/CursorLoader;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/content/CursorLoader;->cancelLoad()Z

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->m0:Landroid/content/CursorLoader;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/content/CursorLoader;->cancelLoad()Z

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->p0:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->h0:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->q0:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->d0()V

    return-void
.end method

.method public h1(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->h1(Z)V

    return-void
.end method

.method public r1()V
    .locals 8

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/CursorLoader;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v2

    sget-object v3, Lcom/ape/offlinescriptmanager/database/c;->a:Landroid/net/Uri;

    sget-object v4, Lcom/ape/offlinescriptmanager/database/c;->b:[Ljava/lang/String;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const-string v7, "time ASC"

    move-object v1, v0

    invoke-direct/range {v1 .. v7}, Landroid/content/CursorLoader;-><init>(Landroid/content/Context;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->l0:Landroid/content/CursorLoader;

    invoke-virtual {v0}, Landroid/content/CursorLoader;->loadInBackground()Landroid/database/Cursor;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->f0:Landroid/database/Cursor;

    goto :goto_0

    :cond_0
    const-string v0, "getActivity is null......................."

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public s0()V
    .locals 2

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "viking flag ----------------enter percentage onResume"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    invoke-super {p0}, Landroidx/fragment/app/Fragment;->s0()V

    return-void
.end method

.method public s1()V
    .locals 8

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/CursorLoader;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v2

    sget-object v3, Lcom/ape/offlinescriptmanager/database/f;->a:Landroid/net/Uri;

    sget-object v4, Lcom/ape/offlinescriptmanager/database/f;->b:[Ljava/lang/String;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const-string v7, "_id ASC"

    move-object v1, v0

    invoke-direct/range {v1 .. v7}, Landroid/content/CursorLoader;-><init>(Landroid/content/Context;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->m0:Landroid/content/CursorLoader;

    invoke-virtual {v0}, Landroid/content/CursorLoader;->loadInBackground()Landroid/database/Cursor;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    goto :goto_0

    :cond_0
    const-string v0, "getActivity is null......................."

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public t1()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->Z:Landroid/content/SharedPreferences;

    const-string v1, "isUpdating"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->k0:Landroid/widget/Switch;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setChecked(Z)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->k0:Landroid/widget/Switch;

    invoke-virtual {v0, v2}, Landroid/widget/Switch;->setChecked(Z)V

    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->k0:Landroid/widget/Switch;

    new-instance v1, Lcom/ape/offlinescriptmanager/batterytool/a$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/batterytool/a$a;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;)V

    invoke-virtual {v0, v1}, Landroid/widget/Switch;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    return-void
.end method

.method protected v1()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/batterytool/a;->s1()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    if-eqz v0, :cond_0

    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/d/b;

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->i0:Lcom/ape/offlinescriptmanager/utils/e;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    invoke-virtual {v2, v3}, Lcom/ape/offlinescriptmanager/utils/e;->e(Landroid/database/Cursor;)Ljava/util/List;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/ape/offlinescriptmanager/batterytool/d/b;-><init>(Landroid/content/Context;Ljava/util/List;)V

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->f()Landroidx/fragment/app/b;

    move-result-object v1

    new-instance v2, Lcom/ape/offlinescriptmanager/batterytool/a$c;

    invoke-direct {v2, p0, v0}, Lcom/ape/offlinescriptmanager/batterytool/a$c;-><init>(Lcom/ape/offlinescriptmanager/batterytool/a;Lcom/ape/offlinescriptmanager/batterytool/d/b;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_1
    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a;->g0:Landroid/database/Cursor;

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    :cond_2
    throw v0
.end method
