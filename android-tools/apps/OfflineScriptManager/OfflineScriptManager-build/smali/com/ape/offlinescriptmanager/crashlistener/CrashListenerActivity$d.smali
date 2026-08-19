.class Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->R()Z
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

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$d;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity$d;->b:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    const-string p2, "android.permission.WRITE_EXTERNAL_STORAGE"

    filled-new-array {p2}, [Ljava/lang/String;

    move-result-object p2

    const/16 v0, 0x2af8

    invoke-static {p1, p2, v0}, Landroidx/core/app/a;->j(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void
.end method
