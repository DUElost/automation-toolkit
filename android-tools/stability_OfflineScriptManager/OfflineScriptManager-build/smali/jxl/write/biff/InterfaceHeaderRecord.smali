.class Ljxl/write/biff/InterfaceHeaderRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->INTERFACEHDR:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    const/4 v0, 0x2

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    return-object v0

    nop

    :array_0
    .array-data 1
        -0x50t
        0x4t
    .end array-data
.end method
