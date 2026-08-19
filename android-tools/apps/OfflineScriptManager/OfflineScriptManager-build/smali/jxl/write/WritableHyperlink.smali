.class public Ljxl/write/WritableHyperlink;
.super Ljxl/write/biff/HyperlinkRecord;
.source ""

# interfaces
.implements Ljxl/Hyperlink;


# direct methods
.method public constructor <init>(IIIILjava/io/File;)V
    .locals 7

    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v6}, Ljxl/write/biff/HyperlinkRecord;-><init>(IIIILjava/io/File;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IIIILjava/io/File;Ljava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Ljxl/write/biff/HyperlinkRecord;-><init>(IIIILjava/io/File;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IIIILjava/lang/String;Ljxl/write/WritableSheet;IIII)V
    .locals 0

    invoke-direct/range {p0 .. p10}, Ljxl/write/biff/HyperlinkRecord;-><init>(IIIILjava/lang/String;Ljxl/write/WritableSheet;IIII)V

    return-void
.end method

.method public constructor <init>(IIIILjava/net/URL;)V
    .locals 7

    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v6}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/net/URL;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IIIILjava/net/URL;Ljava/lang/String;)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Ljxl/write/biff/HyperlinkRecord;-><init>(IIIILjava/net/URL;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IILjava/io/File;)V
    .locals 7

    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v6}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/io/File;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IILjava/io/File;Ljava/lang/String;)V
    .locals 7

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/io/File;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(IILjava/lang/String;Ljxl/write/WritableSheet;II)V
    .locals 11

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move-object v5, p3

    move-object v6, p4

    move/from16 v7, p5

    move/from16 v8, p6

    move/from16 v9, p5

    move/from16 v10, p6

    invoke-direct/range {v0 .. v10}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/lang/String;Ljxl/write/WritableSheet;IIII)V

    return-void
.end method

.method public constructor <init>(IILjava/net/URL;)V
    .locals 6

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Ljxl/write/WritableHyperlink;-><init>(IIIILjava/net/URL;)V

    return-void
.end method

.method public constructor <init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljxl/write/biff/HyperlinkRecord;-><init>(Ljxl/Hyperlink;Ljxl/write/WritableSheet;)V

    return-void
.end method


# virtual methods
.method public setDescription(Ljava/lang/String;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/write/biff/HyperlinkRecord;->setContents(Ljava/lang/String;)V

    return-void
.end method

.method public setFile(Ljava/io/File;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/write/biff/HyperlinkRecord;->setFile(Ljava/io/File;)V

    return-void
.end method

.method public setLocation(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V
    .locals 0

    invoke-super/range {p0 .. p6}, Ljxl/write/biff/HyperlinkRecord;->setLocation(Ljava/lang/String;Ljxl/write/WritableSheet;IIII)V

    return-void
.end method

.method public setURL(Ljava/net/URL;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/write/biff/HyperlinkRecord;->setURL(Ljava/net/URL;)V

    return-void
.end method
