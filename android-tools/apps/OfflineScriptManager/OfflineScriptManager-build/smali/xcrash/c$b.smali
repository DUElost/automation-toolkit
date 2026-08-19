.class Lxcrash/c$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lxcrash/c;->o()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lxcrash/c;


# direct methods
.method constructor <init>(Lxcrash/c;)V
    .locals 0

    iput-object p1, p0, Lxcrash/c$b;->b:Lxcrash/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lxcrash/c$b;->b:Lxcrash/c;

    invoke-static {v0}, Lxcrash/c;->a(Lxcrash/c;)V

    return-void
.end method
