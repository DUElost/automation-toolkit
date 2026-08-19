.class public Ljxl/biff/ConditionalFormat;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private conditions:Ljava/util/ArrayList;

.field private range:Ljxl/biff/ConditionalFormatRangeRecord;


# direct methods
.method public constructor <init>(Ljxl/biff/ConditionalFormatRangeRecord;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Ljxl/biff/ConditionalFormat;->conditions:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public addCondition(Ljxl/biff/ConditionalFormatRecord;)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->conditions:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public insertColumn(I)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord;->insertColumn(I)V

    return-void
.end method

.method public insertRow(I)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord;->insertRow(I)V

    return-void
.end method

.method public removeColumn(I)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord;->removeColumn(I)V

    return-void
.end method

.method public removeRow(I)V
    .locals 1

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-virtual {v0, p1}, Ljxl/biff/ConditionalFormatRangeRecord;->removeRow(I)V

    return-void
.end method

.method public write(Ljxl/write/biff/File;)V
    .locals 2

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->range:Ljxl/biff/ConditionalFormatRangeRecord;

    invoke-virtual {p1, v0}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    iget-object v0, p0, Ljxl/biff/ConditionalFormat;->conditions:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljxl/biff/ConditionalFormatRecord;

    invoke-virtual {p1, v1}, Ljxl/write/biff/File;->write(Ljxl/biff/ByteData;)V

    goto :goto_0

    :cond_0
    return-void
.end method
