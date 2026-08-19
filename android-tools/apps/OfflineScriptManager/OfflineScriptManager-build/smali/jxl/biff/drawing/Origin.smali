.class public final Ljxl/biff/drawing/Origin;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final READ:Ljxl/biff/drawing/Origin;

.field public static final READ_WRITE:Ljxl/biff/drawing/Origin;

.field public static final WRITE:Ljxl/biff/drawing/Origin;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljxl/biff/drawing/Origin;

    invoke-direct {v0}, Ljxl/biff/drawing/Origin;-><init>()V

    sput-object v0, Ljxl/biff/drawing/Origin;->READ:Ljxl/biff/drawing/Origin;

    new-instance v0, Ljxl/biff/drawing/Origin;

    invoke-direct {v0}, Ljxl/biff/drawing/Origin;-><init>()V

    sput-object v0, Ljxl/biff/drawing/Origin;->WRITE:Ljxl/biff/drawing/Origin;

    new-instance v0, Ljxl/biff/drawing/Origin;

    invoke-direct {v0}, Ljxl/biff/drawing/Origin;-><init>()V

    sput-object v0, Ljxl/biff/drawing/Origin;->READ_WRITE:Ljxl/biff/drawing/Origin;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
