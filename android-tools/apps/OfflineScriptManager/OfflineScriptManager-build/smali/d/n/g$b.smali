.class public final enum Ld/n/g$b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/g$b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/g$b;

.field public static final enum c:Ld/n/g$b;

.field public static final enum d:Ld/n/g$b;

.field private static final synthetic e:[Ld/n/g$b;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Ld/n/g$b;

    const-string v1, "PROTOCOL"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/g$b;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    new-instance v1, Ld/n/g$b;

    const-string v3, "CONNECTION"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/g$b;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/g$b;->c:Ld/n/g$b;

    new-instance v3, Ld/n/g$b;

    const-string v5, "TIMEOUT"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/n/g$b;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/n/g$b;->d:Ld/n/g$b;

    const/4 v5, 0x3

    new-array v5, v5, [Ld/n/g$b;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Ld/n/g$b;->e:[Ld/n/g$b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/g$b;
    .locals 1

    const-class v0, Ld/n/g$b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/g$b;

    return-object p0
.end method

.method public static values()[Ld/n/g$b;
    .locals 4

    sget-object v0, Ld/n/g$b;->e:[Ld/n/g$b;

    array-length v1, v0

    new-array v2, v1, [Ld/n/g$b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
