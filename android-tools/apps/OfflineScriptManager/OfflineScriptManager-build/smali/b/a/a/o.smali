.class public final enum Lb/a/a/o;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/a/a/o;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lb/a/a/o;

.field public static final enum c:Lb/a/a/o;

.field public static final enum d:Lb/a/a/o;

.field private static final synthetic e:[Lb/a/a/o;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lb/a/a/o;

    const-string v1, "ALWAYS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lb/a/a/o;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lb/a/a/o;->b:Lb/a/a/o;

    new-instance v1, Lb/a/a/o;

    const-string v3, "ADAPTIVE"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lb/a/a/o;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lb/a/a/o;->c:Lb/a/a/o;

    new-instance v3, Lb/a/a/o;

    const-string v5, "NEVER"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lb/a/a/o;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lb/a/a/o;->d:Lb/a/a/o;

    const/4 v5, 0x3

    new-array v5, v5, [Lb/a/a/o;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lb/a/a/o;->e:[Lb/a/a/o;

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

.method public static valueOf(Ljava/lang/String;)Lb/a/a/o;
    .locals 1

    const-class v0, Lb/a/a/o;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/a/a/o;

    return-object p0
.end method

.method public static values()[Lb/a/a/o;
    .locals 1

    sget-object v0, Lb/a/a/o;->e:[Lb/a/a/o;

    invoke-virtual {v0}, [Lb/a/a/o;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/a/a/o;

    return-object v0
.end method
