.class final enum Ld/n/j/h/a$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/j/h/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/j/h/a$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/j/h/a$a;

.field public static final enum c:Ld/n/j/h/a$a;

.field public static final enum d:Ld/n/j/h/a$a;

.field public static final enum e:Ld/n/j/h/a$a;

.field public static final enum f:Ld/n/j/h/a$a;

.field public static final enum g:Ld/n/j/h/a$a;

.field public static final enum h:Ld/n/j/h/a$a;

.field private static final synthetic i:[Ld/n/j/h/a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 15

    new-instance v0, Ld/n/j/h/a$a;

    const-string v1, "UNPLUGGED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/j/h/a$a;->b:Ld/n/j/h/a$a;

    new-instance v1, Ld/n/j/h/a$a;

    const-string v3, "WAITING_FOR_RECONNECT_TIME"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/j/h/a$a;->c:Ld/n/j/h/a$a;

    new-instance v3, Ld/n/j/h/a$a;

    const-string v5, "WAITING_FOR_PROXY_CONNECTION"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/n/j/h/a$a;->d:Ld/n/j/h/a$a;

    new-instance v5, Ld/n/j/h/a$a;

    const-string v7, "SENDING_GREETING"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v5, Ld/n/j/h/a$a;->e:Ld/n/j/h/a$a;

    new-instance v7, Ld/n/j/h/a$a;

    const-string v9, "WAITING_FOR_CHOICE"

    const/4 v10, 0x4

    invoke-direct {v7, v9, v10}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v7, Ld/n/j/h/a$a;->f:Ld/n/j/h/a$a;

    new-instance v9, Ld/n/j/h/a$a;

    const-string v11, "SENDING_REQUEST"

    const/4 v12, 0x5

    invoke-direct {v9, v11, v12}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v9, Ld/n/j/h/a$a;->g:Ld/n/j/h/a$a;

    new-instance v11, Ld/n/j/h/a$a;

    const-string v13, "WAITING_FOR_RESPONSE"

    const/4 v14, 0x6

    invoke-direct {v11, v13, v14}, Ld/n/j/h/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v11, Ld/n/j/h/a$a;->h:Ld/n/j/h/a$a;

    const/4 v13, 0x7

    new-array v13, v13, [Ld/n/j/h/a$a;

    aput-object v0, v13, v2

    aput-object v1, v13, v4

    aput-object v3, v13, v6

    aput-object v5, v13, v8

    aput-object v7, v13, v10

    aput-object v9, v13, v12

    aput-object v11, v13, v14

    sput-object v13, Ld/n/j/h/a$a;->i:[Ld/n/j/h/a$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/j/h/a$a;
    .locals 1

    const-class v0, Ld/n/j/h/a$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/j/h/a$a;

    return-object p0
.end method

.method public static values()[Ld/n/j/h/a$a;
    .locals 4

    sget-object v0, Ld/n/j/h/a$a;->i:[Ld/n/j/h/a$a;

    array-length v1, v0

    new-array v2, v1, [Ld/n/j/h/a$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
