.class Lcom/ape/offlinescriptmanager/crashlistener/a$c;
.super Landroid/os/AsyncTask;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/crashlistener/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "[",
        "Ljava/io/File;",
        "Ljava/lang/Integer;",
        "Ljava/util/ArrayList<",
        "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
        ">;>;"
    }
.end annotation


# instance fields
.field a:Landroid/app/ProgressDialog;

.field b:[Ljava/io/File;

.field final synthetic c:Lcom/ape/offlinescriptmanager/crashlistener/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/a;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    return-void
.end method

.method private a(Ljava/util/Date;Ljava/util/Date;)Z
    .locals 2

    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->g(J)Ljava/util/Calendar;

    move-result-object p1

    invoke-virtual {p2}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->g(J)Ljava/util/Calendar;

    move-result-object p2

    invoke-virtual {p1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v0

    invoke-virtual {p2}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide p1

    sub-long/2addr p1, v0

    const-wide/32 v0, 0x5265c00

    div-long/2addr p1, v0

    invoke-static {p1, p2}, Ljava/lang/Math;->abs(J)J

    move-result-wide p1

    long-to-int p1, p1

    if-lez p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private b(Ljava/util/ArrayList;)Ljava/util/ArrayList;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;)",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    const/4 v2, 0x0

    :goto_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/ape/offlinescriptmanager/crashlistener/d/a;

    const/4 v4, 0x1

    if-nez v2, :cond_0

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/d/a;

    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->e()Ljava/util/Date;

    move-result-object v5

    invoke-direct {v1, v4, v5}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;-><init>(ZLjava/util/Date;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->e()Ljava/util/Date;

    move-result-object v1

    goto :goto_1

    :cond_0
    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->e()Ljava/util/Date;

    move-result-object v5

    invoke-direct {p0, v1, v5}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a(Ljava/util/Date;Ljava/util/Date;)Z

    move-result v5

    if-eqz v5, :cond_1

    new-instance v1, Lcom/ape/offlinescriptmanager/crashlistener/d/a;

    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->e()Ljava/util/Date;

    move-result-object v5

    invoke-direct {v1, v4, v5}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;-><init>(ZLjava/util/Date;)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;->e()Ljava/util/Date;

    move-result-object v1

    :cond_1
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private d(Ljava/io/File;)Landroid/graphics/Bitmap;
    .locals 2

    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    const/4 v1, 0x0

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    const/4 v1, 0x2

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method private g(J)Ljava/util/Calendar;
    .locals 1

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/16 p1, 0xb

    const/4 p2, 0x0

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xc

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xd

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xe

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    return-object v0
.end method


# virtual methods
.method protected varargs c([[Ljava/io/File;)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([[",
            "Ljava/io/File;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    aget-object p1, p1, v0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->b:[Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    array-length p1, p1

    add-int/lit8 p1, p1, -0x2

    invoke-virtual {v1, p1}, Landroid/app/ProgressDialog;->setMax(I)V

    move p1, v0

    :goto_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->b:[Ljava/io/File;

    array-length v2, v1

    if-ge p1, v2, :cond_1

    aget-object v1, v1, p1

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/ape/offlinescriptmanager/crashlistener/a;->d(Lcom/ape/offlinescriptmanager/crashlistener/a;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/crashlistener/a;->b(Lcom/ape/offlinescriptmanager/crashlistener/a;)Ljava/util/ArrayList;

    move-result-object v2

    new-instance v3, Lcom/ape/offlinescriptmanager/crashlistener/d/a;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v5

    invoke-direct {p0, v1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->d(Ljava/io/File;)Landroid/graphics/Bitmap;

    move-result-object v6

    new-instance v7, Ljava/util/Date;

    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v8

    invoke-direct {v7, v8, v9}, Ljava/util/Date;-><init>(J)V

    invoke-direct {v3, v4, v5, v6, v7}, Lcom/ape/offlinescriptmanager/crashlistener/d/a;-><init>(Ljava/lang/String;Landroid/net/Uri;Landroid/graphics/Bitmap;Ljava/util/Date;)V

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Integer;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v0

    invoke-virtual {p0, v1}, Landroid/os/AsyncTask;->publishProgress([Ljava/lang/Object;)V

    :cond_0
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->b(Lcom/ape/offlinescriptmanager/crashlistener/a;)Ljava/util/ArrayList;

    move-result-object p1

    return-object p1
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [[Ljava/io/File;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c([[Ljava/io/File;)Ljava/util/ArrayList;

    move-result-object p1

    return-object p1
.end method

.method protected e(Ljava/util/ArrayList;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/crashlistener/d/a;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->e(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroidx/recyclerview/widget/RecyclerView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->f(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    invoke-static {}, Ljava/util/Collections;->reverseOrder()Ljava/util/Comparator;

    move-result-object v0

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->b(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->g(Lcom/ape/offlinescriptmanager/crashlistener/a;Ljava/util/ArrayList;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->e(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroidx/recyclerview/widget/RecyclerView;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/view/ViewGroup;->setVisibility(I)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/a;->f(Lcom/ape/offlinescriptmanager/crashlistener/a;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->cancel()V

    return-void
.end method

.method protected varargs f([Ljava/lang/Integer;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onProgressUpdate([Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    const/4 v1, 0x0

    aget-object p1, p1, v1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/app/ProgressDialog;->setProgress(I)V

    return-void
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/ArrayList;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->e(Ljava/util/ArrayList;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 2

    invoke-super {p0}, Landroid/os/AsyncTask;->onPreExecute()V

    new-instance v0, Landroid/app/ProgressDialog;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->c:Lcom/ape/offlinescriptmanager/crashlistener/a;

    invoke-virtual {v1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    const-string v1, "Please wait"

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    const-string v1, "Loading picture..."

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setProgressStyle(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    return-void
.end method

.method protected bridge synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/a$c;->f([Ljava/lang/Integer;)V

    return-void
.end method
