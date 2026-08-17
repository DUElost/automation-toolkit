.class Ld/r/g/a;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private final a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private b:I

.field private c:I

.field private d:I

.field private e:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/r/g/a;->b:I

    iput v0, p0, Ld/r/g/a;->c:I

    iput v0, p0, Ld/r/g/a;->d:I

    iput-boolean v0, p0, Ld/r/g/a;->e:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    return-void
.end method

.method private d(Ld/e;)V
    .locals 2

    iget v0, p0, Ld/r/g/a;->b:I

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget v1, p0, Ld/r/g/a;->b:I

    if-lt v0, v1, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/p/b;

    invoke-direct {p0, v1, p1}, Ld/r/g/a;->j(Ld/p/b;Ld/e;)Z

    move-result v1

    if-nez v1, :cond_2

    add-int/lit8 v0, v0, -0x1

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private j(Ld/p/b;Ld/e;)Z
    .locals 3

    invoke-virtual {p1, p2}, Ld/p/b;->Q0(Ld/e;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    iget-object p2, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v2, p0, Ld/r/g/a;->b:I

    sub-int/2addr v2, v1

    invoke-static {p2, v0, v2}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p2, p0, Ld/r/g/a;->b:I

    sub-int/2addr p2, v1

    iput p2, p0, Ld/r/g/a;->b:I

    iget-object p2, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1

    iget v0, p0, Ld/r/g/a;->c:I

    sub-int/2addr v0, v1

    invoke-static {p2, p1, v0}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->c:I

    sub-int/2addr p1, v1

    iput p1, p0, Ld/r/g/a;->c:I

    iget-object p2, p0, Ld/r/g/a;->a:Ljava/util/List;

    iget v0, p0, Ld/r/g/a;->d:I

    sub-int/2addr v0, v1

    invoke-static {p2, p1, v0}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->d:I

    sub-int/2addr p1, v1

    iput p1, p0, Ld/r/g/a;->d:I

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {p2}, Ld/e;->j()Z

    move-result p2

    if-nez p2, :cond_1

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_1
    return v1
.end method


# virtual methods
.method public a(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1

    iget v1, p0, Ld/r/g/a;->d:I

    invoke-static {v0, p1, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->d:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/g/a;->d:I

    iget-boolean v0, p0, Ld/r/g/a;->e:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    add-int/lit8 p1, p1, -0x1

    iget v1, p0, Ld/r/g/a;->c:I

    invoke-static {v0, p1, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->c:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/g/a;->c:I

    :cond_0
    return-void
.end method

.method public b(Ld/p/b;)V
    .locals 2

    iget-boolean v0, p0, Ld/r/g/a;->e:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Ld/r/g/a;->a:Ljava/util/List;

    iget v0, p0, Ld/r/g/a;->d:I

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p1, v0, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Ld/r/g/a;->a:Ljava/util/List;

    iget v0, p0, Ld/r/g/a;->c:I

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p1, v0, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->c:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/g/a;->c:I

    :goto_0
    iget p1, p0, Ld/r/g/a;->d:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/g/a;->d:I

    return-void
.end method

.method public c()Z
    .locals 3

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget v2, p0, Ld/r/g/a;->b:I

    if-lt v1, v2, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    iget-object v2, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ld/p/b;

    invoke-virtual {v2}, Ld/p/b;->x0()Z

    move-result v2

    if-nez v2, :cond_1

    return v0

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public e(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1

    iget v0, p0, Ld/r/g/a;->b:I

    if-ge p1, v0, :cond_0

    return-void

    :cond_0
    iget v1, p0, Ld/r/g/a;->d:I

    if-lt p1, v1, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-static {v1, p1, v0}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/g/a;->b:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/g/a;->b:I

    return-void
.end method

.method public f(Ld/e;)Z
    .locals 1

    iget v0, p0, Ld/r/g/a;->c:I

    iput v0, p0, Ld/r/g/a;->b:I

    invoke-virtual {p0, p1}, Ld/r/g/a;->g(Ld/e;)Z

    move-result p1

    return p1
.end method

.method public g(Ld/e;)Z
    .locals 1

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    invoke-direct {p0, p1}, Ld/r/g/a;->d(Ld/e;)V

    if-nez v0, :cond_0

    iget p1, p0, Ld/r/g/a;->d:I

    iput p1, p0, Ld/r/g/a;->c:I

    :cond_0
    iput-boolean v0, p0, Ld/r/g/a;->e:Z

    const/4 p1, 0x1

    return p1
.end method

.method public h(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v1, p0, Ld/r/g/a;->b:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    iget v2, p0, Ld/r/g/a;->b:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/g/a;->b:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/r/g/a;->b:I

    :cond_0
    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v1, p0, Ld/r/g/a;->c:I

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    iget v2, p0, Ld/r/g/a;->c:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/g/a;->c:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/r/g/a;->c:I

    :cond_1
    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v1, p0, Ld/r/g/a;->d:I

    if-ge v0, v1, :cond_2

    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    iget v2, p0, Ld/r/g/a;->d:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/g/a;->d:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/r/g/a;->d:I

    :cond_2
    iget-object v0, p0, Ld/r/g/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public i()V
    .locals 1

    const/4 v0, 0x0

    iput v0, p0, Ld/r/g/a;->b:I

    return-void
.end method
