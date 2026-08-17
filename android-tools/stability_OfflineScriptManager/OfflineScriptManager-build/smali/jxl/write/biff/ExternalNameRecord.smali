.class Ljxl/write/biff/ExternalNameRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$ExternalNameRecord:Ljava/lang/Class;


# instance fields
.field logger:Ljxl/common/Logger;

.field private name:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->EXTERNNAME:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    sget-object v0, Ljxl/write/biff/ExternalNameRecord;->class$jxl$write$biff$ExternalNameRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.ExternalNameRecord"

    invoke-static {v0}, Ljxl/write/biff/ExternalNameRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/ExternalNameRecord;->class$jxl$write$biff$ExternalNameRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    iput-object v0, p0, Ljxl/write/biff/ExternalNameRecord;->logger:Ljxl/common/Logger;

    iput-object p1, p0, Ljxl/write/biff/ExternalNameRecord;->name:Ljava/lang/String;

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
    .locals 4

    iget-object v0, p0, Ljxl/write/biff/ExternalNameRecord;->name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    mul-int/2addr v0, v1

    add-int/lit8 v0, v0, 0xc

    new-array v0, v0, [B

    iget-object v2, p0, Ljxl/write/biff/ExternalNameRecord;->name:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    int-to-byte v2, v2

    const/4 v3, 0x6

    aput-byte v2, v0, v3

    const/4 v2, 0x7

    const/4 v3, 0x1

    aput-byte v3, v0, v2

    iget-object v2, p0, Ljxl/write/biff/ExternalNameRecord;->name:Ljava/lang/String;

    const/16 v3, 0x8

    invoke-static {v2, v0, v3}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v2, p0, Ljxl/write/biff/ExternalNameRecord;->name:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    mul-int/2addr v2, v1

    add-int/2addr v2, v3

    aput-byte v1, v0, v2

    add-int/lit8 v1, v2, 0x1

    const/4 v3, 0x0

    aput-byte v3, v0, v1

    add-int/lit8 v1, v2, 0x2

    const/16 v3, 0x1c

    aput-byte v3, v0, v1

    add-int/lit8 v2, v2, 0x3

    const/16 v1, 0x17

    aput-byte v1, v0, v2

    return-object v0
.end method
