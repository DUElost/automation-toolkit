.class public Ljxl/biff/DVParser;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/DVParser$Condition;,
        Ljxl/biff/DVParser$ErrorStyle;,
        Ljxl/biff/DVParser$DVType;
    }
.end annotation


# static fields
.field public static final ANY:Ljxl/biff/DVParser$DVType;

.field public static final BETWEEN:Ljxl/biff/DVParser$Condition;

.field public static final DATE:Ljxl/biff/DVParser$DVType;

.field public static final DECIMAL:Ljxl/biff/DVParser$DVType;

.field private static DECIMAL_FORMAT:Ljava/text/DecimalFormat; = null

.field private static final EMPTY_CELLS_ALLOWED_MASK:I = 0x100

.field public static final EQUAL:Ljxl/biff/DVParser$Condition;

.field public static final FORMULA:Ljxl/biff/DVParser$DVType;

.field public static final GREATER_EQUAL:Ljxl/biff/DVParser$Condition;

.field public static final GREATER_THAN:Ljxl/biff/DVParser$Condition;

.field public static final INFO:Ljxl/biff/DVParser$ErrorStyle;

.field public static final INTEGER:Ljxl/biff/DVParser$DVType;

.field public static final LESS_EQUAL:Ljxl/biff/DVParser$Condition;

.field public static final LESS_THAN:Ljxl/biff/DVParser$Condition;

.field public static final LIST:Ljxl/biff/DVParser$DVType;

.field private static final MAX_VALIDATION_LIST_LENGTH:I = 0xfe

.field public static final NOT_BETWEEN:Ljxl/biff/DVParser$Condition;

.field public static final NOT_EQUAL:Ljxl/biff/DVParser$Condition;

.field private static final SHOW_ERROR_MASK:I = 0x80000

.field private static final SHOW_PROMPT_MASK:I = 0x40000

.field public static final STOP:Ljxl/biff/DVParser$ErrorStyle;

.field private static final STRING_LIST_GIVEN_MASK:I = 0x80

.field private static final SUPPRESS_ARROW_MASK:I = 0x200

.field public static final TEXT_LENGTH:Ljxl/biff/DVParser$DVType;

.field public static final TIME:Ljxl/biff/DVParser$DVType;

.field public static final WARNING:Ljxl/biff/DVParser$ErrorStyle;

.field static synthetic class$jxl$biff$DVParser:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private column1:I

.field private column2:I

.field private condition:Ljxl/biff/DVParser$Condition;

.field private emptyCellsAllowed:Z

.field private errorStyle:Ljxl/biff/DVParser$ErrorStyle;

.field private errorText:Ljava/lang/String;

.field private errorTitle:Ljava/lang/String;

.field private formula1:Ljxl/biff/formula/FormulaParser;

.field private formula1String:Ljava/lang/String;

.field private formula2:Ljxl/biff/formula/FormulaParser;

.field private formula2String:Ljava/lang/String;

.field private promptText:Ljava/lang/String;

.field private promptTitle:Ljava/lang/String;

.field private row1:I

.field private row2:I

.field private showError:Z

.field private showPrompt:Z

.field private stringListGiven:Z

.field private suppressArrow:Z

.field private type:Ljxl/biff/DVParser$DVType;


# direct methods
.method static constructor <clinit>()V
    .locals 10

    sget-object v0, Ljxl/biff/DVParser;->class$jxl$biff$DVParser:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.DVParser"

    invoke-static {v0}, Ljxl/biff/DVParser;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/DVParser;->class$jxl$biff$DVParser:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/DVParser;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v1, 0x0

    const-string v2, "any"

    invoke-direct {v0, v1, v2}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->ANY:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v2, 0x1

    const-string v3, "int"

    invoke-direct {v0, v2, v3}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->INTEGER:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v3, 0x2

    const-string v4, "dec"

    invoke-direct {v0, v3, v4}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->DECIMAL:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v4, 0x3

    const-string v5, "list"

    invoke-direct {v0, v4, v5}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->LIST:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v5, 0x4

    const-string v6, "date"

    invoke-direct {v0, v5, v6}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->DATE:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v6, 0x5

    const-string v7, "time"

    invoke-direct {v0, v6, v7}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->TIME:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v7, 0x6

    const-string v8, "strlen"

    invoke-direct {v0, v7, v8}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->TEXT_LENGTH:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$DVType;

    const/4 v8, 0x7

    const-string v9, "form"

    invoke-direct {v0, v8, v9}, Ljxl/biff/DVParser$DVType;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->FORMULA:Ljxl/biff/DVParser$DVType;

    new-instance v0, Ljxl/biff/DVParser$ErrorStyle;

    invoke-direct {v0, v1}, Ljxl/biff/DVParser$ErrorStyle;-><init>(I)V

    sput-object v0, Ljxl/biff/DVParser;->STOP:Ljxl/biff/DVParser$ErrorStyle;

    new-instance v0, Ljxl/biff/DVParser$ErrorStyle;

    invoke-direct {v0, v2}, Ljxl/biff/DVParser$ErrorStyle;-><init>(I)V

    sput-object v0, Ljxl/biff/DVParser;->WARNING:Ljxl/biff/DVParser$ErrorStyle;

    new-instance v0, Ljxl/biff/DVParser$ErrorStyle;

    invoke-direct {v0, v3}, Ljxl/biff/DVParser$ErrorStyle;-><init>(I)V

    sput-object v0, Ljxl/biff/DVParser;->INFO:Ljxl/biff/DVParser$ErrorStyle;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v9, "{0} <= x <= {1}"

    invoke-direct {v0, v1, v9}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->BETWEEN:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "!({0} <= x <= {1}"

    invoke-direct {v0, v2, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->NOT_BETWEEN:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x == {0}"

    invoke-direct {v0, v3, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->EQUAL:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x != {0}"

    invoke-direct {v0, v4, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->NOT_EQUAL:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x > {0}"

    invoke-direct {v0, v5, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->GREATER_THAN:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x < {0}"

    invoke-direct {v0, v6, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->LESS_THAN:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x >= {0}"

    invoke-direct {v0, v7, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->GREATER_EQUAL:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljxl/biff/DVParser$Condition;

    const-string v1, "x <= {0}"

    invoke-direct {v0, v8, v1}, Ljxl/biff/DVParser$Condition;-><init>(ILjava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->LESS_EQUAL:Ljxl/biff/DVParser$Condition;

    new-instance v0, Ljava/text/DecimalFormat;

    const-string v1, "#.#"

    invoke-direct {v0, v1}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/DVParser;->DECIMAL_FORMAT:Ljava/text/DecimalFormat;

    return-void
.end method

.method public constructor <init>(DDLjxl/biff/DVParser$Condition;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Ljxl/biff/DVParser;->DECIMAL:Ljxl/biff/DVParser$DVType;

    iput-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    sget-object v0, Ljxl/biff/DVParser;->STOP:Ljxl/biff/DVParser$ErrorStyle;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    iput-object p5, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    const/4 p5, 0x0

    iput-boolean p5, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    iput-boolean p5, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showPrompt:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showError:Z

    const-string p5, "\u0000"

    iput-object p5, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iput-object p5, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iput-object p5, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iput-object p5, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    sget-object p5, Ljxl/biff/DVParser;->DECIMAL_FORMAT:Ljava/text/DecimalFormat;

    invoke-virtual {p5, p1, p2}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    invoke-static {p3, p4}, Ljava/lang/Double;->isNaN(D)Z

    move-result p1

    if-nez p1, :cond_0

    sget-object p1, Ljxl/biff/DVParser;->DECIMAL_FORMAT:Ljava/text/DecimalFormat;

    invoke-virtual {p1, p3, p4}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public constructor <init>(IIII)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Ljxl/biff/DVParser;->LIST:Ljxl/biff/DVParser$DVType;

    iput-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    sget-object v0, Ljxl/biff/DVParser;->STOP:Ljxl/biff/DVParser$ErrorStyle;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    sget-object v0, Ljxl/biff/DVParser;->BETWEEN:Ljxl/biff/DVParser$Condition;

    iput-object v0, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    iput-boolean v1, p0, Ljxl/biff/DVParser;->showPrompt:Z

    iput-boolean v1, p0, Ljxl/biff/DVParser;->showError:Z

    const-string v0, "\u0000"

    iput-object v0, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {p1, p2, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    const/16 p1, 0x3a

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-static {p3, p4, v0}, Ljxl/biff/CellReferenceHelper;->getCellReference(IILjava/lang/StringBuffer;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Ljxl/biff/DVParser;->LIST:Ljxl/biff/DVParser$DVType;

    iput-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    sget-object v0, Ljxl/biff/DVParser;->STOP:Ljxl/biff/DVParser$ErrorStyle;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    sget-object v0, Ljxl/biff/DVParser;->BETWEEN:Ljxl/biff/DVParser$Condition;

    iput-object v0, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    iput-boolean v1, p0, Ljxl/biff/DVParser;->showPrompt:Z

    iput-boolean v1, p0, Ljxl/biff/DVParser;->showError:Z

    const-string v0, "\u0000"

    iput-object v0, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    iput-object p1, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/util/Collection;)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Ljxl/biff/DVParser;->LIST:Ljxl/biff/DVParser$DVType;

    iput-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    sget-object v0, Ljxl/biff/DVParser;->STOP:Ljxl/biff/DVParser$ErrorStyle;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    sget-object v0, Ljxl/biff/DVParser;->BETWEEN:Ljxl/biff/DVParser$Condition;

    iput-object v0, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    const/4 v0, 0x1

    iput-boolean v0, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    const/4 v1, 0x0

    iput-boolean v1, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showPrompt:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showError:Z

    const-string v0, "\u0000"

    iput-object v0, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    invoke-interface {p1}, Ljava/util/Collection;->size()I

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Ljxl/biff/DVParser;->logger:Ljxl/common/Logger;

    const-string v2, "no validation strings - ignoring"

    invoke-virtual {v0, v2}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_0
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    const/16 v2, 0x20

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->length()I

    move-result p1

    const/16 v2, 0xfe

    if-le p1, v2, :cond_2

    sget-object p1, Ljxl/biff/DVParser;->logger:Ljxl/common/Logger;

    const-string v3, "Validation list exceeds maximum number of characters - truncating"

    invoke-virtual {p1, v3}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->length()I

    move-result p1

    invoke-virtual {v0, v2, p1}, Ljava/lang/StringBuffer;->delete(II)Ljava/lang/StringBuffer;

    :cond_2
    const/16 p1, 0x22

    invoke-virtual {v0, v1, p1}, Ljava/lang/StringBuffer;->insert(IC)Ljava/lang/StringBuffer;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/DVParser;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-object v0, p1, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    iput-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    iget-object v0, p1, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    iget-object v0, p1, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    iput-object v0, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    iget-boolean v0, p1, Ljxl/biff/DVParser;->stringListGiven:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    iget-boolean v0, p1, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    iget-boolean v0, p1, Ljxl/biff/DVParser;->suppressArrow:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    iget-boolean v0, p1, Ljxl/biff/DVParser;->showPrompt:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showPrompt:Z

    iget-boolean v0, p1, Ljxl/biff/DVParser;->showError:Z

    iput-boolean v0, p0, Ljxl/biff/DVParser;->showError:Z

    iget-object v0, p1, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    iget-object v0, p1, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    iget-object v0, p1, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    iget-object v0, p1, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    iget-object v0, p1, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    if-eqz v0, :cond_0

    iput-object v0, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    iget-object p1, p1, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;

    iput-object p1, p0, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;

    goto :goto_1

    :cond_0
    :try_start_0
    iget-object v0, p1, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    iget-object p1, p1, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    iput-object p1, p0, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    sget-object v0, Ljxl/biff/DVParser;->logger:Ljxl/common/Logger;

    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v2, "Cannot parse validation formula:  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :goto_1
    return-void
.end method

.method public constructor <init>([BLjxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V
    .locals 14

    move-object v1, p0

    move-object v0, p1

    move-object/from16 v8, p4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v9, 0x0

    const/4 v2, 0x1

    if-eqz p3, :cond_0

    move v3, v2

    goto :goto_0

    :cond_0
    move v3, v9

    :goto_0
    invoke-static {v3}, Ljxl/common/Assert;->verify(Z)V

    aget-byte v3, v0, v9

    aget-byte v4, v0, v2

    const/4 v5, 0x2

    aget-byte v6, v0, v5

    const/4 v7, 0x3

    aget-byte v10, v0, v7

    invoke-static {v3, v4, v6, v10}, Ljxl/biff/IntegerHelper;->getInt(BBBB)I

    move-result v3

    and-int/lit8 v4, v3, 0xf

    invoke-static {v4}, Ljxl/biff/DVParser$DVType;->getType(I)Ljxl/biff/DVParser$DVType;

    move-result-object v4

    iput-object v4, v1, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    and-int/lit8 v4, v3, 0x70

    const/4 v6, 0x4

    shr-int/2addr v4, v6

    invoke-static {v4}, Ljxl/biff/DVParser$ErrorStyle;->getErrorStyle(I)Ljxl/biff/DVParser$ErrorStyle;

    move-result-object v4

    iput-object v4, v1, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    const/high16 v4, 0xf00000

    and-int/2addr v4, v3

    shr-int/lit8 v4, v4, 0x14

    invoke-static {v4}, Ljxl/biff/DVParser$Condition;->getCondition(I)Ljxl/biff/DVParser$Condition;

    move-result-object v4

    iput-object v4, v1, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    and-int/lit16 v4, v3, 0x80

    if-eqz v4, :cond_1

    move v4, v2

    goto :goto_1

    :cond_1
    move v4, v9

    :goto_1
    iput-boolean v4, v1, Ljxl/biff/DVParser;->stringListGiven:Z

    and-int/lit16 v4, v3, 0x100

    if-eqz v4, :cond_2

    move v4, v2

    goto :goto_2

    :cond_2
    move v4, v9

    :goto_2
    iput-boolean v4, v1, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    and-int/lit16 v4, v3, 0x200

    if-eqz v4, :cond_3

    move v4, v2

    goto :goto_3

    :cond_3
    move v4, v9

    :goto_3
    iput-boolean v4, v1, Ljxl/biff/DVParser;->suppressArrow:Z

    const/high16 v4, 0x40000

    and-int/2addr v4, v3

    if-eqz v4, :cond_4

    move v4, v2

    goto :goto_4

    :cond_4
    move v4, v9

    :goto_4
    iput-boolean v4, v1, Ljxl/biff/DVParser;->showPrompt:Z

    const/high16 v4, 0x80000

    and-int/2addr v3, v4

    if-eqz v3, :cond_5

    move v3, v2

    goto :goto_5

    :cond_5
    move v3, v9

    :goto_5
    iput-boolean v3, v1, Ljxl/biff/DVParser;->showError:Z

    aget-byte v3, v0, v6

    const/4 v4, 0x5

    aget-byte v4, v0, v4

    invoke-static {v3, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    const/4 v4, 0x7

    if-lez v3, :cond_6

    const/4 v10, 0x6

    aget-byte v10, v0, v10

    if-nez v10, :cond_6

    invoke-static {p1, v3, v4, v8}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v1, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    add-int/2addr v3, v7

    add-int/lit8 v4, v3, 0x4

    goto :goto_6

    :cond_6
    if-lez v3, :cond_7

    invoke-static {p1, v3, v4}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v1, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    mul-int/2addr v3, v5

    add-int/2addr v3, v7

    add-int v4, v6, v3

    :cond_7
    :goto_6
    aget-byte v3, v0, v4

    add-int/lit8 v10, v4, 0x1

    aget-byte v10, v0, v10

    invoke-static {v3, v10}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    if-lez v3, :cond_8

    add-int/lit8 v10, v4, 0x2

    aget-byte v10, v0, v10

    if-nez v10, :cond_8

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10, v8}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    goto :goto_7

    :cond_8
    if-lez v3, :cond_9

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    mul-int/2addr v3, v5

    :goto_7
    add-int/2addr v3, v7

    add-int/2addr v4, v3

    goto :goto_8

    :cond_9
    add-int/2addr v4, v7

    :goto_8
    aget-byte v3, v0, v4

    add-int/lit8 v10, v4, 0x1

    aget-byte v10, v0, v10

    invoke-static {v3, v10}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    if-lez v3, :cond_a

    add-int/lit8 v10, v4, 0x2

    aget-byte v10, v0, v10

    if-nez v10, :cond_a

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10, v8}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    goto :goto_9

    :cond_a
    if-lez v3, :cond_b

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    mul-int/2addr v3, v5

    :goto_9
    add-int/2addr v3, v7

    add-int/2addr v4, v3

    goto :goto_a

    :cond_b
    add-int/2addr v4, v7

    :goto_a
    aget-byte v3, v0, v4

    add-int/lit8 v10, v4, 0x1

    aget-byte v10, v0, v10

    invoke-static {v3, v10}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    if-lez v3, :cond_c

    add-int/lit8 v10, v4, 0x2

    aget-byte v10, v0, v10

    if-nez v10, :cond_c

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10, v8}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    goto :goto_b

    :cond_c
    if-lez v3, :cond_d

    add-int/lit8 v10, v4, 0x3

    invoke-static {p1, v3, v10}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object v10

    iput-object v10, v1, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    mul-int/2addr v3, v5

    :goto_b
    add-int/2addr v3, v7

    add-int/2addr v4, v3

    goto :goto_c

    :cond_d
    add-int/2addr v4, v7

    :goto_c
    aget-byte v3, v0, v4

    add-int/lit8 v7, v4, 0x1

    aget-byte v7, v0, v7

    invoke-static {v3, v7}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    add-int/2addr v4, v6

    add-int v7, v4, v3

    aget-byte v10, v0, v7

    add-int/lit8 v11, v7, 0x1

    aget-byte v11, v0, v11

    invoke-static {v10, v11}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v10

    add-int/lit8 v11, v7, 0x4

    add-int v6, v11, v10

    add-int/2addr v6, v5

    aget-byte v7, v0, v6

    add-int/lit8 v12, v6, 0x1

    aget-byte v12, v0, v12

    invoke-static {v7, v12}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v7

    iput v7, v1, Ljxl/biff/DVParser;->row1:I

    add-int/2addr v6, v5

    aget-byte v7, v0, v6

    add-int/lit8 v12, v6, 0x1

    aget-byte v12, v0, v12

    invoke-static {v7, v12}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v7

    iput v7, v1, Ljxl/biff/DVParser;->row2:I

    add-int/2addr v6, v5

    aget-byte v7, v0, v6

    add-int/lit8 v12, v6, 0x1

    aget-byte v12, v0, v12

    invoke-static {v7, v12}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v7

    iput v7, v1, Ljxl/biff/DVParser;->column1:I

    add-int/2addr v6, v5

    aget-byte v5, v0, v6

    add-int/2addr v6, v2

    aget-byte v2, v0, v6

    invoke-static {v5, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    iput v2, v1, Ljxl/biff/DVParser;->column2:I

    :try_start_0
    new-instance v12, Ljxl/biff/EmptyCell;

    iget v2, v1, Ljxl/biff/DVParser;->column1:I

    iget v5, v1, Ljxl/biff/DVParser;->row1:I

    invoke-direct {v12, v2, v5}, Ljxl/biff/EmptyCell;-><init>(II)V

    if-eqz v3, :cond_e

    new-array v5, v3, [B

    invoke-static {p1, v4, v5, v9, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance v13, Ljxl/biff/formula/FormulaParser;

    move-object v2, v13

    move-object v3, v5

    move-object v4, v12

    move-object/from16 v5, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    invoke-direct/range {v2 .. v7}, Ljxl/biff/formula/FormulaParser;-><init>([BLjxl/Cell;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v13, v1, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {v13}, Ljxl/biff/formula/FormulaParser;->parse()V

    :cond_e
    if-eqz v10, :cond_f

    new-array v3, v10, [B

    invoke-static {p1, v11, v3, v9, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    new-instance v0, Ljxl/biff/formula/FormulaParser;

    move-object v2, v0

    move-object v4, v12

    move-object/from16 v5, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    invoke-direct/range {v2 .. v7}, Ljxl/biff/formula/FormulaParser;-><init>([BLjxl/Cell;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V

    iput-object v0, v1, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->parse()V
    :try_end_0
    .catch Ljxl/biff/formula/FormulaException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_d

    :catch_0
    move-exception v0

    sget-object v2, Ljxl/biff/DVParser;->logger:Ljxl/common/Logger;

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v0, " for cells "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v0, v1, Ljxl/biff/DVParser;->column1:I

    iget v4, v1, Ljxl/biff/DVParser;->row1:I

    invoke-static {v0, v4}, Ljxl/biff/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v0, "-"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v0, v1, Ljxl/biff/DVParser;->column2:I

    iget v4, v1, Ljxl/biff/DVParser;->row2:I

    invoke-static {v0, v4}, Ljxl/biff/CellReferenceHelper;->getCellReference(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    :cond_f
    :goto_d
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


# virtual methods
.method public getData()[B
    .locals 7

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getBytes()[B

    move-result-object v0

    goto :goto_0

    :cond_0
    new-array v0, v1, [B

    :goto_0
    iget-object v2, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljxl/biff/formula/FormulaParser;->getBytes()[B

    move-result-object v2

    goto :goto_1

    :cond_1
    new-array v2, v1, [B

    :goto_1
    iget-object v3, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    mul-int/lit8 v3, v3, 0x2

    const/4 v4, 0x4

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, 0x2

    iget-object v5, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    mul-int/lit8 v5, v5, 0x2

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x2

    iget-object v5, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    mul-int/lit8 v5, v5, 0x2

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x2

    iget-object v5, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    mul-int/lit8 v5, v5, 0x2

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x2

    array-length v5, v0

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x2

    array-length v5, v2

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x2

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, 0xa

    new-array v3, v3, [B

    iget-object v5, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    invoke-virtual {v5}, Ljxl/biff/DVParser$DVType;->getValue()I

    move-result v5

    or-int/2addr v5, v1

    iget-object v6, p0, Ljxl/biff/DVParser;->errorStyle:Ljxl/biff/DVParser$ErrorStyle;

    invoke-virtual {v6}, Ljxl/biff/DVParser$ErrorStyle;->getValue()I

    move-result v6

    shl-int/2addr v6, v4

    or-int/2addr v5, v6

    iget-object v6, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    invoke-virtual {v6}, Ljxl/biff/DVParser$Condition;->getValue()I

    move-result v6

    shl-int/lit8 v6, v6, 0x14

    or-int/2addr v5, v6

    iget-boolean v6, p0, Ljxl/biff/DVParser;->stringListGiven:Z

    if-eqz v6, :cond_2

    or-int/lit16 v5, v5, 0x80

    :cond_2
    iget-boolean v6, p0, Ljxl/biff/DVParser;->emptyCellsAllowed:Z

    if-eqz v6, :cond_3

    or-int/lit16 v5, v5, 0x100

    :cond_3
    iget-boolean v6, p0, Ljxl/biff/DVParser;->suppressArrow:Z

    if-eqz v6, :cond_4

    or-int/lit16 v5, v5, 0x200

    :cond_4
    iget-boolean v6, p0, Ljxl/biff/DVParser;->showPrompt:Z

    if-eqz v6, :cond_5

    const/high16 v6, 0x40000

    or-int/2addr v5, v6

    :cond_5
    iget-boolean v6, p0, Ljxl/biff/DVParser;->showError:Z

    if-eqz v6, :cond_6

    const/high16 v6, 0x80000

    or-int/2addr v5, v6

    :cond_6
    invoke-static {v5, v3, v1}, Ljxl/biff/IntegerHelper;->getFourBytes(I[BI)V

    iget-object v5, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-static {v5, v3, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    const/4 v5, 0x6

    iget-object v6, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    invoke-static {v6, v3, v5}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v6, p0, Ljxl/biff/DVParser;->promptTitle:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    mul-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    iget-object v6, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-static {v6, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget-object v6, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    invoke-static {v6, v3, v5}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v6, p0, Ljxl/biff/DVParser;->errorTitle:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    mul-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    iget-object v6, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-static {v6, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget-object v6, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    invoke-static {v6, v3, v5}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v6, p0, Ljxl/biff/DVParser;->promptText:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    mul-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    iget-object v6, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-static {v6, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget-object v6, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    invoke-static {v6, v3, v5}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v6, p0, Ljxl/biff/DVParser;->errorText:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    mul-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    array-length v6, v0

    invoke-static {v6, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/2addr v5, v4

    array-length v6, v0

    invoke-static {v0, v1, v3, v5, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v0, v0

    add-int/2addr v5, v0

    array-length v0, v2

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/2addr v5, v4

    array-length v0, v2

    invoke-static {v2, v1, v3, v5, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v0, v2

    add-int/2addr v5, v0

    const/4 v0, 0x1

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget v0, p0, Ljxl/biff/DVParser;->row1:I

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget v0, p0, Ljxl/biff/DVParser;->row2:I

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget v0, p0, Ljxl/biff/DVParser;->column1:I

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v5, v5, 0x2

    iget v0, p0, Ljxl/biff/DVParser;->column2:I

    invoke-static {v0, v3, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v3
.end method

.method public getFirstColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/DVParser;->column1:I

    return v0
.end method

.method public getFirstRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/DVParser;->row1:I

    return v0
.end method

.method public getLastColumn()I
    .locals 1

    iget v0, p0, Ljxl/biff/DVParser;->column2:I

    return v0
.end method

.method public getLastRow()I
    .locals 1

    iget v0, p0, Ljxl/biff/DVParser;->row2:I

    return v0
.end method

.method getValidationFormula()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    sget-object v1, Ljxl/biff/DVParser;->LIST:Ljxl/biff/DVParser$DVType;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {v0}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljxl/biff/formula/FormulaParser;->getFormula()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    iget-object v3, p0, Ljxl/biff/DVParser;->condition:Ljxl/biff/DVParser$Condition;

    invoke-virtual {v3, v0, v1}, Ljxl/biff/DVParser$Condition;->getConditionString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v0, "; x "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v0, p0, Ljxl/biff/DVParser;->type:Ljxl/biff/DVParser$DVType;

    invoke-virtual {v0}, Ljxl/biff/DVParser$DVType;->getDescription()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public insertColumn(I)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->columnInserted(IIZ)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v0, :cond_1

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->columnInserted(IIZ)V

    :cond_1
    iget v0, p0, Ljxl/biff/DVParser;->column1:I

    if-lt v0, p1, :cond_2

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->column1:I

    :cond_2
    iget v0, p0, Ljxl/biff/DVParser;->column2:I

    if-lt v0, p1, :cond_3

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->column2:I

    :cond_3
    return-void
.end method

.method public insertRow(I)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->rowInserted(IIZ)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v0, :cond_1

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->rowInserted(IIZ)V

    :cond_1
    iget v0, p0, Ljxl/biff/DVParser;->row1:I

    if-lt v0, p1, :cond_2

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->row1:I

    :cond_2
    iget v0, p0, Ljxl/biff/DVParser;->row2:I

    if-lt v0, p1, :cond_3

    add-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->row2:I

    :cond_3
    return-void
.end method

.method public removeColumn(I)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->columnRemoved(IIZ)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v0, :cond_1

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->columnRemoved(IIZ)V

    :cond_1
    iget v0, p0, Ljxl/biff/DVParser;->column1:I

    if-le v0, p1, :cond_2

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->column1:I

    :cond_2
    iget v0, p0, Ljxl/biff/DVParser;->column2:I

    if-lt v0, p1, :cond_3

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->column2:I

    :cond_3
    return-void
.end method

.method public removeRow(I)V
    .locals 3

    iget-object v0, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->rowRemoved(IIZ)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    if-eqz v0, :cond_1

    invoke-virtual {v0, v1, p1, v2}, Ljxl/biff/formula/FormulaParser;->rowRemoved(IIZ)V

    :cond_1
    iget v0, p0, Ljxl/biff/DVParser;->row1:I

    if-le v0, p1, :cond_2

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->row1:I

    :cond_2
    iget v0, p0, Ljxl/biff/DVParser;->row2:I

    if-lt v0, p1, :cond_3

    sub-int/2addr v0, v2

    iput v0, p0, Ljxl/biff/DVParser;->row2:I

    :cond_3
    return-void
.end method

.method public setCell(IILjxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;)V
    .locals 6

    iput p2, p0, Ljxl/biff/DVParser;->row1:I

    iput p2, p0, Ljxl/biff/DVParser;->row2:I

    iput p1, p0, Ljxl/biff/DVParser;->column1:I

    iput p1, p0, Ljxl/biff/DVParser;->column2:I

    new-instance p1, Ljxl/biff/formula/FormulaParser;

    iget-object v1, p0, Ljxl/biff/DVParser;->formula1String:Ljava/lang/String;

    sget-object v5, Ljxl/biff/formula/ParseContext;->DATA_VALIDATION:Ljxl/biff/formula/ParseContext;

    move-object v0, p1

    move-object v2, p3

    move-object v3, p4

    move-object v4, p5

    invoke-direct/range {v0 .. v5}, Ljxl/biff/formula/FormulaParser;-><init>(Ljava/lang/String;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;Ljxl/biff/formula/ParseContext;)V

    iput-object p1, p0, Ljxl/biff/DVParser;->formula1:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {p1}, Ljxl/biff/formula/FormulaParser;->parse()V

    iget-object p1, p0, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;

    if-eqz p1, :cond_0

    new-instance p1, Ljxl/biff/formula/FormulaParser;

    iget-object v1, p0, Ljxl/biff/DVParser;->formula2String:Ljava/lang/String;

    sget-object v5, Ljxl/biff/formula/ParseContext;->DATA_VALIDATION:Ljxl/biff/formula/ParseContext;

    move-object v0, p1

    move-object v2, p3

    move-object v3, p4

    move-object v4, p5

    invoke-direct/range {v0 .. v5}, Ljxl/biff/formula/FormulaParser;-><init>(Ljava/lang/String;Ljxl/biff/formula/ExternalSheet;Ljxl/biff/WorkbookMethods;Ljxl/WorkbookSettings;Ljxl/biff/formula/ParseContext;)V

    iput-object p1, p0, Ljxl/biff/DVParser;->formula2:Ljxl/biff/formula/FormulaParser;

    invoke-virtual {p1}, Ljxl/biff/formula/FormulaParser;->parse()V

    :cond_0
    return-void
.end method
