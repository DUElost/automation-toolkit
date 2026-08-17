.class public abstract Lcom/ape/offlinescriptmanager/batterytool/g/a;
.super Landroid/os/AsyncTask;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/batterytool/g/a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/content/Context;

.field private b:Landroid/app/ProgressDialog;

.field private c:Z

.field public d:Ljava/lang/String;

.field private e:Z

.field public f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/c$a;",
            ">;"
        }
    .end annotation
.end field

.field public g:Lcom/ape/offlinescriptmanager/batterytool/g/c$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;ZZ)V
    .locals 1

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->g:Lcom/ape/offlinescriptmanager/batterytool/g/c$a;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    iput-boolean p4, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->c:Z

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->e:Z

    return-void
.end method


# virtual methods
.method public a(IILjava/lang/String;)V
    .locals 1

    new-instance v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;

    invoke-direct {v0}, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->g:Lcom/ape/offlinescriptmanager/batterytool/g/c$a;

    iput p1, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->b:I

    iput p2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->a:I

    iput-object p3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->c:Ljava/lang/String;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->f:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 6

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p1

    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p1, v2

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    const-string v5, ".png"

    invoke-virtual {v4, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void
.end method

.method protected c(Ljava/lang/Boolean;)V
    .locals 5

    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->e:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    const-string v1, "com.ape.offlinescriptmanager.pref"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    const/4 v3, 0x1

    const-string v4, "export_data_no_empty"

    if-eqz v1, :cond_1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    :cond_1
    iget-boolean v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->c:Z

    if-eqz v1, :cond_4

    invoke-interface {v0, v4, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_3

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    const v0, 0x7f0f0286

    invoke-static {p1, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    goto :goto_1

    :cond_3
    :goto_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    const v0, 0x7f0f0076

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    new-array v1, v3, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->d:Ljava/lang/String;

    const-string v4, ""

    invoke-static {v3, v4}, Lcom/ape/offlinescriptmanager/utils/g;->l(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    :goto_1
    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_4
    return-void
.end method

.method public d(Ljava/util/List;Ljava/util/List;Lorg/achartengine/h/d;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/a$a;",
            ">;>;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lorg/achartengine/h/d;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    move-object v1, p0

    move-object/from16 v0, p3

    move-object/from16 v2, p4

    new-instance v3, Lorg/achartengine/g/d;

    invoke-direct {v3}, Lorg/achartengine/g/d;-><init>()V

    const/4 v4, 0x0

    move v5, v4

    :goto_0
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v6

    if-ge v5, v6, :cond_1

    new-instance v6, Lorg/achartengine/g/c;

    move-object/from16 v7, p2

    invoke-interface {v7, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-direct {v6, v8}, Lorg/achartengine/g/c;-><init>(Ljava/lang/String;)V

    move-object/from16 v8, p1

    invoke-interface {v8, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/util/List;

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_1
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_0

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;

    iget-wide v11, v10, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->a:D

    iget-wide v13, v10, Lcom/ape/offlinescriptmanager/batterytool/g/a$a;->b:D

    invoke-virtual {v6, v11, v12, v13, v14}, Lorg/achartengine/g/e;->a(DD)V

    goto :goto_1

    :cond_0
    invoke-virtual {v3, v6}, Lorg/achartengine/g/d;->a(Lorg/achartengine/g/e;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_1
    const-string v5, ""

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    invoke-static {v5, v3, v0, v2}, Lorg/achartengine/a;->b(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;

    goto :goto_2

    :cond_2
    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    invoke-static {v5, v3, v0, v2}, Lorg/achartengine/a;->c(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;

    :goto_2
    iget-object v5, v1, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    invoke-static {v5, v3, v0, v2}, Lorg/achartengine/a;->c(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;

    move-result-object v2

    const/16 v3, 0xa

    invoke-virtual {v0, v3}, Lorg/achartengine/h/d;->l1(I)V

    const/4 v3, 0x5

    invoke-virtual {v0, v3}, Lorg/achartengine/h/d;->t1(I)V

    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/view/View;->setDrawingCacheEnabled(Z)V

    invoke-static {v4, v4}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v0

    invoke-static {v4, v4}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v3

    invoke-virtual {v2, v0, v3}, Landroid/view/View;->measure(II)V

    const/16 v0, 0x28a

    const/16 v3, 0x258

    invoke-virtual {v2, v4, v4, v0, v3}, Landroid/view/View;->layout(IIII)V

    invoke-virtual {v2}, Landroid/view/View;->buildDrawingCache()V

    const/4 v3, 0x0

    :try_start_0
    invoke-virtual {v2}, Landroid/view/View;->getDrawingCache()Landroid/graphics/Bitmap;

    move-result-object v3

    if-eqz v3, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v2, p6

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".png"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object/from16 v2, p5

    invoke-virtual {p0, v2, v0, v3}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->e(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_3
    if-eqz v3, :cond_4

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    :cond_4
    return-void

    :catchall_0
    move-exception v0

    if-eqz v3, :cond_5

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    :cond_5
    throw v0
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object p1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    const/4 p1, 0x0

    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    new-instance p2, Ljava/io/FileOutputStream;

    invoke-direct {p2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    sget-object p1, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v0, 0x64

    invoke-virtual {p3, p1, v0, p2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {p2}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_1

    :catch_0
    move-exception p1

    goto :goto_0

    :catchall_0
    move-exception p2

    move-object v2, p2

    move-object p2, p1

    move-object p1, v2

    goto :goto_2

    :catch_1
    move-exception p2

    move-object v2, p2

    move-object p2, p1

    move-object p1, v2

    :goto_0
    :try_start_3
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :try_start_4
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {p2}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_1

    :catch_2
    move-exception p1

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    :goto_1
    return-void

    :catchall_1
    move-exception p1

    :goto_2
    :try_start_5
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {p2}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_3

    :catch_3
    move-exception p2

    invoke-virtual {p2}, Ljava/io/IOException;->printStackTrace()V

    :goto_3
    throw p1
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/batterytool/g/a;->c(Ljava/lang/Boolean;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 3

    invoke-super {p0}, Landroid/os/AsyncTask;->onPreExecute()V

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->e:Z

    if-eqz v0, :cond_0

    new-instance v0, Landroid/app/ProgressDialog;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    const v1, 0x1080027

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setIcon(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->a:Landroid/content/Context;

    const v2, 0x7f0f0077

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/a;->b:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    :cond_0
    return-void
.end method
