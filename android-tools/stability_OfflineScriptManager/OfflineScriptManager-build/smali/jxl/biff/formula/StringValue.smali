.class Ljxl/biff/formula/StringValue;
.super Ljxl/biff/formula/Operand;
.source ""

# interfaces
.implements Ljxl/biff/formula/ParsedThing;


# static fields
.field static synthetic class$jxl$biff$formula$StringValue:Ljava/lang/Class;

.field private static final logger:Ljxl/common/Logger;


# instance fields
.field private settings:Ljxl/WorkbookSettings;

.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/formula/StringValue;->class$jxl$biff$formula$StringValue:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.formula.StringValue"

    invoke-static {v0}, Ljxl/biff/formula/StringValue;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/StringValue;->class$jxl$biff$formula$StringValue:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/formula/StringValue;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operand;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljxl/WorkbookSettings;)V
    .locals 0

    invoke-direct {p0}, Ljxl/biff/formula/Operand;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/StringValue;->settings:Ljxl/WorkbookSettings;

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
.method getBytes()[B
    .locals 5

    iget-object v0, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    mul-int/2addr v0, v1

    const/4 v2, 0x3

    add-int/2addr v0, v2

    new-array v0, v0, [B

    sget-object v3, Ljxl/biff/formula/Token;->STRING:Ljxl/biff/formula/Token;

    invoke-virtual {v3}, Ljxl/biff/formula/Token;->getCode()B

    move-result v3

    const/4 v4, 0x0

    aput-byte v3, v0, v4

    iget-object v3, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    int-to-byte v3, v3

    const/4 v4, 0x1

    aput-byte v3, v0, v4

    aput-byte v4, v0, v1

    iget-object v1, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    return-object v0
.end method

.method public getString(Ljava/lang/StringBuffer;)V
    .locals 2

    const-string v0, "\""

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v1, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    return-void
.end method

.method handleImportedCellReferences()V
    .locals 0

    return-void
.end method

.method public read([BI)I
    .locals 2

    aget-byte v0, p1, p2

    and-int/lit16 v0, v0, 0xff

    add-int/lit8 v1, p2, 0x1

    aget-byte v1, p1, v1

    and-int/lit8 v1, v1, 0x1

    add-int/lit8 p2, p2, 0x2

    if-nez v1, :cond_0

    iget-object v1, p0, Ljxl/biff/formula/StringValue;->settings:Ljxl/WorkbookSettings;

    invoke-static {p1, v0, p2, v1}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-static {p1, v0, p2}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/formula/StringValue;->value:Ljava/lang/String;

    mul-int/lit8 v0, v0, 0x2

    :goto_0
    add-int/lit8 v0, v0, 0x2

    return v0
.end method
