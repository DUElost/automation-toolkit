.class Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    const-class v0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->L(Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;Ljava/lang/Class;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->Q()V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerService;->k(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$a;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    const/4 v0, 0x0

    const-string v1, "listener already running"

    invoke-static {p1, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :goto_0
    return-void
.end method
