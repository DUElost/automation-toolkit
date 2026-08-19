.class Lcom/ape/offlinescriptmanager/batterytool/a$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/batterytool/a;->v1()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/batterytool/d/b;

.field final synthetic c:Lcom/ape/offlinescriptmanager/batterytool/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/batterytool/a;Lcom/ape/offlinescriptmanager/batterytool/d/b;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$c;->c:Lcom/ape/offlinescriptmanager/batterytool/a;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/a$c;->b:Lcom/ape/offlinescriptmanager/batterytool/d/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/a$c;->c:Lcom/ape/offlinescriptmanager/batterytool/a;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/batterytool/a;->p1(Lcom/ape/offlinescriptmanager/batterytool/a;)Landroid/widget/ListView;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/batterytool/a$c;->b:Lcom/ape/offlinescriptmanager/batterytool/d/b;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method
