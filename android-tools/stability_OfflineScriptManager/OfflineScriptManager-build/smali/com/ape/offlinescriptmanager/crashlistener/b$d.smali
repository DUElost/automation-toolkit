.class public Lcom/ape/offlinescriptmanager/crashlistener/b$d;
.super Landroid/os/AsyncTask;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/crashlistener/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "d"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Landroid/media/Image;",
        "Ljava/lang/Void;",
        "Landroid/graphics/Bitmap;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lcom/ape/offlinescriptmanager/crashlistener/b;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/media/Image;)Landroid/graphics/Bitmap;
    .locals 8

    sget-boolean v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->h:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    if-eqz p1, :cond_4

    array-length v0, p1

    const/4 v2, 0x1

    if-lt v0, v2, :cond_4

    const/4 v0, 0x0

    aget-object v2, p1, v0

    if-nez v2, :cond_1

    goto/16 :goto_2

    :cond_1
    aget-object p1, p1, v0

    invoke-virtual {p1}, Landroid/media/Image;->getWidth()I

    move-result v2

    invoke-virtual {p1}, Landroid/media/Image;->getHeight()I

    move-result v3

    invoke-virtual {p1}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v4

    aget-object v5, v4, v0

    invoke-virtual {v5}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v5

    aget-object v6, v4, v0

    invoke-virtual {v6}, Landroid/media/Image$Plane;->getPixelStride()I

    move-result v6

    aget-object v4, v4, v0

    invoke-virtual {v4}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v4

    mul-int v7, v6, v2

    sub-int/2addr v4, v7

    div-int/2addr v4, v6

    add-int/2addr v4, v2

    sget-object v6, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v4, v3, v6}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v4

    invoke-virtual {v4, v5}, Landroid/graphics/Bitmap;->copyPixelsFromBuffer(Ljava/nio/Buffer;)V

    invoke-static {v4, v0, v0, v2, v3}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {p1}, Landroid/media/Image;->close()V

    if-eqz v0, :cond_3

    :try_start_0
    new-instance p1, Ljava/io/File;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/crashlistener/b;->b(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-static {v3}, Lcom/ape/offlinescriptmanager/crashlistener/b;->c(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-static {v4}, Lcom/ape/offlinescriptmanager/crashlistener/b;->d(Lcom/ape/offlinescriptmanager/crashlistener/b;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/ape/offlinescriptmanager/utils/g;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    :cond_2
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x64

    invoke-virtual {v0, v3, v4, v2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V

    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.MEDIA_SCANNER_SCAN_FILE"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a:Lcom/ape/offlinescriptmanager/crashlistener/b;

    invoke-static {v3}, Lcom/ape/offlinescriptmanager/crashlistener/b;->e(Lcom/ape/offlinescriptmanager/crashlistener/b;)Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/io/FileNotFoundException;->printStackTrace()V

    :cond_3
    :goto_0
    move-object p1, v1

    :goto_1
    if-eqz p1, :cond_4

    return-object v0

    :cond_4
    :goto_2
    return-object v1
.end method

.method protected b(Landroid/graphics/Bitmap;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/os/AsyncTask;->onPostExecute(Ljava/lang/Object;)V

    return-void
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/media/Image;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->a([Landroid/media/Image;)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Landroid/graphics/Bitmap;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/crashlistener/b$d;->b(Landroid/graphics/Bitmap;)V

    return-void
.end method
