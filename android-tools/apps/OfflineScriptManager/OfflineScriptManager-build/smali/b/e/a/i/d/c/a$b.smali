.class public Lb/e/a/i/d/c/a$b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/e/a/i/d/c/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation


# instance fields
.field public a:Z

.field public b:Z


# direct methods
.method public constructor <init>(Lb/e/a/i/d/c/a;Lb/e/a/i/d/c/c;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    const/4 p1, 0x4

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    const/4 p1, 0x3

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    const/4 p1, 0x2

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    move-result v0

    iput-boolean v0, p0, Lb/e/a/i/d/c/a$b;->a:Z

    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    move-result v0

    iput-boolean v0, p0, Lb/e/a/i/d/c/a$b;->b:Z

    iget-boolean v0, p0, Lb/e/a/i/d/c/a$b;->a:Z

    if-eqz v0, :cond_0

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    :cond_0
    iget-boolean v0, p0, Lb/e/a/i/d/c/a$b;->b:Z

    if-eqz v0, :cond_1

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    invoke-virtual {p2, p1}, Lb/e/a/i/d/c/c;->a(I)I

    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    :cond_1
    invoke-virtual {p2}, Lb/e/a/i/d/c/c;->b()Z

    return-void
.end method
