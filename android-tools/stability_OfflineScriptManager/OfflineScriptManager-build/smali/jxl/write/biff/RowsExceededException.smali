.class public Ljxl/write/biff/RowsExceededException;
.super Ljxl/write/biff/JxlWriteException;
.source ""


# direct methods
.method public constructor <init>()V
    .locals 1

    sget-object v0, Ljxl/write/biff/JxlWriteException;->maxRowsExceeded:Ljxl/write/biff/JxlWriteException$WriteMessage;

    invoke-direct {p0, v0}, Ljxl/write/biff/JxlWriteException;-><init>(Ljxl/write/biff/JxlWriteException$WriteMessage;)V

    return-void
.end method
