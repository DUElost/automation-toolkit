.class public Lcom/github/johnkil/print/a;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static c:Lcom/github/johnkil/print/a;


# instance fields
.field private final a:Landroid/graphics/Typeface;

.field private final b:Z


# direct methods
.method private constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/github/johnkil/print/a;-><init>(Landroid/graphics/Typeface;)V

    return-void
.end method

.method private constructor <init>(Landroid/graphics/Typeface;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/github/johnkil/print/a;->a:Landroid/graphics/Typeface;

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-boolean p1, p0, Lcom/github/johnkil/print/a;->b:Z

    return-void
.end method

.method static a()Lcom/github/johnkil/print/a;
    .locals 1

    sget-object v0, Lcom/github/johnkil/print/a;->c:Lcom/github/johnkil/print/a;

    if-nez v0, :cond_0

    new-instance v0, Lcom/github/johnkil/print/a;

    invoke-direct {v0}, Lcom/github/johnkil/print/a;-><init>()V

    sput-object v0, Lcom/github/johnkil/print/a;->c:Lcom/github/johnkil/print/a;

    :cond_0
    sget-object v0, Lcom/github/johnkil/print/a;->c:Lcom/github/johnkil/print/a;

    return-object v0
.end method


# virtual methods
.method b()Landroid/graphics/Typeface;
    .locals 1

    iget-object v0, p0, Lcom/github/johnkil/print/a;->a:Landroid/graphics/Typeface;

    return-object v0
.end method

.method c()Z
    .locals 1

    iget-boolean v0, p0, Lcom/github/johnkil/print/a;->b:Z

    return v0
.end method
