.class public Ljxl/write/biff/WritableFormattingRecords;
.super Ljxl/biff/FormattingRecords;
.source ""


# static fields
.field public static normalStyle:Ljxl/write/WritableCellFormat;


# direct methods
.method public constructor <init>(Ljxl/biff/Fonts;Ljxl/write/biff/Styles;)V
    .locals 5

    invoke-direct {p0, p1}, Ljxl/biff/FormattingRecords;-><init>(Ljxl/biff/Fonts;)V

    :try_start_0
    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v0

    sget-object v1, Ljxl/write/NumberFormats;->DEFAULT:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, v0, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v2

    invoke-direct {p1, v2, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    const v2, 0xf400

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v3, v4}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v3

    const/4 v4, 0x3

    invoke-virtual {v3, v4}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object v3

    invoke-direct {p1, v3, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, v2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    invoke-virtual {p2}, Ljxl/write/biff/Styles;->getNormalStyle()Ljxl/write/WritableCellFormat;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object p2

    invoke-virtual {p2, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object p2

    sget-object v1, Ljxl/write/NumberFormats;->FORMAT7:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, p2, v1}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    const p2, 0xf800

    invoke-virtual {p1, p2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v1

    sget-object v2, Ljxl/write/NumberFormats;->FORMAT5:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, v1, v2}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, p2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v1

    sget-object v2, Ljxl/write/NumberFormats;->FORMAT8:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, v1, v2}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, p2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v1

    sget-object v2, Ljxl/write/NumberFormats;->FORMAT6:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, v1, v2}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, p2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V

    new-instance p1, Ljxl/write/biff/StyleXFRecord;

    invoke-virtual {p0}, Ljxl/biff/FormattingRecords;->getFonts()Ljxl/biff/Fonts;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljxl/biff/Fonts;->getFont(I)Ljxl/biff/FontRecord;

    move-result-object v1

    sget-object v2, Ljxl/write/NumberFormats;->PERCENT_INTEGER:Ljxl/biff/DisplayFormat;

    invoke-direct {p1, v1, v2}, Ljxl/write/biff/StyleXFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    invoke-virtual {p1, v0}, Ljxl/write/biff/StyleXFRecord;->setLocked(Z)V

    invoke-virtual {p1, p2}, Ljxl/write/biff/StyleXFRecord;->setCellOptions(I)V

    invoke-virtual {p0, p1}, Ljxl/biff/FormattingRecords;->addStyle(Ljxl/biff/XFRecord;)V
    :try_end_0
    .catch Ljxl/biff/NumFormatRecordsException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    const/4 p2, 0x0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Ljxl/common/Assert;->verify(ZLjava/lang/String;)V

    :goto_0
    return-void
.end method
