.class public final enum Lc/c/a/k/e;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lc/c/a/k/e;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lc/c/a/k/e;

.field public static final enum c:Lc/c/a/k/e;

.field public static final enum d:Lc/c/a/k/e;

.field public static final enum e:Lc/c/a/k/e;

.field private static final synthetic f:[Lc/c/a/k/e;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Lc/c/a/k/e;

    const-string v1, "scalar"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lc/c/a/k/e;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    new-instance v1, Lc/c/a/k/e;

    const-string v3, "sequence"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lc/c/a/k/e;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lc/c/a/k/e;->c:Lc/c/a/k/e;

    new-instance v3, Lc/c/a/k/e;

    const-string v5, "mapping"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lc/c/a/k/e;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lc/c/a/k/e;->d:Lc/c/a/k/e;

    new-instance v5, Lc/c/a/k/e;

    const-string v7, "anchor"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Lc/c/a/k/e;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lc/c/a/k/e;->e:Lc/c/a/k/e;

    const/4 v7, 0x4

    new-array v7, v7, [Lc/c/a/k/e;

    aput-object v0, v7, v2

    aput-object v1, v7, v4

    aput-object v3, v7, v6

    aput-object v5, v7, v8

    sput-object v7, Lc/c/a/k/e;->f:[Lc/c/a/k/e;

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

.method public static valueOf(Ljava/lang/String;)Lc/c/a/k/e;
    .locals 1

    const-class v0, Lc/c/a/k/e;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lc/c/a/k/e;

    return-object p0
.end method

.method public static final values()[Lc/c/a/k/e;
    .locals 1

    sget-object v0, Lc/c/a/k/e;->f:[Lc/c/a/k/e;

    invoke-virtual {v0}, [Lc/c/a/k/e;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc/c/a/k/e;

    return-object v0
.end method
