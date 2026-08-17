.class Ljxl/biff/formula/RangeSeparator;
.super Ljxl/biff/formula/BinaryOperator;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/BinaryOperator;-><init>()V

    return-void
.end method


# virtual methods
.method getBytes()[B
    .locals 5

    invoke-virtual {p0}, Ljxl/biff/formula/ParseItem;->setVolatile()V

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->setOperandAlternateCode()V

    invoke-super {p0}, Ljxl/biff/formula/BinaryOperator;->getBytes()[B

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x3

    add-int/2addr v1, v2

    new-array v1, v1, [B

    array-length v3, v0

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v2, Ljxl/biff/formula/Token;->MEM_FUNC:Ljxl/biff/formula/Token;

    invoke-virtual {v2}, Ljxl/biff/formula/Token;->getCode()B

    move-result v2

    aput-byte v2, v1, v4

    array-length v0, v0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v1
.end method

.method getPrecedence()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public getSymbol()Ljava/lang/String;
    .locals 1

    const-string v0, ":"

    return-object v0
.end method

.method getToken()Ljxl/biff/formula/Token;
    .locals 1

    sget-object v0, Ljxl/biff/formula/Token;->RANGE:Ljxl/biff/formula/Token;

    return-object v0
.end method
