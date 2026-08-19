.class public Lcom/ape/offlinescriptmanager/utils/l/e;
.super Ljava/lang/Thread;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/utils/l/e$a;
    }
.end annotation


# instance fields
.field private b:I

.field private c:Z

.field private final d:Lcom/ape/offlinescriptmanager/utils/l/e$a;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/utils/l/e$a;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    const v0, 0xf731400

    iput v0, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->b:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->c:Z

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->d:Lcom/ape/offlinescriptmanager/utils/l/e$a;

    return-void
.end method


# virtual methods
.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->c:Z

    return-void
.end method

.method public b(Z)V
    .locals 0

    return-void
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->b:I

    return-void
.end method

.method public d()V
    .locals 0

    invoke-virtual {p0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public run()V
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Lcom/ape/offlinescriptmanager/utils/l/e;->b(Z)V

    :cond_0
    iget-boolean v2, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->c:Z

    if-eqz v2, :cond_1

    const-wide/16 v2, 0x3e8

    invoke-static {v2, v3}, Lcom/ape/offlinescriptmanager/utils/g;->L(J)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long/2addr v2, v0

    iget v4, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->b:I

    int-to-long v4, v4

    cmp-long v2, v2, v4

    if-ltz v2, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/ape/offlinescriptmanager/utils/l/e;->b(Z)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/e;->d:Lcom/ape/offlinescriptmanager/utils/l/e$a;

    invoke-interface {v0}, Lcom/ape/offlinescriptmanager/utils/l/e$a;->a()V

    :cond_1
    return-void
.end method
