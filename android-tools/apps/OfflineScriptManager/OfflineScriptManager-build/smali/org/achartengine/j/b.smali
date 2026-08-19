.class public Lorg/achartengine/j/b;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final a:Ljava/text/NumberFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Ljava/text/NumberFormat;->getNumberInstance()Ljava/text/NumberFormat;

    move-result-object v0

    sput-object v0, Lorg/achartengine/j/b;->a:Ljava/text/NumberFormat;

    return-void
.end method

.method private static a(DDI)[D
    .locals 11

    sub-double v0, p0, p2

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x3e7ad7f2a0000000L    # 1.0000000116860974E-7

    cmpg-double v0, v0, v2

    const/4 v1, 0x2

    const/4 v2, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-gez v0, :cond_0

    new-array p2, v2, [D

    aput-wide p0, p2, v4

    aput-wide p0, p2, v3

    const-wide/16 p0, 0x0

    aput-wide p0, p2, v1

    return-object p2

    :cond_0
    cmpl-double v0, p0, p2

    if-lez v0, :cond_1

    move v0, v3

    move-wide v9, p0

    move-wide p0, p2

    move-wide p2, v9

    goto :goto_0

    :cond_1
    move v0, v4

    :goto_0
    sub-double v5, p0, p2

    invoke-static {v5, v6}, Ljava/lang/Math;->abs(D)D

    move-result-wide v5

    int-to-double v7, p4

    div-double/2addr v5, v7

    invoke-static {v5, v6}, Lorg/achartengine/j/b;->c(D)D

    move-result-wide v5

    div-double/2addr p0, v5

    invoke-static {p0, p1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p0

    mul-double/2addr p0, v5

    div-double/2addr p2, v5

    invoke-static {p2, p3}, Ljava/lang/Math;->floor(D)D

    move-result-wide p2

    mul-double/2addr p2, v5

    new-array p4, v2, [D

    if-eqz v0, :cond_2

    aput-wide p2, p4, v4

    aput-wide p0, p4, v3

    const-wide/high16 p0, -0x4010000000000000L    # -1.0

    mul-double/2addr v5, p0

    aput-wide v5, p4, v1

    return-object p4

    :cond_2
    aput-wide p0, p4, v4

    aput-wide p2, p4, v3

    aput-wide v5, p4, v1

    return-object p4
.end method

.method public static b(DDI)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(DDI)",
            "Ljava/util/List<",
            "Ljava/lang/Double;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-gtz p4, :cond_0

    return-object v0

    :cond_0
    sget-object v1, Lorg/achartengine/j/b;->a:Ljava/text/NumberFormat;

    const/4 v2, 0x5

    invoke-virtual {v1, v2}, Ljava/text/NumberFormat;->setMaximumFractionDigits(I)V

    invoke-static {p0, p1, p2, p3, p4}, Lorg/achartengine/j/b;->a(DDI)[D

    move-result-object p0

    const/4 p1, 0x1

    aget-wide p2, p0, p1

    const/4 p4, 0x0

    aget-wide v1, p0, p4

    sub-double/2addr p2, v1

    const/4 v1, 0x2

    aget-wide v2, p0, v1

    div-double/2addr p2, v2

    double-to-int p2, p2

    add-int/2addr p2, p1

    move p1, p4

    :goto_0
    if-lt p1, p2, :cond_1

    return-object v0

    :cond_1
    aget-wide v2, p0, p4

    int-to-double v4, p1

    aget-wide v6, p0, v1

    mul-double/2addr v4, v6

    add-double/2addr v2, v4

    :try_start_0
    sget-object p3, Lorg/achartengine/j/b;->a:Ljava/text/NumberFormat;

    invoke-virtual {p3, v2, v3}, Ljava/text/NumberFormat;->format(D)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p3, v4}, Ljava/text/NumberFormat;->parse(Ljava/lang/String;)Ljava/lang/Number;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v2
    :try_end_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p3

    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method

.method private static c(D)D
    .locals 8

    invoke-static {p0, p1}, Ljava/lang/Math;->log10(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->floor(D)D

    move-result-wide v0

    double-to-int v0, v0

    neg-int v1, v0

    int-to-double v1, v1

    const-wide/high16 v3, 0x4024000000000000L    # 10.0

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v1

    mul-double/2addr p0, v1

    const-wide/high16 v1, 0x4014000000000000L    # 5.0

    cmpl-double v5, p0, v1

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    if-lez v5, :cond_0

    move-wide p0, v3

    goto :goto_0

    :cond_0
    cmpl-double v5, p0, v6

    if-lez v5, :cond_1

    move-wide p0, v1

    goto :goto_0

    :cond_1
    const-wide/high16 v1, 0x3ff0000000000000L    # 1.0

    cmpl-double v1, p0, v1

    if-lez v1, :cond_2

    move-wide p0, v6

    :cond_2
    :goto_0
    int-to-double v0, v0

    invoke-static {v3, v4, v0, v1}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    mul-double/2addr p0, v0

    return-wide p0
.end method
