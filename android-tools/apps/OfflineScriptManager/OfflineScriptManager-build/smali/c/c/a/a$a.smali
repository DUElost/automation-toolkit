.class public final enum Lc/c/a/a$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lc/c/a/a$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lc/c/a/a$a;

.field public static final enum d:Lc/c/a/a$a;

.field public static final enum e:Lc/c/a/a$a;

.field private static final synthetic f:[Lc/c/a/a$a;


# instance fields
.field private b:Ljava/lang/Boolean;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lc/c/a/a$a;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    const-string v2, "FLOW"

    const/4 v3, 0x0

    invoke-direct {v0, v2, v3, v1}, Lc/c/a/a$a;-><init>(Ljava/lang/String;ILjava/lang/Boolean;)V

    sput-object v0, Lc/c/a/a$a;->c:Lc/c/a/a$a;

    new-instance v1, Lc/c/a/a$a;

    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const-string v4, "BLOCK"

    const/4 v5, 0x1

    invoke-direct {v1, v4, v5, v2}, Lc/c/a/a$a;-><init>(Ljava/lang/String;ILjava/lang/Boolean;)V

    sput-object v1, Lc/c/a/a$a;->d:Lc/c/a/a$a;

    new-instance v2, Lc/c/a/a$a;

    const-string v4, "AUTO"

    const/4 v6, 0x2

    const/4 v7, 0x0

    invoke-direct {v2, v4, v6, v7}, Lc/c/a/a$a;-><init>(Ljava/lang/String;ILjava/lang/Boolean;)V

    sput-object v2, Lc/c/a/a$a;->e:Lc/c/a/a$a;

    const/4 v4, 0x3

    new-array v4, v4, [Lc/c/a/a$a;

    aput-object v0, v4, v3

    aput-object v1, v4, v5

    aput-object v2, v4, v6

    sput-object v4, Lc/c/a/a$a;->f:[Lc/c/a/a$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/Boolean;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Boolean;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lc/c/a/a$a;->b:Ljava/lang/Boolean;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lc/c/a/a$a;
    .locals 1

    const-class v0, Lc/c/a/a$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lc/c/a/a$a;

    return-object p0
.end method

.method public static final values()[Lc/c/a/a$a;
    .locals 1

    sget-object v0, Lc/c/a/a$a;->f:[Lc/c/a/a$a;

    invoke-virtual {v0}, [Lc/c/a/a$a;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc/c/a/a$a;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/Boolean;
    .locals 1

    iget-object v0, p0, Lc/c/a/a$a;->b:Ljava/lang/Boolean;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Flow style: \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/a$a;->b:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
