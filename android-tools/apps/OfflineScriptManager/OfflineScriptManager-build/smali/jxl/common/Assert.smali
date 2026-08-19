.class public final Ljxl/common/Assert;
.super Ljava/lang/Object;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static verify(Z)V
    .locals 0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljxl/common/AssertionFailed;

    invoke-direct {p0}, Ljxl/common/AssertionFailed;-><init>()V

    throw p0
.end method

.method public static verify(ZLjava/lang/String;)V
    .locals 0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljxl/common/AssertionFailed;

    invoke-direct {p0, p1}, Ljxl/common/AssertionFailed;-><init>(Ljava/lang/String;)V

    throw p0
.end method
