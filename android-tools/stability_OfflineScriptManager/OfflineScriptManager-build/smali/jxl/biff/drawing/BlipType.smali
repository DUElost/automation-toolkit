.class final Ljxl/biff/drawing/BlipType;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final DIB:Ljxl/biff/drawing/BlipType;

.field public static final EMF:Ljxl/biff/drawing/BlipType;

.field public static final ERROR:Ljxl/biff/drawing/BlipType;

.field public static final FIRST_CLIENT:Ljxl/biff/drawing/BlipType;

.field public static final JPEG:Ljxl/biff/drawing/BlipType;

.field public static final LAST_CLIENT:Ljxl/biff/drawing/BlipType;

.field public static final PICT:Ljxl/biff/drawing/BlipType;

.field public static final PNG:Ljxl/biff/drawing/BlipType;

.field public static final UNKNOWN:Ljxl/biff/drawing/BlipType;

.field public static final WMF:Ljxl/biff/drawing/BlipType;

.field private static types:[Ljxl/biff/drawing/BlipType;


# instance fields
.field private desc:Ljava/lang/String;

.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x0

    new-array v1, v0, [Ljxl/biff/drawing/BlipType;

    sput-object v1, Ljxl/biff/drawing/BlipType;->types:[Ljxl/biff/drawing/BlipType;

    new-instance v1, Ljxl/biff/drawing/BlipType;

    const-string v2, "Error"

    invoke-direct {v1, v0, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v1, Ljxl/biff/drawing/BlipType;->ERROR:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x1

    const-string v2, "Unknown"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->UNKNOWN:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x2

    const-string v2, "EMF"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->EMF:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x3

    const-string v2, "WMF"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->WMF:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x4

    const-string v2, "PICT"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->PICT:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x5

    const-string v2, "JPEG"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->JPEG:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x6

    const-string v2, "PNG"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->PNG:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x7

    const-string v2, "DIB"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->DIB:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/16 v1, 0x20

    const-string v2, "FIRST"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->FIRST_CLIENT:Ljxl/biff/drawing/BlipType;

    new-instance v0, Ljxl/biff/drawing/BlipType;

    const/16 v1, 0xff

    const-string v2, "LAST"

    invoke-direct {v0, v1, v2}, Ljxl/biff/drawing/BlipType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/drawing/BlipType;->LAST_CLIENT:Ljxl/biff/drawing/BlipType;

    return-void
.end method

.method private constructor <init>(ILjava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/BlipType;->value:I

    iput-object p2, p0, Ljxl/biff/drawing/BlipType;->desc:Ljava/lang/String;

    sget-object p1, Ljxl/biff/drawing/BlipType;->types:[Ljxl/biff/drawing/BlipType;

    array-length p2, p1

    add-int/lit8 p2, p2, 0x1

    new-array p2, p2, [Ljxl/biff/drawing/BlipType;

    array-length v0, p1

    const/4 v1, 0x0

    invoke-static {p1, v1, p2, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object p1, Ljxl/biff/drawing/BlipType;->types:[Ljxl/biff/drawing/BlipType;

    array-length p1, p1

    aput-object p0, p2, p1

    sput-object p2, Ljxl/biff/drawing/BlipType;->types:[Ljxl/biff/drawing/BlipType;

    return-void
.end method

.method public static getType(I)Ljxl/biff/drawing/BlipType;
    .locals 4

    sget-object v0, Ljxl/biff/drawing/BlipType;->UNKNOWN:Ljxl/biff/drawing/BlipType;

    const/4 v1, 0x0

    :goto_0
    sget-object v2, Ljxl/biff/drawing/BlipType;->types:[Ljxl/biff/drawing/BlipType;

    array-length v3, v2

    if-ge v1, v3, :cond_1

    aget-object v3, v2, v1

    iget v3, v3, Ljxl/biff/drawing/BlipType;->value:I

    if-ne v3, p0, :cond_0

    aget-object v0, v2, v1

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-object v0
.end method


# virtual methods
.method public getDescription()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/BlipType;->desc:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()I
    .locals 1

    iget v0, p0, Ljxl/biff/drawing/BlipType;->value:I

    return v0
.end method
