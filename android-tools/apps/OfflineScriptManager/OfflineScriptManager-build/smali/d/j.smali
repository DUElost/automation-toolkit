.class public abstract Ld/j;
.super Ld/g;
.source ""

# interfaces
.implements Ld/q/a;
.implements Ld/p/b$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/j$a;,
        Ld/j$b;
    }
.end annotation


# instance fields
.field private final m:Ld/s/d;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/s/d<",
            "Ljava/lang/String;",
            "Ld/j$a;",
            ">;"
        }
    .end annotation
.end field

.field private final n:Ld/s/d;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/s/d<",
            "Ljava/lang/String;",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private o:I

.field private p:Z

.field private q:Z

.field private final r:Ld/d;

.field private final s:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private t:Ld/q/b;

.field private u:Ld/q/b$a;

.field private v:J

.field private w:Ld/j;

.field private x:I

.field protected y:Ljava/lang/String;

.field private final z:Ljava/util/concurrent/locks/ReentrantLock;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method protected constructor <init>(Ld/c;II)V
    .locals 4

    invoke-direct {p0, p1, p2}, Ld/g;-><init>(Ld/c;I)V

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/locks/ReentrantLock;-><init>(Z)V

    iput-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    const v0, -0x45221351

    iput v0, p0, Ld/j;->o:I

    iput-boolean v1, p0, Ld/j;->p:Z

    iput-boolean v1, p0, Ld/j;->q:Z

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Ld/j;->v:J

    const/4 v0, 0x0

    iput-object v0, p0, Ld/j;->w:Ld/j;

    iput v1, p0, Ld/j;->x:I

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iput p3, v0, Ld/f;->J:I

    const/16 v2, 0x2a

    invoke-virtual {p1, v2}, Ld/c;->l(I)I

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    iput-boolean v2, v0, Ld/f;->q:Z

    iget-object v0, p0, Ld/g;->e:Ld/f;

    const/16 v2, 0x46

    invoke-virtual {p1, v2}, Ld/c;->l(I)I

    move-result v2

    if-eqz v2, :cond_1

    const/4 v1, -0x1

    :cond_1
    iput v1, v0, Ld/f;->k:I

    new-instance v0, Ld/s/d;

    invoke-direct {v0}, Ld/s/d;-><init>()V

    iput-object v0, p0, Ld/j;->m:Ld/s/d;

    new-instance v0, Ld/s/d;

    invoke-direct {v0}, Ld/s/d;-><init>()V

    iput-object v0, p0, Ld/j;->n:Ld/s/d;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Ld/j;->s:Ljava/util/Set;

    new-instance v0, Ld/d;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "socket-"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-direct {v0, p1, p3, p2}, Ld/d;-><init>(Ld/c;Ljava/lang/String;I)V

    iput-object v0, p0, Ld/j;->r:Ld/d;

    return-void
.end method

.method private H0(Ljava/lang/String;Ld/g;Ld/p/b;)V
    .locals 2

    invoke-virtual {p0, p2}, Ld/g;->B0(Ld/g;)V

    iget-object v0, p0, Ld/j;->m:Ld/s/d;

    new-instance v1, Ld/j$a;

    invoke-direct {v1, p2, p3}, Ld/j$a;-><init>(Ld/g;Ld/p/b;)V

    invoke-virtual {v0, p1, v1}, Ld/s/d;->e(Ljava/lang/Comparable;Ljava/lang/Object;)Z

    return-void
.end method

.method private I0(Ld/p/b;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Ld/j;->J0(Ld/p/b;Z)V

    return-void
.end method

.method private J0(Ld/p/b;Z)V
    .locals 1

    invoke-virtual {p1, p0}, Ld/p/b;->K0(Ld/p/b$a;)V

    iget-object v0, p0, Ld/j;->s:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, p1, p2}, Ld/j;->k1(Ld/p/b;Z)V

    invoke-virtual {p0}, Ld/g;->A0()Z

    move-result p2

    if-eqz p2, :cond_0

    const/4 p2, 0x1

    invoke-virtual {p0, p2}, Ld/g;->D0(I)V

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Ld/p/b;->P0(Z)V

    :cond_0
    return-void
.end method

.method private L0()V
    .locals 2

    iget-boolean v0, p0, Ld/j;->q:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/j;->t:Ld/q/b;

    iget-object v1, p0, Ld/j;->u:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/q/b;->m(Ld/q/b$a;)V

    invoke-virtual {p0, p0}, Ld/m;->E(Ld/j;)V

    invoke-virtual {p0}, Ld/m;->q0()V

    invoke-super {p0}, Ld/g;->C0()V

    :cond_0
    return-void
.end method

.method private M0(Ljava/lang/String;)Ld/n/j/b;
    .locals 2

    invoke-static {p1}, Ld/n/j/b;->b(Ljava/lang/String;)Ld/n/j/b;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-boolean v0, p1, Ld/n/j/b;->b:Z

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget v0, v0, Ld/f;->j:I

    invoke-virtual {p1, v0}, Ld/n/j/b;->a(I)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfc

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    :cond_1
    return-object p1

    :cond_2
    :goto_0
    iget-object v0, p0, Ld/g;->l:Ld/s/c;

    const/16 v1, 0x2b

    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V

    return-object p1
.end method

.method private Q0(Ljava/lang/String;Ljava/lang/Object;I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V

    iget v0, p0, Ld/j;->x:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    and-int/2addr v0, p3

    if-nez v0, :cond_0

    :goto_0
    iget-object p1, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {p1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    return-void

    :cond_0
    :try_start_1
    new-instance v0, Ld/l$a;

    invoke-direct {v0, p3, p1, p2}, Ld/l$a;-><init>(ILjava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ld/j;->d1(Ld/l$a;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {p2}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw p1
.end method

.method private e1(IZ)Z
    .locals 4

    const-wide/16 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p2, p0, Ld/j;->r:Ld/d;

    int-to-long v2, p1

    invoke-virtual {p2, v2, v3}, Ld/d;->b(J)Ld/a;

    move-result-object p1

    goto :goto_1

    :cond_0
    :goto_0
    iget-object p1, p0, Ld/j;->r:Ld/d;

    invoke-virtual {p1, v0, v1}, Ld/d;->b(J)Ld/a;

    move-result-object p1

    :goto_1
    if-nez p1, :cond_3

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1}, Ld/s/c;->a()I

    move-result p1

    const/4 p2, 0x4

    const/4 v0, 0x0

    if-ne p1, p2, :cond_1

    return v0

    :cond_1
    iget-boolean p1, p0, Ld/j;->p:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const p2, 0x9523dfd

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v0

    :cond_2
    const/4 p1, 0x1

    return p1

    :cond_3
    invoke-virtual {p1}, Ld/a;->a()V

    goto :goto_0
.end method

.method private j1()V
    .locals 5

    iget-object v0, p0, Ld/j;->w:Ld/j;

    if-eqz v0, :cond_1

    iget v0, p0, Ld/j;->x:I

    const/16 v1, 0x400

    and-int/2addr v0, v1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    new-instance v0, Ld/l$a;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, ""

    invoke-direct {v0, v1, v4, v3}, Ld/l$a;-><init>(ILjava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ld/j;->d1(Ld/l$a;)V

    :cond_0
    iget-object v0, p0, Ld/j;->w:Ld/j;

    invoke-virtual {v0}, Ld/j;->close()V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/j;->w:Ld/j;

    iput v2, p0, Ld/j;->x:I

    :cond_1
    return-void
.end method


# virtual methods
.method protected final C0()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/j;->q:Z

    return-void
.end method

.method public final K0(Ljava/lang/String;)Z
    .locals 7

    iget-boolean v0, p0, Ld/j;->p:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfd

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    invoke-direct {p0, v1, v1}, Ld/j;->e1(IZ)Z

    move-result v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p1}, Ld/j$b;->a(Ljava/lang/String;)Ld/j$b;

    move-result-object v0

    invoke-virtual {v0}, Ld/j$b;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ld/j$b;->b()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v2}, Ld/j;->M0(Ljava/lang/String;)Ld/n/j/b;

    move-result-object v2

    if-eqz v2, :cond_d

    iget-boolean v3, v2, Ld/n/j/b;->b:Z

    if-nez v3, :cond_2

    goto/16 :goto_3

    :cond_2
    sget-object v3, Ld/n/j/b;->d:Ld/n/j/b;

    invoke-virtual {v3, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    new-instance v0, Ld/c$a;

    iget-object v1, p0, Ld/g;->e:Ld/f;

    invoke-direct {v0, p0, v1}, Ld/c$a;-><init>(Ld/j;Ld/f;)V

    invoke-virtual {p0, p1, v0}, Ld/m;->Z(Ljava/lang/String;Ld/c$a;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0, p1, p0}, Ld/m;->D(Ljava/lang/String;Ld/j;)V

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iput-object p1, v1, Ld/f;->f:Ljava/lang/String;

    goto :goto_0

    :cond_3
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v1, 0x30

    invoke-virtual {p1, v1}, Ld/s/c;->c(I)V

    :goto_0
    return v0

    :cond_4
    sget-object v3, Ld/n/j/b;->g:Ld/n/j/b;

    invoke-virtual {v3, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    sget-object v3, Ld/n/j/b;->h:Ld/n/j/b;

    invoke-virtual {v3, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    sget-object v3, Ld/n/j/b;->j:Ld/n/j/b;

    invoke-virtual {v3, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    goto/16 :goto_2

    :cond_5
    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-wide v3, v3, Ld/f;->c:J

    invoke-virtual {p0, v3, v4}, Ld/m;->C(J)Ld/n/d;

    move-result-object v3

    if-nez v3, :cond_6

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfe

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v1

    :cond_6
    sget-object v4, Ld/n/j/b;->f:Ld/n/j/b;

    invoke-virtual {v4, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/4 v5, 0x1

    const/4 v6, 0x0

    if-eqz v4, :cond_8

    new-instance v2, Ld/n/j/h/d;

    iget-object v4, p0, Ld/g;->e:Ld/f;

    invoke-direct {v2, v3, p0, v4}, Ld/n/j/h/d;-><init>(Ld/n/d;Ld/j;Ld/f;)V

    invoke-virtual {v2, v0}, Ld/n/j/h/d;->J0(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    invoke-virtual {v2}, Ld/n/j/h/d;->y0()V

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1}, Ld/s/c;->a()I

    move-result p1

    invoke-virtual {p0, v0, p1}, Ld/j;->T0(Ljava/lang/String;I)V

    return v1

    :cond_7
    iget-object v0, p0, Ld/g;->e:Ld/f;

    invoke-virtual {v2}, Ld/n/j/h/d;->I0()Ljava/lang/String;

    move-result-object v1

    :goto_1
    iput-object v1, v0, Ld/f;->f:Ljava/lang/String;

    invoke-direct {p0, p1, v2, v6}, Ld/j;->H0(Ljava/lang/String;Ld/g;Ld/p/b;)V

    return v5

    :cond_8
    sget-object v4, Ld/n/j/b;->e:Ld/n/j/b;

    invoke-virtual {v4, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a

    new-instance v2, Ld/n/j/e/c;

    iget-object v4, p0, Ld/g;->e:Ld/f;

    invoke-direct {v2, v3, p0, v4}, Ld/n/j/e/c;-><init>(Ld/n/d;Ld/j;Ld/f;)V

    invoke-virtual {v2, v0}, Ld/n/j/e/c;->J0(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_9

    invoke-virtual {v2}, Ld/n/j/h/d;->y0()V

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1}, Ld/s/c;->a()I

    move-result p1

    invoke-virtual {p0, v0, p1}, Ld/j;->T0(Ljava/lang/String;I)V

    return v1

    :cond_9
    iget-object v0, p0, Ld/g;->e:Ld/f;

    invoke-virtual {v2}, Ld/n/j/e/c;->I0()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_a
    sget-object v0, Ld/n/j/b;->i:Ld/n/j/b;

    invoke-virtual {v0, v2}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    new-instance p1, Ld/n/j/i/b;

    iget-object v0, p0, Ld/g;->e:Ld/f;

    invoke-direct {p1, v3, p0, v0}, Ld/n/j/i/b;-><init>(Ld/n/d;Ld/j;Ld/f;)V

    throw v6

    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_c
    :goto_2
    invoke-virtual {p0, p1}, Ld/j;->O0(Ljava/lang/String;)Z

    move-result p1

    return p1

    :cond_d
    :goto_3
    return v1
.end method

.method protected final L(Ld/p/b;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/j;->I0(Ld/p/b;)V

    return-void
.end method

.method final N0()Z
    .locals 2

    iget v0, p0, Ld/j;->o:I

    const v1, -0x45221351

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final O0(Ljava/lang/String;)Z
    .locals 13

    iget-boolean v0, p0, Ld/j;->p:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfd

    :goto_0
    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    invoke-direct {p0, v1, v1}, Ld/j;->e1(IZ)Z

    move-result v0

    if-nez v0, :cond_1

    return v1

    :cond_1
    invoke-static {p1}, Ld/j$b;->a(Ljava/lang/String;)Ld/j$b;

    move-result-object v0

    invoke-virtual {v0}, Ld/j$b;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ld/j$b;->b()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v2}, Ld/j;->M0(Ljava/lang/String;)Ld/n/j/b;

    move-result-object v3

    if-eqz v3, :cond_1d

    iget-boolean v4, v3, Ld/n/j/b;->b:Z

    if-nez v4, :cond_2

    goto/16 :goto_b

    :cond_2
    sget-object v4, Ld/n/j/b;->d:Ld/n/j/b;

    invoke-virtual {v4, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/16 v5, 0x8

    const/4 v6, 0x7

    const/4 v7, 0x5

    const/4 v8, -0x1

    const/4 v9, 0x2

    const/4 v10, 0x1

    if-eqz v4, :cond_f

    invoke-virtual {p0, p1}, Ld/m;->F(Ljava/lang/String;)Ld/c$a;

    move-result-object v0

    iget-object v2, v0, Ld/c$a;->a:Ld/j;

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget v3, v3, Ld/f;->a:I

    if-nez v2, :cond_3

    goto :goto_1

    :cond_3
    if-eqz v3, :cond_4

    iget-object v4, v0, Ld/c$a;->b:Ld/f;

    iget v4, v4, Ld/f;->b:I

    if-eqz v4, :cond_4

    add-int/2addr v3, v4

    goto :goto_1

    :cond_4
    move v3, v1

    :goto_1
    iget-object v4, p0, Ld/g;->e:Ld/f;

    iget v4, v4, Ld/f;->b:I

    if-nez v2, :cond_5

    goto :goto_2

    :cond_5
    if-eqz v4, :cond_6

    iget-object v11, v0, Ld/c$a;->b:Ld/f;

    iget v11, v11, Ld/f;->a:I

    if-eqz v11, :cond_6

    add-int/2addr v4, v11

    goto :goto_2

    :cond_6
    move v4, v1

    :goto_2
    new-array v11, v9, [Ld/m;

    aput-object p0, v11, v1

    if-nez v2, :cond_7

    move-object v2, p0

    :cond_7
    aput-object v2, v11, v10

    iget-object v2, p0, Ld/g;->e:Ld/f;

    iget-boolean v12, v2, Ld/f;->K:Z

    if-eqz v12, :cond_9

    iget v2, v2, Ld/f;->j:I

    if-eq v2, v7, :cond_8

    if-eq v2, v6, :cond_8

    if-eq v2, v5, :cond_8

    if-eq v2, v10, :cond_8

    if-ne v2, v9, :cond_9

    :cond_8
    move v2, v10

    goto :goto_3

    :cond_9
    move v2, v1

    :goto_3
    new-array v5, v9, [I

    if-eqz v2, :cond_a

    move v3, v8

    :cond_a
    aput v3, v5, v1

    if-eqz v2, :cond_b

    goto :goto_4

    :cond_b
    move v8, v4

    :goto_4
    aput v8, v5, v10

    new-array v3, v9, [Z

    aput-boolean v2, v3, v1

    aput-boolean v2, v3, v10

    invoke-static {v11, v5, v3}, Ld/p/b;->G0([Ld/m;[I[Z)[Ld/p/b;

    move-result-object v2

    aget-object v3, v2, v1

    invoke-direct {p0, v3}, Ld/j;->I0(Ld/p/b;)V

    iget-object v3, v0, Ld/c$a;->a:Ld/j;

    const/16 v4, 0x40

    if-nez v3, :cond_c

    new-instance v0, Ld/e;

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-byte v3, v3, Ld/f;->d:B

    invoke-direct {v0, v3}, Ld/e;-><init>(I)V

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-object v5, v3, Ld/f;->e:[B

    iget-byte v3, v3, Ld/f;->d:B

    invoke-virtual {v0, v5, v1, v3}, Ld/e;->v([BII)Ld/e;

    invoke-virtual {v0, v4}, Ld/e;->y(I)V

    aget-object v3, v2, v1

    invoke-virtual {v3, v0}, Ld/p/b;->Q0(Ld/e;)Z

    aget-object v0, v2, v1

    invoke-virtual {v0}, Ld/p/b;->B0()V

    new-instance v0, Ld/c$a;

    iget-object v3, p0, Ld/g;->e:Ld/f;

    invoke-direct {v0, p0, v3}, Ld/c$a;-><init>(Ld/j;Ld/f;)V

    invoke-virtual {p0, p1, v0, v2}, Ld/m;->H(Ljava/lang/String;Ld/c$a;[Ld/p/b;)V

    goto :goto_5

    :cond_c
    iget-object v3, v0, Ld/c$a;->b:Ld/f;

    iget-boolean v3, v3, Ld/f;->t:Z

    if-eqz v3, :cond_d

    new-instance v3, Ld/e;

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-byte v5, v5, Ld/f;->d:B

    invoke-direct {v3, v5}, Ld/e;-><init>(I)V

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-object v6, v5, Ld/f;->e:[B

    iget-byte v5, v5, Ld/f;->d:B

    invoke-virtual {v3, v6, v1, v5}, Ld/e;->v([BII)Ld/e;

    invoke-virtual {v3, v4}, Ld/e;->y(I)V

    aget-object v5, v2, v1

    invoke-virtual {v5, v3}, Ld/p/b;->Q0(Ld/e;)Z

    aget-object v3, v2, v1

    invoke-virtual {v3}, Ld/p/b;->B0()V

    :cond_d
    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-boolean v3, v3, Ld/f;->t:Z

    if-eqz v3, :cond_e

    new-instance v3, Ld/e;

    iget-object v5, v0, Ld/c$a;->b:Ld/f;

    iget-byte v5, v5, Ld/f;->d:B

    invoke-direct {v3, v5}, Ld/e;-><init>(I)V

    iget-object v5, v0, Ld/c$a;->b:Ld/f;

    iget-object v6, v5, Ld/f;->e:[B

    iget-byte v5, v5, Ld/f;->d:B

    invoke-virtual {v3, v6, v1, v5}, Ld/e;->v([BII)Ld/e;

    invoke-virtual {v3, v4}, Ld/e;->y(I)V

    aget-object v4, v2, v10

    invoke-virtual {v4, v3}, Ld/p/b;->Q0(Ld/e;)Z

    aget-object v3, v2, v10

    invoke-virtual {v3}, Ld/p/b;->B0()V

    :cond_e
    iget-object v0, v0, Ld/c$a;->a:Ld/j;

    aget-object v3, v2, v10

    invoke-virtual {p0, v0, v3, v1}, Ld/m;->f0(Ld/g;Ld/p/b;Z)V

    :goto_5
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iput-object p1, v0, Ld/f;->f:Ljava/lang/String;

    iget-object v0, p0, Ld/j;->n:Ld/s/d;

    aget-object v1, v2, v1

    invoke-virtual {v0, p1, v1}, Ld/s/d;->e(Ljava/lang/Comparable;Ljava/lang/Object;)Z

    return v10

    :cond_f
    iget-object v4, p0, Ld/g;->e:Ld/f;

    iget v4, v4, Ld/f;->j:I

    if-eq v4, v7, :cond_10

    if-eq v4, v9, :cond_10

    const/4 v11, 0x3

    if-eq v4, v11, :cond_10

    move v4, v1

    goto :goto_6

    :cond_10
    move v4, v10

    :goto_6
    if-eqz v4, :cond_11

    iget-object v4, p0, Ld/j;->m:Ld/s/d;

    invoke-virtual {v4, p1}, Ld/s/d;->d(Ljava/lang/Comparable;)Z

    move-result v4

    if-eqz v4, :cond_11

    return v10

    :cond_11
    iget-object v4, p0, Ld/g;->e:Ld/f;

    iget-wide v11, v4, Ld/f;->c:J

    invoke-virtual {p0, v11, v12}, Ld/m;->C(J)Ld/n/d;

    move-result-object v4

    if-nez v4, :cond_12

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const v0, 0x9523dfe

    goto/16 :goto_0

    :cond_12
    new-instance v11, Ld/n/j/a;

    invoke-direct {v11, v2, v0}, Ld/n/j/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v0, Ld/n/j/b;->f:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    sget-object v0, Ld/n/j/b;->e:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    sget-object v0, Ld/n/j/b;->i:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_14

    :cond_13
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->q:Z

    invoke-virtual {v11, v0}, Ld/n/j/a;->e(Z)Ld/n/j/a$a;

    :cond_14
    sget-object v0, Ld/n/j/b;->g:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_15

    sget-object v2, Ld/n/j/b;->h:Ld/n/j/b;

    invoke-virtual {v2, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    :cond_15
    iget-object v2, p0, Ld/g;->e:Ld/f;

    invoke-static {v4, v10, p0, v2, v11}, Ld/r/d;->e(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;

    move-result-object v2

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    sget-object v0, Ld/n/j/b;->h:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    sget-object v0, Ld/n/j/b;->j:Ld/n/j/b;

    invoke-virtual {v0, v3}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    move v0, v1

    goto :goto_7

    :cond_16
    move v0, v10

    :goto_7
    const/4 v3, 0x0

    iget-object v4, p0, Ld/g;->e:Ld/f;

    iget-boolean v12, v4, Ld/f;->r:Z

    if-nez v12, :cond_17

    if-eqz v0, :cond_1c

    :cond_17
    new-array v3, v9, [Ld/m;

    aput-object p0, v3, v1

    aput-object v2, v3, v10

    iget-boolean v12, v4, Ld/f;->K:Z

    if-eqz v12, :cond_19

    iget v12, v4, Ld/f;->j:I

    if-eq v12, v7, :cond_18

    if-eq v12, v6, :cond_18

    if-eq v12, v5, :cond_18

    if-eq v12, v10, :cond_18

    if-ne v12, v9, :cond_19

    :cond_18
    move v5, v10

    goto :goto_8

    :cond_19
    move v5, v1

    :goto_8
    new-array v6, v9, [I

    if-eqz v5, :cond_1a

    move v7, v8

    goto :goto_9

    :cond_1a
    iget v7, v4, Ld/f;->a:I

    :goto_9
    aput v7, v6, v1

    if-eqz v5, :cond_1b

    goto :goto_a

    :cond_1b
    iget v8, v4, Ld/f;->b:I

    :goto_a
    aput v8, v6, v10

    new-array v4, v9, [Z

    aput-boolean v5, v4, v1

    aput-boolean v5, v4, v10

    invoke-static {v3, v6, v4}, Ld/p/b;->G0([Ld/m;[I[Z)[Ld/p/b;

    move-result-object v3

    aget-object v4, v3, v1

    invoke-direct {p0, v4, v0}, Ld/j;->J0(Ld/p/b;Z)V

    aget-object v0, v3, v1

    aget-object v1, v3, v10

    invoke-virtual {v2, v1}, Ld/n/f;->J0(Ld/p/b;)V

    move-object v3, v0

    :cond_1c
    iget-object v0, p0, Ld/g;->e:Ld/f;

    invoke-virtual {v11}, Ld/n/j/a;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Ld/f;->f:Ljava/lang/String;

    invoke-direct {p0, p1, v2, v3}, Ld/j;->H0(Ljava/lang/String;Ld/g;Ld/p/b;)V

    return v10

    :cond_1d
    :goto_b
    return v1
.end method

.method public final P0()I
    .locals 1

    iget-object v0, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v0}, Ld/s/c;->a()I

    move-result v0

    return v0
.end method

.method public final R0(Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const/16 v0, 0x40

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final S0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    .locals 1

    const/16 v0, 0x20

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final T0(Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const/16 v0, 0x10

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final U0(Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const/16 v0, 0x100

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method protected final V()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V

    invoke-direct {p0}, Ld/j;->j1()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/j;->p:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw v0
.end method

.method public final V0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    .locals 1

    const/16 v0, 0x80

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method protected final W(I)V
    .locals 3

    invoke-virtual {p0, p0}, Ld/m;->w0(Ld/j;)V

    iget-object v0, p0, Ld/j;->s:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v0, p0, Ld/j;->s:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    invoke-virtual {p0, v0}, Ld/g;->D0(I)V

    invoke-super {p0, p1}, Ld/g;->W(I)V

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ld/p/b;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ld/p/b;->P0(Z)V

    goto :goto_0
.end method

.method public final W0(Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const/4 v0, 0x2

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final X0(Ljava/lang/String;I)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V

    iget v0, p0, Ld/j;->x:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x4

    and-int/2addr v0, v1

    if-nez v0, :cond_0

    :goto_0
    iget-object p1, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {p1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    return-void

    :cond_0
    :try_start_1
    new-instance v0, Ld/l$a;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-direct {v0, v1, p1, p2}, Ld/l$a;-><init>(ILjava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Ld/j;->d1(Ld/l$a;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object p2, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {p2}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw p1
.end method

.method public final Y0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final Z0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    .locals 1

    const/16 v0, 0x200

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final a(Ld/p/b;)V
    .locals 1

    invoke-virtual {p0, p1}, Ld/j;->m1(Ld/p/b;)V

    iget-object v0, p0, Ld/j;->n:Ld/s/d;

    invoke-virtual {v0, p1}, Ld/s/d;->h(Ljava/lang/Object;)Z

    iget-object v0, p0, Ld/j;->s:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    invoke-virtual {p0}, Ld/g;->A0()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ld/g;->G0()V

    :cond_0
    return-void
.end method

.method public final a1(Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const v0, 0x8000

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method public final b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final b1(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V
    .locals 1

    const/16 v0, 0x8

    invoke-direct {p0, p1, p2, v0}, Ld/j;->Q0(Ljava/lang/String;Ljava/lang/Object;I)V

    return-void
.end method

.method final c1()Ld/d;
    .locals 1

    iget-object v0, p0, Ld/j;->r:Ld/d;

    return-object v0
.end method

.method public final close()V
    .locals 1

    const v0, -0x21524111

    iput v0, p0, Ld/j;->o:I

    invoke-virtual {p0, p0}, Ld/m;->p0(Ld/j;)V

    return-void
.end method

.method protected final d1(Ld/l$a;)V
    .locals 1

    iget-object v0, p0, Ld/j;->w:Ld/j;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1, v0}, Ld/l$a;->a(Ld/j;)Z

    return-void
.end method

.method public final e()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Ld/j;->e1(IZ)Z

    invoke-direct {p0}, Ld/j;->L0()V

    return-void
.end method

.method public final f1(Ld/e;I)Z
    .locals 8

    iget-boolean v0, p0, Ld/j;->p:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const p2, 0x9523dfd

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    if-eqz p1, :cond_d

    invoke-virtual {p1}, Ld/e;->b()Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_2

    :cond_1
    const/4 v0, 0x1

    invoke-direct {p0, v1, v0}, Ld/j;->e1(IZ)Z

    move-result v2

    if-nez v2, :cond_2

    return v1

    :cond_2
    invoke-virtual {p1, v0}, Ld/e;->w(I)V

    and-int/lit8 v2, p2, 0x2

    if-lez v2, :cond_3

    invoke-virtual {p1, v0}, Ld/e;->y(I)V

    :cond_3
    invoke-virtual {p1}, Ld/e;->x()V

    invoke-virtual {p0, p1}, Ld/j;->o1(Ld/e;)Z

    move-result v2

    if-eqz v2, :cond_4

    return v0

    :cond_4
    iget-object v2, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v2}, Ld/s/c;->a()I

    move-result v2

    const/16 v3, 0x23

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    and-int/2addr p2, v0

    if-gtz p2, :cond_c

    iget-object p2, p0, Ld/g;->e:Ld/f;

    iget p2, p2, Ld/f;->p:I

    if-nez p2, :cond_6

    goto :goto_1

    :cond_6
    if-gez p2, :cond_7

    const-wide/16 v4, 0x0

    goto :goto_0

    :cond_7
    invoke-static {}, Ld/s/b;->a()J

    move-result-wide v4

    int-to-long v6, p2

    add-long/2addr v4, v6

    :cond_8
    :goto_0
    invoke-direct {p0, p2, v1}, Ld/j;->e1(IZ)Z

    move-result v2

    if-nez v2, :cond_9

    return v1

    :cond_9
    invoke-virtual {p0, p1}, Ld/j;->o1(Ld/e;)Z

    move-result v2

    if-eqz v2, :cond_a

    return v0

    :cond_a
    iget-object v2, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v2}, Ld/s/c;->a()I

    move-result v2

    if-eq v2, v3, :cond_b

    return v1

    :cond_b
    if-lez p2, :cond_8

    invoke-static {}, Ld/s/b;->a()J

    move-result-wide v6

    sub-long v6, v4, v6

    long-to-int p2, v6

    if-gtz p2, :cond_8

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p1, v3}, Ld/s/c;->c(I)V

    :cond_c
    :goto_1
    return v1

    :cond_d
    :goto_2
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0xe

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v1
.end method

.method public final g1(ILjava/lang/Object;)Z
    .locals 4

    iget-boolean v0, p0, Ld/j;->p:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const p2, 0x9523dfd

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    return v1

    :cond_0
    invoke-virtual {p0, p1, p2}, Ld/j;->p1(ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v2, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v2}, Ld/s/c;->a()I

    move-result v2

    const/16 v3, 0x16

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ld/g;->e:Ld/f;

    invoke-virtual {v0, p1, p2}, Ld/f;->g(ILjava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p2, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {p2, v1}, Ld/s/c;->c(I)V

    :cond_2
    return p1

    :cond_3
    :goto_0
    return v0
.end method

.method public final h(I)V
    .locals 0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method final h1(Ld/q/b;)V
    .locals 1

    iput-object p1, p0, Ld/j;->t:Ld/q/b;

    iget-object p1, p0, Ld/j;->r:Ld/d;

    invoke-virtual {p1}, Ld/d;->a()Ljava/nio/channels/SelectableChannel;

    move-result-object p1

    iget-object v0, p0, Ld/j;->t:Ld/q/b;

    invoke-virtual {v0, p1, p0}, Ld/q/b;->h(Ljava/nio/channels/SelectableChannel;Ld/q/a;)Ld/q/b$a;

    move-result-object p1

    iput-object p1, p0, Ld/j;->u:Ld/q/b$a;

    iget-object v0, p0, Ld/j;->t:Ld/q/b;

    invoke-virtual {v0, p1}, Ld/q/b;->r(Ld/q/b$a;)V

    invoke-virtual {p0}, Ld/g;->F0()V

    invoke-direct {p0}, Ld/j;->L0()V

    return-void
.end method

.method final i1()V
    .locals 0

    invoke-virtual {p0}, Ld/m;->r0()V

    return-void
.end method

.method protected abstract k1(Ld/p/b;Z)V
.end method

.method protected l1(Ld/p/b;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Must override"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final m(Ld/p/b;)V
    .locals 0

    invoke-virtual {p0, p1}, Ld/j;->q1(Ld/p/b;)V

    return-void
.end method

.method protected abstract m1(Ld/p/b;)V
.end method

.method protected n1(Ld/p/b;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Must Override"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected o1(Ld/e;)Z
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Must Override"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected p1(ILjava/lang/Object;)Z
    .locals 0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method public final q()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method protected q1(Ld/p/b;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Must Override"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final s()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final t(Ld/p/b;)V
    .locals 0

    invoke-virtual {p0, p1}, Ld/j;->n1(Ld/p/b;)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->J:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final v(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->r:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ld/p/b;->P0(Z)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0, p1}, Ld/j;->l1(Ld/p/b;)V

    :goto_0
    return-void
.end method

.method protected y0()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    iget-object v0, p0, Ld/j;->r:Ld/d;

    invoke-virtual {v0}, Ld/d;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :try_start_2
    invoke-direct {p0}, Ld/j;->j1()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object v0, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    return-void

    :catchall_0
    move-exception v0

    iget-object v1, p0, Ld/j;->z:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw v0
.end method
