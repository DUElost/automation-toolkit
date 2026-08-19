.class public Lorg/achartengine/a;
.super Ljava/lang/Object;
.source ""


# direct methods
.method private static a(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V
    .locals 0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lorg/achartengine/g/d;->d()I

    move-result p0

    invoke-virtual {p1}, Lorg/achartengine/h/b;->n()I

    move-result p1

    if-ne p0, p1, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Dataset and renderer should be not null and should have the same number of series"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static final b(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;
    .locals 1

    invoke-static {p1, p2}, Lorg/achartengine/a;->a(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    new-instance v0, Lorg/achartengine/f/g;

    invoke-direct {v0, p1, p2}, Lorg/achartengine/f/g;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    invoke-virtual {v0, p3}, Lorg/achartengine/f/g;->N(Ljava/lang/String;)V

    new-instance p1, Lorg/achartengine/b;

    invoke-direct {p1, p0, v0}, Lorg/achartengine/b;-><init>(Landroid/content/Context;Lorg/achartengine/f/a;)V

    return-object p1
.end method

.method public static final c(Landroid/content/Context;Lorg/achartengine/g/d;Lorg/achartengine/h/d;Ljava/lang/String;)Lorg/achartengine/b;
    .locals 1

    invoke-static {p1, p2}, Lorg/achartengine/a;->a(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    new-instance v0, Lorg/achartengine/f/h;

    invoke-direct {v0, p1, p2}, Lorg/achartengine/f/h;-><init>(Lorg/achartengine/g/d;Lorg/achartengine/h/d;)V

    invoke-virtual {v0, p3}, Lorg/achartengine/f/h;->M(Ljava/lang/String;)V

    new-instance p1, Lorg/achartengine/b;

    invoke-direct {p1, p0, v0}, Lorg/achartengine/b;-><init>(Landroid/content/Context;Lorg/achartengine/f/a;)V

    return-object p1
.end method
