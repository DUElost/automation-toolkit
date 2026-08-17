.class Lcom/ape/offlinescriptmanager/batterytool/c$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/c;->q1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/batterytool/c;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/c$a;->b:Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/c$a;->b:Lcom/ape/offlinescriptmanager/batterytool/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/c;->n1(Lcom/ape/offlinescriptmanager/batterytool/c;)Lorg/achartengine/b;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    return-void
.end method
