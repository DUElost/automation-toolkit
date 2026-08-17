.class abstract Ljxl/biff/formula/UnaryOperator;
.super Ljxl/biff/formula/Operator;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operator;-><init>()V

    return-void
.end method


# virtual methods
.method public adjustRelativeCellReferences(II)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1, p2}, Ljxl/biff/formula/ParseItem;->adjustRelativeCellReferences(II)V

    return-void
.end method

.method columnInserted(IIZ)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnInserted(IIZ)V

    return-void
.end method

.method columnRemoved(IIZ)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnRemoved(IIZ)V

    return-void
.end method

.method getBytes()[B
    .locals 4

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v0

    array-length v2, v0

    add-int/lit8 v2, v2, 0x1

    new-array v2, v2, [B

    array-length v3, v0

    invoke-static {v0, v1, v2, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v0, v0

    invoke-virtual {p0}, Ljxl/biff/formula/UnaryOperator;->getToken()Ljxl/biff/formula/Token;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/biff/formula/Token;->getCode()B

    move-result v1

    aput-byte v1, v2, v0

    return-object v2
.end method

.method public getOperands(Ljava/util/Stack;)V
    .locals 0

    invoke-virtual {p1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/formula/ParseItem;

    invoke-virtual {p0, p1}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    return-void
.end method

.method public getString(Ljava/lang/StringBuffer;)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    invoke-virtual {p0}, Ljxl/biff/formula/UnaryOperator;->getSymbol()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Ljxl/biff/formula/ParseItem;->getString(Ljava/lang/StringBuffer;)V

    return-void
.end method

.method abstract getSymbol()Ljava/lang/String;
.end method

.method abstract getToken()Ljxl/biff/formula/Token;
.end method

.method handleImportedCellReferences()V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->handleImportedCellReferences()V

    return-void
.end method

.method public read([BI)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method rowInserted(IIZ)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowInserted(IIZ)V

    return-void
.end method

.method rowRemoved(IIZ)V
    .locals 2

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowRemoved(IIZ)V

    return-void
.end method
