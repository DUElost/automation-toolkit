.class public final enum Lb/a/a/b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/a/a/b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lb/a/a/b;

.field public static final enum c:Lb/a/a/b;

.field public static final enum d:Lb/a/a/b;

.field private static final synthetic e:[Lb/a/a/b;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lb/a/a/b;

    const-string v1, "POSITIVE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lb/a/a/b;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lb/a/a/b;->b:Lb/a/a/b;

    new-instance v1, Lb/a/a/b;

    const-string v3, "NEUTRAL"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lb/a/a/b;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lb/a/a/b;->c:Lb/a/a/b;

    new-instance v3, Lb/a/a/b;

    const-string v5, "NEGATIVE"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lb/a/a/b;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lb/a/a/b;->d:Lb/a/a/b;

    const/4 v5, 0x3

    new-array v5, v5, [Lb/a/a/b;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lb/a/a/b;->e:[Lb/a/a/b;

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

.method public static valueOf(Ljava/lang/String;)Lb/a/a/b;
    .locals 1

    const-class v0, Lb/a/a/b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/a/a/b;

    return-object p0
.end method

.method public static values()[Lb/a/a/b;
    .locals 1

    sget-object v0, Lb/a/a/b;->e:[Lb/a/a/b;

    invoke-virtual {v0}, [Lb/a/a/b;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/a/a/b;

    return-object v0
.end method
