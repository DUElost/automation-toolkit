.class public final Ljxl/format/PageOrientation;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static LANDSCAPE:Ljxl/format/PageOrientation;

.field public static PORTRAIT:Ljxl/format/PageOrientation;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljxl/format/PageOrientation;

    invoke-direct {v0}, Ljxl/format/PageOrientation;-><init>()V

    sput-object v0, Ljxl/format/PageOrientation;->PORTRAIT:Ljxl/format/PageOrientation;

    new-instance v0, Ljxl/format/PageOrientation;

    invoke-direct {v0}, Ljxl/format/PageOrientation;-><init>()V

    sput-object v0, Ljxl/format/PageOrientation;->LANDSCAPE:Ljxl/format/PageOrientation;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
