.class Ljxl/write/biff/MergedCells;
.super Ljava/lang/Object;
.source ""


# static fields
.field static synthetic class$jxl$write$biff$MergedCells:Ljava/lang/Class; = null

.field private static logger:Ljxl/common/Logger; = null

.field private static final maxRangesPerSheet:I = 0x3fc


# instance fields
.field private ranges:Ljava/util/ArrayList;

.field private sheet:Ljxl/write/WritableSheet;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/MergedCells;->class$jxl$write$biff$MergedCells:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.write.biff.MergedCells"

    invoke-static {v0}, Ljxl/write/biff/MergedCells;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/MergedCells;->class$jxl$write$biff$MergedCells:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/write/biff/MergedCells;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>(Ljxl/write/WritableSheet;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    iput-object p1, p0, Ljxl/write/biff/MergedCells;->sheet:Ljxl/write/WritableSheet;

    return-void
.end method

.method private checkIntersections()V
    .locals 7

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v1, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v4, 0x0

    :cond_1
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    if-nez v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v5, v2}, Ljxl/biff/SheetRangeImpl;->intersects(Ljxl/biff/SheetRangeImpl;)Z

    move-result v5

    if-eqz v5, :cond_1

    sget-object v4, Ljxl/write/biff/MergedCells;->logger:Ljxl/common/Logger;

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Could not merge cells "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    const-string v6, " as they clash with an existing set of merged cells."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    const/4 v4, 0x1

    goto :goto_1

    :cond_2
    if-nez v4, :cond_0

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    iput-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    return-void
.end method

.method private checkRanges()V
    .locals 11

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    :try_start_0
    iget-object v2, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_4

    iget-object v2, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v2}, Ljxl/biff/SheetRangeImpl;->getTopLeft()Ljxl/Cell;

    move-result-object v3

    invoke-virtual {v2}, Ljxl/biff/SheetRangeImpl;->getBottomRight()Ljxl/Cell;

    move-result-object v4

    invoke-interface {v3}, Ljxl/Cell;->getColumn()I

    move-result v5

    move v6, v0

    :goto_1
    invoke-interface {v4}, Ljxl/Cell;->getColumn()I

    move-result v7

    if-gt v5, v7, :cond_3

    invoke-interface {v3}, Ljxl/Cell;->getRow()I

    move-result v7

    :goto_2
    invoke-interface {v4}, Ljxl/Cell;->getRow()I

    move-result v8

    if-gt v7, v8, :cond_2

    iget-object v8, p0, Ljxl/write/biff/MergedCells;->sheet:Ljxl/write/WritableSheet;

    invoke-interface {v8, v5, v7}, Ljxl/Sheet;->getCell(II)Ljxl/Cell;

    move-result-object v8

    invoke-interface {v8}, Ljxl/Cell;->getType()Ljxl/CellType;

    move-result-object v8

    sget-object v9, Ljxl/CellType;->EMPTY:Ljxl/CellType;

    if-eq v8, v9, :cond_1

    if-nez v6, :cond_0

    const/4 v6, 0x1

    goto :goto_3

    :cond_0
    sget-object v8, Ljxl/write/biff/MergedCells;->logger:Ljxl/common/Logger;

    new-instance v9, Ljava/lang/StringBuffer;

    invoke-direct {v9}, Ljava/lang/StringBuffer;-><init>()V

    const-string v10, "Range "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v9, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    const-string v10, " contains more than one data cell.  "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v10, "Setting the other cells to blank."

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v9}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljxl/common/Logger;->warn(Ljava/lang/Object;)V

    new-instance v8, Ljxl/write/Blank;

    invoke-direct {v8, v5, v7}, Ljxl/write/Blank;-><init>(II)V

    iget-object v9, p0, Ljxl/write/biff/MergedCells;->sheet:Ljxl/write/WritableSheet;

    invoke-interface {v9, v8}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V
    :try_end_0
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_3
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    invoke-static {v0}, Ljxl/common/Assert;->verify(Z)V

    :cond_4
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
.method add(Ljxl/Range;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method getMergedCells()[Ljxl/Range;
    .locals 4

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v1, v0, [Ljxl/Range;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    iget-object v3, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljxl/Range;

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method insertColumn(I)V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v1, p1}, Ljxl/biff/SheetRangeImpl;->insertColumn(I)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method insertRow(I)V
    .locals 2

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v1, p1}, Ljxl/biff/SheetRangeImpl;->insertRow(I)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method removeColumn(I)V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v1}, Ljxl/biff/SheetRangeImpl;->getTopLeft()Ljxl/Cell;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getColumn()I

    move-result v2

    if-ne v2, p1, :cond_0

    invoke-virtual {v1}, Ljxl/biff/SheetRangeImpl;->getBottomRight()Ljxl/Cell;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getColumn()I

    move-result v2

    if-ne v2, p1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_0
    invoke-virtual {v1, p1}, Ljxl/biff/SheetRangeImpl;->removeColumn(I)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method removeRow(I)V
    .locals 3

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/SheetRangeImpl;

    invoke-virtual {v1}, Ljxl/biff/SheetRangeImpl;->getTopLeft()Ljxl/Cell;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getRow()I

    move-result v2

    if-ne v2, p1, :cond_0

    invoke-virtual {v1}, Ljxl/biff/SheetRangeImpl;->getBottomRight()Ljxl/Cell;

    move-result-object v2

    invoke-interface {v2}, Ljxl/Cell;->getRow()I

    move-result v2

    if-ne v2, p1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_0
    invoke-virtual {v1, p1}, Ljxl/biff/SheetRangeImpl;->removeRow(I)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method unmergeCells(Ljxl/Range;)V
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result p1

    const/4 v0, -0x1

    if-eq p1, v0, :cond_0

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_0
    return-void
.end method

.method write(Ljxl/write/biff/File;)V
    .locals 10

    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ljxl/write/biff/MergedCells;->sheet:Ljxl/write/WritableSheet;

    check-cast v0, Ljxl/write/biff/WritableSheetImpl;

    invoke-virtual {v0}, Ljxl/write/biff/WritableSheetImpl;->getWorkbookSettings()Ljxl/WorkbookSettings;

    move-result-object v0

    invoke-virtual {v0}, Ljxl/WorkbookSettings;->getMergedCellCheckingDisabled()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Ljxl/write/biff/MergedCells;->checkIntersections()V

    invoke-direct {p0}, Ljxl/write/biff/MergedCells;->checkRanges()V

    :cond_1
    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x3fc

    if-ge v0, v1, :cond_2

    new-instance v0, Ljxl/write/biff/MergedCellsRecord;

    iget-object v1, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljxl/write/biff/MergedCellsRecord;-><init>(Ljava/util/ArrayList;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    return-void

    :cond_2
    iget-object v0, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    div-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    :goto_0
    if-ge v3, v0, :cond_4

    iget-object v5, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    sub-int/2addr v5, v4

    invoke-static {v1, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v5}, Ljava/util/ArrayList;-><init>(I)V

    move v7, v2

    :goto_1
    if-ge v7, v5, :cond_3

    iget-object v8, p0, Ljxl/write/biff/MergedCells;->ranges:Ljava/util/ArrayList;

    add-int v9, v4, v7

    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_3
    new-instance v7, Ljxl/write/biff/MergedCellsRecord;

    invoke-direct {v7, v6}, Ljxl/write/biff/MergedCellsRecord;-><init>(Ljava/util/ArrayList;)V

    invoke-virtual {p1, v7}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    add-int/2addr v4, v5

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_4
    return-void
.end method
