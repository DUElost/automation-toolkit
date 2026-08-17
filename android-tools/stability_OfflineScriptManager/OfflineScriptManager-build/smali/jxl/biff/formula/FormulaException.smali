.class public Ljxl/biff/formula/FormulaException;
.super Ljxl/JXLException;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ljxl/biff/formula/FormulaException$FormulaMessage;
    }
.end annotation


# static fields
.field public static final BIFF8_SUPPORTED:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final CELL_NAME_NOT_FOUND:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final INCORRECT_ARGUMENTS:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final LEXICAL_ERROR:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final SHEET_REF_NOT_FOUND:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final UNRECOGNIZED_FUNCTION:Ljxl/biff/formula/FormulaException$FormulaMessage;

.field static final UNRECOGNIZED_TOKEN:Ljxl/biff/formula/FormulaException$FormulaMessage;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Unrecognized token"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->UNRECOGNIZED_TOKEN:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Unrecognized function"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->UNRECOGNIZED_FUNCTION:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Only biff8 formulas are supported"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->BIFF8_SUPPORTED:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Lexical error:  "

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->LEXICAL_ERROR:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Incorrect arguments supplied to function"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->INCORRECT_ARGUMENTS:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Could not find sheet"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->SHEET_REF_NOT_FOUND:Ljxl/biff/formula/FormulaException$FormulaMessage;

    new-instance v0, Ljxl/biff/formula/FormulaException$FormulaMessage;

    const-string v1, "Could not find named cell"

    invoke-direct {v0, v1}, Ljxl/biff/formula/FormulaException$FormulaMessage;-><init>(Ljava/lang/String;)V

    sput-object v0, Ljxl/biff/formula/FormulaException;->CELL_NAME_NOT_FOUND:Ljxl/biff/formula/FormulaException$FormulaMessage;

    return-void
.end method

.method public constructor <init>(Ljxl/biff/formula/FormulaException$FormulaMessage;)V
    .locals 0

    invoke-static {p1}, Ljxl/biff/formula/FormulaException$FormulaMessage;->access$000(Ljxl/biff/formula/FormulaException$FormulaMessage;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljxl/JXLException;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/formula/FormulaException$FormulaMessage;I)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {p1}, Ljxl/biff/formula/FormulaException$FormulaMessage;->access$000(Ljxl/biff/formula/FormulaException$FormulaMessage;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljxl/JXLException;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljxl/biff/formula/FormulaException$FormulaMessage;Ljava/lang/String;)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {p1}, Ljxl/biff/formula/FormulaException$FormulaMessage;->access$000(Ljxl/biff/formula/FormulaException$FormulaMessage;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljxl/JXLException;-><init>(Ljava/lang/String;)V

    return-void
.end method
