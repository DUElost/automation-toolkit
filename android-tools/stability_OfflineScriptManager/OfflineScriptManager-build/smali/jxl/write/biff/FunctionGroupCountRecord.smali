.class Ljxl/write/biff/FunctionGroupCountRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private data:[B

.field private numFunctionGroups:I


# direct methods
.method public constructor <init>()V
    .locals 3

    sget-object v0, Ljxl/biff/Type;->FNGROUPCOUNT:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/16 v0, 0xe

    iput v0, p0, Ljxl/write/biff/FunctionGroupCountRecord;->numFunctionGroups:I

    const/4 v1, 0x2

    new-array v1, v1, [B

    iput-object v1, p0, Ljxl/write/biff/FunctionGroupCountRecord;->data:[B

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/FunctionGroupCountRecord;->data:[B

    return-object v0
.end method
