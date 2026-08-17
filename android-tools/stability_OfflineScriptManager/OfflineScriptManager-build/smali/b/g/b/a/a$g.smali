.class Lb/g/b/a/a$g;
.super Lb/g/b/a/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/g/b/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "g"
.end annotation


# instance fields
.field private a:I

.field private b:I


# direct methods
.method public constructor <init>(Lb/g/b/a/a;IJ)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lb/g/b/a/a$a;-><init>(Lb/g/b/a/a;Lb/g/b/a/a$a;)V

    iput p2, p0, Lb/g/b/a/a$g;->a:I

    long-to-int p1, p3

    iput p1, p0, Lb/g/b/a/a$g;->b:I

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget v0, p0, Lb/g/b/a/a$g;->b:I

    int-to-long v0, v0

    return-wide v0
.end method

.method public clear()I
    .locals 1

    iget v0, p0, Lb/g/b/a/a$g;->a:I

    return v0
.end method
