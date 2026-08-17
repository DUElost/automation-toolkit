.class Ljxl/biff/formula/FormulaException$FormulaMessage;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ljxl/biff/formula/FormulaException;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FormulaMessage"
.end annotation


# instance fields
.field private message:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ljxl/biff/formula/FormulaException$FormulaMessage;->message:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Ljxl/biff/formula/FormulaException$FormulaMessage;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Ljxl/biff/formula/FormulaException$FormulaMessage;->message:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public getMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Ljxl/biff/formula/FormulaException$FormulaMessage;->message:Ljava/lang/String;

    return-object v0
.end method
