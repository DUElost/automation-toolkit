.class public Ld/r/b;
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

.field private d:Z

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

    iput v0, p0, Ld/r/b;->b:I

    iput v0, p0, Ld/r/b;->c:I

    iput-boolean v0, p0, Ld/r/b;->d:Z

    iput-boolean v0, p0, Ld/r/b;->e:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public a(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1

    iget v1, p0, Ld/r/b;->b:I

    invoke-static {v0, p1, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget p1, p0, Ld/r/b;->b:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/r/b;->b:I

    return-void
.end method

.method public b(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, p1}, Ld/r/b;->a(Ld/p/b;)V

    return-void
.end method

.method public c(Ld/e;Ld/s/c;Ld/s/f;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ld/e;",
            "Ld/s/c;",
            "Ld/s/f<",
            "Ld/p/b;",
            ">;)Z"
        }
    .end annotation

    iget-boolean v0, p0, Ld/r/b;->e:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result p1

    iput-boolean p1, p0, Ld/r/b;->d:Z

    iput-boolean p1, p0, Ld/r/b;->e:Z

    return v1

    :cond_0
    :goto_0
    iget v0, p0, Ld/r/b;->b:I

    const/4 v2, 0x0

    if-gtz v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    iget v3, p0, Ld/r/b;->c:I

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/p/b;

    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    move-result v0

    if-eqz v0, :cond_5

    if-eqz p3, :cond_2

    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    iget v3, p0, Ld/r/b;->c:I

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/p/b;

    invoke-virtual {p3, v0}, Ld/s/f;->b(Ljava/lang/Object;)V

    :cond_2
    :goto_1
    iget p3, p0, Ld/r/b;->b:I

    if-nez p3, :cond_3

    const/16 p1, 0x23

    invoke-virtual {p2, p1}, Ld/s/c;->c(I)V

    return v2

    :cond_3
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result p1

    iput-boolean p1, p0, Ld/r/b;->d:Z

    if-nez p1, :cond_4

    iget-object p1, p0, Ld/r/b;->a:Ljava/util/List;

    iget p2, p0, Ld/r/b;->c:I

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->B0()V

    iget p1, p0, Ld/r/b;->c:I

    add-int/2addr p1, v1

    iput p1, p0, Ld/r/b;->c:I

    iget p2, p0, Ld/r/b;->b:I

    if-lt p1, p2, :cond_4

    iput v2, p0, Ld/r/b;->c:I

    :cond_4
    return v1

    :cond_5
    iget v0, p0, Ld/r/b;->b:I

    sub-int/2addr v0, v1

    iput v0, p0, Ld/r/b;->b:I

    iget v3, p0, Ld/r/b;->c:I

    if-ge v3, v0, :cond_6

    iget-object v2, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-static {v2, v3, v0}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    goto :goto_0

    :cond_6
    iput v2, p0, Ld/r/b;->c:I

    goto :goto_0
.end method

.method public d(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    iget v1, p0, Ld/r/b;->c:I

    const/4 v2, 0x1

    if-ne v0, v1, :cond_0

    iget-boolean v1, p0, Ld/r/b;->d:Z

    if-eqz v1, :cond_0

    iput-boolean v2, p0, Ld/r/b;->e:Z

    :cond_0
    iget v1, p0, Ld/r/b;->b:I

    if-ge v0, v1, :cond_1

    sub-int/2addr v1, v2

    iput v1, p0, Ld/r/b;->b:I

    iget-object v2, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-static {v2, v0, v1}, Ljava/util/Collections;->swap(Ljava/util/List;II)V

    iget v0, p0, Ld/r/b;->c:I

    iget v1, p0, Ld/r/b;->b:I

    if-ne v0, v1, :cond_1

    const/4 v0, 0x0

    iput v0, p0, Ld/r/b;->c:I

    :cond_1
    iget-object v0, p0, Ld/r/b;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method
