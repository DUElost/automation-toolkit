.class public final enum Ld/n/j/d;
.super Ljava/lang/Enum;
.source ""

# interfaces
.implements Ld/n/j/c;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/j/d;",
        ">;",
        "Ld/n/j/c;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/j/d;

.field public static final enum c:Ld/n/j/d;

.field private static final synthetic d:[Ld/n/j/d;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Ld/n/j/d;

    const-string v1, "INET"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/j/d;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/j/d;->b:Ld/n/j/d;

    new-instance v1, Ld/n/j/d;

    const-string v3, "INET6"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/j/d;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/j/d;->c:Ld/n/j/d;

    const/4 v3, 0x2

    new-array v3, v3, [Ld/n/j/d;

    aput-object v0, v3, v2

    aput-object v1, v3, v4

    sput-object v3, Ld/n/j/d;->d:[Ld/n/j/d;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/j/d;
    .locals 1

    const-class v0, Ld/n/j/d;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/j/d;

    return-object p0
.end method

.method public static values()[Ld/n/j/d;
    .locals 4

    sget-object v0, Ld/n/j/d;->d:[Ld/n/j/d;

    array-length v1, v0

    new-array v2, v1, [Ld/n/j/d;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
