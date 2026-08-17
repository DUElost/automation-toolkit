.class public Ljxl/biff/BaseCellFeatures;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/BaseCellFeatures$ValidationCondition;
    }
.end annotation


# static fields
.field public static final BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final GREATER_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final LESS_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final LESS_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final NOT_BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field public static final NOT_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

.field static synthetic class$jxl$biff$BaseCellFeatures:Ljava/lang/Class; = null

.field private static final defaultCommentHeight:D = 4.0

.field private static final defaultCommentWidth:D = 3.0

.field public static logger:Ljxl/common/Logger;


# instance fields
.field private comboBox:Ljxl/biff/drawing/ComboBox;

.field private comment:Ljava/lang/String;

.field private commentDrawing:Ljxl/biff/drawing/Comment;

.field private commentHeight:D

.field private commentWidth:D

.field private dataValidation:Z

.field private dropDown:Z

.field private dvParser:Ljxl/biff/DVParser;

.field private validationSettings:Ljxl/biff/DataValiditySettingsRecord;

.field private writableCell:Ljxl/write/biff/CellValue;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget-object v0, Ljxl/biff/BaseCellFeatures;->class$jxl$biff$BaseCellFeatures:Ljava/lang/Class;

    if-nez v0, :cond_0

    const-string v0, "jxl.biff.BaseCellFeatures"

    invoke-static {v0}, Ljxl/biff/BaseCellFeatures;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Ljxl/biff/BaseCellFeatures;->class$jxl$biff$BaseCellFeatures:Ljava/lang/Class;

    :cond_0
    invoke-static {v0}, Ljxl/common/Logger;->getLogger(Ljava/lang/Class;)Ljxl/common/Logger;

    move-result-object v0

    sput-object v0, Ljxl/biff/BaseCellFeatures;->logger:Ljxl/common/Logger;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->BETWEEN:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->NOT_BETWEEN:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->NOT_BETWEEN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->EQUAL:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->NOT_EQUAL:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->NOT_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->GREATER_THAN:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->GREATER_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->LESS_THAN:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->LESS_THAN:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->GREATER_EQUAL:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->GREATER_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    new-instance v0, Ljxl/biff/BaseCellFeatures$ValidationCondition;

    sget-object v1, Ljxl/biff/DVParser;->LESS_EQUAL:Ljxl/biff/DVParser$Condition;

    invoke-direct {v0, v1}, Ljxl/biff/BaseCellFeatures$ValidationCondition;-><init>(Ljxl/biff/DVParser$Condition;)V

    sput-object v0, Ljxl/biff/BaseCellFeatures;->LESS_EQUAL:Ljxl/biff/BaseCellFeatures$ValidationCondition;

    return-void
.end method

.method protected constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/BaseCellFeatures;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-object v0, p1, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    iget-wide v0, p1, Ljxl/biff/BaseCellFeatures;->commentWidth:D

    iput-wide v0, p0, Ljxl/biff/BaseCellFeatures;->commentWidth:D

    iget-wide v0, p1, Ljxl/biff/BaseCellFeatures;->commentHeight:D

    iput-wide v0, p0, Ljxl/biff/BaseCellFeatures;->commentHeight:D

    iget-boolean v0, p1, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iput-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iget-boolean v0, p1, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    iput-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    iget-object v0, p1, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    iget-object v0, p1, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    if-eqz v0, :cond_0

    new-instance v0, Ljxl/biff/DVParser;

    iget-object p1, p1, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    invoke-direct {v0, p1}, Ljxl/biff/DVParser;-><init>(Ljxl/biff/DVParser;)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    :cond_0
    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1

    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/NoClassDefFoundError;

    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private clearValidationSettings()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 v1, 0x0

    iput-boolean v1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->comboBox:Ljxl/biff/drawing/ComboBox;

    iput-boolean v1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method


# virtual methods
.method protected getComment()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    return-object v0
.end method

.method public final getCommentDrawing()Ljxl/biff/drawing/Comment;
    .locals 1

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    return-object v0
.end method

.method public getCommentHeight()D
    .locals 2

    iget-wide v0, p0, Ljxl/biff/BaseCellFeatures;->commentHeight:D

    return-wide v0
.end method

.method public getCommentWidth()D
    .locals 2

    iget-wide v0, p0, Ljxl/biff/BaseCellFeatures;->commentWidth:D

    return-wide v0
.end method

.method public getDVParser()Ljxl/biff/DVParser;
    .locals 2

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    if-eqz v0, :cond_1

    new-instance v0, Ljxl/biff/DVParser;

    iget-object v1, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    invoke-virtual {v1}, Ljxl/biff/DataValiditySettingsRecord;->getDVParser()Ljxl/biff/DVParser;

    move-result-object v1

    invoke-direct {v0, v1}, Ljxl/biff/DVParser;-><init>(Ljxl/biff/DVParser;)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    return-object v0

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDataValidationList()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    invoke-virtual {v0}, Ljxl/biff/DataValiditySettingsRecord;->getValidationFormula()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public hasDataValidation()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return v0
.end method

.method public hasDropDown()Z
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    return v0
.end method

.method public removeComment()V
    .locals 3

    const/4 v0, 0x0

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    iget-object v1, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    if-eqz v1, :cond_0

    iget-object v2, p0, Ljxl/biff/BaseCellFeatures;->writableCell:Ljxl/write/biff/CellValue;

    invoke-virtual {v2, v1}, Ljxl/write/biff/CellValue;->removeComment(Ljxl/biff/drawing/Comment;)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    :cond_0
    return-void
.end method

.method public removeDataValidation()V
    .locals 1

    iget-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->writableCell:Ljxl/write/biff/CellValue;

    invoke-virtual {v0}, Ljxl/write/biff/CellValue;->removeDataValidation()V

    :cond_0
    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    return-void
.end method

.method public setComboBox(Ljxl/biff/drawing/ComboBox;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->comboBox:Ljxl/biff/drawing/ComboBox;

    return-void
.end method

.method public setComment(Ljava/lang/String;)V
    .locals 6

    const-wide/high16 v2, 0x4008000000000000L    # 3.0

    const-wide/high16 v4, 0x4010000000000000L    # 4.0

    move-object v0, p0

    move-object v1, p1

    invoke-virtual/range {v0 .. v5}, Ljxl/biff/BaseCellFeatures;->setComment(Ljava/lang/String;DD)V

    return-void
.end method

.method public setComment(Ljava/lang/String;DD)V
    .locals 1

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    iput-wide p2, p0, Ljxl/biff/BaseCellFeatures;->commentWidth:D

    iput-wide p4, p0, Ljxl/biff/BaseCellFeatures;->commentHeight:D

    iget-object v0, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Ljxl/biff/drawing/Comment;->setCommentText(Ljava/lang/String;)V

    iget-object p1, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    invoke-virtual {p1, p2, p3}, Ljxl/biff/drawing/Comment;->setWidth(D)V

    iget-object p1, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    invoke-virtual {p1, p4, p5}, Ljxl/biff/drawing/Comment;->setWidth(D)V

    :cond_0
    return-void
.end method

.method public final setCommentDrawing(Ljxl/biff/drawing/Comment;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->commentDrawing:Ljxl/biff/drawing/Comment;

    return-void
.end method

.method public setDataValidationList(Ljava/util/Collection;)V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    new-instance v0, Ljxl/biff/DVParser;

    invoke-direct {v0, p1}, Ljxl/biff/DVParser;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public setDataValidationRange(IIII)V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    new-instance v0, Ljxl/biff/DVParser;

    invoke-direct {v0, p1, p2, p3, p4}, Ljxl/biff/DVParser;-><init>(IIII)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public setDataValidationRange(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    new-instance v0, Ljxl/biff/DVParser;

    invoke-direct {v0, p1}, Ljxl/biff/DVParser;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public setNumberValidation(DDLjxl/biff/BaseCellFeatures$ValidationCondition;)V
    .locals 7

    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    new-instance v6, Ljxl/biff/DVParser;

    invoke-virtual {p5}, Ljxl/biff/BaseCellFeatures$ValidationCondition;->getCondition()Ljxl/biff/DVParser$Condition;

    move-result-object v5

    move-object v0, v6

    move-wide v1, p1

    move-wide v3, p3

    invoke-direct/range {v0 .. v5}, Ljxl/biff/DVParser;-><init>(DDLjxl/biff/DVParser$Condition;)V

    iput-object v6, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public setNumberValidation(DLjxl/biff/BaseCellFeatures$ValidationCondition;)V
    .locals 7

    invoke-direct {p0}, Ljxl/biff/BaseCellFeatures;->clearValidationSettings()V

    new-instance v6, Ljxl/biff/DVParser;

    invoke-virtual {p3}, Ljxl/biff/BaseCellFeatures$ValidationCondition;->getCondition()Ljxl/biff/DVParser$Condition;

    move-result-object v5

    const-wide/high16 v3, 0x7ff8000000000000L    # Double.NaN

    move-object v0, v6

    move-wide v1, p1

    invoke-direct/range {v0 .. v5}, Ljxl/biff/DVParser;-><init>(DDLjxl/biff/DVParser$Condition;)V

    iput-object v6, p0, Ljxl/biff/BaseCellFeatures;->dvParser:Ljxl/biff/DVParser;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dropDown:Z

    const/4 p1, 0x1

    iput-boolean p1, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public setReadComment(Ljava/lang/String;DD)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->comment:Ljava/lang/String;

    iput-wide p2, p0, Ljxl/biff/BaseCellFeatures;->commentWidth:D

    iput-wide p4, p0, Ljxl/biff/BaseCellFeatures;->commentHeight:D

    return-void
.end method

.method public setValidationSettings(Ljxl/biff/DataValiditySettingsRecord;)V
    .locals 2

    const/4 v0, 0x1

    if-eqz p1, :cond_0

    move v1, v0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v1}, Ljxl/common/Assert;->verify(Z)V

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->validationSettings:Ljxl/biff/DataValiditySettingsRecord;

    iput-boolean v0, p0, Ljxl/biff/BaseCellFeatures;->dataValidation:Z

    return-void
.end method

.method public final setWritableCell(Ljxl/write/biff/CellValue;)V
    .locals 0

    iput-object p1, p0, Ljxl/biff/BaseCellFeatures;->writableCell:Ljxl/write/biff/CellValue;

    return-void
.end method
