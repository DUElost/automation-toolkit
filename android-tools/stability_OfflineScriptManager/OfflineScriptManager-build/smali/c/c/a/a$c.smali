.class public final enum Lc/c/a/a$c;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lc/c/a/a$c;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lc/c/a/a$c;

.field public static final enum d:Lc/c/a/a$c;

.field public static final enum e:Lc/c/a/a$c;

.field public static final enum f:Lc/c/a/a$c;

.field public static final enum g:Lc/c/a/a$c;

.field private static final synthetic h:[Lc/c/a/a$c;


# instance fields
.field private b:Ljava/lang/Character;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    new-instance v0, Lc/c/a/a$c;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x22

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "DOUBLE_QUOTED"

    const/4 v3, 0x0

    invoke-direct {v0, v2, v3, v1}, Lc/c/a/a$c;-><init>(Ljava/lang/String;ILjava/lang/Character;)V

    sput-object v0, Lc/c/a/a$c;->c:Lc/c/a/a$c;

    new-instance v1, Lc/c/a/a$c;

    new-instance v2, Ljava/lang/Character;

    const/16 v4, 0x27

    invoke-direct {v2, v4}, Ljava/lang/Character;-><init>(C)V

    const-string v4, "SINGLE_QUOTED"

    const/4 v5, 0x1

    invoke-direct {v1, v4, v5, v2}, Lc/c/a/a$c;-><init>(Ljava/lang/String;ILjava/lang/Character;)V

    sput-object v1, Lc/c/a/a$c;->d:Lc/c/a/a$c;

    new-instance v2, Lc/c/a/a$c;

    new-instance v4, Ljava/lang/Character;

    const/16 v6, 0x7c

    invoke-direct {v4, v6}, Ljava/lang/Character;-><init>(C)V

    const-string v6, "LITERAL"

    const/4 v7, 0x2

    invoke-direct {v2, v6, v7, v4}, Lc/c/a/a$c;-><init>(Ljava/lang/String;ILjava/lang/Character;)V

    sput-object v2, Lc/c/a/a$c;->e:Lc/c/a/a$c;

    new-instance v4, Lc/c/a/a$c;

    new-instance v6, Ljava/lang/Character;

    const/16 v8, 0x3e

    invoke-direct {v6, v8}, Ljava/lang/Character;-><init>(C)V

    const-string v8, "FOLDED"

    const/4 v9, 0x3

    invoke-direct {v4, v8, v9, v6}, Lc/c/a/a$c;-><init>(Ljava/lang/String;ILjava/lang/Character;)V

    sput-object v4, Lc/c/a/a$c;->f:Lc/c/a/a$c;

    new-instance v6, Lc/c/a/a$c;

    const-string v8, "PLAIN"

    const/4 v10, 0x4

    const/4 v11, 0x0

    invoke-direct {v6, v8, v10, v11}, Lc/c/a/a$c;-><init>(Ljava/lang/String;ILjava/lang/Character;)V

    sput-object v6, Lc/c/a/a$c;->g:Lc/c/a/a$c;

    const/4 v8, 0x5

    new-array v8, v8, [Lc/c/a/a$c;

    aput-object v0, v8, v3

    aput-object v1, v8, v5

    aput-object v2, v8, v7

    aput-object v4, v8, v9

    aput-object v6, v8, v10

    sput-object v8, Lc/c/a/a$c;->h:[Lc/c/a/a$c;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/Character;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Character;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lc/c/a/a$c;->b:Ljava/lang/Character;

    return-void
.end method

.method public static a(Ljava/lang/Character;)Lc/c/a/a$c;
    .locals 3

    if-nez p0, :cond_0

    sget-object p0, Lc/c/a/a$c;->g:Lc/c/a/a$c;

    return-object p0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/Character;->charValue()C

    move-result v0

    const/16 v1, 0x22

    if-eq v0, v1, :cond_4

    const/16 v1, 0x27

    if-eq v0, v1, :cond_3

    const/16 v1, 0x3e

    if-eq v0, v1, :cond_2

    const/16 v1, 0x7c

    if-ne v0, v1, :cond_1

    sget-object p0, Lc/c/a/a$c;->e:Lc/c/a/a$c;

    return-object p0

    :cond_1
    new-instance v0, Lc/c/a/g/b;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown scalar style character: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Lc/c/a/g/b;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    sget-object p0, Lc/c/a/a$c;->f:Lc/c/a/a$c;

    return-object p0

    :cond_3
    sget-object p0, Lc/c/a/a$c;->d:Lc/c/a/a$c;

    return-object p0

    :cond_4
    sget-object p0, Lc/c/a/a$c;->c:Lc/c/a/a$c;

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lc/c/a/a$c;
    .locals 1

    const-class v0, Lc/c/a/a$c;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lc/c/a/a$c;

    return-object p0
.end method

.method public static final values()[Lc/c/a/a$c;
    .locals 1

    sget-object v0, Lc/c/a/a$c;->h:[Lc/c/a/a$c;

    invoke-virtual {v0}, [Lc/c/a/a$c;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc/c/a/a$c;

    return-object v0
.end method


# virtual methods
.method public b()Ljava/lang/Character;
    .locals 1

    iget-object v0, p0, Lc/c/a/a$c;->b:Ljava/lang/Character;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Scalar style: \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lc/c/a/a$c;->b:Ljava/lang/Character;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
