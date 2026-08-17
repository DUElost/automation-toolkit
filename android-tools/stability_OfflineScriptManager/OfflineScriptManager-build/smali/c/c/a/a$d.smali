.class public final enum Lc/c/a/a$d;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "d"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lc/c/a/a$d;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lc/c/a/a$d;

.field public static final enum d:Lc/c/a/a$d;

.field private static final synthetic e:[Lc/c/a/a$d;


# instance fields
.field private b:[Ljava/lang/Integer;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lc/c/a/a$d;

    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/Integer;

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v2, v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v2, v3

    const-string v6, "V1_0"

    invoke-direct {v0, v6, v5, v2}, Lc/c/a/a$d;-><init>(Ljava/lang/String;I[Ljava/lang/Integer;)V

    sput-object v0, Lc/c/a/a$d;->c:Lc/c/a/a$d;

    new-instance v2, Lc/c/a/a$d;

    new-array v6, v1, [Ljava/lang/Integer;

    aput-object v4, v6, v5

    aput-object v4, v6, v3

    const-string v4, "V1_1"

    invoke-direct {v2, v4, v3, v6}, Lc/c/a/a$d;-><init>(Ljava/lang/String;I[Ljava/lang/Integer;)V

    sput-object v2, Lc/c/a/a$d;->d:Lc/c/a/a$d;

    new-array v1, v1, [Lc/c/a/a$d;

    aput-object v0, v1, v5

    aput-object v2, v1, v3

    sput-object v1, Lc/c/a/a$d;->e:[Lc/c/a/a$d;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I[Ljava/lang/Integer;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Integer;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lc/c/a/a$d;->b:[Ljava/lang/Integer;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lc/c/a/a$d;
    .locals 1

    const-class v0, Lc/c/a/a$d;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lc/c/a/a$d;

    return-object p0
.end method

.method public static final values()[Lc/c/a/a$d;
    .locals 1

    sget-object v0, Lc/c/a/a$d;->e:[Lc/c/a/a$d;

    invoke-virtual {v0}, [Lc/c/a/a$d;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc/c/a/a$d;

    return-object v0
.end method


# virtual methods
.method public a()[Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lc/c/a/a$d;->b:[Ljava/lang/Integer;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Version: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/a$d;->b:[Ljava/lang/Integer;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/a$d;->b:[Ljava/lang/Integer;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
