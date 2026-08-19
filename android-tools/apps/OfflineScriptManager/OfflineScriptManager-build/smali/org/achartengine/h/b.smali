.class public Lorg/achartengine/h/b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field private static final I:Landroid/graphics/Typeface;


# instance fields
.field private A:F

.field private B:Z

.field private C:F

.field private D:Z

.field private E:F

.field private F:Z

.field private G:I

.field private H:Z

.field private b:Ljava/lang/String;

.field private c:F

.field private d:Ljava/lang/String;

.field private e:I

.field private f:Landroid/graphics/Typeface;

.field private g:I

.field private h:Z

.field private i:Z

.field private j:I

.field private k:I

.field private l:Z

.field private m:Z

.field private n:I

.field private o:F

.field private p:Z

.field private q:F

.field private r:Z

.field private s:Z

.field private t:Z

.field private u:Z

.field private v:Z

.field private w:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/achartengine/h/c;",
            ">;"
        }
    .end annotation
.end field

.field private x:Z

.field private y:I

.field private z:[I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v0

    sput-object v0, Lorg/achartengine/h/b;->I:Landroid/graphics/Typeface;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lorg/achartengine/h/b;->b:Ljava/lang/String;

    const/high16 v0, 0x41700000    # 15.0f

    iput v0, p0, Lorg/achartengine/h/b;->c:F

    sget-object v0, Lorg/achartengine/h/b;->I:Landroid/graphics/Typeface;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/achartengine/h/b;->d:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lorg/achartengine/h/b;->e:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lorg/achartengine/h/b;->i:Z

    const v2, -0x333334

    iput v2, p0, Lorg/achartengine/h/b;->j:I

    iput v2, p0, Lorg/achartengine/h/b;->k:I

    iput-boolean v1, p0, Lorg/achartengine/h/b;->l:Z

    iput-boolean v1, p0, Lorg/achartengine/h/b;->m:Z

    iput v2, p0, Lorg/achartengine/h/b;->n:I

    const/high16 v2, 0x41200000    # 10.0f

    iput v2, p0, Lorg/achartengine/h/b;->o:F

    iput-boolean v1, p0, Lorg/achartengine/h/b;->p:Z

    const/high16 v2, 0x41400000    # 12.0f

    iput v2, p0, Lorg/achartengine/h/b;->q:F

    iput-boolean v0, p0, Lorg/achartengine/h/b;->r:Z

    iput-boolean v0, p0, Lorg/achartengine/h/b;->s:Z

    iput-boolean v0, p0, Lorg/achartengine/h/b;->t:Z

    iput-boolean v0, p0, Lorg/achartengine/h/b;->u:Z

    iput-boolean v0, p0, Lorg/achartengine/h/b;->v:Z

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lorg/achartengine/h/b;->w:Ljava/util/List;

    iput-boolean v1, p0, Lorg/achartengine/h/b;->x:Z

    iput v0, p0, Lorg/achartengine/h/b;->y:I

    const/4 v1, 0x4

    new-array v1, v1, [I

    fill-array-data v1, :array_0

    iput-object v1, p0, Lorg/achartengine/h/b;->z:[I

    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, p0, Lorg/achartengine/h/b;->A:F

    iput-boolean v0, p0, Lorg/achartengine/h/b;->B:Z

    const/high16 v2, 0x3fc00000    # 1.5f

    iput v2, p0, Lorg/achartengine/h/b;->C:F

    iput-boolean v0, p0, Lorg/achartengine/h/b;->D:Z

    iput v1, p0, Lorg/achartengine/h/b;->E:F

    iput-boolean v0, p0, Lorg/achartengine/h/b;->F:Z

    const/16 v0, 0xf

    iput v0, p0, Lorg/achartengine/h/b;->G:I

    return-void

    :array_0
    .array-data 4
        0x14
        0x1e
        0xa
        0x14
    .end array-data
.end method


# virtual methods
.method public A()Z
    .locals 0

    const p0, 0x0

    throw p0
.end method

.method public B()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->i:Z

    return v0
.end method

.method public C()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->u:Z

    return v0
.end method

.method public D()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->v:Z

    return v0
.end method

.method public E()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->s:Z

    return v0
.end method

.method public F()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->t:Z

    return v0
.end method

.method public G()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->l:Z

    return v0
.end method

.method public H()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->p:Z

    return v0
.end method

.method public I()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->m:Z

    return v0
.end method

.method public J()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->B:Z

    return v0
.end method

.method public K()Z
    .locals 0

    const p0, 0x0

    throw p0
.end method

.method public L(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->h:Z

    return-void
.end method

.method public M(I)V
    .locals 0

    invoke-virtual {p0, p1}, Lorg/achartengine/h/b;->a0(I)V

    invoke-virtual {p0, p1}, Lorg/achartengine/h/b;->b0(I)V

    return-void
.end method

.method public N(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->g:I

    return-void
.end method

.method public O(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/h/b;->b:Ljava/lang/String;

    return-void
.end method

.method public P(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->c:F

    return-void
.end method

.method public Q(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->n:I

    return-void
.end method

.method public R(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->o:F

    return-void
.end method

.method public S(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->q:F

    return-void
.end method

.method public T([I)V
    .locals 0

    iput-object p1, p0, Lorg/achartengine/h/b;->z:[I

    return-void
.end method

.method public U(F)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->A:F

    return-void
.end method

.method public V(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->i:Z

    return-void
.end method

.method public W(Z)V
    .locals 0

    invoke-virtual {p0, p1}, Lorg/achartengine/h/b;->X(Z)V

    invoke-virtual {p0, p1}, Lorg/achartengine/h/b;->Y(Z)V

    return-void
.end method

.method public X(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->s:Z

    return-void
.end method

.method public Y(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->t:Z

    return-void
.end method

.method public Z(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->l:Z

    return-void
.end method

.method public a(Lorg/achartengine/h/c;)V
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->w:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public a0(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->k:I

    return-void
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->g:I

    return v0
.end method

.method public b0(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/b;->j:I

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c0(Z)V
    .locals 0

    iput-boolean p1, p0, Lorg/achartengine/h/b;->B:Z

    return-void
.end method

.method public d()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->c:F

    return v0
.end method

.method public e()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->n:I

    return v0
.end method

.method public f()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->o:F

    return v0
.end method

.method public g()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->y:I

    return v0
.end method

.method public h()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->q:F

    return v0
.end method

.method public i()[I
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->z:[I

    return-object v0
.end method

.method public j()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->E:F

    return v0
.end method

.method public k()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->A:F

    return v0
.end method

.method public l()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->G:I

    return v0
.end method

.method public m(I)Lorg/achartengine/h/c;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->w:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/achartengine/h/c;

    return-object p1
.end method

.method public n()I
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->w:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public o()Landroid/graphics/Typeface;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->f:Landroid/graphics/Typeface;

    return-object v0
.end method

.method public p()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/b;->d:Ljava/lang/String;

    return-object v0
.end method

.method public q()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->e:I

    return v0
.end method

.method public r()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->k:I

    return v0
.end method

.method public s()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->j:I

    return v0
.end method

.method public t()F
    .locals 1

    iget v0, p0, Lorg/achartengine/h/b;->C:F

    return v0
.end method

.method public u()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->x:Z

    return v0
.end method

.method public v()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->h:Z

    return v0
.end method

.method public w()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->F:Z

    return v0
.end method

.method public x()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->D:Z

    return v0
.end method

.method public y()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->r:Z

    return v0
.end method

.method public z()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/b;->H:Z

    return v0
.end method
