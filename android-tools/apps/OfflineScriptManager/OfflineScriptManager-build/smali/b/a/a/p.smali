.class public final enum Lb/a/a/p;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/a/a/p;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lb/a/a/p;

.field public static final enum c:Lb/a/a/p;

.field private static final synthetic d:[Lb/a/a/p;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lb/a/a/p;

    const-string v1, "LIGHT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lb/a/a/p;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lb/a/a/p;->b:Lb/a/a/p;

    new-instance v1, Lb/a/a/p;

    const-string v3, "DARK"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lb/a/a/p;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lb/a/a/p;->c:Lb/a/a/p;

    const/4 v3, 0x2

    new-array v3, v3, [Lb/a/a/p;

    aput-object v0, v3, v2

    aput-object v1, v3, v4

    sput-object v3, Lb/a/a/p;->d:[Lb/a/a/p;

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

.method public static valueOf(Ljava/lang/String;)Lb/a/a/p;
    .locals 1

    const-class v0, Lb/a/a/p;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/a/a/p;

    return-object p0
.end method

.method public static values()[Lb/a/a/p;
    .locals 1

    sget-object v0, Lb/a/a/p;->d:[Lb/a/a/p;

    invoke-virtual {v0}, [Lb/a/a/p;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/a/a/p;

    return-object v0
.end method
