.class final Ljxl/biff/drawing/Opt$Property;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/drawing/Opt;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Property"
.end annotation


# instance fields
.field blipId:Z

.field complex:Z

.field id:I

.field stringValue:Ljava/lang/String;

.field value:I


# direct methods
.method public constructor <init>(IZZI)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/Opt$Property;->id:I

    iput-boolean p2, p0, Ljxl/biff/drawing/Opt$Property;->blipId:Z

    iput-boolean p3, p0, Ljxl/biff/drawing/Opt$Property;->complex:Z

    iput p4, p0, Ljxl/biff/drawing/Opt$Property;->value:I

    return-void
.end method

.method public constructor <init>(IZZILjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/Opt$Property;->id:I

    iput-boolean p2, p0, Ljxl/biff/drawing/Opt$Property;->blipId:Z

    iput-boolean p3, p0, Ljxl/biff/drawing/Opt$Property;->complex:Z

    iput p4, p0, Ljxl/biff/drawing/Opt$Property;->value:I

    iput-object p5, p0, Ljxl/biff/drawing/Opt$Property;->stringValue:Ljava/lang/String;

    return-void
.end method
