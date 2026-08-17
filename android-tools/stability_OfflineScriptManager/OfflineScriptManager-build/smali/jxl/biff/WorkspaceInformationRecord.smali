.class public Ljxl/biff/WorkspaceInformationRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field private static final DEFAULT_OPTIONS:I = 0x4c1

.field private static final FIT_TO_PAGES:I = 0x100

.field private static final SHOW_COLUMN_OUTLINE_SYMBOLS:I = 0x800

.field private static final SHOW_ROW_OUTLINE_SYMBOLS:I = 0x400

.field static synthetic class$jxl$biff$WorkspaceInformationRecord:Ljava/lang/Class;

.field private static logger:Ljxl/common/Logger;


# instance fields
.field private columnOutlines:Z

.field private fitToPages:Z

.field private rowOutlines:Z

.field private wsoptions:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/WorkspaceInformationRecord;->class$jxl$biff$WorkspaceInformationRecord:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.WorkspaceInformationRecord"

    invoke-static {v0}, Ljxl/biff/WorkspaceInformationRecord;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/WorkspaceInformationRecord;->class$jxl$biff$WorkspaceInformationRecord:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/WorkspaceInformationRecord;->logger:Ljxl/common/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->WSBOOL:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/16 v0, 0x4c1

    iput v0, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    return-void
.end method

.method public constructor <init>(Ljxl/read/biff/Record;)V
    .locals 3

    invoke-direct {p0, p1}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/read/biff/Record;)V

    invoke-virtual {p0}, Ljxl/biff/RecordData;->getRecord()Ljxl/read/biff/Record;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    const/4 v0, 0x0

    aget-byte v1, p1, v0

    const/4 v2, 0x1

    aget-byte p1, p1, v2

    invoke-static {v1, p1}, Ljxl/biff/IntegerHelper;->getInt(BB)I

    move-result p1

    iput p1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    or-int/lit16 v1, p1, 0x100

    if-eqz v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    iput-boolean v1, p0, Ljxl/biff/WorkspaceInformationRecord;->fitToPages:Z

    or-int/lit16 v1, p1, 0x400

    if-eqz v1, :cond_1

    move v1, v2

    goto :goto_1

    :cond_1
    move v1, v0

    :goto_1
    iput-boolean v1, p0, Ljxl/biff/WorkspaceInformationRecord;->rowOutlines:Z

    or-int/lit16 p1, p1, 0x800

    if-eqz p1, :cond_2

    move v0, v2

    :cond_2
    iput-boolean v0, p0, Ljxl/biff/WorkspaceInformationRecord;->columnOutlines:Z

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
    .locals 3

    const/4 v0, 0x2

    new-array v0, v0, [B

    iget-boolean v1, p0, Ljxl/biff/WorkspaceInformationRecord;->fitToPages:Z

    if-eqz v1, :cond_0

    iget v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    or-int/lit16 v1, v1, 0x100

    iput v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    :cond_0
    iget-boolean v1, p0, Ljxl/biff/WorkspaceInformationRecord;->rowOutlines:Z

    if-eqz v1, :cond_1

    iget v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    or-int/lit16 v1, v1, 0x400

    iput v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    :cond_1
    iget-boolean v1, p0, Ljxl/biff/WorkspaceInformationRecord;->columnOutlines:Z

    if-eqz v1, :cond_2

    iget v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    or-int/lit16 v1, v1, 0x800

    iput v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    :cond_2
    iget v1, p0, Ljxl/biff/WorkspaceInformationRecord;->wsoptions:I

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Ljxl/biff/IntegerHelper;->getTwoBytes(I[BI)V

    return-object v0
.end method

.method public getFitToPages()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/WorkspaceInformationRecord;->fitToPages:Z

    return v0
.end method

.method public setColumnOutlines(Z)V
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/WorkspaceInformationRecord;->rowOutlines:Z

    return-void
.end method

.method public setFitToPages(Z)V
    .locals 0

    iput-boolean p1, p0, Ljxl/biff/WorkspaceInformationRecord;->fitToPages:Z

    return-void
.end method

.method public setRowOutlines(Z)V
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/WorkspaceInformationRecord;->rowOutlines:Z

    return-void
.end method
