.class public Ld/r/h/c;
.super Ld/r/h/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/h/c$a;
    }
.end annotation


# instance fields
.field private D:Z

.field private E:Z

.field private final F:Ld/s/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/s/f<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private G:Z

.field private H:I

.field private I:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/c;II)V
    .locals 1

    invoke-direct {p0, p1, p2, p3}, Ld/r/h/a;-><init>(Ld/c;II)V

    new-instance p1, Ld/s/f;

    invoke-direct {p1}, Ld/s/f;-><init>()V

    iput-object p1, p0, Ld/r/h/c;->F:Ld/s/f;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/r/h/c;->D:Z

    const/4 p2, 0x1

    iput-boolean p2, p0, Ld/r/h/c;->E:Z

    iget-object p3, p0, Ld/g;->e:Ld/f;

    const/4 v0, 0x3

    iput v0, p3, Ld/f;->j:I

    iput-boolean p1, p0, Ld/r/h/c;->G:Z

    invoke-static {}, Ld/s/e;->c()I

    move-result p1

    iput p1, p0, Ld/r/h/c;->H:I

    iput-boolean p2, p0, Ld/r/h/c;->I:Z

    return-void
.end method


# virtual methods
.method protected m1(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/r/h/c;->F:Ld/s/f;

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :cond_0

    iget-object v0, p0, Ld/r/h/c;->F:Ld/s/f;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ld/s/f;->b(Ljava/lang/Object;)V

    :cond_0
    invoke-super {p0, p1}, Ld/r/h/a;->m1(Ld/p/b;)V

    return-void
.end method

.method public o1(Ld/e;)Z
    .locals 5

    iget-boolean v0, p0, Ld/r/h/c;->D:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Ld/r/h/c;->I:Z

    if-eqz v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfb

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    iput-boolean v1, p0, Ld/r/h/c;->D:Z

    iput-boolean v2, p0, Ld/r/h/c;->E:Z

    :cond_1
    iget-boolean v0, p0, Ld/r/h/c;->E:Z

    if-eqz v0, :cond_5

    iget-object v0, p0, Ld/r/h/c;->F:Ld/s/f;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-boolean v0, p0, Ld/r/h/c;->G:Z

    if-eqz v0, :cond_2

    iget v0, p0, Ld/r/h/c;->H:I

    add-int/2addr v0, v2

    iput v0, p0, Ld/r/h/c;->H:I

    new-instance v0, Ld/e;

    const/4 v3, 0x4

    invoke-direct {v0, v3}, Ld/e;-><init>(I)V

    invoke-virtual {v0}, Ld/e;->a()Ljava/nio/ByteBuffer;

    move-result-object v3

    iget v4, p0, Ld/r/h/c;->H:I

    invoke-static {v3, v4}, Ld/s/g;->d(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v2}, Ld/e;->y(I)V

    iget-object v3, p0, Ld/r/h/c;->F:Ld/s/f;

    invoke-super {p0, v0, v3}, Ld/r/h/a;->s1(Ld/e;Ld/s/f;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    :cond_2
    new-instance v0, Ld/e;

    invoke-direct {v0}, Ld/e;-><init>()V

    invoke-virtual {v0, v2}, Ld/e;->y(I)V

    iget-object v3, p0, Ld/r/h/c;->F:Ld/s/f;

    invoke-super {p0, v0, v3}, Ld/r/h/a;->s1(Ld/e;Ld/s/f;)Z

    move-result v0

    if-nez v0, :cond_3

    return v1

    :cond_3
    iput-boolean v1, p0, Ld/r/h/c;->E:Z

    :cond_4
    invoke-super {p0}, Ld/r/h/a;->t1()Ld/e;

    move-result-object v0

    if-nez v0, :cond_4

    :cond_5
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    invoke-super {p0, p1}, Ld/r/h/a;->o1(Ld/e;)Z

    move-result p1

    if-nez p1, :cond_6

    return v1

    :cond_6
    if-nez v0, :cond_7

    iput-boolean v2, p0, Ld/r/h/c;->D:Z

    iput-boolean v2, p0, Ld/r/h/c;->E:Z

    :cond_7
    return v2
.end method

.method protected p1(ILjava/lang/Object;)Z
    .locals 2

    const/16 v0, 0x34

    const/4 v1, 0x1

    if-eq p1, v0, :cond_1

    const/16 v0, 0x35

    if-eq p1, v0, :cond_0

    invoke-super {p0, p1, p2}, Ld/r/h/a;->p1(ILjava/lang/Object;)Z

    move-result p1

    return p1

    :cond_0
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    xor-int/2addr p1, v1

    iput-boolean p1, p0, Ld/r/h/c;->I:Z

    return v1

    :cond_1
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/r/h/c;->G:Z

    return v1
.end method
