.class public Lcom/ape/offlinescriptmanager/utils/MyApplication;
.super Landroid/app/Application;
.source ""


# static fields
.field public static b:Lcom/ape/offlinescriptmanager/utils/MyApplication;

.field private static c:Landroid/widget/Toast;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method public static a()Lcom/ape/offlinescriptmanager/utils/MyApplication;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/MyApplication;->b:Lcom/ape/offlinescriptmanager/utils/MyApplication;

    return-object v0
.end method


# virtual methods
.method public b(Ljava/lang/String;)V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ShowToast"
        }
    .end annotation

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/MyApplication;->c:Landroid/widget/Toast;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    sput-object p1, Lcom/ape/offlinescriptmanager/utils/MyApplication;->c:Landroid/widget/Toast;

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/widget/Toast;->cancel()V

    sget-object v0, Lcom/ape/offlinescriptmanager/utils/MyApplication;->c:Landroid/widget/Toast;

    invoke-virtual {v0, p1}, Landroid/widget/Toast;->setText(Ljava/lang/CharSequence;)V

    sget-object p1, Lcom/ape/offlinescriptmanager/utils/MyApplication;->c:Landroid/widget/Toast;

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :goto_0
    return-void
.end method

.method public onCreate()V
    .locals 1

    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    invoke-static {}, Lcom/ape/offlinescriptmanager/utils/d;->a()Lcom/ape/offlinescriptmanager/utils/d;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/ape/offlinescriptmanager/utils/d;->b(Landroid/content/Context;)V

    const-string v0, "Start Crashhandler"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    sput-object p0, Lcom/ape/offlinescriptmanager/utils/MyApplication;->b:Lcom/ape/offlinescriptmanager/utils/MyApplication;

    return-void
.end method
