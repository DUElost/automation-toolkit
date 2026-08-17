.class public Ljxl/write/biff/StyleXFRecord;
.super Ljxl/biff/XFRecord;
.source ""


# direct methods
.method public constructor <init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljxl/biff/XFRecord;-><init>(Ljxl/biff/FontRecord;Ljxl/biff/DisplayFormat;)V

    sget-object p1, Ljxl/biff/XFRecord;->style:Ljxl/biff/XFRecord$XFType;

    const p2, 0xfff0

    invoke-virtual {p0, p1, p2}, Ljxl/biff/XFRecord;->setXFDetails(Ljxl/biff/XFRecord$XFType;I)V

    return-void
.end method


# virtual methods
.method public final setCellOptions(I)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/biff/XFRecord;->setXFCellOptions(I)V

    return-void
.end method

.method public setLocked(Z)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/biff/XFRecord;->setXFLocked(Z)V

    return-void
.end method
