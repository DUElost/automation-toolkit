.class Ljxl/write/biff/ReadBooleanFormulaRecord;
.super Ljxl/write/biff/ReadFormulaRecord;
.source ""

# interfaces
.implements Ljxl/BooleanFormulaCell;


# direct methods
.method public constructor <init>(Ljxl/biff/FormulaData;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/write/biff/ReadFormulaRecord;-><init>(Ljxl/biff/FormulaData;)V

    return-void
.end method


# virtual methods
.method public getValue()Z
    .locals 1

    invoke-virtual {p0}, Ljxl/write/biff/ReadFormulaRecord;->getReadFormula()Ljxl/biff/FormulaData;

    move-result-object v0

    check-cast v0, Ljxl/BooleanFormulaCell;

    invoke-interface {v0}, Ljxl/BooleanCell;->getValue()Z

    move-result v0

    return v0
.end method
