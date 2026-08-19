.class public final Ljxl/write/DateFormats;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/write/DateFormats$BuiltInFormat;
    }
.end annotation


# static fields
.field public static final DEFAULT:Ljxl/biff/DisplayFormat;

.field public static final FORMAT1:Ljxl/biff/DisplayFormat;

.field public static final FORMAT10:Ljxl/biff/DisplayFormat;

.field public static final FORMAT11:Ljxl/biff/DisplayFormat;

.field public static final FORMAT12:Ljxl/biff/DisplayFormat;

.field public static final FORMAT2:Ljxl/biff/DisplayFormat;

.field public static final FORMAT3:Ljxl/biff/DisplayFormat;

.field public static final FORMAT4:Ljxl/biff/DisplayFormat;

.field public static final FORMAT5:Ljxl/biff/DisplayFormat;

.field public static final FORMAT6:Ljxl/biff/DisplayFormat;

.field public static final FORMAT7:Ljxl/biff/DisplayFormat;

.field public static final FORMAT8:Ljxl/biff/DisplayFormat;

.field public static final FORMAT9:Ljxl/biff/DisplayFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0xe

    const-string v2, "M/d/yy"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT1:Ljxl/biff/DisplayFormat;

    sput-object v0, Ljxl/write/DateFormats;->DEFAULT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0xf

    const-string v2, "d-MMM-yy"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT2:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x10

    const-string v2, "d-MMM"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT3:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x11

    const-string v2, "MMM-yy"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT4:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x12

    const-string v2, "h:mm a"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT5:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x13

    const-string v2, "h:mm:ss a"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT6:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x14

    const-string v2, "H:mm"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT7:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x15

    const-string v2, "H:mm:ss"

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT8:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x16

    const-string v3, "M/d/yy H:mm"

    invoke-direct {v0, v1, v3}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT9:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x2d

    const-string v3, "mm:ss"

    invoke-direct {v0, v1, v3}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT10:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x2e

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT11:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/DateFormats$BuiltInFormat;

    const/16 v1, 0x2f

    invoke-direct {v0, v1, v2}, Ljxl/write/DateFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/DateFormats;->FORMAT12:Ljxl/biff/DisplayFormat;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
