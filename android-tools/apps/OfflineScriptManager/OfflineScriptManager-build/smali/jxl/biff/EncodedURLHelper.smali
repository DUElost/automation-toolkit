.class public Ljxl/biff/EncodedURLHelper;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$biff$EncodedURLHelper:Ljava/lang/Class;

.field private static endOfSubdirectory:B

.field private static logger:Ljxl/common/Logger;

.field private static msDosDriveLetter:B

.field private static parentDirectory:B

.field private static sameDrive:B

.field private static unencodedUrl:B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/EncodedURLHelper;->class$jxl$biff$EncodedURLHelper:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.EncodedURLHelper"

    invoke-static {v0}, Ljxl/biff/EncodedURLHelper;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/EncodedURLHelper;->class$jxl$biff$EncodedURLHelper:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/EncodedURLHelper;->logger:Ljxl/common/Logger;

    const/4 v0, 0x1

    sput-byte v0, Ljxl/biff/EncodedURLHelper;->msDosDriveLetter:B

    const/4 v0, 0x2

    sput-byte v0, Ljxl/biff/EncodedURLHelper;->sameDrive:B

    const/4 v0, 0x3

    sput-byte v0, Ljxl/biff/EncodedURLHelper;->endOfSubdirectory:B

    const/4 v0, 0x4

    sput-byte v0, Ljxl/biff/EncodedURLHelper;->parentDirectory:B

    const/4 v0, 0x5

    sput-byte v0, Ljxl/biff/EncodedURLHelper;->unencodedUrl:B

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

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

.method public static getEncodedURL(Ljava/lang/String;Ljxl/WorkbookSettings;)[B
    .locals 1

    const-string v0, "http:"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Ljxl/biff/EncodedURLHelper;->getURL(Ljava/lang/String;Ljxl/WorkbookSettings;)[B

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {p0, p1}, Ljxl/biff/EncodedURLHelper;->getFile(Ljava/lang/String;Ljxl/WorkbookSettings;)[B

    move-result-object p0

    return-object p0
.end method

.method private static getFile(Ljava/lang/String;Ljxl/WorkbookSettings;)[B
    .locals 8

    new-instance v0, Ljxl/biff/ByteArray;

    invoke-direct {v0}, Ljxl/biff/ByteArray;-><init>()V

    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2f

    const/16 v3, 0x5c

    const/4 v4, 0x0

    const/16 v5, 0x3a

    if-ne v1, v5, :cond_0

    sget-byte v1, Ljxl/biff/EncodedURLHelper;->msDosDriveLetter:B

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    int-to-byte v1, v1

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    const/4 v1, 0x2

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-eq v1, v3, :cond_1

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v1, v2, :cond_2

    :cond_1
    sget-byte v1, Ljxl/biff/EncodedURLHelper;->sameDrive:B

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    :cond_2
    move v1, v4

    :goto_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-eq v5, v3, :cond_c

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v5, v2, :cond_3

    goto/16 :goto_6

    :cond_3
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v1, v5, :cond_b

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v5

    invoke-virtual {p0, v3, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v6

    const/4 v7, -0x1

    if-eq v5, v7, :cond_4

    if-eq v6, v7, :cond_4

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v5

    goto :goto_3

    :cond_4
    if-eq v5, v7, :cond_6

    if-ne v6, v7, :cond_5

    goto :goto_2

    :cond_5
    move v5, v4

    goto :goto_3

    :cond_6
    :goto_2
    invoke-static {v5, v6}, Ljava/lang/Math;->max(II)I

    move-result v5

    :goto_3
    if-ne v5, v7, :cond_7

    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    goto :goto_4

    :cond_7
    invoke-virtual {p0, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v5, v5, 0x1

    :goto_4
    const-string v6, "."

    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_8

    goto :goto_5

    :cond_8
    const-string v6, ".."

    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_9

    sget-byte v1, Ljxl/biff/EncodedURLHelper;->parentDirectory:B

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    goto :goto_5

    :cond_9
    invoke-static {v1, p1}, Ljxl/biff/StringHelper;->getBytes(Ljava/lang/String;Ljxl/WorkbookSettings;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add([B)V

    :goto_5
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v5, v1, :cond_a

    sget-byte v1, Ljxl/biff/EncodedURLHelper;->endOfSubdirectory:B

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    :cond_a
    move v1, v5

    goto :goto_1

    :cond_b
    invoke-virtual {v0}, Ljxl/biff/ByteArray;->getBytes()[B

    move-result-object p0

    return-object p0

    :cond_c
    :goto_6
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method private static getURL(Ljava/lang/String;Ljxl/WorkbookSettings;)[B
    .locals 2

    new-instance v0, Ljxl/biff/ByteArray;

    invoke-direct {v0}, Ljxl/biff/ByteArray;-><init>()V

    sget-byte v1, Ljxl/biff/EncodedURLHelper;->unencodedUrl:B

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    int-to-byte v1, v1

    invoke-virtual {v0, v1}, Ljxl/biff/ByteArray;->add(B)V

    invoke-static {p0, p1}, Ljxl/biff/StringHelper;->getBytes(Ljava/lang/String;Ljxl/WorkbookSettings;)[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljxl/biff/ByteArray;->add([B)V

    invoke-virtual {v0}, Ljxl/biff/ByteArray;->getBytes()[B

    move-result-object p0

    return-object p0
.end method
