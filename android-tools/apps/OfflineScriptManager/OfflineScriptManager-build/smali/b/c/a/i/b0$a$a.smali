.class public Lb/c/a/i/b0$a$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/c/a/i/b0$a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field private a:J

.field private b:I

.field private c:I

.field private d:J


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lb/c/a/i/b0$a$a;->c:I

    return v0
.end method

.method public b()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/b0$a$a;->d:J

    return-wide v0
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lb/c/a/i/b0$a$a;->b:I

    return v0
.end method

.method public d()J
    .locals 2

    iget-wide v0, p0, Lb/c/a/i/b0$a$a;->a:J

    return-wide v0
.end method

.method public e(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/b0$a$a;->c:I

    return-void
.end method

.method public f(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/b0$a$a;->d:J

    return-void
.end method

.method public g(I)V
    .locals 0

    iput p1, p0, Lb/c/a/i/b0$a$a;->b:I

    return-void
.end method

.method public h(J)V
    .locals 0

    iput-wide p1, p0, Lb/c/a/i/b0$a$a;->a:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "SubsampleEntry{subsampleSize="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lb/c/a/i/b0$a$a;->a:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", subsamplePriority="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/b0$a$a;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", discardable="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/c/a/i/b0$a$a;->c:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", reserved="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lb/c/a/i/b0$a$a;->d:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
