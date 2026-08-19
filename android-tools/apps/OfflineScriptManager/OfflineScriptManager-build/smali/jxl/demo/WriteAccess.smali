.class Ljxl/demo/WriteAccess;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private reader:Ljxl/read/biff/BiffRecordReader;


# direct methods
.method public constructor <init>(Ljava/io/File;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    new-instance p1, Ljxl/read/biff/File;

    invoke-direct {p1, v1, v0}, Ljxl/read/biff/File;-><init>(Ljava/io/InputStream;Ljxl/WorkbookSettings;)V

    new-instance v2, Ljxl/read/biff/BiffRecordReader;

    invoke-direct {v2, p1}, Ljxl/read/biff/BiffRecordReader;-><init>(Ljxl/read/biff/File;)V

    iput-object v2, p0, Ljxl/demo/WriteAccess;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-direct {p0, v0}, Ljxl/demo/WriteAccess;->display(Ljxl/WorkbookSettings;)V

    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V

    return-void
.end method

.method private display(Ljxl/WorkbookSettings;)V
    .locals 5

    const/4 v0, 0x0

    const/4 v1, 0x0

    move v2, v0

    :cond_0
    :goto_0
    iget-object v3, p0, Ljxl/demo/WriteAccess;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-virtual {v3}, Ljxl/read/biff/BiffRecordReader;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    if-nez v2, :cond_1

    iget-object v1, p0, Ljxl/demo/WriteAccess;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-virtual {v1}, Ljxl/read/biff/BiffRecordReader;->next()Ljxl/read/biff/Record;

    move-result-object v1

    invoke-virtual {v1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v3

    sget-object v4, Ljxl/biff/Type;->WRITEACCESS:Ljxl/biff/Type;

    if-ne v3, v4, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_1
    if-nez v2, :cond_2

    sget-object p1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string v0, "Warning:  could not find write access record"

    invoke-virtual {p1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return-void

    :cond_2
    invoke-virtual {v1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object v1

    array-length v2, v1

    invoke-static {v1, v2, v0, p1}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    return-void
.end method
