.class final enum Ld/r/h/c$a$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/h/c$a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/r/h/c$a$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/r/h/c$a$a;

.field public static final enum c:Ld/r/h/c$a$a;

.field private static final synthetic d:[Ld/r/h/c$a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Ld/r/h/c$a$a;

    const-string v1, "BOTTOM"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/r/h/c$a$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/r/h/c$a$a;->b:Ld/r/h/c$a$a;

    new-instance v1, Ld/r/h/c$a$a;

    const-string v3, "BODY"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/r/h/c$a$a;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/r/h/c$a$a;->c:Ld/r/h/c$a$a;

    const/4 v3, 0x2

    new-array v3, v3, [Ld/r/h/c$a$a;

    aput-object v0, v3, v2

    aput-object v1, v3, v4

    sput-object v3, Ld/r/h/c$a$a;->d:[Ld/r/h/c$a$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/r/h/c$a$a;
    .locals 1

    const-class v0, Ld/r/h/c$a$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/r/h/c$a$a;

    return-object p0
.end method

.method public static values()[Ld/r/h/c$a$a;
    .locals 4

    sget-object v0, Ld/r/h/c$a$a;->d:[Ld/r/h/c$a$a;

    array-length v1, v0

    new-array v2, v1, [Ld/r/h/c$a$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
