.class Lcom/ape/offlinescriptmanager/crashlistener/c$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/crashlistener/c;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/crashlistener/c;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/crashlistener/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/crashlistener/c$b;->b:Lcom/ape/offlinescriptmanager/crashlistener/c;

    iget-object p1, p1, Lcom/ape/offlinescriptmanager/crashlistener/c;->d:Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/crashlistener/CrashListenerActivity;->R()Z

    :cond_0
    return-void
.end method
