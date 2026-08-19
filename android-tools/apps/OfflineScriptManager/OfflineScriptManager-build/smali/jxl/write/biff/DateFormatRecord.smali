.class public Ljxl/write/biff/DateFormatRecord;
.super Ljxl/biff/FormatRecord;
.source ""


# direct methods
.method protected constructor <init>(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljxl/biff/FormatRecord;-><init>()V

    const-string v0, "a"

    const-string v1, "AM/PM"

    invoke-virtual {p0, p1, v0, v1}, Ljxl/biff/FormatRecord;->replace(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "S"

    const-string v1, "0"

    invoke-virtual {p0, p1, v0, v1}, Ljxl/biff/FormatRecord;->replace(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljxl/biff/FormatRecord;->setFormatString(Ljava/lang/String;)V

    return-void
.end method
