.class public Ljxl/write/WritableCellFeatures;
.super Ljxl/CellFeatures;
.source ""


# static fields
.field public static final BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final GREATER_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final LESS_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final LESS_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final NOT_BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final NOT_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Ljxl/biff/BaseCellFeatures;->BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->NOT_BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->NOT_BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->NOT_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->NOT_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->LESS_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->LESS_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->GREATER_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->GREATER_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v0, Ljxl/biff/BaseCellFeatures;->LESS_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sput-object v0, Ljxl/write/WritableCellFeatures;->LESS_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljxl/CellFeatures;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljxl/CellFeatures;)V
    .locals 0

    invoke-direct {p0, p1}, Ljxl/CellFeatures;-><init>(Ljxl/CellFeatures;)V

    return-void
.end method


# virtual methods
.method public removeComment()V
    .locals 0

    invoke-super {p0}, Ljxl/biff/BaseCellFeatures;->removeComment()V

    return-void
.end method

.method public removeDataValidation()V
    .locals 0

    invoke-super {p0}, Ljxl/biff/BaseCellFeatures;->removeDataValidation()V

    return-void
.end method

.method public setComment(Ljava/lang/String;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/biff/BaseCellFeatures;->setComment(Ljava/lang/String;)V

    return-void
.end method

.method public setComment(Ljava/lang/String;DD)V
    .locals 0

    invoke-super/range {p0 .. p5}, Ljxl/biff/BaseCellFeatures;->setComment(Ljava/lang/String;DD)V

    return-void
.end method

.method public setDataValidationList(Ljava/util/Collection;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/biff/BaseCellFeatures;->setDataValidationList(Ljava/util/Collection;)V

    return-void
.end method

.method public setDataValidationRange(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Ljxl/biff/BaseCellFeatures;->setDataValidationRange(IIII)V

    return-void
.end method

.method public setDataValidationRange(Ljava/lang/String;)V
    .locals 0

    invoke-super {p0, p1}, Ljxl/biff/BaseCellFeatures;->setDataValidationRange(Ljava/lang/String;)V

    return-void
.end method

.method public setNumberValidation(DDLjxl/biff/BaseCellFeatures$ValidationCondition;)V
    .locals 0

    invoke-super/range {p0 .. p5}, Ljxl/biff/BaseCellFeatures;->setNumberValidation(DDLjxl/biff/BaseCellFeatures$ValidationCondition;)V

    return-void
.end method

.method public setNumberValidation(DLjxl/biff/BaseCellFeatures$ValidationCondition;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Ljxl/biff/BaseCellFeatures;->setNumberValidation(DLjxl/biff/BaseCellFeatures$ValidationCondition;)V

    return-void
.end method
