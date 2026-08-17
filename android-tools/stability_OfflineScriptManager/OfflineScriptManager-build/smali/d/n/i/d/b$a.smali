.class final enum Ld/n/i/d/b$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/i/d/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/i/d/b$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/i/d/b$a;

.field public static final enum c:Ld/n/i/d/b$a;

.field public static final enum d:Ld/n/i/d/b$a;

.field public static final enum e:Ld/n/i/d/b$a;

.field public static final enum f:Ld/n/i/d/b$a;

.field public static final enum g:Ld/n/i/d/b$a;

.field private static final synthetic h:[Ld/n/i/d/b$a;


# direct methods
.method static constructor <clinit>()V
    .locals 13

    new-instance v0, Ld/n/i/d/b$a;

    const-string v1, "SEND_HELLO"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/i/d/b$a;->b:Ld/n/i/d/b$a;

    new-instance v1, Ld/n/i/d/b$a;

    const-string v3, "EXPECT_WELCOME"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/i/d/b$a;->c:Ld/n/i/d/b$a;

    new-instance v3, Ld/n/i/d/b$a;

    const-string v5, "SEND_INITIATE"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/n/i/d/b$a;->d:Ld/n/i/d/b$a;

    new-instance v5, Ld/n/i/d/b$a;

    const-string v7, "EXPECT_READY"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v5, Ld/n/i/d/b$a;->e:Ld/n/i/d/b$a;

    new-instance v7, Ld/n/i/d/b$a;

    const-string v9, "ERROR_RECEIVED"

    const/4 v10, 0x4

    invoke-direct {v7, v9, v10}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v7, Ld/n/i/d/b$a;->f:Ld/n/i/d/b$a;

    new-instance v9, Ld/n/i/d/b$a;

    const-string v11, "CONNECTED"

    const/4 v12, 0x5

    invoke-direct {v9, v11, v12}, Ld/n/i/d/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v9, Ld/n/i/d/b$a;->g:Ld/n/i/d/b$a;

    const/4 v11, 0x6

    new-array v11, v11, [Ld/n/i/d/b$a;

    aput-object v0, v11, v2

    aput-object v1, v11, v4

    aput-object v3, v11, v6

    aput-object v5, v11, v8

    aput-object v7, v11, v10

    aput-object v9, v11, v12

    sput-object v11, Ld/n/i/d/b$a;->h:[Ld/n/i/d/b$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/i/d/b$a;
    .locals 1

    const-class v0, Ld/n/i/d/b$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/i/d/b$a;

    return-object p0
.end method

.method public static values()[Ld/n/i/d/b$a;
    .locals 4

    sget-object v0, Ld/n/i/d/b$a;->h:[Ld/n/i/d/b$a;

    array-length v1, v0

    new-array v2, v1, [Ld/n/i/d/b$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
