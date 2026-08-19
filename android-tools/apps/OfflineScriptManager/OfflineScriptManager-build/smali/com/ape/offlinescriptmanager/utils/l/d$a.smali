.class final Lcom/ape/offlinescriptmanager/utils/l/d$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lcom/ape/offlinescriptmanager/utils/l/e$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/utils/l/d;->a(Ljava/lang/String;Lcom/ape/offlinescriptmanager/utils/l/a;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Process;


# direct methods
.method constructor <init>(Ljava/lang/Process;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/d$a;->a:Ljava/lang/Process;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/d$a;->a:Ljava/lang/Process;

    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V

    const-string v0, "RunListener: out of max time and destroy process"

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/b;->h(Ljava/lang/String;)V

    return-void
.end method
