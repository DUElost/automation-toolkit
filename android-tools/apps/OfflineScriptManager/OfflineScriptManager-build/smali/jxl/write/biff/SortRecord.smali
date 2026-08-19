.class Ljxl/write/biff/SortRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# instance fields
.field private column1Name:Ljava/lang/String;

.field private column2Name:Ljava/lang/String;

.field private column3Name:Ljava/lang/String;

.field private sortCaseSensitive:Z

.field private sortColumns:Z

.field private sortKey1Desc:Z

.field private sortKey2Desc:Z

.field private sortKey3Desc:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZZZZ)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->SORT:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    iput-object p1, p0, Ljxl/write/biff/SortRecord;->column1Name:Ljava/lang/String;

    iput-object p2, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    iput-object p3, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    iput-boolean p4, p0, Ljxl/write/biff/SortRecord;->sortColumns:Z

    iput-boolean p5, p0, Ljxl/write/biff/SortRecord;->sortKey1Desc:Z

    iput-boolean p6, p0, Ljxl/write/biff/SortRecord;->sortKey2Desc:Z

    iput-boolean p7, p0, Ljxl/write/biff/SortRecord;->sortKey3Desc:Z

    iput-boolean p8, p0, Ljxl/write/biff/SortRecord;->sortCaseSensitive:Z

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 7

    iget-object v0, p0, Ljxl/write/biff/SortRecord;->column1Name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    mul-int/2addr v0, v1

    const/4 v2, 0x5

    add-int/2addr v0, v2

    const/4 v3, 0x1

    add-int/2addr v0, v3

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_0

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    mul-int/2addr v4, v1

    add-int/2addr v4, v3

    add-int/2addr v0, v4

    :cond_0
    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_1

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    mul-int/2addr v4, v1

    add-int/2addr v4, v3

    add-int/2addr v0, v4

    :cond_1
    add-int/2addr v0, v3

    new-array v0, v0, [B

    iget-boolean v4, p0, Ljxl/write/biff/SortRecord;->sortColumns:Z

    const/4 v5, 0x0

    if-eqz v4, :cond_2

    move v4, v3

    goto :goto_0

    :cond_2
    move v4, v5

    :goto_0
    iget-boolean v6, p0, Ljxl/write/biff/SortRecord;->sortKey1Desc:Z

    if-eqz v6, :cond_3

    or-int/lit8 v4, v4, 0x2

    :cond_3
    iget-boolean v6, p0, Ljxl/write/biff/SortRecord;->sortKey2Desc:Z

    if-eqz v6, :cond_4

    or-int/lit8 v4, v4, 0x4

    :cond_4
    iget-boolean v6, p0, Ljxl/write/biff/SortRecord;->sortKey3Desc:Z

    if-eqz v6, :cond_5

    or-int/lit8 v4, v4, 0x8

    :cond_5
    iget-boolean v6, p0, Ljxl/write/biff/SortRecord;->sortCaseSensitive:Z

    if-eqz v6, :cond_6

    or-int/lit8 v4, v4, 0x10

    :cond_6
    int-to-byte v4, v4

    aput-byte v4, v0, v5

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column1Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, v0, v1

    const/4 v4, 0x3

    iget-object v5, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    int-to-byte v5, v5

    aput-byte v5, v0, v4

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    int-to-byte v4, v4

    const/4 v5, 0x4

    aput-byte v4, v0, v5

    aput-byte v3, v0, v2

    iget-object v2, p0, Ljxl/write/biff/SortRecord;->column1Name:Ljava/lang/String;

    const/4 v4, 0x6

    invoke-static {v2, v0, v4}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v2, p0, Ljxl/write/biff/SortRecord;->column1Name:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    mul-int/2addr v2, v1

    add-int/2addr v2, v4

    iget-object v4, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_7

    add-int/lit8 v4, v2, 0x1

    aput-byte v3, v0, v2

    iget-object v2, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-static {v2, v0, v4}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v2, p0, Ljxl/write/biff/SortRecord;->column2Name:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    mul-int/2addr v2, v1

    add-int/2addr v2, v4

    :cond_7
    iget-object v1, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_8

    add-int/lit8 v1, v2, 0x1

    aput-byte v3, v0, v2

    iget-object v2, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-static {v2, v0, v1}, Ljxl/biff/StringHelper;->getUnicodeBytes(Ljava/lang/String;[BI)V

    iget-object v1, p0, Ljxl/write/biff/SortRecord;->column3Name:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    :cond_8
    return-object v0
.end method
