.class public Lb/b/a/a/b/h;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:I

.field private b:J

.field private c:J

.field private d:J

.field private e:Lb/b/a/a/b/g;

.field private f:Ljava/lang/String;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/b/a/a/b/c;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/b/h;->a:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lb/b/a/a/b/h;->b:J

    iput-wide v0, p0, Lb/b/a/a/b/h;->c:J

    iput-wide v0, p0, Lb/b/a/a/b/h;->d:J

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/b/h;->g:Ljava/util/List;

    new-instance v0, Landroid/util/ArrayMap;

    invoke-direct {v0}, Landroid/util/ArrayMap;-><init>()V

    iput-object v0, p0, Lb/b/a/a/b/h;->h:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lb/b/a/a/b/h;->h:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public b(Lb/b/a/a/b/c;)V
    .locals 1

    iget-object v0, p0, Lb/b/a/a/b/h;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public c()V
    .locals 4

    iget-wide v0, p0, Lb/b/a/a/b/h;->c:J

    iget-wide v2, p0, Lb/b/a/a/b/h;->b:J

    sub-long/2addr v0, v2

    iput-wide v0, p0, Lb/b/a/a/b/h;->d:J

    return-void
.end method

.method public d()J
    .locals 2

    invoke-virtual {p0}, Lb/b/a/a/b/h;->c()V

    iget-wide v0, p0, Lb/b/a/a/b/h;->d:J

    return-wide v0
.end method

.method public e()J
    .locals 2

    iget-wide v0, p0, Lb/b/a/a/b/h;->c:J

    return-wide v0
.end method

.method public f()I
    .locals 1

    iget v0, p0, Lb/b/a/a/b/h;->a:I

    return v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/b/h;->f:Ljava/lang/String;

    return-object v0
.end method

.method public h()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/b/h;->h:Ljava/util/Map;

    return-object v0
.end method

.method public i()J
    .locals 2

    iget-wide v0, p0, Lb/b/a/a/b/h;->b:J

    return-wide v0
.end method

.method public j()Lb/b/a/a/b/g;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/b/h;->e:Lb/b/a/a/b/g;

    return-object v0
.end method

.method public k()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/b/a/a/b/c;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/b/h;->g:Ljava/util/List;

    return-object v0
.end method

.method public l(J)V
    .locals 0

    iput-wide p1, p0, Lb/b/a/a/b/h;->c:J

    return-void
.end method

.method public m(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/b/h;->f:Ljava/lang/String;

    return-void
.end method

.method public n(J)V
    .locals 0

    iput-wide p1, p0, Lb/b/a/a/b/h;->b:J

    return-void
.end method

.method public o(Lb/b/a/a/b/g;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/b/h;->e:Lb/b/a/a/b/g;

    return-void
.end method
