.class public Lcom/ape/offlinescriptmanager/batterytool/g/c;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/batterytool/g/c$a;
    }
.end annotation


# instance fields
.field public a:Ljxl/Workbook;

.field public b:Ljxl/write/WritableWorkbook;

.field public c:Ljxl/write/WritableSheet;

.field public d:Ljxl/write/WritableSheet;

.field public e:Ljxl/write/WritableSheet;

.field public f:Ljxl/write/WritableSheet;

.field public g:Ljxl/write/WritableSheet;

.field public h:Ljxl/write/WritableSheet;

.field public i:Ljxl/write/WritableSheet;

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->a:Ljxl/Workbook;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->f:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->g:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->h:Ljxl/write/WritableSheet;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->i:Ljxl/write/WritableSheet;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->j:Ljava/lang/String;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->k:Ljava/lang/String;

    const-string v0, "battery"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "battery_result_data.xls"

    goto :goto_0

    :cond_0
    const-string v1, "null"

    :goto_0
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    if-eqz p1, :cond_a

    invoke-static {p1}, Ljxl/Workbook;->getWorkbook(Ljava/io/InputStream;)Ljxl/Workbook;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->a:Ljxl/Workbook;

    new-instance p1, Ljava/io/File;

    const-string v2, ""

    invoke-static {p2, v2}, Lcom/ape/offlinescriptmanager/utils/g;->l(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p2}, Ljava/io/File;->mkdirs()Z

    :cond_1
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p2}, Ljava/io/File;->delete()Z

    :cond_2
    invoke-virtual {p2}, Ljava/io/File;->createNewFile()Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->a:Ljxl/Workbook;

    invoke-static {p2, p1}, Ljxl/Workbook;->createWorkbook(Ljava/io/File;Ljxl/Workbook;)Ljxl/write/WritableWorkbook;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    if-eqz p1, :cond_9

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 p2, 0x4

    const/4 v0, 0x3

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v0}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, p2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->f:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->g:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    const/4 p2, 0x6

    invoke-virtual {p1, p2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->h:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    const/4 p2, 0x7

    invoke-virtual {p1, p2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->i:Ljxl/write/WritableSheet;

    goto/16 :goto_3

    :cond_3
    const-string p1, "signal"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v0}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    :goto_1
    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    goto/16 :goto_3

    :cond_4
    const-string p1, "scrutator"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    goto/16 :goto_3

    :cond_5
    const-string p1, "roadrecorder"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    :goto_2
    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    goto/16 :goto_3

    :cond_6
    const-string p1, "externalmonitor"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v0}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->e:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, p2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->f:Ljxl/write/WritableSheet;

    goto/16 :goto_3

    :cond_7
    const-string p1, "simSignal"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->d:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v0}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    goto :goto_1

    :cond_8
    const-string p1, "wifiSignal"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v2}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->c:Ljxl/write/WritableSheet;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {p1, v1}, Ljxl/write/WritableWorkbook;->getSheet(I)Ljxl/write/WritableSheet;

    move-result-object p1

    goto :goto_2

    :cond_9
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "cann\'t create writableWorkbook ,please note!!!"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_0
    .catch Ljxl/read/biff/BiffException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "IOException e : "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    :catch_1
    move-exception p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "BiffException e : "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/ape/offlinescriptmanager/utils/i;->a(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_a
    :goto_3
    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {v0}, Ljxl/write/WritableWorkbook;->close()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->a:Ljxl/Workbook;

    invoke-virtual {v0}, Ljxl/Workbook;->close()V
    :try_end_0
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public b()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->b:Ljxl/write/WritableWorkbook;

    invoke-virtual {v0}, Ljxl/write/WritableWorkbook;->write()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public c(Ljxl/write/WritableSheet;DDDDLjava/lang/String;)V
    .locals 12

    move-object v0, p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->j:Ljava/lang/String;

    iget-object v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c;->k:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/ape/offlinescriptmanager/utils/g;->l(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-object/from16 v2, p10

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".png"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v11, Ljava/io/File;

    invoke-direct {v11, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v11}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljxl/write/WritableImage;

    move-object v2, v1

    move-wide v3, p2

    move-wide/from16 v5, p4

    move-wide/from16 v7, p6

    move-wide/from16 v9, p8

    invoke-direct/range {v2 .. v11}, Ljxl/write/WritableImage;-><init>(DDDDLjava/io/File;)V

    move-object v2, p1

    invoke-interface {p1, v1}, Ljxl/write/WritableSheet;->addImage(Ljxl/write/WritableImage;)V

    :cond_0
    return-void
.end method

.method public d(Ljxl/write/WritableSheet;Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljxl/write/WritableSheet;",
            "Ljava/util/List<",
            "Lcom/ape/offlinescriptmanager/batterytool/g/c$a;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljxl/write/WritableFont;

    sget-object v1, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    invoke-direct {v0, v1}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    new-instance v1, Ljxl/write/WritableCellFormat;

    invoke-direct {v1, v0}, Ljxl/write/WritableCellFormat;-><init>(Ljxl/write/WritableFont;)V

    sget-object v0, Ljxl/format/Alignment;->CENTRE:Ljxl/format/Alignment;

    invoke-virtual {v1, v0}, Ljxl/write/WritableCellFormat;->setAlignment(Ljxl/format/Alignment;)V

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;

    new-instance v2, Ljxl/write/Label;

    iget v3, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->b:I

    iget v4, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->a:I

    iget-object v0, v0, Lcom/ape/offlinescriptmanager/batterytool/g/c$a;->c:Ljava/lang/String;

    invoke-direct {v2, v3, v4, v0, v1}, Ljxl/write/Label;-><init>(IILjava/lang/String;Ljxl/format/CellFormat;)V

    invoke-interface {p1, v2}, Ljxl/write/WritableSheet;->addCell(Ljxl/write/WritableCell;)V
    :try_end_0
    .catch Ljxl/write/biff/RowsExceededException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljxl/write/WriteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    return-void
.end method
