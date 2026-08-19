.class public Ljxl/common/LengthUnit;
.super Ljxl/common/BaseUnit;
.source ""


# static fields
.field public static CENTIMETRES:Ljxl/common/LengthUnit;

.field public static INCHES:Ljxl/common/LengthUnit;

.field public static METRES:Ljxl/common/LengthUnit;

.field public static POINTS:Ljxl/common/LengthUnit;

.field private static count:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljxl/common/LengthUnit;

    invoke-direct {v0}, Ljxl/common/LengthUnit;-><init>()V

    sput-object v0, Ljxl/common/LengthUnit;->POINTS:Ljxl/common/LengthUnit;

    new-instance v0, Ljxl/common/LengthUnit;

    invoke-direct {v0}, Ljxl/common/LengthUnit;-><init>()V

    sput-object v0, Ljxl/common/LengthUnit;->METRES:Ljxl/common/LengthUnit;

    new-instance v0, Ljxl/common/LengthUnit;

    invoke-direct {v0}, Ljxl/common/LengthUnit;-><init>()V

    sput-object v0, Ljxl/common/LengthUnit;->CENTIMETRES:Ljxl/common/LengthUnit;

    new-instance v0, Ljxl/common/LengthUnit;

    invoke-direct {v0}, Ljxl/common/LengthUnit;-><init>()V

    sput-object v0, Ljxl/common/LengthUnit;->INCHES:Ljxl/common/LengthUnit;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    sget v0, Ljxl/common/LengthUnit;->count:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Ljxl/common/LengthUnit;->count:I

    invoke-direct {p0, v0}, Ljxl/common/BaseUnit;-><init>(I)V

    return-void
.end method

.method public static getCount()I
    .locals 1

    sget v0, Ljxl/common/LengthUnit;->count:I

    return v0
.end method
