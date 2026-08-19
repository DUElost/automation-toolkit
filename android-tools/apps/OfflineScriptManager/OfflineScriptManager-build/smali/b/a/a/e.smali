.class public final enum Lb/a/a/e;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/a/a/e;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lb/a/a/e;

.field public static final enum c:Lb/a/a/e;

.field public static final enum d:Lb/a/a/e;

.field private static final e:Z

.field private static final synthetic f:[Lb/a/a/e;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lb/a/a/e;

    const-string v1, "START"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lb/a/a/e;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lb/a/a/e;->b:Lb/a/a/e;

    new-instance v1, Lb/a/a/e;

    const-string v3, "CENTER"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lb/a/a/e;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lb/a/a/e;->c:Lb/a/a/e;

    new-instance v3, Lb/a/a/e;

    const-string v5, "END"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lb/a/a/e;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lb/a/a/e;->d:Lb/a/a/e;

    const/4 v5, 0x3

    new-array v5, v5, [Lb/a/a/e;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lb/a/a/e;->f:[Lb/a/a/e;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x11

    if-lt v0, v1, :cond_0

    move v2, v4

    :cond_0
    sput-boolean v2, Lb/a/a/e;->e:Z

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lb/a/a/e;
    .locals 1

    const-class v0, Lb/a/a/e;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/a/a/e;

    return-object p0
.end method

.method public static values()[Lb/a/a/e;
    .locals 1

    sget-object v0, Lb/a/a/e;->f:[Lb/a/a/e;

    invoke-virtual {v0}, [Lb/a/a/e;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/a/a/e;

    return-object v0
.end method


# virtual methods
.method public a()I
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

    sget-object v0, Lb/a/a/e$a;->a:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x3

    const/4 v2, 0x1

    if-eq v0, v2, :cond_3

    const/4 v3, 0x2

    if-eq v0, v3, :cond_2

    if-ne v0, v1, :cond_1

    sget-boolean v0, Lb/a/a/e;->e:Z

    if-eqz v0, :cond_0

    const v0, 0x800005

    goto :goto_0

    :cond_0
    const/4 v0, 0x5

    :goto_0
    return v0

    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Invalid gravity constant"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    return v2

    :cond_3
    sget-boolean v0, Lb/a/a/e;->e:Z

    if-eqz v0, :cond_4

    const v1, 0x800003

    :cond_4
    return v1
.end method

.method public b()I
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0x11
    .end annotation

    sget-object v0, Lb/a/a/e$a;->a:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    const/4 v0, 0x5

    return v0

    :cond_0
    const/4 v0, 0x6

    return v0

    :cond_1
    const/4 v0, 0x4

    return v0
.end method
