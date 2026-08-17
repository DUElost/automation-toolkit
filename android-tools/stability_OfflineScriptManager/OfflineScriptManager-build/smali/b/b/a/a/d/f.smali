.class public Lb/b/a/a/d/f;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/b/a/a/d/f$a;
    }
.end annotation


# instance fields
.field private a:Z

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:I

.field private e:I

.field private f:I

.field private g:I

.field private h:I

.field private i:Z

.field private j:Lb/b/a/a/d/h;

.field private k:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/d/h;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lb/b/a/a/d/f;->a:Z

    iput v0, p0, Lb/b/a/a/d/f;->d:I

    const v0, 0xf731400

    iput v0, p0, Lb/b/a/a/d/f;->e:I

    const/4 v0, 0x0

    iput v0, p0, Lb/b/a/a/d/f;->f:I

    iput v0, p0, Lb/b/a/a/d/f;->g:I

    const/4 v1, 0x2

    iput v1, p0, Lb/b/a/a/d/f;->h:I

    iput-boolean v0, p0, Lb/b/a/a/d/f;->i:Z

    new-instance v0, Lb/b/a/a/d/h;

    invoke-direct {v0}, Lb/b/a/a/d/h;-><init>()V

    iput-object v0, p0, Lb/b/a/a/d/f;->j:Lb/b/a/a/d/h;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lb/b/a/a/d/f;->k:Ljava/util/ArrayList;

    iget-object v0, p0, Lb/b/a/a/d/f;->j:Lb/b/a/a/d/h;

    const-string v1, "\ufffd\ufffd\ufffd\ufffd\u01f0\ufffd\ufffd\u0524\ufffd\u00f5\u0132\ufffd\ufffd\ufffd"

    invoke-virtual {v0, v1}, Lb/b/a/a/d/h;->p(Ljava/lang/String;)V

    iget-object v0, p0, Lb/b/a/a/d/f;->j:Lb/b/a/a/d/h;

    const-string v1, "\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\u8c78\ufffd\u03f5\ufffd\ufffd\u01f8\ufffd\ufffd\u013c\ufffd\ufffd\u0423\ufffd\ufffd\ufffd\ufffd\ufffdpush\u02b2\u00f4\ufffd\u013c\ufffd\ufffd\u0175\ufffd\ufffd\u8c78"

    invoke-virtual {v0, v1}, Lb/b/a/a/d/h;->g(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(Lb/b/a/a/d/h;)V
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/f;->k:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/f;->g:I

    return v0
.end method

.method public c()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/d/f;->a:Z

    return v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/f;->c:Ljava/lang/String;

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/f;->b:Ljava/lang/String;

    return-object v0
.end method

.method public f()Lb/b/a/a/d/h;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/d/f;->j:Lb/b/a/a/d/h;

    return-object v0
.end method

.method public g()Z
    .locals 1

    iget-boolean v0, p0, Lb/b/a/a/d/f;->i:Z

    return v0
.end method

.method public h()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/f;->f:I

    return v0
.end method

.method public i()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/d/h;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/b/a/a/d/f;->k:Ljava/util/ArrayList;

    return-object v0
.end method

.method public j()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/f;->h:I

    return v0
.end method

.method public k()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/f;->e:I

    return v0
.end method

.method public l()I
    .locals 1

    iget v0, p0, Lb/b/a/a/d/f;->d:I

    return v0
.end method

.method public m(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/f;->g:I

    return-void
.end method

.method public n(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/d/f;->a:Z

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/d/f;->c:Ljava/lang/String;

    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/d/f;->b:Ljava/lang/String;

    return-void
.end method

.method public q(Lb/b/a/a/d/h;)V
    .locals 0

    iput-object p1, p0, Lb/b/a/a/d/f;->j:Lb/b/a/a/d/h;

    return-void
.end method

.method public r(Z)V
    .locals 0

    iput-boolean p1, p0, Lb/b/a/a/d/f;->i:Z

    return-void
.end method

.method public s(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/f;->f:I

    return-void
.end method

.method public t(Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lb/b/a/a/d/h;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lb/b/a/a/d/f;->k:Ljava/util/ArrayList;

    return-void
.end method

.method public u(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/f;->h:I

    return-void
.end method

.method public v(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/f;->e:I

    return-void
.end method

.method public w(I)V
    .locals 0

    iput p1, p0, Lb/b/a/a/d/f;->d:I

    return-void
.end method
