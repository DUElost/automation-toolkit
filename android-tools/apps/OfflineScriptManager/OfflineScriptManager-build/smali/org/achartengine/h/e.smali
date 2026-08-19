.class public Lorg/achartengine/h/e;
.super Lorg/achartengine/h/c;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/achartengine/h/e$a;
    }
.end annotation


# instance fields
.field private g:Z

.field private h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/achartengine/h/e$a;",
            ">;"
        }
    .end annotation
.end field

.field private i:Lorg/achartengine/f/d;

.field private j:F

.field private k:F

.field private l:Z

.field private m:I

.field private n:F

.field private o:Landroid/graphics/Paint$Align;

.field private p:F

.field private q:F

.field private r:Landroid/graphics/Paint$Align;

.field private s:I


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lorg/achartengine/h/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/achartengine/h/e;->g:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/achartengine/h/e;->h:Ljava/util/List;

    sget-object v0, Lorg/achartengine/f/d;->h:Lorg/achartengine/f/d;

    iput-object v0, p0, Lorg/achartengine/h/e;->i:Lorg/achartengine/f/d;

    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lorg/achartengine/h/e;->j:F

    iput v0, p0, Lorg/achartengine/h/e;->k:F

    const/16 v0, 0x64

    iput v0, p0, Lorg/achartengine/h/e;->m:I

    const/high16 v0, 0x41200000    # 10.0f

    iput v0, p0, Lorg/achartengine/h/e;->n:F

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    iput-object v1, p0, Lorg/achartengine/h/e;->o:Landroid/graphics/Paint$Align;

    const/high16 v2, 0x40a00000    # 5.0f

    iput v2, p0, Lorg/achartengine/h/e;->p:F

    iput v0, p0, Lorg/achartengine/h/e;->q:F

    iput-object v1, p0, Lorg/achartengine/h/e;->r:Landroid/graphics/Paint$Align;

    const v0, -0x333334

    iput v0, p0, Lorg/achartengine/h/e;->s:I

    return-void
.end method


# virtual methods
.method public h(Lorg/achartengine/h/e$a;)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e;->h:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->s:I

    return v0
.end method

.method public j()Landroid/graphics/Paint$Align;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e;->r:Landroid/graphics/Paint$Align;

    return-object v0
.end method

.method public k()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->q:F

    return v0
.end method

.method public l()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->p:F

    return v0
.end method

.method public m()Landroid/graphics/Paint$Align;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e;->o:Landroid/graphics/Paint$Align;

    return-object v0
.end method

.method public n()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->n:F

    return v0
.end method

.method public o()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->m:I

    return v0
.end method

.method public p()[Lorg/achartengine/h/e$a;
    .locals 2

    iget-object v0, p0, Lorg/achartengine/h/e;->h:Ljava/util/List;

    const/4 v1, 0x0

    new-array v1, v1, [Lorg/achartengine/h/e$a;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/achartengine/h/e$a;

    return-object v0
.end method

.method public q()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->k:F

    return v0
.end method

.method public r()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e;->j:F

    return v0
.end method

.method public s()Lorg/achartengine/f/d;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e;->i:Lorg/achartengine/f/d;

    return-object v0
.end method

.method public t()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/e;->l:Z

    return v0
.end method

.method public u()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/e;->g:Z

    return v0
.end method

.method public v(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/e;->g:Z

    return-void
.end method

.method public w(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/e;->k:F

    return-void
.end method

.method public x(Lorg/achartengine/f/d;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/h/e;->i:Lorg/achartengine/f/d;

    return-void
.end method
