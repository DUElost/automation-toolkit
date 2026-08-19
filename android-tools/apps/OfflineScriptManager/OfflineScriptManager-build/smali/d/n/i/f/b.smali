.class public Ld/n/i/f/b;
.super Ld/n/i/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/f/b$a;
    }
.end annotation


# static fields
.field private static synthetic j:[I


# instance fields
.field private i:Ld/n/i/f/b$a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/f;Ld/n/j/a;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    sget-object p1, Ld/n/i/f/b$a;->b:Ld/n/i/f/b$a;

    iput-object p1, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    return-void
.end method

.method static synthetic A()[I
    .locals 3

    sget-object v0, Ld/n/i/f/b;->j:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/i/f/b$a;->values()[Ld/n/i/f/b$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/i/f/b$a;->h:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x7

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/i/f/b$a;->i:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/16 v2, 0x8

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/i/f/b$a;->g:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/i/f/b$a;->e:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/i/f/b$a;->c:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/i/f/b$a;->b:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    sget-object v1, Ld/n/i/f/b$a;->d:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    :try_start_7
    sget-object v1, Ld/n/i/f/b$a;->f:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_7
    .catch Ljava/lang/NoSuchFieldError; {:try_start_7 .. :try_end_7} :catch_7

    :catch_7
    sput-object v0, Ld/n/i/f/b;->j:[I

    return-object v0
.end method

.method private B(Ld/e;)I
    .locals 1

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->h:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1
.end method

.method private C(Ld/e;)I
    .locals 9

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x6

    const v2, 0x9523e34

    if-lt v0, v1, :cond_9

    const-string v3, "HELLO"

    const/4 v4, 0x1

    invoke-virtual {p0, p1, v3, v4}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v3

    if-nez v3, :cond_0

    goto :goto_3

    :cond_0
    add-int/lit8 v0, v0, -0x6

    if-ge v0, v4, :cond_1

    const-string p1, "PLAIN I: invalid PLAIN client, did not send username"

    :goto_0
    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    return v2

    :cond_1
    invoke-virtual {p1, v1}, Ld/e;->e(I)B

    move-result v1

    const/4 v3, -0x1

    add-int/2addr v0, v3

    if-ge v0, v1, :cond_2

    const-string p1, "PLAIN I: invalid PLAIN client, sent malformed username"

    goto :goto_0

    :cond_2
    new-array v5, v1, [B

    const/4 v6, 0x7

    const/4 v7, 0x0

    invoke-virtual {p1, v6, v5, v7, v1}, Ld/e;->f(I[BII)I

    sub-int/2addr v0, v1

    add-int/2addr v6, v1

    invoke-virtual {p1, v6}, Ld/e;->e(I)B

    move-result v1

    add-int/2addr v0, v3

    if-ge v0, v1, :cond_3

    const-string p1, "PLAIN I: invalid PLAIN client, sent malformed password"

    goto :goto_0

    :cond_3
    new-array v8, v1, [B

    add-int/2addr v6, v4

    invoke-virtual {p1, v6, v8, v7, v1}, Ld/e;->f(I[BII)I

    sub-int/2addr v0, v1

    if-lez v0, :cond_4

    const-string p1, "PLAIN I: invalid PLAIN client, sent extraneous data"

    goto :goto_0

    :cond_4
    iget-object p1, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {p1}, Ld/n/f;->V0()I

    move-result p1

    if-nez p1, :cond_8

    invoke-direct {p0, v5, v8}, Ld/n/i/f/b;->G([B[B)V

    invoke-virtual {p0}, Ld/n/i/a;->t()I

    move-result p1

    if-nez p1, :cond_6

    iget-object p1, p0, Ld/n/i/a;->h:Ljava/lang/String;

    const-string v0, "200"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    goto :goto_1

    :cond_5
    sget-object p1, Ld/n/i/f/b$a;->g:Ld/n/i/f/b$a;

    goto :goto_2

    :cond_6
    const/16 v0, 0x23

    if-ne p1, v0, :cond_7

    sget-object p1, Ld/n/i/f/b$a;->f:Ld/n/i/f/b$a;

    goto :goto_2

    :cond_7
    return v3

    :cond_8
    :goto_1
    sget-object p1, Ld/n/i/f/b$a;->c:Ld/n/i/f/b$a;

    :goto_2
    iput-object p1, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    return v7

    :cond_9
    :goto_3
    const-string p1, "PLAIN I: invalid PLAIN client, did not send HELLO"

    goto :goto_0
.end method

.method private D(Ld/e;)I
    .locals 3

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/16 v1, 0x9

    if-lt v0, v1, :cond_2

    const/4 v0, 0x1

    const-string v2, "INITIATE"

    invoke-virtual {p0, p1, v2, v0}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v1, v0}, Ld/n/i/a;->o(Ld/e;IZ)I

    move-result p1

    if-nez p1, :cond_1

    sget-object v0, Ld/n/i/f/b$a;->e:Ld/n/i/f/b$a;

    iput-object v0, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    :cond_1
    return p1

    :cond_2
    :goto_0
    const-string p1, "PLAIN I: invalid PLAIN client, did not send INITIATE"

    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    const p1, 0x9523e34

    return p1
.end method

.method private E(Ld/e;)I
    .locals 3

    const-string v0, "READY"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->a:Ld/f;

    iget v0, v0, Ld/f;->j:I

    invoke-virtual {p0, v0}, Ld/n/i/a;->x(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Socket-Type"

    invoke-virtual {p0, p1, v1, v0}, Ld/n/i/a;->d(Ld/e;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Ld/n/i/a;->a:Ld/f;

    iget v1, v0, Ld/f;->j:I

    const/4 v2, 0x3

    if-eq v1, v2, :cond_0

    const/4 v2, 0x5

    if-eq v1, v2, :cond_0

    const/4 v2, 0x6

    if-ne v1, v2, :cond_1

    :cond_0
    iget-object v0, v0, Ld/f;->e:[B

    const-string v1, "Identity"

    invoke-virtual {p0, p1, v1, v0}, Ld/n/i/a;->e(Ld/e;Ljava/lang/String;[B)V

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method private F(Ld/e;)I
    .locals 1

    const-string v0, "WELCOME"

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1
.end method

.method private G([B[B)V
    .locals 3

    sget-object v0, Ld/n/i/b;->c:Ld/n/i/b;

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ld/n/i/a;->u(Ld/n/i/b;Z)V

    new-instance v0, Ld/e;

    array-length v2, p1

    invoke-direct {v0, v2}, Ld/e;-><init>(I)V

    invoke-virtual {v0, v1}, Ld/e;->y(I)V

    invoke-virtual {v0, p1}, Ld/e;->u([B)Ld/e;

    iget-object p1, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {p1, v0}, Ld/n/f;->U0(Ld/e;)Z

    new-instance p1, Ld/e;

    array-length v0, p2

    invoke-direct {p1, v0}, Ld/e;-><init>(I)V

    invoke-virtual {p1, p2}, Ld/e;->u([B)Ld/e;

    iget-object p2, p0, Ld/n/i/a;->f:Ld/n/f;

    invoke-virtual {p2, p1}, Ld/n/f;->U0(Ld/e;)Z

    return-void
.end method


# virtual methods
.method public m(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/f/b;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    const/16 p1, 0x23

    goto :goto_1

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/f/b;->B(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/f/b$a;->h:Ld/n/i/f/b$a;

    :goto_0
    iput-object v0, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    goto :goto_1

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/f/b;->E(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/f/b$a;->i:Ld/n/i/f/b$a;

    goto :goto_0

    :cond_2
    invoke-direct {p0, p1}, Ld/n/i/f/b;->F(Ld/e;)I

    move-result p1

    if-nez p1, :cond_3

    sget-object v0, Ld/n/i/f/b$a;->d:Ld/n/i/f/b$a;

    goto :goto_0

    :cond_3
    :goto_1
    return p1
.end method

.method public q(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/f/b;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const-string p1, "PLAIN Server I: invalid handshake command"

    invoke-virtual {p0, p1}, Ld/n/i/a;->s(Ljava/lang/String;)V

    const p1, 0x9523e34

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/f/b;->D(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/f/b;->C(Ld/e;)I

    move-result p1

    :goto_0
    return p1
.end method

.method public y()Ld/n/i/a$b;
    .locals 2

    iget-object v0, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    sget-object v1, Ld/n/i/f/b$a;->i:Ld/n/i/f/b$a;

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    return-object v0

    :cond_0
    sget-object v1, Ld/n/i/f/b$a;->h:Ld/n/i/f/b$a;

    if-ne v0, v1, :cond_1

    sget-object v0, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    return-object v0

    :cond_1
    sget-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    return-object v0
.end method

.method public z()I
    .locals 3

    iget-object v0, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    sget-object v1, Ld/n/i/f/b$a;->f:Ld/n/i/f/b$a;

    if-eq v0, v1, :cond_0

    const v0, 0x9523dfb

    return v0

    :cond_0
    invoke-virtual {p0}, Ld/n/i/a;->t()I

    move-result v0

    if-nez v0, :cond_2

    iget-object v1, p0, Ld/n/i/a;->h:Ljava/lang/String;

    const-string v2, "200"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Ld/n/i/f/b$a;->c:Ld/n/i/f/b$a;

    goto :goto_0

    :cond_1
    sget-object v1, Ld/n/i/f/b$a;->g:Ld/n/i/f/b$a;

    :goto_0
    iput-object v1, p0, Ld/n/i/f/b;->i:Ld/n/i/f/b$a;

    :cond_2
    return v0
.end method
