.class public Ljxl/biff/CountryCode;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final BELGIUM:Ljxl/biff/CountryCode;

.field public static final CANADA:Ljxl/biff/CountryCode;

.field public static final CHINA:Ljxl/biff/CountryCode;

.field public static final DENMARK:Ljxl/biff/CountryCode;

.field public static final FRANCE:Ljxl/biff/CountryCode;

.field public static final GERMANY:Ljxl/biff/CountryCode;

.field public static final GREECE:Ljxl/biff/CountryCode;

.field public static final INDIA:Ljxl/biff/CountryCode;

.field public static final ITALY:Ljxl/biff/CountryCode;

.field public static final NETHERLANDS:Ljxl/biff/CountryCode;

.field public static final NORWAY:Ljxl/biff/CountryCode;

.field public static final PHILIPPINES:Ljxl/biff/CountryCode;

.field public static final SPAIN:Ljxl/biff/CountryCode;

.field public static final SWEDEN:Ljxl/biff/CountryCode;

.field public static final SWITZERLAND:Ljxl/biff/CountryCode;

.field public static final UK:Ljxl/biff/CountryCode;

.field public static final UNKNOWN:Ljxl/biff/CountryCode;

.field public static final USA:Ljxl/biff/CountryCode;

.field static synthetic class$jxl$biff$CountryCode:Ljava/lang/Class;

.field private static codes:[Ljxl/biff/CountryCode;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private code:Ljava/lang/String;

.field private description:Ljava/lang/String;

.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    sget-object v0, Ljxl/biff/CountryCode;->class$jxl$biff$CountryCode:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.CountryCode"

    invoke-static {v0}, Ljxl/biff/CountryCode;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/CountryCode;->class$jxl$biff$CountryCode:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/CountryCode;->logger:Ljxl/common/Logger;

    const/4 v0, 0x0

    new-array v0, v0, [Ljxl/biff/CountryCode;

    sput-object v0, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/4 v1, 0x1

    const-string v2, "US"

    const-string v3, "USA"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->USA:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/4 v1, 0x2

    const-string v2, "CA"

    const-string v3, "Canada"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->CANADA:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x1e

    const-string v2, "GR"

    const-string v3, "Greece"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->GREECE:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x1f

    const-string v2, "NE"

    const-string v3, "Netherlands"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->NETHERLANDS:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x20

    const-string v2, "BE"

    const-string v3, "Belgium"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->BELGIUM:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x21

    const-string v2, "FR"

    const-string v3, "France"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->FRANCE:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x22

    const-string v2, "ES"

    const-string v3, "Spain"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->SPAIN:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x27

    const-string v2, "IT"

    const-string v3, "Italy"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->ITALY:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x29

    const-string v2, "CH"

    const-string v3, "Switzerland"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->SWITZERLAND:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x2c

    const-string v2, "UK"

    const-string v3, "United Kingdowm"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->UK:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x2d

    const-string v2, "DK"

    const-string v3, "Denmark"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->DENMARK:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x2e

    const-string v2, "SE"

    const-string v3, "Sweden"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->SWEDEN:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x2f

    const-string v2, "NO"

    const-string v3, "Norway"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->NORWAY:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x31

    const-string v2, "DE"

    const-string v3, "Germany"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->GERMANY:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x3f

    const-string v2, "PH"

    const-string v3, "Philippines"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->PHILIPPINES:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x56

    const-string v2, "CN"

    const-string v3, "China"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->CHINA:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const/16 v1, 0x5b

    const-string v2, "IN"

    const-string v3, "India"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->INDIA:Ljxl/biff/CountryCode;

    new-instance v0, Ljxl/biff/CountryCode;

    const v1, 0xffff

    const-string v2, "??"

    const-string v3, "Unknown"

    invoke-direct {v0, v1, v2, v3}, Ljxl/biff/CountryCode;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/CountryCode;->UNKNOWN:Ljxl/biff/CountryCode;

    return-void
.end method

.method private constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/CountryCode;->value:I

    const-string p1, "Arbitrary"

    iput-object p1, p0, Ljxl/biff/CountryCode;->description:Ljava/lang/String;

    const-string p1, "??"

    iput-object p1, p0, Ljxl/biff/CountryCode;->code:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(ILjava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/CountryCode;->value:I

    iput-object p2, p0, Ljxl/biff/CountryCode;->code:Ljava/lang/String;

    iput-object p3, p0, Ljxl/biff/CountryCode;->description:Ljava/lang/String;

    sget-object p1, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

    array-length p2, p1

    add-int/lit8 p2, p2, 0x1

    new-array p2, p2, [Ljxl/biff/CountryCode;

    array-length p3, p1

    const/4 v0, 0x0

    invoke-static {p1, v0, p2, v0, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object p1, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

    array-length p1, p1

    aput-object p0, p2, p1

    sput-object p2, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

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

.method public static createArbitraryCode(I)Ljxl/biff/CountryCode;
    .locals 1

    new-instance v0, Ljxl/biff/CountryCode;

    invoke-direct {v0, p0}, Ljxl/biff/CountryCode;-><init>(I)V

    return-object v0
.end method

.method public static getCountryCode(Ljava/lang/String;)Ljxl/biff/CountryCode;
    .locals 4

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_1

    :cond_0
    sget-object v0, Ljxl/biff/CountryCode;->UNKNOWN:Ljxl/biff/CountryCode;

    const/4 v1, 0x0

    :goto_0
    sget-object v2, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

    array-length v3, v2

    if-ge v1, v3, :cond_2

    sget-object v3, Ljxl/biff/CountryCode;->UNKNOWN:Ljxl/biff/CountryCode;

    if-ne v0, v3, :cond_2

    aget-object v2, v2, v1

    iget-object v2, v2, Ljxl/biff/CountryCode;->code:Ljava/lang/String;

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    sget-object v0, Ljxl/biff/CountryCode;->codes:[Ljxl/biff/CountryCode;

    aget-object v0, v0, v1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    return-object v0

    :cond_3
    :goto_1
    sget-object p0, Ljxl/biff/CountryCode;->logger:Ljxl/common/Logger;

    const-string v0, "Please specify two character ISO 3166 country code"

    invoke-virtual {p0, v0}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    sget-object p0, Ljxl/biff/CountryCode;->USA:Ljxl/biff/CountryCode;

    return-object p0
.end method


# virtual methods
.method public getCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/CountryCode;->code:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()I
    .locals 1

    iget v0, p0, Ljxl/biff/CountryCode;->value:I

    return v0
.end method
