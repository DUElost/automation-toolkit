.class La/h/a/a$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/h/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:La/h/a/a;


# direct methods
.method constructor <init>(La/h/a/a;)V
    .locals 0

    iput-object p1, p0, La/h/a/a$b;->b:La/h/a/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, La/h/a/a$b;->b:La/h/a/a;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, La/h/a/a;->E(I)V

    return-void
.end method
