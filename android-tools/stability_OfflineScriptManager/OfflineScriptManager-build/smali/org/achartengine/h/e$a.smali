.class public Lorg/achartengine/h/e$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/achartengine/h/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/achartengine/h/e$a$a;
    }
.end annotation


# instance fields
.field private final b:Lorg/achartengine/h/e$a$a;

.field private c:I

.field private d:[I


# direct methods
.method public constructor <init>(Lorg/achartengine/h/e$a$a;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x7d

    const/4 v1, 0x0

    const/16 v2, 0xc8

    invoke-static {v0, v1, v1, v2}, Landroid/graphics/Color;->argb(IIII)I

    move-result v0

    iput v0, p0, Lorg/achartengine/h/e$a;->c:I

    iput-object p1, p0, Lorg/achartengine/h/e$a;->b:Lorg/achartengine/h/e$a$a;

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/e$a;->c:I

    return v0
.end method

.method public b()[I
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e$a;->d:[I

    return-object v0
.end method

.method public c()Lorg/achartengine/h/e$a$a;
    .locals 1

    iget-object v0, p0, Lorg/achartengine/h/e$a;->b:Lorg/achartengine/h/e$a$a;

    return-object v0
.end method

.method public d(I)V
    .locals 0

    iput p1, p0, Lorg/achartengine/h/e$a;->c:I

    return-void
.end method
