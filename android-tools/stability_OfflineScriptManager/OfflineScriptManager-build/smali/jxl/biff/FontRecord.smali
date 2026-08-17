.class public Ljxl/biff/FontRecord;
.super Ljxl/biff/WritableRecordData;
.source ""

# interfaces
.implements Ljxl/format/Font;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/FontRecord$Biff7;
    }
.end annotation


# static fields
.field private static final EXCEL_UNITS_PER_POINT:I = 0x14

.field public static final biff7:Ljxl/biff/FontRecord$Biff7;

.field static synthetic class$jxl$biff$FontRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private boldWeight:I

.field private characterSet:B

.field private colourIndex:I

.field private fontFamily:B

.field private fontIndex:I

.field private initialized:Z

.field private italic:Z

.field private name:Ljava/lang/String;

.field private pointHeight:I

.field private scriptStyle:I

.field private struckout:Z

.field private underlineStyle:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/biff/FontRecord;->class$jxl$biff$FontRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.FontRecord"

    invoke-static {v0}, Ljxl/biff/FontRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/FontRecord;->class$jxl$biff$FontRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/FontRecord;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/biff/FontRecord$Biff7;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljxl/biff/FontRecord$Biff7;-><init>(Ljxl/biff/FontRecord$1;)V

    sput-object v0, Ljxl/biff/FontRecord;->biff7:Ljxl/biff/FontRecord$Biff7;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;IIZIII)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->FONT:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput p3, p0, Ljxl/biff/FontRecord;->boldWeight:I

    iput p5, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    iput-object p1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    iput p2, p0, Ljxl/biff/FontRecord;->pointHeight:I

    iput-boolean p4, p0, Ljxl/biff/FontRecord;->italic:Z

    iput p7, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    iput p6, p0, Ljxl/biff/FontRecord;->colourIndex:I

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->initialized:Z

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->struckout:Z

    return-void
.end method

.method protected constructor <init>(Ljxl/format/Font;)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->FONT:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    invoke-interface {p1}, Ljxl/format/Font;->getPointSize()I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->pointHeight:I

    invoke-interface {p1}, Ljxl/format/Font;->getColour()Ljxl/format/Colour;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/format/Colour;->getValue()I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->colourIndex:I

    invoke-interface {p1}, Ljxl/format/Font;->getBoldWeight()I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->boldWeight:I

    invoke-interface {p1}, Ljxl/format/Font;->getScriptStyle()Ljxl/format/ScriptStyle;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/format/ScriptStyle;->getValue()I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    invoke-interface {p1}, Ljxl/format/Font;->getUnderlineStyle()Ljxl/format/UnderlineStyle;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/format/UnderlineStyle;->getValue()I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    invoke-interface {p1}, Ljxl/format/Font;->isItalic()Z

    move-result v1

    iput-boolean v1, p0, Ljxl/biff/FontRecord;->italic:Z

    invoke-interface {p1}, Ljxl/format/Font;->getName()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-interface {p1}, Ljxl/format/Font;->isStruckout()Z

    move-result p1

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->struckout:Z

    iput-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;)V
    .locals 5

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v1, p1, v0

    const/4 v2, 0x1

    aget-byte v3, p1, v2

    invoke-static {v1, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    div-int/lit8 v1, v1, 0x14

    iput v1, p0, Ljxl/biff/FontRecord;->pointHeight:I

    const/4 v1, 0x4

    aget-byte v1, p1, v1

    const/4 v3, 0x5

    aget-byte v3, p1, v3

    invoke-static {v1, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->colourIndex:I

    const/4 v1, 0x6

    aget-byte v1, p1, v1

    const/4 v3, 0x7

    aget-byte v3, p1, v3

    invoke-static {v1, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v1

    iput v1, p0, Ljxl/biff/FontRecord;->boldWeight:I

    const/16 v1, 0x8

    aget-byte v3, p1, v1

    const/16 v4, 0x9

    aget-byte v4, p1, v4

    invoke-static {v3, v4}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v3

    iput v3, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    const/16 v3, 0xa

    aget-byte v3, p1, v3

    iput v3, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    const/16 v3, 0xb

    aget-byte v3, p1, v3

    iput-byte v3, p0, Ljxl/biff/FontRecord;->fontFamily:B

    const/16 v3, 0xc

    aget-byte v3, p1, v3

    iput-byte v3, p0, Ljxl/biff/FontRecord;->characterSet:B

    iput-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    const/4 v0, 0x2

    aget-byte v3, p1, v0

    and-int/2addr v3, v0

    if-eqz v3, :cond_0

    iput-boolean v2, p0, Ljxl/biff/FontRecord;->italic:Z

    :cond_0
    aget-byte v0, p1, v0

    and-int/2addr v0, v1

    if-eqz v0, :cond_1

    iput-boolean v2, p0, Ljxl/biff/FontRecord;->struckout:Z

    :cond_1
    const/16 v0, 0xe

    aget-byte v0, p1, v0

    const/16 v1, 0xf

    aget-byte v3, p1, v1

    const/16 v4, 0x10

    if-nez v3, :cond_2

    invoke-static {p1, v0, v4, p2}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    goto :goto_1

    :cond_2
    aget-byte v3, p1, v1

    if-ne v3, v2, :cond_3

    invoke-static {p1, v0, v4}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_3
    invoke-static {p1, v0, v1, p2}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :goto_1
    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;Ljxl/WorkbookSettings;Ljxl/biff/FontRecord$Biff7;)V
    .locals 4

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 p3, 0x0

    aget-byte v0, p1, p3

    const/4 v1, 0x1

    aget-byte v2, p1, v1

    invoke-static {v0, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    div-int/lit8 v0, v0, 0x14

    iput v0, p0, Ljxl/biff/FontRecord;->pointHeight:I

    const/4 v0, 0x4

    aget-byte v0, p1, v0

    const/4 v2, 0x5

    aget-byte v2, p1, v2

    invoke-static {v0, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/FontRecord;->colourIndex:I

    const/4 v0, 0x6

    aget-byte v0, p1, v0

    const/4 v2, 0x7

    aget-byte v2, p1, v2

    invoke-static {v0, v2}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v0

    iput v0, p0, Ljxl/biff/FontRecord;->boldWeight:I

    const/16 v0, 0x8

    aget-byte v2, p1, v0

    const/16 v3, 0x9

    aget-byte v3, p1, v3

    invoke-static {v2, v3}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result v2

    iput v2, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    const/16 v2, 0xa

    aget-byte v2, p1, v2

    iput v2, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    const/16 v2, 0xb

    aget-byte v2, p1, v2

    iput-byte v2, p0, Ljxl/biff/FontRecord;->fontFamily:B

    iput-boolean p3, p0, Ljxl/biff/FontRecord;->initialized:Z

    const/4 p3, 0x2

    aget-byte v2, p1, p3

    and-int/2addr v2, p3

    if-eqz v2, :cond_0

    iput-boolean v1, p0, Ljxl/biff/FontRecord;->italic:Z

    :cond_0
    aget-byte p3, p1, p3

    and-int/2addr p3, v0

    if-eqz p3, :cond_1

    iput-boolean v1, p0, Ljxl/biff/FontRecord;->struckout:Z

    :cond_1
    const/16 p3, 0xe

    aget-byte p3, p1, p3

    const/16 v0, 0xf

    invoke-static {p1, p3, v0, p2}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

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
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Ljxl/biff/FontRecord;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Ljxl/biff/FontRecord;

    iget v1, p0, Ljxl/biff/FontRecord;->pointHeight:I

    iget v3, p1, Ljxl/biff/FontRecord;->pointHeight:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/FontRecord;->colourIndex:I

    iget v3, p1, Ljxl/biff/FontRecord;->colourIndex:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/FontRecord;->boldWeight:I

    iget v3, p1, Ljxl/biff/FontRecord;->boldWeight:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    iget v3, p1, Ljxl/biff/FontRecord;->scriptStyle:I

    if-ne v1, v3, :cond_2

    iget v1, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    iget v3, p1, Ljxl/biff/FontRecord;->underlineStyle:I

    if-ne v1, v3, :cond_2

    iget-boolean v1, p0, Ljxl/biff/FontRecord;->italic:Z

    iget-boolean v3, p1, Ljxl/biff/FontRecord;->italic:Z

    if-ne v1, v3, :cond_2

    iget-boolean v1, p0, Ljxl/biff/FontRecord;->struckout:Z

    iget-boolean v3, p1, Ljxl/biff/FontRecord;->struckout:Z

    if-ne v1, v3, :cond_2

    iget-byte v1, p0, Ljxl/biff/FontRecord;->fontFamily:B

    iget-byte v3, p1, Ljxl/biff/FontRecord;->fontFamily:B

    if-ne v1, v3, :cond_2

    iget-byte v1, p0, Ljxl/biff/FontRecord;->characterSet:B

    iget-byte v3, p1, Ljxl/biff/FontRecord;->characterSet:B

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    iget-object p1, p1, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    :cond_2
    return v2
.end method

.method public getBoldWeight()I
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->boldWeight:I

    return v0
.end method

.method public getColour()Ljxl/format/Colour;
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->colourIndex:I

    invoke-static {v0}, Ljxl/format/Colour;->getInternalColour(I)Ljxl/format/Colour;

    move-result-object v0

    return-object v0
.end method

.method public getData()[B
    .locals 6

    iget-object v0, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    mul-int/2addr v0, v1

    const/16 v2, 0x10

    add-int/2addr v0, v2

    new-array v0, v0, [B

    iget v3, p0, Ljxl/biff/FontRecord;->pointHeight:I

    mul-int/lit8 v3, v3, 0x14

    const/4 v4, 0x0

    invoke-static {v3, v0, v4}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget-boolean v3, p0, Ljxl/biff/FontRecord;->italic:Z

    if-eqz v3, :cond_0

    aget-byte v3, v0, v1

    or-int/2addr v3, v1

    int-to-byte v3, v3

    aput-byte v3, v0, v1

    :cond_0
    iget-boolean v3, p0, Ljxl/biff/FontRecord;->struckout:Z

    const/16 v5, 0x8

    if-eqz v3, :cond_1

    aget-byte v3, v0, v1

    or-int/2addr v3, v5

    int-to-byte v3, v3

    aput-byte v3, v0, v1

    :cond_1
    iget v1, p0, Ljxl/biff/FontRecord;->colourIndex:I

    const/4 v3, 0x4

    invoke-static {v1, v0, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/FontRecord;->boldWeight:I

    const/4 v3, 0x6

    invoke-static {v1, v0, v3}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    iget v1, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    invoke-static {v1, v0, v5}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    const/16 v1, 0xa

    iget v3, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    int-to-byte v3, v3

    aput-byte v3, v0, v1

    const/16 v1, 0xb

    iget-byte v3, p0, Ljxl/biff/FontRecord;->fontFamily:B

    aput-byte v3, v0, v1

    const/16 v1, 0xc

    iget-byte v3, p0, Ljxl/biff/FontRecord;->characterSet:B

    aput-byte v3, v0, v1

    const/16 v1, 0xd

    aput-byte v4, v0, v1

    const/16 v1, 0xe

    iget-object v3, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, v0, v1

    const/16 v1, 0xf

    const/4 v3, 0x1

    aput-byte v3, v0, v1

    iget-object v1, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    return-object v0
.end method

.method public final getFontIndex()I
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->fontIndex:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getPointSize()I
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->pointHeight:I

    return v0
.end method

.method public getScriptStyle()Ljxl/format/ScriptStyle;
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    invoke-static {v0}, Ljxl/format/ScriptStyle;->getStyle(I)Ljxl/format/ScriptStyle;

    move-result-object v0

    return-object v0
.end method

.method public getUnderlineStyle()Ljxl/format/UnderlineStyle;
    .locals 1

    iget v0, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    invoke-static {v0}, Ljxl/format/UnderlineStyle;->getStyle(I)Ljxl/format/UnderlineStyle;

    move-result-object v0

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Ljxl/biff/FontRecord;->name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public final initialize(I)V
    .locals 0

    iput p1, p0, Ljxl/biff/FontRecord;->fontIndex:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->initialized:Z

    return-void
.end method

.method public final isInitialized()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    return v0
.end method

.method public isItalic()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->italic:Z

    return v0
.end method

.method public isStruckout()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->struckout:Z

    return v0
.end method

.method protected setFontBoldStyle(I)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput p1, p0, Ljxl/biff/FontRecord;->boldWeight:I

    return-void
.end method

.method protected setFontColour(I)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput p1, p0, Ljxl/biff/FontRecord;->colourIndex:I

    return-void
.end method

.method protected setFontItalic(Z)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->italic:Z

    return-void
.end method

.method protected setFontPointSize(I)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput p1, p0, Ljxl/biff/FontRecord;->pointHeight:I

    return-void
.end method

.method protected setFontScriptStyle(I)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput p1, p0, Ljxl/biff/FontRecord;->scriptStyle:I

    return-void
.end method

.method protected setFontStruckout(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/biff/FontRecord;->struckout:Z

    return-void
.end method

.method protected setFontUnderlineStyle(I)V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    xor-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    iput p1, p0, Ljxl/biff/FontRecord;->underlineStyle:I

    return-void
.end method

.method public final uninitialize()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Ljxl/biff/FontRecord;->initialized:Z

    return-void
.end method
