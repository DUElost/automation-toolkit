.class public Lb/e/a/j/g;
.super Ljava/lang/Object;
.source ""


# direct methods
.method public static a(JJ)J
    .locals 4

    :goto_0
    move-wide v2, p0

    move-wide p0, p2

    move-wide p2, v2

    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gtz v0, :cond_0

    return-wide p2

    :cond_0
    rem-long/2addr p2, p0

    goto :goto_0
.end method

.method public static b(JJ)J
    .locals 2

    invoke-static {p0, p1, p2, p3}, Lb/e/a/j/g;->a(JJ)J

    move-result-wide v0

    div-long/2addr p2, v0

    mul-long/2addr p0, p2

    return-wide p0
.end method
