.class public Ld/n/f;
.super Ld/g;
.source ""

# interfaces
.implements Ld/p/b$a;
.implements Ld/q/a;


# static fields
.field private static synthetic y:[I

.field private static synthetic z:[I


# instance fields
.field private final m:Z

.field private n:Ld/p/b;

.field private o:Ld/p/b;

.field private final p:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ld/p/b;",
            ">;"
        }
    .end annotation
.end field

.field private q:Z

.field private r:Z

.field private s:Ld/n/b;

.field protected final t:Ld/j;

.field private final u:Ld/n/d;

.field private v:Z

.field private final w:Ld/n/j/a;

.field private final x:Ld/n/c;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)V
    .locals 0

    invoke-direct {p0, p1, p4}, Ld/g;-><init>(Ld/n/d;Ld/f;)V

    new-instance p4, Ld/n/c;

    invoke-direct {p4, p1, p0}, Ld/n/c;-><init>(Ld/n/d;Ld/q/a;)V

    iput-object p4, p0, Ld/n/f;->x:Ld/n/c;

    iput-boolean p2, p0, Ld/n/f;->m:Z

    const/4 p2, 0x0

    iput-object p2, p0, Ld/n/f;->n:Ld/p/b;

    iput-object p2, p0, Ld/n/f;->o:Ld/p/b;

    const/4 p4, 0x0

    iput-boolean p4, p0, Ld/n/f;->q:Z

    iput-boolean p4, p0, Ld/n/f;->r:Z

    iput-object p2, p0, Ld/n/f;->s:Ld/n/b;

    iput-object p3, p0, Ld/n/f;->t:Ld/j;

    iput-object p1, p0, Ld/n/f;->u:Ld/n/d;

    iput-boolean p4, p0, Ld/n/f;->v:Z

    iput-object p5, p0, Ld/n/f;->w:Ld/n/j/a;

    new-instance p1, Ljava/util/HashSet;

    invoke-direct {p1}, Ljava/util/HashSet;-><init>()V

    iput-object p1, p0, Ld/n/f;->p:Ljava/util/Set;

    return-void
.end method

.method static synthetic H0()[I
    .locals 3

    sget-object v0, Ld/n/f;->y:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/g$b;->values()[Ld/n/g$b;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/g$b;->c:Ld/n/g$b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/g$b;->b:Ld/n/g$b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/g$b;->d:Ld/n/g$b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    sput-object v0, Ld/n/f;->y:[I

    return-object v0
.end method

.method static synthetic I0()[I
    .locals 3

    sget-object v0, Ld/n/f;->z:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/j/b;->values()[Ld/n/j/b;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/j/b;->h:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/j/b;->d:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/j/b;->e:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/j/b;->j:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x7

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/j/b;->g:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/j/b;->f:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    sget-object v1, Ld/n/j/b;->i:Ld/n/j/b;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    sput-object v0, Ld/n/f;->z:[I

    return-object v0
.end method

.method private K0()V
    .locals 1

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->J0()V

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->B0()V

    :cond_0
    iget-boolean v0, p0, Ld/n/f;->q:Z

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Ld/n/f;->O0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_0

    :goto_0
    return-void
.end method

.method private R0()V
    .locals 3

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-boolean v0, v0, Ld/f;->r:Z

    if-nez v0, :cond_0

    sget-object v0, Ld/n/j/b;->g:Ld/n/j/b;

    iget-object v1, p0, Ld/n/f;->w:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->d()Ld/n/j/b;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Ld/n/j/b;->h:Ld/n/j/b;

    iget-object v1, p0, Ld/n/f;->w:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->d()Ld/n/j/b;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Ld/n/j/b;->j:Ld/n/j/b;

    iget-object v1, p0, Ld/n/f;->w:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->d()Ld/n/j/b;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->E0()V

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ld/p/b;->P0(Z)V

    iget-object v0, p0, Ld/n/f;->p:Ljava/util/Set;

    iget-object v1, p0, Ld/n/f;->n:Ld/p/b;

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/f;->n:Ld/p/b;

    :cond_0
    invoke-virtual {p0}, Ld/n/f;->S0()V

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget v0, v0, Ld/f;->l:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Ld/n/f;->T0(Z)V

    :cond_1
    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v0, :cond_3

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget v1, v1, Ld/f;->j:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_2

    const/16 v2, 0xa

    if-ne v1, v2, :cond_3

    :cond_2
    invoke-virtual {v0}, Ld/p/b;->E0()V

    :cond_3
    return-void
.end method

.method private T0(Z)V
    .locals 10

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-wide v0, v0, Ld/f;->c:J

    invoke-virtual {p0, v0, v1}, Ld/m;->C(J)Ld/n/d;

    move-result-object v3

    iget-object v0, p0, Ld/n/f;->w:Ld/n/j/a;

    invoke-virtual {v0}, Ld/n/j/a;->d()Ld/n/j/b;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x2b

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    return-void

    :cond_0
    invoke-static {}, Ld/n/f;->I0()[I

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    move-result v2

    aget v1, v1, v2

    const/16 v2, 0x9

    const/4 v4, 0x1

    const/4 v9, 0x0

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_3

    :pswitch_0
    iget-object p1, p0, Ld/g;->e:Ld/f;

    iget v0, p1, Ld/f;->j:I

    if-eq v0, v4, :cond_2

    if-ne v0, v2, :cond_1

    goto :goto_0

    :cond_1
    new-instance v0, Ld/n/j/f/a;

    invoke-direct {v0, v3, p1}, Ld/n/j/f/a;-><init>(Ld/n/d;Ld/f;)V

    throw v9

    :cond_2
    :goto_0
    new-instance v0, Ld/n/j/f/a;

    invoke-direct {v0, v3, p1}, Ld/n/j/f/a;-><init>(Ld/n/d;Ld/f;)V

    throw v9

    :pswitch_1
    new-instance v2, Ld/n/j/i/a;

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-object v6, p0, Ld/n/f;->w:Ld/n/j/a;

    move-object v4, p0

    move v7, p1

    invoke-direct/range {v2 .. v7}, Ld/n/j/i/a;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V

    throw v9

    :pswitch_2
    sget-object p1, Ld/n/j/b;->h:Ld/n/j/b;

    iget-object p1, p0, Ld/g;->e:Ld/f;

    iget v0, p1, Ld/f;->j:I

    if-eq v0, v4, :cond_4

    if-ne v0, v2, :cond_3

    goto :goto_1

    :cond_3
    new-instance v0, Ld/n/j/g/a;

    invoke-direct {v0, v3, p1}, Ld/n/j/g/a;-><init>(Ld/n/d;Ld/f;)V

    throw v9

    :cond_4
    :goto_1
    new-instance v0, Ld/n/j/g/b;

    invoke-direct {v0, v3, p1}, Ld/n/j/g/b;-><init>(Ld/n/d;Ld/f;)V

    throw v9

    :pswitch_3
    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-object v0, v0, Ld/f;->v:Ljava/lang/String;

    if-nez v0, :cond_5

    new-instance v0, Ld/n/j/h/c;

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-object v6, p0, Ld/n/f;->w:Ld/n/j/a;

    move-object v2, v0

    move-object v4, p0

    move v7, p1

    invoke-direct/range {v2 .. v7}, Ld/n/j/h/c;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V

    goto :goto_2

    :cond_5
    new-instance v7, Ld/n/j/a;

    sget-object v0, Ld/n/j/b;->f:Ld/n/j/b;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Ld/g;->e:Ld/f;

    iget-object v1, v1, Ld/f;->v:Ljava/lang/String;

    invoke-direct {v7, v0, v1}, Ld/n/j/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v2, Ld/n/j/h/a;

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-object v6, p0, Ld/n/f;->w:Ld/n/j/a;

    move-object v4, p0

    move v8, p1

    invoke-direct/range {v2 .. v8}, Ld/n/j/h/a;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Ld/n/j/a;Z)V

    throw v9

    :pswitch_4
    new-instance v0, Ld/n/j/e/b;

    iget-object v5, p0, Ld/g;->e:Ld/f;

    iget-object v6, p0, Ld/n/f;->w:Ld/n/j/a;

    move-object v2, v0

    move-object v4, p0

    move v7, p1

    invoke-direct/range {v2 .. v7}, Ld/n/j/e/b;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V

    :goto_2
    invoke-virtual {p0, v0}, Ld/g;->B0(Ld/g;)V

    :goto_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public J0(Ld/p/b;)V
    .locals 0

    iput-object p1, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {p1, p0}, Ld/p/b;->K0(Ld/p/b$a;)V

    return-void
.end method

.method protected K(Ld/n/b;)V
    .locals 9

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-nez v0, :cond_4

    invoke-virtual {p0}, Ld/g;->A0()Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x2

    new-array v1, v0, [Ld/m;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    iget-object v3, p0, Ld/n/f;->t:Ld/j;

    const/4 v4, 0x1

    aput-object v3, v1, v4

    iget-object v3, p0, Ld/g;->e:Ld/f;

    iget-boolean v5, v3, Ld/f;->K:Z

    if-eqz v5, :cond_1

    iget v5, v3, Ld/f;->j:I

    const/4 v6, 0x5

    if-eq v5, v6, :cond_0

    const/4 v6, 0x7

    if-eq v5, v6, :cond_0

    const/16 v6, 0x8

    if-eq v5, v6, :cond_0

    if-eq v5, v4, :cond_0

    if-ne v5, v0, :cond_1

    :cond_0
    move v5, v4

    goto :goto_0

    :cond_1
    move v5, v2

    :goto_0
    new-array v6, v0, [I

    const/4 v7, -0x1

    if-eqz v5, :cond_2

    move v8, v7

    goto :goto_1

    :cond_2
    iget v8, v3, Ld/f;->b:I

    :goto_1
    aput v8, v6, v2

    if-eqz v5, :cond_3

    goto :goto_2

    :cond_3
    iget v7, v3, Ld/f;->a:I

    :goto_2
    aput v7, v6, v4

    new-array v0, v0, [Z

    aput-boolean v5, v0, v2

    aput-boolean v5, v0, v4

    invoke-static {v1, v6, v0}, Ld/p/b;->G0([Ld/m;[I[Z)[Ld/p/b;

    move-result-object v0

    aget-object v1, v0, v2

    invoke-virtual {v1, p0}, Ld/p/b;->K0(Ld/p/b$a;)V

    aget-object v1, v0, v2

    iput-object v1, p0, Ld/n/f;->n:Ld/p/b;

    iget-object v1, p0, Ld/n/f;->t:Ld/j;

    aget-object v0, v0, v4

    invoke-virtual {p0, v1, v0}, Ld/m;->e0(Ld/g;Ld/p/b;)V

    :cond_4
    iput-object p1, p0, Ld/n/f;->s:Ld/n/b;

    iget-object v0, p0, Ld/n/f;->u:Ld/n/d;

    invoke-interface {p1, v0, p0}, Ld/n/b;->c(Ld/n/d;Ld/n/f;)V

    return-void
.end method

.method public L0(Ld/n/g$b;)V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/f;->s:Ld/n/b;

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v0, :cond_0

    invoke-direct {p0}, Ld/n/f;->K0()V

    :cond_0
    invoke-static {}, Ld/n/f;->H0()[I

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_2

    const/4 v0, 0x2

    if-eq p1, v0, :cond_1

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    goto :goto_0

    :cond_1
    iget-boolean p1, p0, Ld/n/f;->m:Z

    if-eqz p1, :cond_2

    invoke-direct {p0}, Ld/n/f;->R0()V

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Ld/g;->F0()V

    :goto_0
    iget-object p1, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ld/p/b;->y0()Z

    :cond_3
    iget-object p1, p0, Ld/n/f;->o:Ld/p/b;

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ld/p/b;->y0()Z

    :cond_4
    return-void
.end method

.method public M0()V
    .locals 1

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ld/p/b;->B0()V

    :cond_0
    return-void
.end method

.method public N0()Ld/j;
    .locals 1

    iget-object v0, p0, Ld/n/f;->t:Ld/j;

    return-object v0
.end method

.method protected O0()Ld/e;
    .locals 2

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    invoke-virtual {v0}, Ld/p/b;->I0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    invoke-virtual {v0}, Ld/e;->j()Z

    move-result v1

    iput-boolean v1, p0, Ld/n/f;->q:Z

    return-object v0
.end method

.method protected P0(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x23

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method public Q0()Ld/e;
    .locals 3

    iget-object v0, p0, Ld/n/f;->o:Ld/p/b;

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/g;->l:Ld/s/c;

    const/16 v1, 0x39

    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V

    const/4 v0, 0x0

    return-object v0

    :cond_0
    invoke-virtual {v0}, Ld/p/b;->I0()Ld/e;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v1, p0, Ld/g;->l:Ld/s/c;

    const/16 v2, 0x23

    invoke-virtual {v1, v2}, Ld/s/c;->c(I)V

    :cond_1
    return-object v0
.end method

.method protected R()V
    .locals 1

    iget-object v0, p0, Ld/n/f;->x:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->f()V

    iget-boolean v0, p0, Ld/n/f;->m:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Ld/n/f;->T0(Z)V

    :cond_0
    return-void
.end method

.method protected S0()V
    .locals 0

    return-void
.end method

.method public U0(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/n/f;->o:Ld/p/b;

    if-nez v0, :cond_0

    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0x39

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Ld/p/b;->Q0(Ld/e;)Z

    invoke-virtual {p1}, Ld/e;->j()Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Ld/n/f;->o:Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->B0()V

    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method public V0()I
    .locals 6

    const-string v0, "inproc://zeromq.zap.01"

    invoke-virtual {p0, v0}, Ld/m;->F(Ljava/lang/String;)Ld/c$a;

    move-result-object v0

    iget-object v1, v0, Ld/c$a;->a:Ld/j;

    const/16 v2, 0x3d

    if-nez v1, :cond_0

    :goto_0
    iget-object v0, p0, Ld/g;->l:Ld/s/c;

    invoke-virtual {v0, v2}, Ld/s/c;->c(I)V

    return v2

    :cond_0
    iget-object v3, v0, Ld/c$a;->b:Ld/f;

    iget v3, v3, Ld/f;->j:I

    const/4 v4, 0x4

    if-eq v3, v4, :cond_1

    const/4 v4, 0x6

    if-eq v3, v4, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x2

    new-array v3, v2, [Ld/m;

    const/4 v4, 0x0

    aput-object p0, v3, v4

    const/4 v5, 0x1

    aput-object v1, v3, v5

    new-array v1, v2, [I

    new-array v2, v2, [Z

    invoke-static {v3, v1, v2}, Ld/p/b;->G0([Ld/m;[I[Z)[Ld/p/b;

    move-result-object v1

    aget-object v2, v1, v4

    iput-object v2, p0, Ld/n/f;->o:Ld/p/b;

    invoke-virtual {v2}, Ld/p/b;->N0()V

    iget-object v2, p0, Ld/n/f;->o:Ld/p/b;

    invoke-virtual {v2, p0}, Ld/p/b;->K0(Ld/p/b$a;)V

    iget-object v2, v0, Ld/c$a;->a:Ld/j;

    aget-object v1, v1, v5

    invoke-virtual {p0, v2, v1, v4}, Ld/m;->f0(Ld/g;Ld/p/b;Z)V

    iget-object v0, v0, Ld/c$a;->b:Ld/f;

    iget-boolean v0, v0, Ld/f;->t:Z

    if-eqz v0, :cond_2

    new-instance v0, Ld/e;

    invoke-direct {v0}, Ld/e;-><init>()V

    const/16 v1, 0x40

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    iget-object v1, p0, Ld/n/f;->o:Ld/p/b;

    invoke-virtual {v1, v0}, Ld/p/b;->Q0(Ld/e;)Z

    iget-object v0, p0, Ld/n/f;->o:Ld/p/b;

    invoke-virtual {v0}, Ld/p/b;->B0()V

    :cond_2
    return v4
.end method

.method protected W(I)V
    .locals 6

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/f;->o:Ld/p/b;

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/f;->p:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-super {p0, v1}, Ld/g;->W(I)V

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/f;->r:Z

    iget-object v2, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz v2, :cond_3

    if-lez p1, :cond_1

    iget-object v2, p0, Ld/n/f;->x:Ld/n/c;

    int-to-long v3, p1

    const/16 v5, 0x20

    invoke-virtual {v2, v3, v4, v5}, Ld/n/c;->c(JI)V

    iput-boolean v0, p0, Ld/n/f;->v:Z

    :cond_1
    iget-object v2, p0, Ld/n/f;->n:Ld/p/b;

    if-eqz p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, v1

    :goto_0
    invoke-virtual {v2, v0}, Ld/p/b;->P0(Z)V

    iget-object p1, p0, Ld/n/f;->s:Ld/n/b;

    if-nez p1, :cond_3

    iget-object p1, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {p1}, Ld/p/b;->y0()Z

    :cond_3
    iget-object p1, p0, Ld/n/f;->o:Ld/p/b;

    if-eqz p1, :cond_4

    invoke-virtual {p1, v1}, Ld/p/b;->P0(Z)V

    :cond_4
    return-void
.end method

.method protected W0()Z
    .locals 3

    iget-object v0, p0, Ld/g;->e:Ld/f;

    iget-object v1, v0, Ld/f;->B:Ld/n/i/b;

    sget-object v2, Ld/n/i/b;->b:Ld/n/i/b;

    if-ne v1, v2, :cond_1

    iget-object v0, v0, Ld/f;->D:Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    return v0

    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method public a(Ld/p/b;)V
    .locals 3

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-ne v0, p1, :cond_0

    iput-object v2, p0, Ld/n/f;->n:Ld/p/b;

    iget-boolean p1, p0, Ld/n/f;->v:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Ld/n/f;->x:Ld/n/c;

    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ld/n/c;->d(I)V

    iput-boolean v1, p0, Ld/n/f;->v:Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Ld/n/f;->o:Ld/p/b;

    if-ne v0, p1, :cond_1

    iput-object v2, p0, Ld/n/f;->o:Ld/p/b;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Ld/n/f;->p:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    invoke-virtual {p0}, Ld/g;->A0()Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Ld/g;->e:Ld/f;

    iget-boolean p1, p1, Ld/f;->u:Z

    if-eqz p1, :cond_3

    iget-object p1, p0, Ld/n/f;->s:Ld/n/b;

    if-eqz p1, :cond_3

    invoke-interface {p1}, Ld/n/b;->d()V

    iput-object v2, p0, Ld/n/f;->s:Ld/n/b;

    :cond_3
    iget-boolean p1, p0, Ld/n/f;->r:Z

    if-eqz p1, :cond_4

    iget-object p1, p0, Ld/n/f;->n:Ld/p/b;

    if-nez p1, :cond_4

    iget-object p1, p0, Ld/n/f;->o:Ld/p/b;

    if-nez p1, :cond_4

    iget-object p1, p0, Ld/n/f;->p:Ljava/util/Set;

    invoke-interface {p1}, Ljava/util/Set;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_4

    iput-boolean v1, p0, Ld/n/f;->r:Z

    invoke-super {p0, v1}, Ld/g;->W(I)V

    :cond_4
    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public e()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public h(I)V
    .locals 1

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/n/f;->v:Z

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    invoke-virtual {v0, p1}, Ld/p/b;->P0(Z)V

    return-void
.end method

.method public m(Ld/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Ld/n/f;->s:Ld/n/b;

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ld/n/b;->a()V

    :cond_1
    return-void
.end method

.method public q()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public s()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public t(Ld/p/b;)V
    .locals 2

    iget-object v0, p0, Ld/n/f;->n:Ld/p/b;

    if-eq v0, p1, :cond_0

    iget-object v1, p0, Ld/n/f;->o:Ld/p/b;

    if-eq v1, p1, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Ld/n/f;->s:Ld/n/b;

    if-nez v1, :cond_1

    invoke-virtual {v0}, Ld/p/b;->y0()Z

    return-void

    :cond_1
    if-ne v0, p1, :cond_2

    invoke-interface {v1}, Ld/n/b;->f()V

    goto :goto_0

    :cond_2
    invoke-interface {v1}, Ld/n/b;->g()V

    :goto_0
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

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/n/f;->t:Ld/j;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public v(Ld/p/b;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Must Override"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public y0()V
    .locals 2

    iget-boolean v0, p0, Ld/n/f;->v:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/f;->x:Ld/n/c;

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ld/n/c;->d(I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/f;->v:Z

    :cond_0
    iget-object v0, p0, Ld/n/f;->s:Ld/n/b;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ld/n/b;->d()V

    :cond_1
    iget-object v0, p0, Ld/n/f;->x:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->o()V

    return-void
.end method

.method public final z0()V
    .locals 0

    invoke-super {p0}, Ld/g;->z0()V

    return-void
.end method
