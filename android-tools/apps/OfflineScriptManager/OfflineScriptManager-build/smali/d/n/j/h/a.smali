.class public Ld/n/j/h/a;
.super Ld/n/j/h/c;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/j/h/a$a;
    }
.end annotation


# static fields
.field private static synthetic x:[I


# instance fields
.field private v:Ld/n/j/a;

.field w:Ld/n/j/h/a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Ld/n/j/a;Z)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p6

    invoke-direct/range {v0 .. v5}, Ld/n/j/h/c;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V

    iput-object p5, p0, Ld/n/j/h/a;->v:Ld/n/j/a;

    invoke-virtual {p5}, Ld/n/j/a;->toString()Ljava/lang/String;

    sget-object p1, Ld/n/j/h/a$a;->b:Ld/n/j/h/a$a;

    iput-object p1, p0, Ld/n/j/h/a;->w:Ld/n/j/h/a$a;

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "Socks connecter is not implemented"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method static synthetic M0()[I
    .locals 3

    sget-object v0, Ld/n/j/h/a;->x:[I

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ld/n/j/h/a$a;->values()[Ld/n/j/h/a$a;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    :try_start_0
    sget-object v1, Ld/n/j/h/a$a;->e:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Ld/n/j/h/a$a;->g:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x6

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Ld/n/j/h/a$a;->b:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    sget-object v1, Ld/n/j/h/a$a;->f:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x5

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    sget-object v1, Ld/n/j/h/a$a;->d:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    sget-object v1, Ld/n/j/h/a$a;->c:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    sget-object v1, Ld/n/j/h/a$a;->h:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    const/4 v2, 0x7

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    sput-object v0, Ld/n/j/h/a;->x:[I

    return-object v0
.end method


# virtual methods
.method N0()V
    .locals 0

    return-void
.end method

.method O0()V
    .locals 0

    return-void
.end method

.method protected R()V
    .locals 1

    iget-boolean v0, p0, Ld/n/j/h/c;->q:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ld/n/j/h/a;->O0()V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ld/n/j/h/a;->N0()V

    :goto_0
    return-void
.end method

.method protected W(I)V
    .locals 2

    invoke-static {}, Ld/n/j/h/a;->M0()[I

    move-result-object v0

    iget-object v1, p0, Ld/n/j/h/a;->w:Ld/n/j/h/a$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {p0}, Ld/n/j/h/c;->close()V

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Ld/n/j/h/c;->m:Ld/n/c;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ld/n/c;->d(I)V

    :goto_0
    invoke-super {p0, p1}, Ld/n/j/h/c;->W(I)V

    return-void

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public e()V
    .locals 0

    invoke-super {p0}, Ld/n/j/h/c;->e()V

    return-void
.end method

.method public h(I)V
    .locals 0

    invoke-super {p0, p1}, Ld/n/j/h/c;->h(I)V

    return-void
.end method

.method public s()V
    .locals 0

    invoke-super {p0}, Ld/n/j/h/c;->s()V

    return-void
.end method
