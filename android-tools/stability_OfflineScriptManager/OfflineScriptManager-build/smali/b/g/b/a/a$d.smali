.class Lb/g/b/a/a$d;
.super Lb/g/b/a/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/g/b/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field private a:B

.field private b:J


# direct methods
.method public constructor <init>(Lb/g/b/a/a;IJ)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lb/g/b/a/a$a;-><init>(Lb/g/b/a/a;Lb/g/b/a/a$a;)V

    int-to-byte p1, p2

    iput-byte p1, p0, Lb/g/b/a/a$d;->a:B

    iput-wide p3, p0, Lb/g/b/a/a$d;->b:J

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lb/g/b/a/a$d;->b:J

    return-wide v0
.end method

.method public clear()I
    .locals 1

    iget-byte v0, p0, Lb/g/b/a/a$d;->a:B

    return v0
.end method
