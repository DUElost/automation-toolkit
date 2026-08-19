.class Ljxl/biff/formula/Attribute;
.super Ljxl/biff/formula/Operator;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# static fields
.field private static final CHOOSE_MASK:I = 0x4

.field private static final GOTO_MASK:I = 0x8

.field private static final IF_MASK:I = 0x2

.field private static final SUM_MASK:I = 0x10

.field static synthetic class$jxl$biff$formula$Attribute:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private ifConditions:Ljxl/biff/formula/VariableArgFunction;

.field private options:I

.field private settings:Ljxl/WorkbookSettings;

.field private word:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/Attribute;->class$jxl$biff$formula$Attribute:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.Attribute"

    invoke-static {v0}, Ljxl/biff/formula/Attribute;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Attribute;->class$jxl$biff$formula$Attribute:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Attribute;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operator;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/Attribute;->settings:Ljxl/WorkbookSettings;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/formula/StringFunction;Ljxl/WorkbookSettings;)V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/formula/Operator;-><init>()V

    iput-object p2, p0, Ljxl/biff/formula/Attribute;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, p2}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object p2

    sget-object v0, Ljxl/biff/formula/Function;->SUM:Ljxl/biff/formula/Function;

    if-ne p2, v0, :cond_0

    iget p1, p0, Ljxl/biff/formula/Attribute;->options:I

    or-int/lit8 p1, p1, 0x10

    :goto_0
    iput p1, p0, Ljxl/biff/formula/Attribute;->options:I

    goto :goto_1

    :cond_0
    iget-object p2, p0, Ljxl/biff/formula/Attribute;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, p2}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object p1

    sget-object p2, Ljxl/biff/formula/Function;->IF:Ljxl/biff/formula/Function;

    if-ne p1, p2, :cond_1

    iget p1, p0, Ljxl/biff/formula/Attribute;->options:I

    or-int/lit8 p1, p1, 0x2

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1

    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/NoClassDefFoundError;

    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private getIf()[B
    .locals 14

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v3

    array-length v4, v3

    array-length v5, v3

    add-int/lit8 v5, v5, 0x4

    new-array v6, v5, [B

    array-length v7, v3

    invoke-static {v3, v2, v6, v2, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v3, Ljxl/biff/formula/Token;->ATTRIBUTE:Ljxl/biff/formula/Token;

    invoke-virtual {v3}, Ljxl/biff/formula/Token;->getCode()B

    move-result v7

    aput-byte v7, v6, v4

    add-int/lit8 v7, v4, 0x1

    const/4 v8, 0x2

    aput-byte v8, v6, v7

    add-int/2addr v4, v8

    const/4 v7, 0x1

    aget-object v9, v0, v7

    invoke-virtual {v9}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v9

    array-length v10, v9

    add-int/2addr v10, v5

    new-array v11, v10, [B

    invoke-static {v6, v2, v11, v2, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v6, v9

    invoke-static {v9, v2, v11, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v5, v10, 0x4

    new-array v6, v5, [B

    invoke-static {v11, v2, v6, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {v3}, Ljxl/biff/formula/Token;->getCode()B

    move-result v9

    aput-byte v9, v6, v10

    add-int/lit8 v9, v10, 0x1

    const/16 v11, 0x8

    aput-byte v11, v6, v9

    add-int/2addr v10, v8

    const/4 v9, 0x3

    if-le v1, v8, :cond_0

    sub-int v12, v5, v4

    sub-int/2addr v12, v8

    invoke-static {v12, v6, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v12, v1, -0x1

    aget-object v0, v0, v12

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v0

    array-length v12, v0

    add-int/2addr v12, v5

    new-array v13, v12, [B

    invoke-static {v6, v2, v13, v2, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v6, v0

    invoke-static {v0, v2, v13, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v0, v12, 0x4

    new-array v6, v0, [B

    invoke-static {v13, v2, v6, v2, v12}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {v3}, Ljxl/biff/formula/Token;->getCode()B

    move-result v0

    aput-byte v0, v6, v12

    add-int/lit8 v0, v12, 0x1

    aput-byte v11, v6, v0

    add-int/2addr v12, v8

    aput-byte v9, v6, v12

    :cond_0
    array-length v0, v6

    array-length v3, v6

    add-int/lit8 v3, v3, 0x4

    new-array v5, v3, [B

    array-length v11, v6

    invoke-static {v6, v2, v5, v2, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v6, Ljxl/biff/formula/Token;->FUNCTIONVARARG:Ljxl/biff/formula/Token;

    invoke-virtual {v6}, Ljxl/biff/formula/Token;->getCode()B

    move-result v6

    aput-byte v6, v5, v0

    add-int/lit8 v6, v0, 0x1

    int-to-byte v11, v1

    aput-byte v11, v5, v6

    add-int/lit8 v6, v0, 0x2

    aput-byte v7, v5, v6

    add-int/2addr v0, v9

    aput-byte v2, v5, v0

    sub-int/2addr v3, v7

    if-ge v1, v9, :cond_1

    sub-int v0, v3, v4

    add-int/lit8 v0, v0, -0x5

    invoke-static {v0, v5, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    :cond_1
    sub-int/2addr v3, v10

    sub-int/2addr v3, v8

    invoke-static {v3, v5, v10}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v5
.end method


# virtual methods
.method public adjustRelativeCellReferences(II)V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2, p1, p2}, Ljxl/biff/formula/ParseItem;->adjustRelativeCellReferences(II)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method columnInserted(IIZ)V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnInserted(IIZ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method columnRemoved(IIZ)V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnRemoved(IIZ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method getBytes()[B
    .locals 7

    const/4 v0, 0x0

    new-array v1, v0, [B

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isSum()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v2

    array-length v3, v2

    add-int/lit8 v3, v3, -0x1

    :goto_0
    if-ltz v3, :cond_0

    aget-object v4, v2, v3

    invoke-virtual {v4}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v4

    array-length v5, v1

    array-length v6, v4

    add-int/2addr v5, v6

    new-array v5, v5, [B

    array-length v6, v1

    invoke-static {v1, v0, v5, v0, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v1, v1

    array-length v6, v4

    invoke-static {v4, v0, v5, v1, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/lit8 v3, v3, -0x1

    move-object v1, v5

    goto :goto_0

    :cond_0
    array-length v2, v1

    add-int/lit8 v2, v2, 0x4

    new-array v2, v2, [B

    array-length v3, v1

    invoke-static {v1, v0, v2, v0, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v0, v1

    sget-object v3, Ljxl/biff/formula/Token;->ATTRIBUTE:Ljxl/biff/formula/Token;

    invoke-virtual {v3}, Ljxl/biff/formula/Token;->getCode()B

    move-result v3

    aput-byte v3, v2, v0

    array-length v0, v1

    add-int/lit8 v0, v0, 0x1

    const/16 v1, 0x10

    aput-byte v1, v2, v0

    move-object v1, v2

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-direct {p0}, Ljxl/biff/formula/Attribute;->getIf()[B

    move-result-object v0

    return-object v0

    :cond_2
    :goto_1
    return-object v1
.end method

.method public getOperands(Ljava/util/Stack;)V
    .locals 2

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v1, v0, 0x10

    if-eqz v1, :cond_0

    :goto_0
    invoke-virtual {p1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/formula/ParseItem;

    invoke-virtual {p0, p1}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    goto :goto_1

    :cond_0
    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return-void
.end method

.method getPrecedence()I
    .locals 1

    const/4 v0, 0x3

    return v0
.end method

.method public getString(Ljava/lang/StringBuffer;)V
    .locals 6

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v1, v0, 0x10

    const/16 v2, 0x29

    const/4 v3, 0x0

    const/16 v4, 0x28

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    sget-object v1, Ljxl/biff/formula/Function;->SUM:Ljxl/biff/formula/Function;

    iget-object v5, p0, Ljxl/biff/formula/Attribute;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v1, v5}, Ljxl/biff/formula/Function;->getName(Ljxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1, v4}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    aget-object v0, v0, v3

    :goto_0
    invoke-virtual {v0, p1}, Ljxl/biff/formula/ParseItem;->getString(Ljava/lang/StringBuffer;)V

    invoke-virtual {p1, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_2

    :cond_0
    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_2

    sget-object v0, Ljxl/biff/formula/Function;->IF:Ljxl/biff/formula/Function;

    iget-object v1, p0, Ljxl/biff/formula/Attribute;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {v0, v1}, Ljxl/biff/formula/Function;->getName(Ljxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1, v4}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_1
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    if-ge v3, v1, :cond_1

    aget-object v1, v0, v3

    invoke-virtual {v1, p1}, Ljxl/biff/formula/ParseItem;->getString(Ljava/lang/StringBuffer;)V

    const/16 v1, 0x2c

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    array-length v1, v0

    add-int/lit8 v1, v1, -0x1

    aget-object v0, v0, v1

    goto :goto_0

    :cond_2
    :goto_2
    return-void
.end method

.method handleImportedCellReferences()V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2}, Ljxl/biff/formula/ParseItem;->handleImportedCellReferences()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method public isChoose()Z
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isFunction()Z
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v0, v0, 0x12

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isGoto()Z
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v0, v0, 0x8

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isIf()Z
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isSum()Z
    .locals 1

    iget v0, p0, Ljxl/biff/formula/Attribute;->options:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public read([BI)I
    .locals 1

    aget-byte v0, p1, p2

    iput v0, p0, Ljxl/biff/formula/Attribute;->options:I

    add-int/lit8 v0, p2, 0x1

    aget-byte v0, p1, v0

    add-int/lit8 p2, p2, 0x2

    aget-byte p1, p1, p2

    invoke-static {v0, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/biff/formula/Attribute;->word:I

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isChoose()Z

    move-result p1

    const/4 p2, 0x3

    if-nez p1, :cond_0

    return p2

    :cond_0
    iget p1, p0, Ljxl/biff/formula/Attribute;->word:I

    add-int/lit8 p1, p1, 0x1

    mul-int/lit8 p1, p1, 0x2

    add-int/2addr p1, p2

    return p1
.end method

.method rowInserted(IIZ)V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowInserted(IIZ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method rowRemoved(IIZ)V
    .locals 3

    invoke-virtual {p0}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    invoke-virtual {v0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljxl/biff/formula/Operator;->getOperands()[Ljxl/biff/formula/ParseItem;

    move-result-object v0

    :goto_0
    const/4 v1, 0x0

    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_1

    aget-object v2, v0, v1

    invoke-virtual {v2, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowRemoved(IIZ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method setIfConditions(Ljxl/biff/formula/VariableArgFunction;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/formula/Attribute;->ifConditions:Ljxl/biff/formula/VariableArgFunction;

    iget p1, p0, Ljxl/biff/formula/Attribute;->options:I

    or-int/lit8 p1, p1, 0x2

    iput p1, p0, Ljxl/biff/formula/Attribute;->options:I

    return-void
.end method
