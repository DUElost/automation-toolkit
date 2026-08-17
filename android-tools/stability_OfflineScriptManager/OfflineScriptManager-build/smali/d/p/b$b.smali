.class final enum Ld/p/b$b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/p/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/p/b$b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/p/b$b;

.field public static final enum c:Ld/p/b$b;

.field public static final enum d:Ld/p/b$b;

.field public static final enum e:Ld/p/b$b;

.field public static final enum f:Ld/p/b$b;

.field public static final enum g:Ld/p/b$b;

.field private static final synthetic h:[Ld/p/b$b;


# direct methods
.method static constructor <clinit>()V
    .locals 13

    new-instance v0, Ld/p/b$b;

    const-string v1, "ACTIVE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/p/b$b;->b:Ld/p/b$b;

    new-instance v1, Ld/p/b$b;

    const-string v3, "DELIMITER_RECEIVED"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/p/b$b;->c:Ld/p/b$b;

    new-instance v3, Ld/p/b$b;

    const-string v5, "WAITING_FOR_DELIMITER"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/p/b$b;->d:Ld/p/b$b;

    new-instance v5, Ld/p/b$b;

    const-string v7, "TERM_ACK_SENT"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v5, Ld/p/b$b;->e:Ld/p/b$b;

    new-instance v7, Ld/p/b$b;

    const-string v9, "TERM_REQ_SENT_1"

    const/4 v10, 0x4

    invoke-direct {v7, v9, v10}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v7, Ld/p/b$b;->f:Ld/p/b$b;

    new-instance v9, Ld/p/b$b;

    const-string v11, "TERM_REQ_SENT_2"

    const/4 v12, 0x5

    invoke-direct {v9, v11, v12}, Ld/p/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v9, Ld/p/b$b;->g:Ld/p/b$b;

    const/4 v11, 0x6

    new-array v11, v11, [Ld/p/b$b;

    aput-object v0, v11, v2

    aput-object v1, v11, v4

    aput-object v3, v11, v6

    aput-object v5, v11, v8

    aput-object v7, v11, v10

    aput-object v9, v11, v12

    sput-object v11, Ld/p/b$b;->h:[Ld/p/b$b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/p/b$b;
    .locals 1

    const-class v0, Ld/p/b$b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/p/b$b;

    return-object p0
.end method

.method public static values()[Ld/p/b$b;
    .locals 4

    sget-object v0, Ld/p/b$b;->h:[Ld/p/b$b;

    array-length v1, v0

    new-array v2, v1, [Ld/p/b$b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
