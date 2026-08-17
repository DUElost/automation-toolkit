.class public Ld/n/i/f/a;
.super Ld/n/i/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/i/f/a$a;
    }
.end annotation


# static fields
.field private static synthetic j:[I


# instance fields
.field private i:Ld/n/i/f/a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/f;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0, p1}, Ld/n/i/a;-><init>(Ld/n/f;Ld/n/j/a;Ld/f;)V

    sget-object p1, Ld/n/i/f/a$a;->b:Ld/n/i/f/a$a;

    iput-object p1, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    return-void
.end method

.method static synthetic A()[I
    .locals 3

    sget-object v0, Ld/n/i/f/a;->j:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/i/f/a$a;->values()[Ld/n/i/f/a$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/i/f/a$a;->f:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/i/f/a$a;->g:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/i/f/a$a;->b:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/i/f/a$a;->d:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/i/f/a$a;->e:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/i/f/a$a;->c:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    sput-object v0, Ld/n/i/f/a;->j:[I

    return-object v0
.end method

.method private B(Ld/e;)I
    .locals 3

    iget-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    sget-object v1, Ld/n/i/f/a$a;->c:Ld/n/i/f/a$a;

    const v2, 0x9523e34

    if-eq v0, v1, :cond_0

    sget-object v1, Ld/n/i/f/a$a;->e:Ld/n/i/f/a$a;

    if-eq v0, v1, :cond_0

    return v2

    :cond_0
    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x7

    if-ge v0, v1, :cond_1

    return v2

    :cond_1
    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Ld/e;->e(I)B

    move-result v0

    invoke-virtual {p1}, Ld/e;->B()I

    move-result p1

    sub-int/2addr p1, v1

    if-le v0, p1, :cond_2

    return v2

    :cond_2
    sget-object p1, Ld/n/i/f/a$a;->f:Ld/n/i/f/a$a;

    iput-object p1, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    const/4 p1, 0x0

    return p1
.end method

.method private C(Ld/e;)I
    .locals 2

    iget-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    sget-object v1, Ld/n/i/f/a$a;->e:Ld/n/i/f/a$a;

    if-eq v0, v1, :cond_0

    const p1, 0x9523e34

    return p1

    :cond_0
    const/4 v0, 0x6

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->o(Ld/e;IZ)I

    move-result p1

    if-nez p1, :cond_1

    sget-object v0, Ld/n/i/f/a$a;->g:Ld/n/i/f/a$a;

    iput-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    :cond_1
    return p1
.end method

.method private D(Ld/e;)I
    .locals 3

    iget-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    sget-object v1, Ld/n/i/f/a$a;->c:Ld/n/i/f/a$a;

    const v2, 0x9523e34

    if-eq v0, v1, :cond_0

    return v2

    :cond_0
    invoke-virtual {p1}, Ld/e;->B()I

    move-result p1

    const/16 v0, 0x8

    if-eq p1, v0, :cond_1

    return v2

    :cond_1
    sget-object p1, Ld/n/i/f/a$a;->d:Ld/n/i/f/a$a;

    iput-object p1, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    const/4 p1, 0x0

    return p1
.end method

.method private E(Ld/e;)I
    .locals 3

    iget-object v0, p0, Ld/n/i/a;->a:Ld/f;

    iget-object v1, v0, Ld/f;->E:Ljava/lang/String;

    iget-object v0, v0, Ld/f;->F:Ljava/lang/String;

    const-string v2, "HELLO"

    invoke-virtual {p0, p1, v2}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    invoke-virtual {p0, p1, v1}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Ld/n/i/a;->f(Ld/e;Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1
.end method

.method private F(Ld/e;)I
    .locals 3

    const-string v0, "INITIATE"

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


# virtual methods
.method public m(Ld/e;)I
    .locals 2

    invoke-static {}, Ld/n/i/f/a;->A()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const/16 p1, 0x23

    goto :goto_1

    :cond_0
    invoke-direct {p0, p1}, Ld/n/i/f/a;->F(Ld/e;)I

    move-result p1

    if-nez p1, :cond_2

    sget-object v0, Ld/n/i/f/a$a;->e:Ld/n/i/f/a$a;

    :goto_0
    iput-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    goto :goto_1

    :cond_1
    invoke-direct {p0, p1}, Ld/n/i/f/a;->E(Ld/e;)I

    move-result p1

    if-nez p1, :cond_2

    sget-object v0, Ld/n/i/f/a$a;->c:Ld/n/i/f/a$a;

    goto :goto_0

    :cond_2
    :goto_1
    return p1
.end method

.method public q(Ld/e;)I
    .locals 4

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    const/4 v1, 0x1

    const/16 v2, 0x8

    if-lt v0, v2, :cond_0

    const-string v2, "WELCOME"

    invoke-virtual {p0, p1, v2, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p1}, Ld/n/i/f/a;->D(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 v2, 0x6

    if-lt v0, v2, :cond_1

    const-string v3, "READY"

    invoke-virtual {p0, p1, v3, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-direct {p0, p1}, Ld/n/i/f/a;->C(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_1
    if-lt v0, v2, :cond_2

    const-string v0, "ERROR"

    invoke-virtual {p0, p1, v0, v1}, Ld/n/i/a;->h(Ld/e;Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0, p1}, Ld/n/i/f/a;->B(Ld/e;)I

    move-result p1

    goto :goto_0

    :cond_2
    sget-object p1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v0, "PLAIN Client I: invalid handshake command"

    invoke-virtual {p1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    const p1, 0x9523e34

    :goto_0
    return p1
.end method

.method public y()Ld/n/i/a$b;
    .locals 2

    iget-object v0, p0, Ld/n/i/f/a;->i:Ld/n/i/f/a$a;

    sget-object v1, Ld/n/i/f/a$a;->g:Ld/n/i/f/a$a;

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    return-object v0

    :cond_0
    sget-object v1, Ld/n/i/f/a$a;->f:Ld/n/i/f/a$a;

    if-ne v0, v1, :cond_1

    sget-object v0, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    return-object v0

    :cond_1
    sget-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    return-object v0
.end method

.method public z()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
