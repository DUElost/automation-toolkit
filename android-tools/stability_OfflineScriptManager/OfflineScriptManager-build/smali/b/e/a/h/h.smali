.class public Lb/e/a/h/h;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Cloneable;


# instance fields
.field private b:Ljava/lang/String;

.field private c:J

.field private d:Ljava/util/Date;

.field private e:Lb/e/a/j/h;

.field private f:D

.field private g:D

.field private h:F

.field private i:J

.field private j:I

.field k:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "eng"

    iput-object v0, p0, Lb/e/a/h/h;->b:Ljava/lang/String;

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    iput-object v0, p0, Lb/e/a/h/h;->d:Ljava/util/Date;

    sget-object v0, Lb/e/a/j/h;->j:Lb/e/a/j/h;

    iput-object v0, p0, Lb/e/a/h/h;->e:Lb/e/a/j/h;

    const-wide/16 v0, 0x1

    iput-wide v0, p0, Lb/e/a/h/h;->i:J

    const/4 v0, 0x0

    iput v0, p0, Lb/e/a/h/h;->j:I

    return-void
.end method


# virtual methods
.method public a()Ljava/util/Date;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/h;->d:Ljava/util/Date;

    return-object v0
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lb/e/a/h/h;->j:I

    return v0
.end method

.method public c()D
    .locals 2

    iget-wide v0, p0, Lb/e/a/h/h;->g:D

    return-wide v0
.end method

.method public clone()Ljava/lang/Object;
    .locals 1

    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/h;->b:Ljava/lang/String;

    return-object v0
.end method

.method public e()I
    .locals 1

    iget v0, p0, Lb/e/a/h/h;->k:I

    return v0
.end method

.method public f()Lb/e/a/j/h;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/h;->e:Lb/e/a/j/h;

    return-object v0
.end method

.method public g()J
    .locals 2

    iget-wide v0, p0, Lb/e/a/h/h;->c:J

    return-wide v0
.end method

.method public h()J
    .locals 2

    iget-wide v0, p0, Lb/e/a/h/h;->i:J

    return-wide v0
.end method

.method public i()F
    .locals 1

    iget v0, p0, Lb/e/a/h/h;->h:F

    return v0
.end method

.method public j()D
    .locals 2

    iget-wide v0, p0, Lb/e/a/h/h;->f:D

    return-wide v0
.end method

.method public k(Ljava/util/Date;)V
    .locals 0

    iput-object p1, p0, Lb/e/a/h/h;->d:Ljava/util/Date;

    return-void
.end method

.method public l(D)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/h/h;->g:D

    return-void
.end method

.method public m(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/e/a/h/h;->b:Ljava/lang/String;

    return-void
.end method

.method public n(I)V
    .locals 0

    iput p1, p0, Lb/e/a/h/h;->k:I

    return-void
.end method

.method public o(Lb/e/a/j/h;)V
    .locals 0

    iput-object p1, p0, Lb/e/a/h/h;->e:Lb/e/a/j/h;

    return-void
.end method

.method public p(Ljava/util/Date;)V
    .locals 0

    return-void
.end method

.method public q(J)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/h/h;->c:J

    return-void
.end method

.method public r(J)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/h/h;->i:J

    return-void
.end method

.method public s(F)V
    .locals 0

    iput p1, p0, Lb/e/a/h/h;->h:F

    return-void
.end method

.method public t(D)V
    .locals 0

    iput-wide p1, p0, Lb/e/a/h/h;->f:D

    return-void
.end method
