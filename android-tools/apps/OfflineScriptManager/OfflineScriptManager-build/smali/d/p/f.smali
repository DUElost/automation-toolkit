.class Ld/p/f;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/p/f$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private a:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field

.field private b:I

.field private c:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field

.field private d:I

.field private e:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field

.field private f:I

.field private volatile g:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field

.field private final h:I

.field private i:I


# direct methods
.method public constructor <init>(I)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ld/p/f;->h:I

    const/4 v0, 0x0

    iput v0, p0, Ld/p/f;->i:I

    new-instance v1, Ld/p/f$a;

    invoke-direct {v1, p1, v0}, Ld/p/f$a;-><init>(II)V

    iput-object v1, p0, Ld/p/f;->a:Ld/p/f$a;

    iget v2, p0, Ld/p/f;->i:I

    add-int/2addr v2, p1

    iput v2, p0, Ld/p/f;->i:I

    iput v0, p0, Ld/p/f;->b:I

    iput v0, p0, Ld/p/f;->d:I

    iput-object v1, p0, Ld/p/f;->c:Ld/p/f$a;

    iput-object v1, p0, Ld/p/f;->g:Ld/p/f$a;

    iget-object p1, p0, Ld/p/f;->a:Ld/p/f$a;

    iput-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    const/4 p1, 0x1

    iput p1, p0, Ld/p/f;->f:I

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Ld/p/f;->c:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->a:[Ljava/lang/Object;

    iget v1, p0, Ld/p/f;->d:I

    aget-object v0, v0, v1

    return-object v0
.end method

.method public b()I
    .locals 2

    iget-object v0, p0, Ld/p/f;->c:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->b:[I

    iget v1, p0, Ld/p/f;->d:I

    aget v0, v0, v1

    return v0
.end method

.method public c()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Ld/p/f;->a:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->a:[Ljava/lang/Object;

    iget v1, p0, Ld/p/f;->b:I

    aget-object v0, v0, v1

    return-object v0
.end method

.method public d()I
    .locals 2

    iget-object v0, p0, Ld/p/f;->a:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->b:[I

    iget v1, p0, Ld/p/f;->b:I

    aget v0, v0, v1

    return v0
.end method

.method public e()Ljava/lang/Object;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Ld/p/f;->a:Ld/p/f$a;

    iget-object v1, v0, Ld/p/f$a;->a:[Ljava/lang/Object;

    iget v2, p0, Ld/p/f;->b:I

    aget-object v3, v1, v2

    const/4 v4, 0x0

    aput-object v4, v1, v2

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Ld/p/f;->b:I

    iget v1, p0, Ld/p/f;->h:I

    if-ne v2, v1, :cond_0

    iget-object v0, v0, Ld/p/f$a;->d:Ld/p/f$a;

    iput-object v0, p0, Ld/p/f;->a:Ld/p/f$a;

    iput-object v4, v0, Ld/p/f$a;->c:Ld/p/f$a;

    const/4 v0, 0x0

    iput v0, p0, Ld/p/f;->b:I

    :cond_0
    return-object v3
.end method

.method public f(Ljava/lang/Object;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    iget-object v0, p0, Ld/p/f;->c:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->a:[Ljava/lang/Object;

    iget v1, p0, Ld/p/f;->d:I

    aput-object p1, v0, v1

    iget-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    iput-object p1, p0, Ld/p/f;->c:Ld/p/f$a;

    iget p1, p0, Ld/p/f;->f:I

    iput p1, p0, Ld/p/f;->d:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ld/p/f;->f:I

    iget v0, p0, Ld/p/f;->h:I

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Ld/p/f;->g:Ld/p/f$a;

    iget-object v0, p0, Ld/p/f;->a:Ld/p/f$a;

    if-eq p1, v0, :cond_1

    iget-object v0, p0, Ld/p/f;->g:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->d:Ld/p/f$a;

    iput-object v0, p0, Ld/p/f;->g:Ld/p/f$a;

    iget-object v0, p0, Ld/p/f;->e:Ld/p/f$a;

    iput-object p1, v0, Ld/p/f$a;->d:Ld/p/f$a;

    iput-object v0, p1, Ld/p/f$a;->c:Ld/p/f$a;

    goto :goto_0

    :cond_1
    iget-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    new-instance v0, Ld/p/f$a;

    iget v1, p0, Ld/p/f;->h:I

    iget v2, p0, Ld/p/f;->i:I

    invoke-direct {v0, v1, v2}, Ld/p/f$a;-><init>(II)V

    iput-object v0, p1, Ld/p/f$a;->d:Ld/p/f$a;

    iget p1, p0, Ld/p/f;->i:I

    iget v0, p0, Ld/p/f;->h:I

    add-int/2addr p1, v0

    iput p1, p0, Ld/p/f;->i:I

    iget-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    iget-object v0, p1, Ld/p/f$a;->d:Ld/p/f$a;

    iput-object p1, v0, Ld/p/f$a;->c:Ld/p/f$a;

    :goto_0
    iget-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    iget-object p1, p1, Ld/p/f$a;->d:Ld/p/f$a;

    iput-object p1, p0, Ld/p/f;->e:Ld/p/f$a;

    const/4 p1, 0x0

    iput p1, p0, Ld/p/f;->f:I

    return-void
.end method

.method public g()V
    .locals 2

    iget v0, p0, Ld/p/f;->d:I

    if-lez v0, :cond_0

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/p/f;->d:I

    goto :goto_0

    :cond_0
    iget v0, p0, Ld/p/f;->h:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/p/f;->d:I

    iget-object v0, p0, Ld/p/f;->c:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->c:Ld/p/f$a;

    iput-object v0, p0, Ld/p/f;->c:Ld/p/f$a;

    :goto_0
    iget v0, p0, Ld/p/f;->f:I

    if-lez v0, :cond_1

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/p/f;->f:I

    goto :goto_1

    :cond_1
    iget v0, p0, Ld/p/f;->h:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Ld/p/f;->f:I

    iget-object v0, p0, Ld/p/f;->e:Ld/p/f$a;

    iget-object v0, v0, Ld/p/f$a;->c:Ld/p/f$a;

    iput-object v0, p0, Ld/p/f;->e:Ld/p/f$a;

    const/4 v1, 0x0

    iput-object v1, v0, Ld/p/f$a;->d:Ld/p/f$a;

    :goto_1
    return-void
.end method
