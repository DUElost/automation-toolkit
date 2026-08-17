.class Ljxl/biff/formula/StringFormulaParser;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljxl/biff/formula/Parser;


# static fields
.field static synthetic class$jxl$biff$formula$StringFormulaParser:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private arguments:Ljava/util/Stack;

.field private externalSheet:Ljxl/biff/formula/ExternalSheet;

.field private formula:Ljava/lang/String;

.field private nameTable:Ljxl/biff/WorkbookMethods;

.field private parseContext:Ljxl/biff/formula/ParseContext;

.field private parsedFormula:Ljava/lang/String;

.field private root:Ljxl/biff/formula/ParseItem;

.field private settings:Ljxl/WorkbookSettings;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/StringFormulaParser;->class$jxl$biff$formula$StringFormulaParser:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.StringFormulaParser"

    invoke-static {v0}, Ljxl/biff/formula/StringFormulaParser;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/StringFormulaParser;->class$jxl$biff$formula$StringFormulaParser:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/StringFormulaParser;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;Ljxl/biff/formula/ParseContext;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/StringFormulaParser;->formula:Ljava/lang/String;

    iput-object p4, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    iput-object p2, p0, Ljxl/biff/formula/StringFormulaParser;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    iput-object p3, p0, Ljxl/biff/formula/StringFormulaParser;->nameTable:Ljxl/biff/WorkbookMethods;

    iput-object p5, p0, Ljxl/biff/formula/StringFormulaParser;->parseContext:Ljxl/biff/formula/ParseContext;

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

.method private getTokens()Ljava/util/ArrayList;
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/io/StringReader;

    iget-object v2, p0, Ljxl/biff/formula/StringFormulaParser;->formula:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljxl/biff/formula/Yylex;

    invoke-direct {v2, v1}, Ljxl/biff/formula/Yylex;-><init>(Ljava/io/Reader;)V

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->externalSheet:Ljxl/biff/formula/ExternalSheet;

    invoke-virtual {v2, v1}, Ljxl/biff/formula/Yylex;->setExternalSheet(Ljxl/biff/formula/ExternalSheet;)V

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->nameTable:Ljxl/biff/WorkbookMethods;

    invoke-virtual {v2, v1}, Ljxl/biff/formula/Yylex;->setNameTable(Ljxl/biff/WorkbookMethods;)V

    :goto_0
    :try_start_0
    invoke-virtual {v2}, Ljxl/biff/formula/Yylex;->yylex()Ljxl/biff/formula/ParseItem;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-instance v0, Ljxl/biff/formula/FormulaException;

    sget-object v1, Ljxl/biff/formula/FormulaException;->LEXICAL_ERROR:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    iget-object v4, p0, Ljxl/biff/formula/StringFormulaParser;->formula:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v4, " at char  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljxl/biff/formula/Yylex;->getPos()I

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;Ljava/lang/String;)V

    throw v0

    :catch_1
    move-exception v1

    sget-object v2, Ljxl/biff/formula/StringFormulaParser;->logger:Ljxl/common/Logger;

    invoke-virtual {v1}, Ljava/io/IOException;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_0
    return-object v0
.end method

.method private handleFunction(Ljxl/biff/formula/StringFunction;Ljava/util/Iterator;Ljava/util/Stack;)V
    .locals 6

    invoke-direct {p0, p2}, Ljxl/biff/formula/StringFormulaParser;->parseCurrent(Ljava/util/Iterator;)Ljxl/biff/formula/ParseItem;

    move-result-object p2

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object v0

    sget-object v1, Ljxl/biff/formula/Function;->UNKNOWN:Ljxl/biff/formula/Function;

    if-eq v0, v1, :cond_e

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object v0

    sget-object v1, Ljxl/biff/formula/Function;->SUM:Ljxl/biff/formula/Function;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    if-nez v0, :cond_0

    new-instance v0, Ljxl/biff/formula/Attribute;

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v0, p1, v1}, Ljxl/biff/formula/Attribute;-><init>(Ljxl/biff/formula/StringFunction;Ljxl/WorkbookSettings;)V

    invoke-virtual {v0, p2}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    invoke-virtual {p3, v0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_0
    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object v0

    sget-object v1, Ljxl/biff/formula/Function;->IF:Ljxl/biff/formula/Function;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_2

    new-instance p2, Ljxl/biff/formula/Attribute;

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p2, p1, v0}, Ljxl/biff/formula/Attribute;-><init>(Ljxl/biff/formula/StringFunction;Ljxl/WorkbookSettings;)V

    new-instance p1, Ljxl/biff/formula/VariableArgFunction;

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {p1, v0}, Ljxl/biff/formula/VariableArgFunction;-><init>(Ljxl/WorkbookSettings;)V

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v0

    :goto_0
    if-ge v2, v0, :cond_1

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {v1, v2}, Ljava/util/Stack;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/formula/ParseItem;

    invoke-virtual {p1, v1}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p2, p1}, Ljxl/biff/formula/Attribute;->setIfConditions(Ljxl/biff/formula/VariableArgFunction;)V

    invoke-virtual {p3, p2}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_2
    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/biff/formula/Function;->getNumArgs()I

    move-result v0

    const/16 v1, 0xff

    const/4 v3, 0x1

    if-ne v0, v1, :cond_8

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    if-nez v0, :cond_5

    if-eqz p2, :cond_3

    move v2, v3

    :cond_3
    new-instance v0, Ljxl/biff/formula/VariableArgFunction;

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v1}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object p1

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v0, p1, v2, v1}, Ljxl/biff/formula/VariableArgFunction;-><init>(Ljxl/biff/formula/Function;ILjxl/WorkbookSettings;)V

    if-eqz p2, :cond_4

    invoke-virtual {v0, p2}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    :cond_4
    invoke-virtual {p3, v0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    :cond_5
    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result p2

    new-instance v0, Ljxl/biff/formula/VariableArgFunction;

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v1}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object p1

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v0, p1, p2, v1}, Ljxl/biff/formula/VariableArgFunction;-><init>(Ljxl/biff/formula/Function;ILjxl/WorkbookSettings;)V

    new-array p1, p2, [Ljxl/biff/formula/ParseItem;

    move v1, v2

    :goto_1
    if-ge v1, p2, :cond_6

    iget-object v4, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljxl/biff/formula/ParseItem;

    sub-int v5, p2, v1

    sub-int/2addr v5, v3

    aput-object v4, p1, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_6
    :goto_2
    if-ge v2, p2, :cond_7

    aget-object v1, p1, v2

    invoke-virtual {v0, v1}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_7
    invoke-virtual {p3, v0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {p1}, Ljava/util/Stack;->clear()V

    const/4 p1, 0x0

    iput-object p1, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    :goto_3
    return-void

    :cond_8
    new-instance v0, Ljxl/biff/formula/BuiltInFunction;

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v1}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object v1

    iget-object v4, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-direct {v0, v1, v4}, Ljxl/biff/formula/BuiltInFunction;-><init>(Ljxl/biff/formula/Function;Ljxl/WorkbookSettings;)V

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->settings:Ljxl/WorkbookSettings;

    invoke-virtual {p1, v1}, Ljxl/biff/formula/StringFunction;->getFunction(Ljxl/WorkbookSettings;)Ljxl/biff/formula/Function;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/biff/formula/Function;->getNumArgs()I

    move-result p1

    if-ne p1, v3, :cond_9

    invoke-virtual {v0, p2}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    goto :goto_5

    :cond_9
    iget-object p2, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    if-nez p2, :cond_a

    if-nez p1, :cond_b

    :cond_a
    if-eqz p2, :cond_c

    invoke-virtual {p2}, Ljava/util/Stack;->size()I

    move-result p2

    if-ne p1, p2, :cond_b

    goto :goto_4

    :cond_b
    new-instance p1, Ljxl/biff/formula/FormulaException;

    sget-object p2, Ljxl/biff/formula/FormulaException;->INCORRECT_ARGUMENTS:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {p1, p2}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;)V

    throw p1

    :cond_c
    :goto_4
    if-ge v2, p1, :cond_d

    iget-object p2, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {p2, v2}, Ljava/util/Stack;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p2}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_d
    :goto_5
    invoke-virtual {p3, v0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_e
    new-instance p1, Ljxl/biff/formula/FormulaException;

    sget-object p2, Ljxl/biff/formula/FormulaException;->UNRECOGNIZED_FUNCTION:Ljxl/biff/formula/FormulaException$FormulaMessage;

    invoke-direct {p1, p2}, Ljxl/biff/formula/FormulaException;-><init>(Ljxl/biff/formula/FormulaException$FormulaMessage;)V

    throw p1
.end method

.method private handleOperand(Ljxl/biff/formula/Operand;Ljava/util/Stack;)V
    .locals 3

    instance-of v0, p1, Ljxl/biff/formula/IntegerValue;

    if-nez v0, :cond_0

    invoke-virtual {p2, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_0
    if-eqz v0, :cond_2

    check-cast p1, Ljxl/biff/formula/IntegerValue;

    invoke-virtual {p1}, Ljxl/biff/formula/IntegerValue;->isOutOfRange()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p2, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    new-instance v0, Ljxl/biff/formula/DoubleValue;

    invoke-virtual {p1}, Ljxl/biff/formula/IntegerValue;->getValue()D

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljxl/biff/formula/DoubleValue;-><init>(D)V

    invoke-virtual {p2, v0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    :goto_0
    return-void
.end method

.method private parseCurrent(Ljava/util/Iterator;)Ljxl/biff/formula/ParseItem;
    .locals 10

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    new-instance v1, Ljava/util/Stack;

    invoke-direct {v1}, Ljava/util/Stack;-><init>()V

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v4, v2

    move-object v5, v4

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_e

    if-nez v3, :cond_e

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljxl/biff/formula/ParseItem;

    iget-object v7, p0, Ljxl/biff/formula/StringFormulaParser;->parseContext:Ljxl/biff/formula/ParseContext;

    invoke-virtual {v6, v7}, Ljxl/biff/formula/ParseItem;->setParseContext(Ljxl/biff/formula/ParseContext;)V

    instance-of v7, v6, Ljxl/biff/formula/Operand;

    if-eqz v7, :cond_0

    move-object v5, v6

    check-cast v5, Ljxl/biff/formula/Operand;

    invoke-direct {p0, v5, v0}, Ljxl/biff/formula/StringFormulaParser;->handleOperand(Ljxl/biff/formula/Operand;Ljava/util/Stack;)V

    goto/16 :goto_5

    :cond_0
    instance-of v7, v6, Ljxl/biff/formula/StringFunction;

    if-eqz v7, :cond_1

    move-object v5, v6

    check-cast v5, Ljxl/biff/formula/StringFunction;

    invoke-direct {p0, v5, p1, v0}, Ljxl/biff/formula/StringFormulaParser;->handleFunction(Ljxl/biff/formula/StringFunction;Ljava/util/Iterator;Ljava/util/Stack;)V

    goto/16 :goto_5

    :cond_1
    instance-of v7, v6, Ljxl/biff/formula/Operator;

    if-eqz v7, :cond_8

    move-object v7, v6

    check-cast v7, Ljxl/biff/formula/Operator;

    instance-of v8, v7, Ljxl/biff/formula/StringOperator;

    if-eqz v8, :cond_4

    check-cast v7, Ljxl/biff/formula/StringOperator;

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_3

    instance-of v5, v5, Ljxl/biff/formula/Operator;

    if-eqz v5, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v7}, Ljxl/biff/formula/StringOperator;->getBinaryOperator()Ljxl/biff/formula/Operator;

    move-result-object v7

    goto :goto_2

    :cond_3
    :goto_1
    invoke-virtual {v7}, Ljxl/biff/formula/StringOperator;->getUnaryOperator()Ljxl/biff/formula/Operator;

    move-result-object v7

    :cond_4
    :goto_2
    invoke-virtual {v1}, Ljava/util/Stack;->empty()Z

    move-result v5

    if-eqz v5, :cond_5

    :goto_3
    invoke-virtual {v1, v7}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_5

    :cond_5
    invoke-virtual {v1}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/formula/Operator;

    invoke-virtual {v7}, Ljxl/biff/formula/Operator;->getPrecedence()I

    move-result v8

    invoke-virtual {v5}, Ljxl/biff/formula/Operator;->getPrecedence()I

    move-result v9

    if-ge v8, v9, :cond_6

    goto :goto_3

    :cond_6
    invoke-virtual {v7}, Ljxl/biff/formula/Operator;->getPrecedence()I

    move-result v8

    invoke-virtual {v5}, Ljxl/biff/formula/Operator;->getPrecedence()I

    move-result v9

    if-ne v8, v9, :cond_7

    instance-of v8, v7, Ljxl/biff/formula/UnaryOperator;

    if-eqz v8, :cond_7

    goto :goto_3

    :cond_7
    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    invoke-virtual {v5, v0}, Ljxl/biff/formula/Operator;->getOperands(Ljava/util/Stack;)V

    invoke-virtual {v0, v5}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    :cond_8
    instance-of v5, v6, Ljxl/biff/formula/ArgumentSeparator;

    if-eqz v5, :cond_b

    :goto_4
    invoke-virtual {v1}, Ljava/util/Stack;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_9

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/formula/Operator;

    invoke-virtual {v5, v0}, Ljxl/biff/formula/Operator;->getOperands(Ljava/util/Stack;)V

    invoke-virtual {v0, v5}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_4

    :cond_9
    if-nez v4, :cond_a

    new-instance v4, Ljava/util/Stack;

    invoke-direct {v4}, Ljava/util/Stack;-><init>()V

    :cond_a
    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/util/Stack;->clear()V

    goto :goto_5

    :cond_b
    instance-of v5, v6, Ljxl/biff/formula/OpenParentheses;

    if-eqz v5, :cond_c

    invoke-direct {p0, p1}, Ljxl/biff/formula/StringFormulaParser;->parseCurrent(Ljava/util/Iterator;)Ljxl/biff/formula/ParseItem;

    move-result-object v5

    new-instance v7, Ljxl/biff/formula/Parenthesis;

    invoke-direct {v7}, Ljxl/biff/formula/Parenthesis;-><init>()V

    invoke-virtual {v5, v7}, Ljxl/biff/formula/ParseItem;->setParent(Ljxl/biff/formula/ParseItem;)V

    invoke-virtual {v7, v5}, Ljxl/biff/formula/Operator;->add(Ljxl/biff/formula/ParseItem;)V

    invoke-virtual {v0, v7}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_5

    :cond_c
    instance-of v5, v6, Ljxl/biff/formula/CloseParentheses;

    if-eqz v5, :cond_d

    const/4 v3, 0x1

    :cond_d
    :goto_5
    move-object v5, v6

    goto/16 :goto_0

    :cond_e
    :goto_6
    invoke-virtual {v1}, Ljava/util/Stack;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_f

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljxl/biff/formula/Operator;

    invoke-virtual {p1, v0}, Ljxl/biff/formula/Operator;->getOperands(Ljava/util/Stack;)V

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    :cond_f
    invoke-virtual {v0}, Ljava/util/Stack;->empty()Z

    move-result p1

    if-nez p1, :cond_10

    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object p1

    move-object v2, p1

    check-cast v2, Ljxl/biff/formula/ParseItem;

    :cond_10
    if-eqz v4, :cond_11

    if-eqz v2, :cond_11

    invoke-virtual {v4, v2}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_11
    iput-object v4, p0, Ljxl/biff/formula/StringFormulaParser;->arguments:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->empty()Z

    move-result p1

    if-eqz p1, :cond_12

    invoke-virtual {v1}, Ljava/util/Stack;->empty()Z

    move-result p1

    if-nez p1, :cond_13

    :cond_12
    sget-object p1, Ljxl/biff/formula/StringFormulaParser;->logger:Ljxl/common/Logger;

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    const-string v1, "Formula "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->formula:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, " has a non-empty parse stack"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_13
    return-object v2
.end method


# virtual methods
.method public adjustRelativeCellReferences(II)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2}, Ljxl/biff/formula/ParseItem;->adjustRelativeCellReferences(II)V

    return-void
.end method

.method public columnInserted(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnInserted(IIZ)V

    return-void
.end method

.method public columnRemoved(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->columnRemoved(IIZ)V

    return-void
.end method

.method public getBytes()[B
    .locals 5

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->getBytes()[B

    move-result-object v0

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v1}, Ljxl/biff/formula/ParseItem;->isVolatile()Z

    move-result v1

    if-eqz v1, :cond_0

    array-length v1, v0

    const/4 v2, 0x4

    add-int/2addr v1, v2

    new-array v1, v1, [B

    array-length v3, v0

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object v0, Ljxl/biff/formula/Token;->ATTRIBUTE:Ljxl/biff/formula/Token;

    invoke-virtual {v0}, Ljxl/biff/formula/Token;->getCode()B

    move-result v0

    aput-byte v0, v1, v4

    const/4 v0, 0x1

    aput-byte v0, v1, v0

    move-object v0, v1

    :cond_0
    return-object v0
.end method

.method public getFormula()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->parsedFormula:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    iget-object v1, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v1, v0}, Ljxl/biff/formula/ParseItem;->getString(Ljava/lang/StringBuffer;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->parsedFormula:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->parsedFormula:Ljava/lang/String;

    return-object v0
.end method

.method public handleImportedCellReferences()Z
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->handleImportedCellReferences()V

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0}, Ljxl/biff/formula/ParseItem;->isValid()Z

    move-result v0

    return v0
.end method

.method public parse()V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/formula/StringFormulaParser;->getTokens()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-direct {p0, v0}, Ljxl/biff/formula/StringFormulaParser;->parseCurrent(Ljava/util/Iterator;)Ljxl/biff/formula/ParseItem;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    return-void
.end method

.method public rowInserted(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowInserted(IIZ)V

    return-void
.end method

.method public rowRemoved(IIZ)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/StringFormulaParser;->root:Ljxl/biff/formula/ParseItem;

    invoke-virtual {v0, p1, p2, p3}, Ljxl/biff/formula/ParseItem;->rowRemoved(IIZ)V

    return-void
.end method
