.class public Lcom/ape/offlinescriptmanager/screenrecorder/e/a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lcom/ape/offlinescriptmanager/screenrecorder/e/a;",
        ">;"
    }
.end annotation


# instance fields
.field private b:Ljava/lang/String;

.field private c:Landroid/net/Uri;

.field private d:Landroid/graphics/Bitmap;

.field private e:Ljava/util/Date;

.field private f:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Landroid/net/Uri;Landroid/graphics/Bitmap;Ljava/util/Date;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->f:Z

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b:Ljava/lang/String;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->c:Landroid/net/Uri;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->d:Landroid/graphics/Bitmap;

    iput-object p4, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->e:Ljava/util/Date;

    return-void
.end method

.method public constructor <init>(ZLjava/util/Date;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->f:Z

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->f:Z

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->e:Ljava/util/Date;

    return-void
.end method


# virtual methods
.method public a(Lcom/ape/offlinescriptmanager/screenrecorder/e/a;)I
    .locals 1

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->d()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->d()Ljava/util/Date;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/Date;->compareTo(Ljava/util/Date;)I

    move-result p1

    return p1
.end method

.method public b()Landroid/net/Uri;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->c:Landroid/net/Uri;

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b:Ljava/lang/String;

    return-object v0
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->a(Lcom/ape/offlinescriptmanager/screenrecorder/e/a;)I

    move-result p1

    return p1
.end method

.method public d()Ljava/util/Date;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->e:Ljava/util/Date;

    return-object v0
.end method

.method public e()Landroid/graphics/Bitmap;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->d:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public f()Z
    .locals 1

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->f:Z

    return v0
.end method
