.class Ljxl/biff/formula/TokenFormulaParser;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/formula/Parser;


# static fields
.field static synthetic class$jxl$biff$formula$TokenFormulaParser:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private nameTable:Ljxl/biff/WorkbookMethods;

.field private pos:I

.field private relativeTo:Ljxl/Cell;

.field private root:Ljxl/biff/formula/ParseItem;

.field private settings:Ljxl/WorkbookSettings;

.field private tokenData:[B

.field private tokenStack:Ljava/util/Stack;

.field private workbook:Ljxl/biff/formula/ExternalSheet;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/TokenFormulaParser;->class$jxl$biff$formula$TokenFormulaParser:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.TokenFormulaParser"

    invoke-static {v0}, Ljxl/biff/formula/TokenFormulaParser;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/TokenFormulaParser;->class$jxl$biff$formula$TokenFormulaParser:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/TokenFormulaParser;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>([BLjxl/Cell;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    const/4 p1, 0x0

    iput p1, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iput-object p2, p0, Ljxl/biff/formula/TokenFormulaParser;->relativeTo:Ljxl/Cell;

    iput-object p3, p0, Ljxl/biff/formula/TokenFormulaParser;->workbook:Ljxl/biff/formula/ExternalSheet;

    iput-object p4, p0, Ljxl/biff/formula/TokenFormulaParser;->nameTable:Ljxl/biff/WorkbookMethods;

    new-instance p2, Ljava/util/Stack;

    invoke-direct {p2}, Ljava/util/Stack;-><init>()V

    iput-object p2, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    iput-object p5, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    iget-object p2, p0, Ljxl/biff/formula/TokenFormulaParser;->nameTable:Ljxl/biff/WorkbookMethods;

    if-eqz p2, :cond_0

    const/4 p1, 0x1

    :cond_0
    invoke-static {p1}, Ljxl/common/Assert;->verify(Z)V

    return-void
.end method

.method private addOperator(Ljxl/biff/formula/Operator;)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/Operator;->getOperands(Ljava/util/Stack;)V

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

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

.method private handleMemoryFunction(Ljxl/biff/formula/SubExpression;)V
    .locals 4

    iget v0, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v1, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v1, v0}, Ljxl/biff/formula/SubExpression;->read([BI)I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    new-instance v1, Ljava/util/Stack;

    invoke-direct {v1}, Ljava/util/Stack;-><init>()V

    iput-object v1, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {p1}, Ljxl/biff/formula/SubExpression;->getLength()I

    move-result v1

    invoke-direct {p0, v1}, Ljxl/biff/formula/TokenFormulaParser;->parseSubExpression(I)V

    iget-object v1, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    new-array v1, v1, [Ljxl/biff/formula/ParseItem;

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/biff/formula/ParseItem;

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p1, v1}, Ljxl/biff/formula/SubExpression;->setSubExpression([Ljxl/biff/formula/ParseItem;)V

    iput-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private parseSubExpression(I)V
    .locals 4

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iget v1, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    add-int/2addr v1, p1

    :cond_0
    :goto_0
    iget p1, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    if-ge p1, v1, :cond_29

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    aget-byte v2, v2, p1

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    invoke-static {v2}, Ljxl/biff/formula/Token;->getToken(I)Ljxl/biff/formula/Token;

    move-result-object p1

    sget-object v3, Ljxl/biff/formula/Token;->UNKNOWN:Ljxl/biff/formula/Token;

    if-eq p1, v3, :cond_28

    if-eq p1, v3, :cond_1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    :goto_1
    invoke-static {v2}, Ljxl/common/Assert;->verify(Z)V

    sget-object v2, Ljxl/biff/formula/Token;->REF:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_2

    new-instance p1, Ljxl/biff/formula/CellReference;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->relativeTo:Ljxl/Cell;

    invoke-direct {p1, v2}, Ljxl/biff/formula/CellReference;-><init>(Ljxl/Cell;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/CellReference;->read([BI)I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    iput v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v2, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_2
    sget-object v2, Ljxl/biff/formula/Token;->REFERR:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_3

    new-instance p1, Ljxl/biff/formula/CellReferenceError;

    invoke-direct {p1}, Ljxl/biff/formula/CellReferenceError;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/CellReferenceError;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_3
    sget-object v2, Ljxl/biff/formula/Token;->ERR:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_4

    new-instance p1, Ljxl/biff/formula/ErrorConstant;

    invoke-direct {p1}, Ljxl/biff/formula/ErrorConstant;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/ErrorConstant;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_4
    sget-object v2, Ljxl/biff/formula/Token;->REFV:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_5

    new-instance p1, Ljxl/biff/formula/SharedFormulaCellReference;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->relativeTo:Ljxl/Cell;

    invoke-direct {p1, v2}, Ljxl/biff/formula/SharedFormulaCellReference;-><init>(Ljxl/Cell;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/SharedFormulaCellReference;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_5
    sget-object v2, Ljxl/biff/formula/Token;->REF3D:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_6

    new-instance p1, Ljxl/biff/formula/CellReference3d;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->relativeTo:Ljxl/Cell;

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->workbook:Ljxl/biff/formula/ExternalSheet;

    invoke-direct {p1, v2, v3}, Ljxl/biff/formula/CellReference3d;-><init>(Ljxl/Cell;Ljxl/biff/formula/ExternalSheet;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/CellReference3d;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_6
    sget-object v2, Ljxl/biff/formula/Token;->AREA:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_7

    new-instance p1, Ljxl/biff/formula/Area;

    invoke-direct {p1}, Ljxl/biff/formula/Area;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/Area;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_7
    sget-object v2, Ljxl/biff/formula/Token;->AREAV:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_8

    new-instance p1, Ljxl/biff/formula/SharedFormulaArea;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->relativeTo:Ljxl/Cell;

    invoke-direct {p1, v2}, Ljxl/biff/formula/SharedFormulaArea;-><init>(Ljxl/Cell;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/SharedFormulaArea;->read([BI)I

    move-result v3

    goto :goto_2

    :cond_8
    sget-object v2, Ljxl/biff/formula/Token;->AREA3D:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_9

    new-instance p1, Ljxl/biff/formula/Area3d;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->workbook:Ljxl/biff/formula/ExternalSheet;

    invoke-direct {p1, v2}, Ljxl/biff/formula/Area3d;-><init>(Ljxl/biff/formula/ExternalSheet;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/Area3d;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_9
    sget-object v2, Ljxl/biff/formula/Token;->NAME:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_a

    new-instance p1, Ljxl/biff/formula/Name;

    invoke-direct {p1}, Ljxl/biff/formula/Name;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/Name;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_a
    sget-object v2, Ljxl/biff/formula/Token;->NAMED_RANGE:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_b

    new-instance p1, Ljxl/biff/formula/NameRange;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->nameTable:Ljxl/biff/WorkbookMethods;

    invoke-direct {p1, v2}, Ljxl/biff/formula/NameRange;-><init>(Ljxl/biff/WorkbookMethods;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/NameRange;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_b
    sget-object v2, Ljxl/biff/formula/Token;->INTEGER:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_c

    new-instance p1, Ljxl/biff/formula/IntegerValue;

    invoke-direct {p1}, Ljxl/biff/formula/IntegerValue;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/IntegerValue;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_c
    sget-object v2, Ljxl/biff/formula/Token;->DOUBLE:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_d

    new-instance p1, Ljxl/biff/formula/DoubleValue;

    invoke-direct {p1}, Ljxl/biff/formula/DoubleValue;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/DoubleValue;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_d
    sget-object v2, Ljxl/biff/formula/Token;->BOOL:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_e

    new-instance p1, Ljxl/biff/formula/BooleanValue;

    invoke-direct {p1}, Ljxl/biff/formula/BooleanValue;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BooleanValue;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_e
    sget-object v2, Ljxl/biff/formula/Token;->STRING:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_f

    new-instance p1, Ljxl/biff/formula/StringValue;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p1, v2}, Ljxl/biff/formula/StringValue;-><init>(Ljxl/WorkbookSettings;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/StringValue;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_f
    sget-object v2, Ljxl/biff/formula/Token;->MISSING_ARG:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_10

    new-instance p1, Ljxl/biff/formula/MissingArg;

    invoke-direct {p1}, Ljxl/biff/formula/MissingArg;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/MissingArg;->read([BI)I

    move-result v3

    goto/16 :goto_2

    :cond_10
    sget-object v2, Ljxl/biff/formula/Token;->UNARY_PLUS:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_11

    new-instance p1, Ljxl/biff/formula/UnaryPlus;

    invoke-direct {p1}, Ljxl/biff/formula/UnaryPlus;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/UnaryOperator;->read([BI)I

    move-result v3

    :goto_3
    add-int/2addr v2, v3

    iput v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    :goto_4
    invoke-direct {p0, p1}, Ljxl/biff/formula/TokenFormulaParser;->addOperator(Ljxl/biff/formula/Operator;)V

    goto/16 :goto_0

    :cond_11
    sget-object v2, Ljxl/biff/formula/Token;->UNARY_MINUS:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_12

    new-instance p1, Ljxl/biff/formula/UnaryMinus;

    invoke-direct {p1}, Ljxl/biff/formula/UnaryMinus;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/UnaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_12
    sget-object v2, Ljxl/biff/formula/Token;->PERCENT:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_13

    new-instance p1, Ljxl/biff/formula/Percent;

    invoke-direct {p1}, Ljxl/biff/formula/Percent;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/UnaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_13
    sget-object v2, Ljxl/biff/formula/Token;->SUBTRACT:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_14

    new-instance p1, Ljxl/biff/formula/Subtract;

    invoke-direct {p1}, Ljxl/biff/formula/Subtract;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_14
    sget-object v2, Ljxl/biff/formula/Token;->ADD:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_15

    new-instance p1, Ljxl/biff/formula/Add;

    invoke-direct {p1}, Ljxl/biff/formula/Add;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_15
    sget-object v2, Ljxl/biff/formula/Token;->MULTIPLY:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_16

    new-instance p1, Ljxl/biff/formula/Multiply;

    invoke-direct {p1}, Ljxl/biff/formula/Multiply;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_16
    sget-object v2, Ljxl/biff/formula/Token;->DIVIDE:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_17

    new-instance p1, Ljxl/biff/formula/Divide;

    invoke-direct {p1}, Ljxl/biff/formula/Divide;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto :goto_3

    :cond_17
    sget-object v2, Ljxl/biff/formula/Token;->CONCAT:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_18

    new-instance p1, Ljxl/biff/formula/Concatenate;

    invoke-direct {p1}, Ljxl/biff/formula/Concatenate;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_18
    sget-object v2, Ljxl/biff/formula/Token;->POWER:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_19

    new-instance p1, Ljxl/biff/formula/Power;

    invoke-direct {p1}, Ljxl/biff/formula/Power;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_19
    sget-object v2, Ljxl/biff/formula/Token;->LESS_THAN:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1a

    new-instance p1, Ljxl/biff/formula/LessThan;

    invoke-direct {p1}, Ljxl/biff/formula/LessThan;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1a
    sget-object v2, Ljxl/biff/formula/Token;->LESS_EQUAL:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1b

    new-instance p1, Ljxl/biff/formula/LessEqual;

    invoke-direct {p1}, Ljxl/biff/formula/LessEqual;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1b
    sget-object v2, Ljxl/biff/formula/Token;->GREATER_THAN:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1c

    new-instance p1, Ljxl/biff/formula/GreaterThan;

    invoke-direct {p1}, Ljxl/biff/formula/GreaterThan;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1c
    sget-object v2, Ljxl/biff/formula/Token;->GREATER_EQUAL:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1d

    new-instance p1, Ljxl/biff/formula/GreaterEqual;

    invoke-direct {p1}, Ljxl/biff/formula/GreaterEqual;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1d
    sget-object v2, Ljxl/biff/formula/Token;->NOT_EQUAL:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1e

    new-instance p1, Ljxl/biff/formula/NotEqual;

    invoke-direct {p1}, Ljxl/biff/formula/NotEqual;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1e
    sget-object v2, Ljxl/biff/formula/Token;->EQUAL:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_1f

    new-instance p1, Ljxl/biff/formula/Equal;

    invoke-direct {p1}, Ljxl/biff/formula/Equal;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BinaryOperator;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_1f
    sget-object v2, Ljxl/biff/formula/Token;->PARENTHESIS:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_20

    new-instance p1, Ljxl/biff/formula/Parenthesis;

    invoke-direct {p1}, Ljxl/biff/formula/Parenthesis;-><init>()V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/Parenthesis;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_20
    sget-object v2, Ljxl/biff/formula/Token;->ATTRIBUTE:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_22

    new-instance p1, Ljxl/biff/formula/Attribute;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p1, v2}, Ljxl/biff/formula/Attribute;-><init>(Ljxl/WorkbookSettings;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/Attribute;->read([BI)I

    move-result v3

    add-int/2addr v2, v3

    iput v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    invoke-virtual {p1}, Ljxl/biff/formula/Attribute;->isSum()Z

    move-result v2

    if-eqz v2, :cond_21

    :goto_5
    goto/16 :goto_4

    :cond_21
    invoke-virtual {p1}, Ljxl/biff/formula/Attribute;->isIf()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    :cond_22
    sget-object v2, Ljxl/biff/formula/Token;->FUNCTION:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_23

    new-instance p1, Ljxl/biff/formula/BuiltInFunction;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p1, v2}, Ljxl/biff/formula/BuiltInFunction;-><init>(Ljxl/WorkbookSettings;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/BuiltInFunction;->read([BI)I

    move-result v3

    goto/16 :goto_3

    :cond_23
    sget-object v2, Ljxl/biff/formula/Token;->FUNCTIONVARARG:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_26

    new-instance p1, Ljxl/biff/formula/VariableArgFunction;

    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p1, v2}, Ljxl/biff/formula/VariableArgFunction;-><init>(Ljxl/WorkbookSettings;)V

    iget v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    invoke-virtual {p1, v3, v2}, Ljxl/biff/formula/VariableArgFunction;->read([BI)I

    move-result v3

    add-int/2addr v2, v3

    iput v2, p0, Ljxl/biff/formula/TokenFormulaParser;->pos:I

    invoke-virtual {p1}, Ljxl/biff/formula/VariableArgFunction;->getFunction()Ljxl/biff/formula/Function;

    move-result-object v2

    sget-object v3, Ljxl/biff/formula/Function;->ATTRIBUTE:Ljxl/biff/formula/Function;

    if-eq v2, v3, :cond_24

    goto :goto_5

    :cond_24
    iget-object v2, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {p1, v2}, Ljxl/biff/formula/VariableArgFunction;->getOperands(Ljava/util/Stack;)V

    invoke-virtual {v0}, Ljava/util/Stack;->empty()Z

    move-result v2

    if-eqz v2, :cond_25

    new-instance v2, Ljxl/biff/formula/Attribute;

    iget-object v3, p0, Ljxl/biff/formula/TokenFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v2, v3}, Ljxl/biff/formula/Attribute;-><init>(Ljxl/WorkbookSettings;)V

    goto :goto_6

    :cond_25
    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/formula/Attribute;

    :goto_6
    invoke-virtual {v2, p1}, Ljxl/biff/formula/Attribute;->setIfConditions(Ljxl/biff/formula/VariableArgFunction;)V

    iget-object p1, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {p1, v2}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    :cond_26
    sget-object v2, Ljxl/biff/formula/Token;->MEM_FUNC:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_27

    new-instance p1, Ljxl/biff/formula/MemFunc;

    invoke-direct {p1}, Ljxl/biff/formula/MemFunc;-><init>()V

    :goto_7
    invoke-direct {p0, p1}, Ljxl/biff/formula/TokenFormulaParser;->handleMemoryFunction(Ljxl/biff/formula/SubExpression;)V

    goto/16 :goto_0

    :cond_27
    sget-object v2, Ljxl/biff/formula/Token;->MEM_AREA:Ljxl/biff/formula/Token;

    if-ne p1, v2, :cond_0

    new-instance p1, Ljxl/biff/formula/MemArea;

    invoke-direct {p1}, Ljxl/biff/formula/MemArea;-><init>()V

    goto :goto_7

    :cond_28
    new-instance p1, Ljxl/biff/formula/FormulaException;

    sget-object v0, Ljxl/biff/formula/FormulaException;->UNRECOGNIZED_TOKEN:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {p1, v0, v2}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;I)V

    throw p1

    :cond_29
    return-void
.end method


# virtual methods
.method public adjustRelativeCellReferences(II)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2}, Ljxl/biff/formula/ParseItem;->adjustRelativeCellReferences(II)V

    return-void
.end method

.method public columnInserted(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnInserted(IIZ)V

    return-void
.end method

.method public columnRemoved(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnRemoved(IIZ)V

    return-void
.end method

.method public getBytes()[B
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v0

    return-object v0
.end method

.method public getFormula()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    iget-object v1, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v1, v0}, Ljxl/biff/formula/ParseItem;->getString(Ljava/lang/StringBuffer;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public handleImportedCellReferences()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->handleImportedCellReferences()V

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->isValid()Z

    move-result v0

    return v0
.end method

.method public parse()V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenData:[B

    array-length v0, v0

    invoke-direct {p0, v0}, Ljxl/biff/formula/TokenFormulaParser;->parseSubExpression(I)V

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljxl/biff/formula/ParseItem;

    iput-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->tokenStack:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->empty()Z

    move-result v0

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    return-void
.end method

.method public rowInserted(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowInserted(IIZ)V

    return-void
.end method

.method public rowRemoved(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/TokenFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowRemoved(IIZ)V

    return-void
.end method
