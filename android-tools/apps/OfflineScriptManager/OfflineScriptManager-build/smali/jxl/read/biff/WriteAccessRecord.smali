.class Ljxl/read/biff/WriteAccessRecord;
.super Ljxl/biff/RecordData;
.source ""


# instance fields
.field private wauser:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljxl/read/biff/Record;ZLjxl/WorkbookSettings;)V
    .locals 1

    sget-object v0, Ljxl/biff/Type;->WRITEACCESS:Ljxl/biff/Type;

    invoke-direct {p0, v0}, Ljxl/biff/RecordData;-><init>(Ljxl/biff/Type;)V

    invoke-virtual {p1}, Ljxl/read/biff/Record;->getData()[B

    move-result-object p1

    if-eqz p2, :cond_0

    const/16 p2, 0x38

    const/4 p3, 0x0

    invoke-static {p1, p2, p3}, Ljxl/biff/StringHelper;->getUnicodeString([BII)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_0
    const/4 p2, 0x1

    aget-byte v0, p1, p2

    invoke-static {p1, v0, p2, p3}, Ljxl/biff/StringHelper;->getString([BIILjxl/WorkbookSettings;)Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Ljxl/read/biff/WriteAccessRecord;->wauser:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getWriteAccess()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/read/biff/WriteAccessRecord;->wauser:Ljava/lang/String;

    return-object v0
.end method
