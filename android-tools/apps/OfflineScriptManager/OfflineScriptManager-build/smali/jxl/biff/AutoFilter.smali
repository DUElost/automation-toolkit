.class public Ljxl/biff/AutoFilter;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private autoFilter:Ljxl/biff/AutoFilterRecord;

.field private autoFilterInfo:Ljxl/biff/AutoFilterInfoRecord;

.field private filterMode:Ljxl/biff/FilterModeRecord;


# direct methods
.method public constructor <init>(Ljxl/biff/FilterModeRecord;Ljxl/biff/AutoFilterInfoRecord;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/AutoFilter;->filterMode:Ljxl/biff/FilterModeRecord;

    iput-object p2, p0, Ljxl/biff/AutoFilter;->autoFilterInfo:Ljxl/biff/AutoFilterInfoRecord;

    return-void
.end method


# virtual methods
.method public add(Ljxl/biff/AutoFilterRecord;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/AutoFilter;->autoFilter:Ljxl/biff/AutoFilterRecord;

    return-void
.end method

.method public write(Ljxl/write/biff/File;)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/AutoFilter;->filterMode:Ljxl/biff/FilterModeRecord;

    if-eqz v0, :cond_0

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_0
    iget-object v0, p0, Ljxl/biff/AutoFilter;->autoFilterInfo:Ljxl/biff/AutoFilterInfoRecord;

    if-eqz v0, :cond_1

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_1
    iget-object v0, p0, Ljxl/biff/AutoFilter;->autoFilter:Ljxl/biff/AutoFilterRecord;

    if-eqz v0, :cond_2

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    :cond_2
    return-void
.end method
