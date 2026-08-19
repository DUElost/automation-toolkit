.class public abstract Ljxl/biff/WritableRecordData;
.super Ljxl/biff/RecordData;
.source ""

# interfaces
.implements Ljxl/biff/ByteData;


# static fields
.field static synthetic class$jxl$biff$WritableRecordData:Ljava/lang/Class; = null

.field private static logger:Ljxl/common/Logger; = null

.field protected static final maxRecordLength:I = 0x2024


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/WritableRecordData;->class$jxl$biff$WritableRecordData:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.WritableRecordData"

    invoke-static {v0}, Ljxl/biff/WritableRecordData;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/WritableRecordData;->class$jxl$biff$WritableRecordData:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/WritableRecordData;->logger:Ljxl/common/Logger;

    return-void
.end method

.method protected constructor <init>(Ljxl/biff/Type;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/biff/Type;)V

    return-void
.end method

.method protected constructor <init>(Ljxl/read/biff/Record;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/biff/RecordData;-><init>(Ljxl/read/biff/Record;)V

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

.method private handleContinueRecords([B)[B
    .locals 8

    array-length v0, p1

    const/16 v1, 0x2020

    sub-int/2addr v0, v1

    div-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    array-length v2, p1

    mul-int/lit8 v3, v0, 0x4

    add-int/2addr v2, v3

    new-array v2, v2, [B

    const/4 v3, 0x0

    invoke-static {p1, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move v4, v1

    move v5, v4

    :goto_0
    if-ge v3, v0, :cond_0

    array-length v6, p1

    sub-int/2addr v6, v4

    invoke-static {v6, v1}, Ljava/lang/Math;->min(II)I

    move-result v6

    sget-object v7, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    iget v7, v7, Ljxl/biff/Type;->value:I

    invoke-static {v7, v2, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v7, v5, 0x2

    invoke-static {v6, v2, v7}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    add-int/lit8 v7, v5, 0x4

    invoke-static {p1, v4, v2, v7, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    add-int/2addr v4, v6

    add-int/lit8 v6, v6, 0x4

    add-int/2addr v5, v6

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    return-object v2
.end method


# virtual methods
.method public final getBytes()[B
    .locals 6

    invoke-virtual {p0}, Ljxl/biff/WritableRecordData;->getData()[B

    move-result-object v0

    array-length v1, v0

    array-length v2, v0

    const/16 v3, 0x2020

    if-le v2, v3, :cond_0

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;->handleContinueRecords([B)[B

    move-result-object v0

    move v1, v3

    :cond_0
    array-length v2, v0

    const/4 v3, 0x4

    add-int/2addr v2, v3

    new-array v2, v2, [B

    array-length v4, v0

    const/4 v5, 0x0

    invoke-static {v0, v5, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getCode()I

    move-result v0

    invoke-static {v0, v2, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    const/4 v0, 0x2

    invoke-static {v1, v2, v0}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v2
.end method

.method protected abstract getData()[B
.end method
