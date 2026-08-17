.class Ld/n/h/c$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/h/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Ld/n/h/c;


# direct methods
.method constructor <init>(Ld/n/h/c;)V
    .locals 0

    iput-object p1, p0, Ld/n/h/c$b;->b:Ld/n/h/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Ld/n/h/c$b;->b:Ld/n/h/c;

    invoke-virtual {v0}, Ld/n/h/c;->h()V

    return-void
.end method
