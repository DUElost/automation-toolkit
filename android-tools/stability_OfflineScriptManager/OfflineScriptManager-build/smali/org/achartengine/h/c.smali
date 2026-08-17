.class public Lorg/achartengine/h/c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private b:I

.field private c:Lorg/achartengine/h/a;

.field private d:Z

.field private e:Z

.field private f:Ljava/text/NumberFormat;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, -0xffff01

    iput v0, p0, Lorg/achartengine/h/c;->b:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/achartengine/h/c;->d:Z

    iput-boolean v0, p0, Lorg/achartengine/h/c;->e:Z

    return-void
.end method


# virtual methods
.method public a()Ljava/text/NumberFormat;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/c;->f:Ljava/text/NumberFormat;

    return-object v0
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/c;->b:I

    return v0
.end method

.method public c()Lorg/achartengine/h/a;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/c;->c:Lorg/achartengine/h/a;

    return-object v0
.end method

.method public d()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/c;->e:Z

    return v0
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lorg/achartengine/h/c;->d:Z

    return v0
.end method

.method public f(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/c;->b:I

    return-void
.end method

.method public g(Z)V
    .locals 0

    return-void
.end method
