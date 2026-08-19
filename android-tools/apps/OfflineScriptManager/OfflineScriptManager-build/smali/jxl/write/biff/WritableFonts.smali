.class public Ljxl/write/biff/WritableFonts;
.super Ljxl/biff/Fonts;
.source ""


# direct methods
.method public constructor <init>(Ljxl/write/biff/WritableWorkbookImpl;)V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/Fonts;-><init>()V

    invoke-virtual {p1}, Ljxl/write/biff/WritableWorkbookImpl;->getStyles()Ljxl/write/biff/Styles;

    move-result-object p1

    invoke-virtual {p1}, Ljxl/write/biff/Styles;->getArial10Pt()Ljxl/write/WritableFont;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljxl/biff/Fonts;->addFont(Ljxl/biff/FontRecord;)V

    new-instance p1, Ljxl/write/WritableFont;

    sget-object v0, Ljxl/write/WritableFont;->ARIAL:Ljxl/write/WritableFont$FontName;

    invoke-direct {p1, v0}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    invoke-virtual {p0, p1}, Ljxl/biff/Fonts;->addFont(Ljxl/biff/FontRecord;)V

    new-instance p1, Ljxl/write/WritableFont;

    invoke-direct {p1, v0}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    invoke-virtual {p0, p1}, Ljxl/biff/Fonts;->addFont(Ljxl/biff/FontRecord;)V

    new-instance p1, Ljxl/write/WritableFont;

    invoke-direct {p1, v0}, Ljxl/write/WritableFont;-><init>(Ljxl/write/WritableFont$FontName;)V

    invoke-virtual {p0, p1}, Ljxl/biff/Fonts;->addFont(Ljxl/biff/FontRecord;)V

    return-void
.end method
