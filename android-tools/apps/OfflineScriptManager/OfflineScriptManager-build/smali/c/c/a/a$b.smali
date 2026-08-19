.class public final enum Lc/c/a/a$b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lc/c/a/a$b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lc/c/a/a$b;

.field public static final enum d:Lc/c/a/a$b;

.field public static final enum e:Lc/c/a/a$b;

.field private static final synthetic f:[Lc/c/a/a$b;


# instance fields
.field private b:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lc/c/a/a$b;

    const-string v1, "WIN"

    const/4 v2, 0x0

    const-string v3, "\r\n"

    invoke-direct {v0, v1, v2, v3}, Lc/c/a/a$b;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lc/c/a/a$b;->c:Lc/c/a/a$b;

    new-instance v1, Lc/c/a/a$b;

    const-string v3, "MAC"

    const/4 v4, 0x1

    const-string v5, "\r"

    invoke-direct {v1, v3, v4, v5}, Lc/c/a/a$b;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v1, Lc/c/a/a$b;->d:Lc/c/a/a$b;

    new-instance v3, Lc/c/a/a$b;

    const-string v5, "UNIX"

    const/4 v6, 0x2

    const-string v7, "\n"

    invoke-direct {v3, v5, v6, v7}, Lc/c/a/a$b;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v3, Lc/c/a/a$b;->e:Lc/c/a/a$b;

    const/4 v5, 0x3

    new-array v5, v5, [Lc/c/a/a$b;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lc/c/a/a$b;->f:[Lc/c/a/a$b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lc/c/a/a$b;->b:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lc/c/a/a$b;
    .locals 1

    const-class v0, Lc/c/a/a$b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lc/c/a/a$b;

    return-object p0
.end method

.method public static final values()[Lc/c/a/a$b;
    .locals 1

    sget-object v0, Lc/c/a/a$b;->f:[Lc/c/a/a$b;

    invoke-virtual {v0}, [Lc/c/a/a$b;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc/c/a/a$b;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/a$b;->b:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Line break: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
