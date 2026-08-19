.class public final Ljxl/write/NumberFormats;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/write/NumberFormats$BuiltInFormat;
    }
.end annotation


# static fields
.field public static final ACCOUNTING_FLOAT:Ljxl/biff/DisplayFormat;

.field public static final ACCOUNTING_INTEGER:Ljxl/biff/DisplayFormat;

.field public static final ACCOUNTING_RED_FLOAT:Ljxl/biff/DisplayFormat;

.field public static final ACCOUNTING_RED_INTEGER:Ljxl/biff/DisplayFormat;

.field public static final DEFAULT:Ljxl/biff/DisplayFormat;

.field public static final EXPONENTIAL:Ljxl/biff/DisplayFormat;

.field public static final FLOAT:Ljxl/biff/DisplayFormat;

.field public static final FORMAT1:Ljxl/biff/DisplayFormat;

.field public static final FORMAT10:Ljxl/biff/DisplayFormat;

.field public static final FORMAT2:Ljxl/biff/DisplayFormat;

.field public static final FORMAT3:Ljxl/biff/DisplayFormat;

.field public static final FORMAT4:Ljxl/biff/DisplayFormat;

.field public static final FORMAT5:Ljxl/biff/DisplayFormat;

.field public static final FORMAT6:Ljxl/biff/DisplayFormat;

.field public static final FORMAT7:Ljxl/biff/DisplayFormat;

.field public static final FORMAT8:Ljxl/biff/DisplayFormat;

.field public static final FORMAT9:Ljxl/biff/DisplayFormat;

.field public static final FRACTION_ONE_DIGIT:Ljxl/biff/DisplayFormat;

.field public static final FRACTION_TWO_DIGITS:Ljxl/biff/DisplayFormat;

.field public static final INTEGER:Ljxl/biff/DisplayFormat;

.field public static final PERCENT_FLOAT:Ljxl/biff/DisplayFormat;

.field public static final PERCENT_INTEGER:Ljxl/biff/DisplayFormat;

.field public static final TEXT:Ljxl/biff/DisplayFormat;

.field public static final THOUSANDS_FLOAT:Ljxl/biff/DisplayFormat;

.field public static final THOUSANDS_INTEGER:Ljxl/biff/DisplayFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x0

    const-string v2, "#"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->DEFAULT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x1

    const-string v2, "0"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->INTEGER:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x2

    const-string v2, "0.00"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FLOAT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x3

    const-string v2, "#,##0"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->THOUSANDS_INTEGER:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x4

    const-string v2, "#,##0.00"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->THOUSANDS_FLOAT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x5

    const-string v2, "$#,##0;($#,##0)"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->ACCOUNTING_INTEGER:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x6

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->ACCOUNTING_RED_INTEGER:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/4 v1, 0x7

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->ACCOUNTING_FLOAT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x8

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->ACCOUNTING_RED_FLOAT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x9

    const-string v2, "0%"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->PERCENT_INTEGER:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0xa

    const-string v2, "0.00%"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->PERCENT_FLOAT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0xb

    const-string v2, "0.00E00"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->EXPONENTIAL:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0xc

    const-string v2, "?/?"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FRACTION_ONE_DIGIT:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0xd

    const-string v2, "??/??"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FRACTION_TWO_DIGITS:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x25

    const-string v2, "#,##0;(#,##0)"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT1:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x26

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT2:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x27

    const-string v3, "#,##0.00;(#,##0.00)"

    invoke-direct {v0, v1, v3}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT3:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x28

    invoke-direct {v0, v1, v3}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT4:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x29

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT5:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x2a

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT6:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x2b

    invoke-direct {v0, v1, v3}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT7:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x2c

    invoke-direct {v0, v1, v3}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT8:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x2e

    invoke-direct {v0, v1, v3}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT9:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x30

    const-string v2, "##0.0E0"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->FORMAT10:Ljxl/biff/DisplayFormat;

    new-instance v0, Ljxl/write/NumberFormats$BuiltInFormat;

    const/16 v1, 0x31

    const-string v2, "@"

    invoke-direct {v0, v1, v2}, Ljxl/write/NumberFormats$BuiltInFormat;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/write/NumberFormats;->TEXT:Ljxl/biff/DisplayFormat;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
