.class public Ld/r/a;
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

.field private c:Ld/p/b;

.field private d:I

.field private e:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Ld/r/a;->b:I

    iput v0, p0, Ld/r/a;->d:I

    iput-boolean v0, p0, Ld/r/a;->e:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public a(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1

    iget v1, p0, Ld/r/a;->b:I

    invoke-static {v0, p1, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/a;->b:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/a;->b:I

    return-void
.end method

.method public b(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Ld/r/a;->a:Ljava/util/List;

    iget v0, p0, Ld/r/a;->b:I

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p1, v0, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/a;->b:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/a;->b:I

    return-void
.end method

.method public c(Ld/s/c;Ld/s/f;)Ld/e;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/s/c;",
            "Ld/s/f<",
            "Ld/p/b;",
            ">;)",
            "Ld/e;"
        }
    .end annotation

    :cond_0
    :goto_0
    iget v0, p0, Ld/r/a;->b:I

    if-gtz v0, :cond_1

    const/16 p2, 0x23

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return-object p1

    :cond_1
    iget-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    iget v1, p0, Ld/r/a;->d:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->I0()Ld/e;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_2

    move v4, v3

    goto :goto_1

    :cond_2
    move v4, v2

    :goto_1
    if-eqz v4, :cond_5

    if-eqz p2, :cond_3

    invoke-virtual {p2, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    :cond_3
    invoke-virtual {v1}, Ld/e;->j()Z

    move-result p1

    iput-boolean p1, p0, Ld/r/a;->e:Z

    if-nez p1, :cond_4

    iput-object v0, p0, Ld/r/a;->c:Ld/p/b;

    iget p1, p0, Ld/r/a;->d:I

    add-int/2addr p1, v3

    iget p2, p0, Ld/r/a;->b:I

    rem-int/2addr p1, p2

    iput p1, p0, Ld/r/a;->d:I

    :cond_4
    return-object v1

    :cond_5
    iget v0, p0, Ld/r/a;->b:I

    sub-int/2addr v0, v3

    iput v0, p0, Ld/r/a;->b:I

    iget-object v1, p0, Ld/r/a;->a:Ljava/util/List;

    iget v3, p0, Ld/r/a;->d:I

    invoke-static {v1, v3, v0}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/a;->d:I

    iget v1, p0, Ld/r/a;->b:I

    if-ne v0, v1, :cond_0

    iput v2, p0, Ld/r/a;->d:I

    goto :goto_0
.end method

.method public d(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v1, p0, Ld/r/a;->b:I

    if-ge v0, v1, :cond_0

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Ld/r/a;->b:I

    iget-object v2, p0, Ld/r/a;->a:Ljava/util/List;

    invoke-static {v2, v0, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/a;->d:I

    iget v1, p0, Ld/r/a;->b:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Ld/r/a;->d:I

    :cond_0
    iget-object v0, p0, Ld/r/a;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Ld/r/a;->c:Ld/p/b;

    if-ne v0, p1, :cond_1

    invoke-virtual {v0}, Ld/p/b;->C0()Ld/s/a;

    const/4 p1, 0x0

    iput-object p1, p0, Ld/r/a;->c:Ld/p/b;

    :cond_1
    return-void
.end method
