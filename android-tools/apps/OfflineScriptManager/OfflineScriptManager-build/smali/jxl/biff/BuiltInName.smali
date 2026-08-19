.class public Ljxl/biff/BuiltInName;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final AUTO_ACTIVATE:Ljxl/biff/BuiltInName;

.field public static final AUTO_CLOSE:Ljxl/biff/BuiltInName;

.field public static final AUTO_DEACTIVATE:Ljxl/biff/BuiltInName;

.field public static final AUTO_OPEN:Ljxl/biff/BuiltInName;

.field public static final CONSOLIDATE_AREA:Ljxl/biff/BuiltInName;

.field public static final CRITERIA:Ljxl/biff/BuiltInName;

.field public static final DATABASE:Ljxl/biff/BuiltInName;

.field public static final DATA_FORM:Ljxl/biff/BuiltInName;

.field public static final EXTRACT:Ljxl/biff/BuiltInName;

.field public static final FILTER_DATABASE:Ljxl/biff/BuiltInName;

.field public static final PRINT_AREA:Ljxl/biff/BuiltInName;

.field public static final PRINT_TITLES:Ljxl/biff/BuiltInName;

.field public static final RECORDER:Ljxl/biff/BuiltInName;

.field public static final SHEET_TITLE:Ljxl/biff/BuiltInName;

.field private static builtInNames:[Ljxl/biff/BuiltInName;


# instance fields
.field private name:Ljava/lang/String;

.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x0

    new-array v1, v0, [Ljxl/biff/BuiltInName;

    sput-object v1, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    new-instance v1, Ljxl/biff/BuiltInName;

    const-string v2, "Consolidate_Area"

    invoke-direct {v1, v2, v0}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ljxl/biff/BuiltInName;->CONSOLIDATE_AREA:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Auto_Open"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->AUTO_OPEN:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->AUTO_CLOSE:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Extract"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->EXTRACT:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Database"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->DATABASE:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Criteria"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->CRITERIA:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Print_Area"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->PRINT_AREA:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Print_Titles"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->PRINT_TITLES:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Recorder"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->RECORDER:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Data_Form"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->DATA_FORM:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Auto_Activate"

    const/16 v2, 0xa

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->AUTO_ACTIVATE:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Auto_Deactivate"

    const/16 v2, 0xb

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->AUTO_DEACTIVATE:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "Sheet_Title"

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->SHEET_TITLE:Ljxl/biff/BuiltInName;

    new-instance v0, Ljxl/biff/BuiltInName;

    const-string v1, "_FilterDatabase"

    const/16 v2, 0xd

    invoke-direct {v0, v1, v2}, Ljxl/biff/BuiltInName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ljxl/biff/BuiltInName;->FILTER_DATABASE:Ljxl/biff/BuiltInName;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/BuiltInName;->name:Ljava/lang/String;

    iput p2, p0, Ljxl/biff/BuiltInName;->value:I

    sget-object p1, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    array-length p2, p1

    add-int/lit8 p2, p2, 0x1

    new-array p2, p2, [Ljxl/biff/BuiltInName;

    sput-object p2, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    array-length v0, p1

    const/4 v1, 0x0

    invoke-static {p1, v1, p2, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    sget-object p2, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    array-length p1, p1

    aput-object p0, p2, p1

    return-void
.end method

.method public static getBuiltInName(I)Ljxl/biff/BuiltInName;
    .locals 4

    sget-object v0, Ljxl/biff/BuiltInName;->FILTER_DATABASE:Ljxl/biff/BuiltInName;

    const/4 v1, 0x0

    :goto_0
    sget-object v2, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    array-length v3, v2

    if-ge v1, v3, :cond_1

    aget-object v2, v2, v1

    invoke-virtual {v2}, Ljxl/biff/BuiltInName;->getValue()I

    move-result v2

    if-ne v2, p0, :cond_0

    sget-object v0, Ljxl/biff/BuiltInName;->builtInNames:[Ljxl/biff/BuiltInName;

    aget-object v0, v0, v1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/BuiltInName;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()I
    .locals 1

    iget v0, p0, Ljxl/biff/BuiltInName;->value:I

    return v0
.end method
