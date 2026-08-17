.class Ljxl/write/biff/WriteAccessRecord;
.super Ljxl/biff/WritableRecordData;
.source ""


# static fields
.field private static final authorString:Ljava/lang/String; = "Java Excel API"


# instance fields
.field private data:[B

.field private userName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Ljxl/biff/Type;->WRITEACCESS:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/WritableRecordData;-><init>(Ljxl/biff/Type;)V

    const/16 v0, 0x70

    new-array v0, v0, [B

    iput-object v0, p0, Ljxl/write/biff/WriteAccessRecord;->data:[B

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/lang/StringBuffer;

    invoke-direct {p1}, Ljava/lang/StringBuffer;-><init>()V

    const-string v0, "Java Excel API v"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-static {}, Ljxl/Workbook;->getVersion()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    iget-object v0, p0, Ljxl/write/biff/WriteAccessRecord;->data:[B

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Ljxl/biff/StringHelper;->getBytes(Ljava/lang/String;[BI)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    :goto_1
    iget-object v0, p0, Ljxl/write/biff/WriteAccessRecord;->data:[B

    array-length v1, v0

    if-ge p1, v1, :cond_1

    const/16 v1, 0x20

    aput-byte v1, v0, p1

    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/write/biff/WriteAccessRecord;->data:[B

    return-object v0
.end method
