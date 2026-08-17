.class Lorg/achartengine/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/achartengine/b;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Lorg/achartengine/b;


# direct methods
.method constructor <init>(Lorg/achartengine/b;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/b$a;->b:Lorg/achartengine/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/b$a;->b:Lorg/achartengine/b;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    return-void
.end method
