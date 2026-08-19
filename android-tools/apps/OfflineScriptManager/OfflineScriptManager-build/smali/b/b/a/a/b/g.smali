.class public final enum Lb/b/a/a/b/g;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/b/a/a/b/g;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lb/b/a/a/b/g;

.field public static final enum d:Lb/b/a/a/b/g;

.field public static final enum e:Lb/b/a/a/b/g;

.field public static final enum f:Lb/b/a/a/b/g;

.field public static final enum g:Lb/b/a/a/b/g;

.field public static final enum h:Lb/b/a/a/b/g;

.field private static final synthetic i:[Lb/b/a/a/b/g;


# instance fields
.field private b:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 14

    new-instance v0, Lb/b/a/a/b/g;

    const-string v1, "PASS"

    const/4 v2, 0x0

    const-string v3, "Pass"

    invoke-direct {v0, v1, v2, v3}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lb/b/a/a/b/g;->c:Lb/b/a/a/b/g;

    new-instance v1, Lb/b/a/a/b/g;

    const-string v3, "ERROR"

    const/4 v4, 0x1

    const-string v5, "Error"

    invoke-direct {v1, v3, v4, v5}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v1, Lb/b/a/a/b/g;->d:Lb/b/a/a/b/g;

    new-instance v3, Lb/b/a/a/b/g;

    const-string v5, "FAILURE"

    const/4 v6, 0x2

    const-string v7, "Failure"

    invoke-direct {v3, v5, v6, v7}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v3, Lb/b/a/a/b/g;->e:Lb/b/a/a/b/g;

    new-instance v5, Lb/b/a/a/b/g;

    const-string v7, "NOTEXECUTED"

    const/4 v8, 0x3

    const-string v9, "notExecuted"

    invoke-direct {v5, v7, v8, v9}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v5, Lb/b/a/a/b/g;->f:Lb/b/a/a/b/g;

    new-instance v7, Lb/b/a/a/b/g;

    const-string v9, "RUNNING"

    const/4 v10, 0x4

    const-string v11, "running"

    invoke-direct {v7, v9, v10, v11}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v7, Lb/b/a/a/b/g;->g:Lb/b/a/a/b/g;

    new-instance v9, Lb/b/a/a/b/g;

    const-string v11, "INCOMPLETE"

    const/4 v12, 0x5

    const-string v13, "Incomplete"

    invoke-direct {v9, v11, v12, v13}, Lb/b/a/a/b/g;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v9, Lb/b/a/a/b/g;->h:Lb/b/a/a/b/g;

    const/4 v11, 0x6

    new-array v11, v11, [Lb/b/a/a/b/g;

    aput-object v0, v11, v2

    aput-object v1, v11, v4

    aput-object v3, v11, v6

    aput-object v5, v11, v8

    aput-object v7, v11, v10

    aput-object v9, v11, v12

    sput-object v11, Lb/b/a/a/b/g;->i:[Lb/b/a/a/b/g;

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

    iput-object p3, p0, Lb/b/a/a/b/g;->b:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lb/b/a/a/b/g;
    .locals 1

    const-class v0, Lb/b/a/a/b/g;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/b/a/a/b/g;

    return-object p0
.end method

.method public static values()[Lb/b/a/a/b/g;
    .locals 1

    sget-object v0, Lb/b/a/a/b/g;->i:[Lb/b/a/a/b/g;

    invoke-virtual {v0}, [Lb/b/a/a/b/g;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/b/a/a/b/g;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/b/a/a/b/g;->b:Ljava/lang/String;

    return-object v0
.end method
