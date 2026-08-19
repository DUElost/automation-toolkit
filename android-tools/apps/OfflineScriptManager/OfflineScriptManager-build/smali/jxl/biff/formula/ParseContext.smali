.class public Ljxl/biff/formula/ParseContext;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static DATA_VALIDATION:Ljxl/biff/formula/ParseContext;

.field public static DEFAULT:Ljxl/biff/formula/ParseContext;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljxl/biff/formula/ParseContext;

    invoke-direct {v0}, Ljxl/biff/formula/ParseContext;-><init>()V

    sput-object v0, Ljxl/biff/formula/ParseContext;->DEFAULT:Ljxl/biff/formula/ParseContext;

    new-instance v0, Ljxl/biff/formula/ParseContext;

    invoke-direct {v0}, Ljxl/biff/formula/ParseContext;-><init>()V

    sput-object v0, Ljxl/biff/formula/ParseContext;->DATA_VALIDATION:Ljxl/biff/formula/ParseContext;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
