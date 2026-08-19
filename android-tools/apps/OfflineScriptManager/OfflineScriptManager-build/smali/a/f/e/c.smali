.class public La/f/e/c;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final a:La/f/e/h;

.field private static final b:La/d/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "La/d/e<",
            "Ljava/lang/String;",
            "Landroid/graphics/Typeface;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    new-instance v0, La/f/e/g;

    invoke-direct {v0}, La/f/e/g;-><init>()V

    :goto_0
    sput-object v0, La/f/e/c;->a:La/f/e/h;

    goto :goto_1

    :cond_0
    const/16 v1, 0x1a

    if-lt v0, v1, :cond_1

    new-instance v0, La/f/e/f;

    invoke-direct {v0}, La/f/e/f;-><init>()V

    goto :goto_0

    :cond_1
    const/16 v1, 0x18

    if-lt v0, v1, :cond_2

    invoke-static {}, La/f/e/e;->j()Z

    move-result v1

    if-eqz v1, :cond_2

    new-instance v0, La/f/e/e;

    invoke-direct {v0}, La/f/e/e;-><init>()V

    goto :goto_0

    :cond_2
    const/16 v1, 0x15

    if-lt v0, v1, :cond_3

    new-instance v0, La/f/e/d;

    invoke-direct {v0}, La/f/e/d;-><init>()V

    goto :goto_0

    :cond_3
    new-instance v0, La/f/e/h;

    invoke-direct {v0}, La/f/e/h;-><init>()V

    goto :goto_0

    :goto_1
    new-instance v0, La/d/e;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, La/d/e;-><init>(I)V

    sput-object v0, La/f/e/c;->b:La/d/e;

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/os/CancellationSignal;[La/f/i/b$f;I)Landroid/graphics/Typeface;
    .locals 1

    sget-object v0, La/f/e/c;->a:La/f/e/h;

    invoke-virtual {v0, p0, p1, p2, p3}, La/f/e/h;->b(Landroid/content/Context;Landroid/os/CancellationSignal;[La/f/i/b$f;I)Landroid/graphics/Typeface;

    move-result-object p0

    return-object p0
.end method

.method public static b(Landroid/content/Context;Landroidx/core/content/c/c$a;Landroid/content/res/Resources;IILandroidx/core/content/c/f$a;Landroid/os/Handler;Z)Landroid/graphics/Typeface;
    .locals 7

    instance-of v1, p1, Landroidx/core/content/c/c$d;

    if-eqz v1, :cond_3

    move-object v0, p1

    check-cast v0, Landroidx/core/content/c/c$d;

    const/4 v1, 0x1

    const/4 v4, 0x0

    if-eqz p7, :cond_0

    invoke-virtual {v0}, Landroidx/core/content/c/c$d;->a()I

    move-result v5

    if-nez v5, :cond_1

    goto :goto_0

    :cond_0
    if-nez p5, :cond_1

    :goto_0
    move v4, v1

    :cond_1
    if-eqz p7, :cond_2

    invoke-virtual {v0}, Landroidx/core/content/c/c$d;->c()I

    move-result v1

    goto :goto_1

    :cond_2
    const/4 v1, -0x1

    :goto_1
    move v5, v1

    invoke-virtual {v0}, Landroidx/core/content/c/c$d;->b()La/f/i/a;

    move-result-object v1

    move-object v0, p0

    move-object v2, p5

    move-object v3, p6

    move v6, p4

    invoke-static/range {v0 .. v6}, La/f/i/b;->g(Landroid/content/Context;La/f/i/a;Landroidx/core/content/c/f$a;Landroid/os/Handler;ZII)Landroid/graphics/Typeface;

    move-result-object v0

    goto :goto_2

    :cond_3
    sget-object v1, La/f/e/c;->a:La/f/e/h;

    move-object v0, p1

    check-cast v0, Landroidx/core/content/c/c$b;

    invoke-virtual {v1, p0, v0, p2, p4}, La/f/e/h;->a(Landroid/content/Context;Landroidx/core/content/c/c$b;Landroid/content/res/Resources;I)Landroid/graphics/Typeface;

    move-result-object v0

    if-eqz p5, :cond_5

    if-eqz v0, :cond_4

    invoke-virtual {p5, v0, p6}, Landroidx/core/content/c/f$a;->b(Landroid/graphics/Typeface;Landroid/os/Handler;)V

    goto :goto_2

    :cond_4
    const/4 v1, -0x3

    invoke-virtual {p5, v1, p6}, Landroidx/core/content/c/f$a;->a(ILandroid/os/Handler;)V

    :cond_5
    :goto_2
    if-eqz v0, :cond_6

    sget-object v1, La/f/e/c;->b:La/d/e;

    invoke-static {p2, p3, p4}, La/f/e/c;->d(Landroid/content/res/Resources;II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, La/d/e;->d(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    return-object v0
.end method

.method public static c(Landroid/content/Context;Landroid/content/res/Resources;ILjava/lang/String;I)Landroid/graphics/Typeface;
    .locals 6

    sget-object v0, La/f/e/c;->a:La/f/e/h;

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, La/f/e/h;->d(Landroid/content/Context;Landroid/content/res/Resources;ILjava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object p0

    if-eqz p0, :cond_0

    invoke-static {p1, p2, p4}, La/f/e/c;->d(Landroid/content/res/Resources;II)Ljava/lang/String;

    move-result-object p1

    sget-object p2, La/f/e/c;->b:La/d/e;

    invoke-virtual {p2, p1, p0}, La/d/e;->d(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object p0
.end method

.method private static d(Landroid/content/res/Resources;II)Ljava/lang/String;
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getResourcePackageName(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "-"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static e(Landroid/content/res/Resources;II)Landroid/graphics/Typeface;
    .locals 1

    sget-object v0, La/f/e/c;->b:La/d/e;

    invoke-static {p0, p1, p2}, La/f/e/c;->d(Landroid/content/res/Resources;II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, La/d/e;->c(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/graphics/Typeface;

    return-object p0
.end method
