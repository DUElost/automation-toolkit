.class Ljxl/demo/BiffDump;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final bytesPerLine:I = 0x10


# instance fields
.field private bofs:I

.field private fontIndex:I

.field private reader:Ljxl/read/biff/BiffRecordReader;

.field private recordNames:Ljava/util/HashMap;

.field private writer:Ljava/io/BufferedWriter;

.field private xfIndex:I


# direct methods
.method public constructor <init>(Ljava/io/File;Ljava/io/OutputStream;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/io/BufferedWriter;

    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-direct {v1, p2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    iput-object v0, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    new-instance p2, Ljava/io/FileInputStream;

    invoke-direct {p2, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    new-instance p1, Ljxl/read/biff/File;

    new-instance v0, Ljxl/WorkbookSettings;

    invoke-direct {v0}, Ljxl/WorkbookSettings;-><init>()V

    invoke-direct {p1, p2, v0}, Ljxl/read/biff/File;-><init>(Ljava/io/InputStream;Ljxl/WorkbookSettings;)V

    new-instance v0, Ljxl/read/biff/BiffRecordReader;

    invoke-direct {v0, p1}, Ljxl/read/biff/BiffRecordReader;-><init>(Ljxl/read/biff/File;)V

    iput-object v0, p0, Ljxl/demo/BiffDump;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-direct {p0}, Ljxl/demo/BiffDump;->buildNameHash()V

    invoke-direct {p0}, Ljxl/demo/BiffDump;->dump()V

    iget-object p1, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->flush()V

    iget-object p1, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->close()V

    invoke-virtual {p2}, Ljava/io/FileInputStream;->close()V

    return-void
.end method

.method private buildNameHash()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x32

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BOF:Ljxl/biff/Type;

    const-string v2, "BOF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->EOF:Ljxl/biff/Type;

    const-string v2, "EOF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FONT:Ljxl/biff/Type;

    const-string v2, "FONT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SST:Ljxl/biff/Type;

    const-string v2, "SST"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->LABELSST:Ljxl/biff/Type;

    const-string v2, "LABELSST"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WRITEACCESS:Ljxl/biff/Type;

    const-string v2, "WRITEACCESS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FORMULA:Ljxl/biff/Type;

    const-string v2, "FORMULA"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FORMULA2:Ljxl/biff/Type;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->XF:Ljxl/biff/Type;

    const-string v2, "XF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MULRK:Ljxl/biff/Type;

    const-string v2, "MULRK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->NUMBER:Ljxl/biff/Type;

    const-string v2, "NUMBER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BOUNDSHEET:Ljxl/biff/Type;

    const-string v2, "BOUNDSHEET"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CONTINUE:Ljxl/biff/Type;

    const-string v2, "CONTINUE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FORMAT:Ljxl/biff/Type;

    const-string v2, "FORMAT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->EXTERNSHEET:Ljxl/biff/Type;

    const-string v2, "EXTERNSHEET"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->INDEX:Ljxl/biff/Type;

    const-string v2, "INDEX"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DIMENSION:Ljxl/biff/Type;

    const-string v2, "DIMENSION"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->ROW:Ljxl/biff/Type;

    const-string v2, "ROW"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DBCELL:Ljxl/biff/Type;

    const-string v2, "DBCELL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BLANK:Ljxl/biff/Type;

    const-string v2, "BLANK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MULBLANK:Ljxl/biff/Type;

    const-string v2, "MULBLANK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->RK:Ljxl/biff/Type;

    const-string v2, "RK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->RK2:Ljxl/biff/Type;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->COLINFO:Ljxl/biff/Type;

    const-string v2, "COLINFO"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->LABEL:Ljxl/biff/Type;

    const-string v2, "LABEL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SHAREDFORMULA:Ljxl/biff/Type;

    const-string v2, "SHAREDFORMULA"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CODEPAGE:Ljxl/biff/Type;

    const-string v2, "CODEPAGE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WINDOW1:Ljxl/biff/Type;

    const-string v2, "WINDOW1"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WINDOW2:Ljxl/biff/Type;

    const-string v2, "WINDOW2"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MERGEDCELLS:Ljxl/biff/Type;

    const-string v2, "MERGEDCELLS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->HLINK:Ljxl/biff/Type;

    const-string v2, "HLINK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->HEADER:Ljxl/biff/Type;

    const-string v2, "HEADER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FOOTER:Ljxl/biff/Type;

    const-string v2, "FOOTER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->INTERFACEHDR:Ljxl/biff/Type;

    const-string v2, "INTERFACEHDR"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MMS:Ljxl/biff/Type;

    const-string v2, "MMS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->INTERFACEEND:Ljxl/biff/Type;

    const-string v2, "INTERFACEEND"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DSF:Ljxl/biff/Type;

    const-string v2, "DSF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FNGROUPCOUNT:Ljxl/biff/Type;

    const-string v2, "FNGROUPCOUNT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->COUNTRY:Ljxl/biff/Type;

    const-string v2, "COUNTRY"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->TABID:Ljxl/biff/Type;

    const-string v2, "TABID"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PROTECT:Ljxl/biff/Type;

    const-string v2, "PROTECT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SCENPROTECT:Ljxl/biff/Type;

    const-string v2, "SCENPROTECT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->OBJPROTECT:Ljxl/biff/Type;

    const-string v2, "OBJPROTECT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WINDOWPROTECT:Ljxl/biff/Type;

    const-string v2, "WINDOWPROTECT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PASSWORD:Ljxl/biff/Type;

    const-string v2, "PASSWORD"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PROT4REV:Ljxl/biff/Type;

    const-string v2, "PROT4REV"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PROT4REVPASS:Ljxl/biff/Type;

    const-string v2, "PROT4REVPASS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BACKUP:Ljxl/biff/Type;

    const-string v2, "BACKUP"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->HIDEOBJ:Ljxl/biff/Type;

    const-string v2, "HIDEOBJ"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->NINETEENFOUR:Ljxl/biff/Type;

    const-string v2, "1904"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PRECISION:Ljxl/biff/Type;

    const-string v2, "PRECISION"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BOOKBOOL:Ljxl/biff/Type;

    const-string v2, "BOOKBOOL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->STYLE:Ljxl/biff/Type;

    const-string v2, "STYLE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->EXTSST:Ljxl/biff/Type;

    const-string v2, "EXTSST"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->REFRESHALL:Ljxl/biff/Type;

    const-string v2, "REFRESHALL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CALCMODE:Ljxl/biff/Type;

    const-string v2, "CALCMODE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CALCCOUNT:Ljxl/biff/Type;

    const-string v2, "CALCCOUNT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->NAME:Ljxl/biff/Type;

    const-string v2, "NAME"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MSODRAWINGGROUP:Ljxl/biff/Type;

    const-string v2, "MSODRAWINGGROUP"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->MSODRAWING:Ljxl/biff/Type;

    const-string v2, "MSODRAWING"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->OBJ:Ljxl/biff/Type;

    const-string v2, "OBJ"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->USESELFS:Ljxl/biff/Type;

    const-string v2, "USESELFS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SUPBOOK:Ljxl/biff/Type;

    const-string v2, "SUPBOOK"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->LEFTMARGIN:Ljxl/biff/Type;

    const-string v2, "LEFTMARGIN"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->RIGHTMARGIN:Ljxl/biff/Type;

    const-string v2, "RIGHTMARGIN"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->TOPMARGIN:Ljxl/biff/Type;

    const-string v2, "TOPMARGIN"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BOTTOMMARGIN:Ljxl/biff/Type;

    const-string v2, "BOTTOMMARGIN"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->HCENTER:Ljxl/biff/Type;

    const-string v2, "HCENTER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->VCENTER:Ljxl/biff/Type;

    const-string v2, "VCENTER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->ITERATION:Ljxl/biff/Type;

    const-string v2, "ITERATION"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DELTA:Ljxl/biff/Type;

    const-string v2, "DELTA"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SAVERECALC:Ljxl/biff/Type;

    const-string v2, "SAVERECALC"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PRINTHEADERS:Ljxl/biff/Type;

    const-string v2, "PRINTHEADERS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PRINTGRIDLINES:Ljxl/biff/Type;

    const-string v2, "PRINTGRIDLINES"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SETUP:Ljxl/biff/Type;

    const-string v2, "SETUP"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SELECTION:Ljxl/biff/Type;

    const-string v2, "SELECTION"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->STRING:Ljxl/biff/Type;

    const-string v2, "STRING"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FONTX:Ljxl/biff/Type;

    const-string v2, "FONTX"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->IFMT:Ljxl/biff/Type;

    const-string v2, "IFMT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WSBOOL:Ljxl/biff/Type;

    const-string v2, "WSBOOL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->GRIDSET:Ljxl/biff/Type;

    const-string v2, "GRIDSET"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->REFMODE:Ljxl/biff/Type;

    const-string v2, "REFMODE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->GUTS:Ljxl/biff/Type;

    const-string v2, "GUTS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->EXTERNNAME:Ljxl/biff/Type;

    const-string v2, "EXTERNNAME"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FBI:Ljxl/biff/Type;

    const-string v2, "FBI"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CRN:Ljxl/biff/Type;

    const-string v2, "CRN"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->HORIZONTALPAGEBREAKS:Ljxl/biff/Type;

    const-string v2, "HORIZONTALPAGEBREAKS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->VERTICALPAGEBREAKS:Ljxl/biff/Type;

    const-string v2, "VERTICALPAGEBREAKS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DEFAULTROWHEIGHT:Ljxl/biff/Type;

    const-string v2, "DEFAULTROWHEIGHT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->TEMPLATE:Ljxl/biff/Type;

    const-string v2, "TEMPLATE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PANE:Ljxl/biff/Type;

    const-string v2, "PANE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SCL:Ljxl/biff/Type;

    const-string v2, "SCL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PALETTE:Ljxl/biff/Type;

    const-string v2, "PALETTE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->PLS:Ljxl/biff/Type;

    const-string v2, "PLS"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->OBJPROJ:Ljxl/biff/Type;

    const-string v2, "OBJPROJ"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DEFCOLWIDTH:Ljxl/biff/Type;

    const-string v2, "DEFCOLWIDTH"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->ARRAY:Ljxl/biff/Type;

    const-string v2, "ARRAY"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->WEIRD1:Ljxl/biff/Type;

    const-string v2, "WEIRD1"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BOOLERR:Ljxl/biff/Type;

    const-string v2, "BOOLERR"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SORT:Ljxl/biff/Type;

    const-string v2, "SORT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->BUTTONPROPERTYSET:Ljxl/biff/Type;

    const-string v2, "BUTTONPROPERTYSET"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->NOTE:Ljxl/biff/Type;

    const-string v2, "NOTE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->TXO:Ljxl/biff/Type;

    const-string v2, "TXO"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DV:Ljxl/biff/Type;

    const-string v2, "DV"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->DVAL:Ljxl/biff/Type;

    const-string v2, "DVAL"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SERIES:Ljxl/biff/Type;

    const-string v2, "SERIES"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SERIESLIST:Ljxl/biff/Type;

    const-string v2, "SERIESLIST"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->SBASEREF:Ljxl/biff/Type;

    const-string v2, "SBASEREF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CONDFMT:Ljxl/biff/Type;

    const-string v2, "CONDFMT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->CF:Ljxl/biff/Type;

    const-string v2, "CF"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->FILTERMODE:Ljxl/biff/Type;

    const-string v2, "FILTERMODE"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->AUTOFILTER:Ljxl/biff/Type;

    const-string v2, "AUTOFILTER"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->AUTOFILTERINFO:Ljxl/biff/Type;

    const-string v2, "AUTOFILTERINFO"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->XCT:Ljxl/biff/Type;

    const-string v2, "XCT"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    sget-object v1, Ljxl/biff/Type;->UNKNOWN:Ljxl/biff/Type;

    const-string v2, "???"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private dump()V
    .locals 2

    const/4 v0, 0x1

    :goto_0
    iget-object v1, p0, Ljxl/demo/BiffDump;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-virtual {v1}, Ljxl/read/biff/BiffRecordReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/demo/BiffDump;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-virtual {v0}, Ljxl/read/biff/BiffRecordReader;->next()Ljxl/read/biff/Record;

    move-result-object v0

    invoke-direct {p0, v0}, Ljxl/demo/BiffDump;->writeRecord(Ljxl/read/biff/Record;)Z

    move-result v0

    goto :goto_0

    :cond_0
    return-void
.end method

.method private writeByte(BLjava/lang/StringBuffer;)V
    .locals 2

    and-int/lit16 p1, p1, 0xff

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/16 v0, 0x30

    invoke-virtual {p2, v0}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    :cond_0
    invoke-virtual {p2, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    return-void
.end method

.method private writeRecord(Ljxl/read/biff/Record;)Z
    .locals 12

    iget-object v0, p0, Ljxl/demo/BiffDump;->reader:Ljxl/read/biff/BiffRecordReader;

    invoke-virtual {v0}, Ljxl/read/biff/BiffRecordReader;->getPos()I

    move-result v0

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getCode()I

    move-result v1

    iget v2, p0, Ljxl/demo/BiffDump;->bofs:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-nez v2, :cond_1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v2

    sget-object v5, Ljxl/biff/Type;->BOF:Ljxl/biff/Type;

    if-ne v2, v5, :cond_0

    goto :goto_0

    :cond_0
    move v2, v3

    goto :goto_1

    :cond_1
    :goto_0
    move v2, v4

    :goto_1
    if-nez v2, :cond_2

    return v2

    :cond_2
    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v5

    sget-object v6, Ljxl/biff/Type;->BOF:Ljxl/biff/Type;

    if-ne v5, v6, :cond_3

    iget v5, p0, Ljxl/demo/BiffDump;->bofs:I

    add-int/2addr v5, v4

    iput v5, p0, Ljxl/demo/BiffDump;->bofs:I

    :cond_3
    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v5

    sget-object v6, Ljxl/biff/Type;->EOF:Ljxl/biff/Type;

    if-ne v5, v6, :cond_4

    iget v5, p0, Ljxl/demo/BiffDump;->bofs:I

    sub-int/2addr v5, v4

    iput v5, p0, Ljxl/demo/BiffDump;->bofs:I

    :cond_4
    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    invoke-direct {p0, v0, v5}, Ljxl/demo/BiffDump;->writeSixDigitValue(ILjava/lang/StringBuffer;)V

    const-string v6, " ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget-object v6, p0, Ljxl/demo/BiffDump;->recordNames:Ljava/util/HashMap;

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getType()Ljxl/biff/Type;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v6, "  (0x"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v6, ")"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    sget-object v7, Ljxl/biff/Type;->XF:Ljxl/biff/Type;

    iget v7, v7, Ljxl/biff/Type;->value:I

    const-string v8, " (0x"

    if-ne v1, v7, :cond_5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v7, p0, Ljxl/demo/BiffDump;->xfIndex:I

    invoke-static {v7}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v7, p0, Ljxl/demo/BiffDump;->xfIndex:I

    add-int/2addr v7, v4

    iput v7, p0, Ljxl/demo/BiffDump;->xfIndex:I

    :cond_5
    sget-object v7, Ljxl/biff/Type;->FONT:Ljxl/biff/Type;

    iget v7, v7, Ljxl/biff/Type;->value:I

    const/4 v9, 0x4

    if-ne v1, v7, :cond_7

    iget v7, p0, Ljxl/demo/BiffDump;->fontIndex:I

    if-ne v7, v9, :cond_6

    add-int/2addr v7, v4

    iput v7, p0, Ljxl/demo/BiffDump;->fontIndex:I

    :cond_6
    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v7, p0, Ljxl/demo/BiffDump;->fontIndex:I

    invoke-static {v7}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    iget v6, p0, Ljxl/demo/BiffDump;->fontIndex:I

    add-int/2addr v6, v4

    iput v6, p0, Ljxl/demo/BiffDump;->fontIndex:I

    :cond_7
    iget-object v6, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    iget-object v5, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {v5}, Ljava/io/BufferedWriter;->newLine()V

    new-array v5, v9, [B

    and-int/lit16 v6, v1, 0xff

    int-to-byte v6, v6

    aput-byte v6, v5, v3

    const v6, 0xff00

    and-int/2addr v1, v6

    shr-int/lit8 v1, v1, 0x8

    int-to-byte v1, v1

    aput-byte v1, v5, v4

    const/4 v1, 0x2

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getLength()I

    move-result v4

    and-int/lit16 v4, v4, 0xff

    int-to-byte v4, v4

    aput-byte v4, v5, v1

    const/4 v1, 0x3

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getLength()I

    move-result v4

    and-int/2addr v4, v6

    shr-int/lit8 v4, v4, 0x8

    int-to-byte v4, v4

    aput-byte v4, v5, v1

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    array-length v1, p1

    add-int/2addr v1, v9

    new-array v4, v1, [B

    invoke-static {v5, v3, v4, v3, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    array-length v5, p1

    invoke-static {p1, v3, v4, v9, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move p1, v3

    :goto_2
    if-ge p1, v1, :cond_d

    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    add-int v6, v0, p1

    invoke-direct {p0, v6, v5}, Ljxl/demo/BiffDump;->writeSixDigitValue(ILjava/lang/StringBuffer;)V

    const-string v6, "   "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    sub-int v7, v1, p1

    const/16 v8, 0x10

    invoke-static {v8, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    move v9, v3

    :goto_3
    const/16 v10, 0x20

    if-ge v9, v7, :cond_8

    add-int v11, v9, p1

    aget-byte v11, v4, v11

    invoke-direct {p0, v11, v5}, Ljxl/demo/BiffDump;->writeByte(BLjava/lang/StringBuffer;)V

    invoke-virtual {v5, v10}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    add-int/lit8 v9, v9, 0x1

    goto :goto_3

    :cond_8
    if-ge v7, v8, :cond_9

    move v8, v3

    :goto_4
    rsub-int/lit8 v9, v7, 0x10

    if-ge v8, v9, :cond_9

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    add-int/lit8 v8, v8, 0x1

    goto :goto_4

    :cond_9
    const-string v6, "  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move v6, v3

    :goto_5
    if-ge v6, v7, :cond_c

    add-int v8, v6, p1

    aget-byte v8, v4, v8

    int-to-char v8, v8

    if-lt v8, v10, :cond_a

    const/16 v9, 0x7a

    if-le v8, v9, :cond_b

    :cond_a
    const/16 v8, 0x2e

    :cond_b
    invoke-virtual {v5, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    :cond_c
    add-int/2addr p1, v7

    iget-object v6, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    iget-object v5, p0, Ljxl/demo/BiffDump;->writer:Ljava/io/BufferedWriter;

    invoke-virtual {v5}, Ljava/io/BufferedWriter;->newLine()V

    goto :goto_2

    :cond_d
    return v2
.end method

.method private writeSixDigitValue(ILjava/lang/StringBuffer;)V
    .locals 2

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x6

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-le v0, v1, :cond_0

    const/16 v1, 0x30

    invoke-virtual {p2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p2, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    return-void
.end method
