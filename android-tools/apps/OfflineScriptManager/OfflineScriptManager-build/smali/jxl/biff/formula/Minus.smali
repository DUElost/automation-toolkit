.class Ljxl/biff/formula/Minus;
.super Ljxl/biff/formula/StringOperator;
.source ""


# static fields
.field static synthetic class$jxl$biff$formula$StringOperator:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/Minus;->class$jxl$biff$formula$StringOperator:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.StringOperator"

    invoke-static {v0}, Ljxl/biff/formula/Minus;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Minus;->class$jxl$biff$formula$StringOperator:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/Minus;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/StringOperator;-><init>()V

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
.method getBinaryOperator()Ljxl/biff/formula/Operator;
    .locals 1

    new-instance v0, Ljxl/biff/formula/Subtract;

    invoke-direct {v0}, Ljxl/biff/formula/Subtract;-><init>()V

    return-object v0
.end method

.method getUnaryOperator()Ljxl/biff/formula/Operator;
    .locals 1

    new-instance v0, Ljxl/biff/formula/UnaryMinus;

    invoke-direct {v0}, Ljxl/biff/formula/UnaryMinus;-><init>()V

    return-object v0
.end method

.method handleImportedCellReferences()V
    .locals 0

    return-void
.end method
