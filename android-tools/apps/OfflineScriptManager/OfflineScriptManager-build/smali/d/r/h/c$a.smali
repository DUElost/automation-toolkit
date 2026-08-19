.class public Ld/r/h/c$a;
.super Ld/n/f;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/h/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/r/h/c$a$a;
    }
.end annotation


# static fields
.field private static synthetic B:[I


# instance fields
.field private A:Ld/r/h/c$a$a;


# direct methods
.method public constructor <init>(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Ld/n/f;-><init>(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)V

    sget-object p1, Ld/r/h/c$a$a;->b:Ld/r/h/c$a$a;

    iput-object p1, p0, Ld/r/h/c$a;->A:Ld/r/h/c$a$a;

    return-void
.end method

.method static synthetic X0()[I
    .locals 3

    sget-object v0, Ld/r/h/c$a;->B:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/r/h/c$a$a;->values()[Ld/r/h/c$a$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/r/h/c$a$a;->c:Ld/r/h/c$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/r/h/c$a$a;->b:Ld/r/h/c$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    sput-object v0, Ld/r/h/c$a;->B:[I

    return-object v0
.end method


# virtual methods
.method public P0(Ld/e;)Z
    .locals 2

    invoke-static {}, Ld/r/h/c$a;->X0()[I

    move-result-object v0

    iget-object v1, p0, Ld/r/h/c$a;->A:Ld/r/h/c$a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_2

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-super {p0, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    return p1

    :cond_1
    invoke-virtual {p1}, Ld/e;->d()I

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Ld/r/h/c$a$a;->b:Ld/r/h/c$a$a;

    iput-object v0, p0, Ld/r/h/c$a;->A:Ld/r/h/c$a$a;

    invoke-super {p0, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    return p1

    :cond_2
    invoke-virtual {p1}, Ld/e;->j()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Ld/e;->B()I

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Ld/r/h/c$a$a;->c:Ld/r/h/c$a$a;

    iput-object v0, p0, Ld/r/h/c$a;->A:Ld/r/h/c$a$a;

    invoke-super {p0, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    return p1

    :cond_3
    :goto_0
    iget-object p1, p0, Ld/g;->l:Ld/s/c;

    const/16 v0, 0xe

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, 0x0

    return p1
.end method

.method public S0()V
    .locals 1

    invoke-super {p0}, Ld/n/f;->S0()V

    sget-object v0, Ld/r/h/c$a$a;->b:Ld/r/h/c$a$a;

    iput-object v0, p0, Ld/r/h/c$a;->A:Ld/r/h/c$a$a;

    return-void
.end method
