.class final enum Ld/n/g$f;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "f"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/g$f;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Ld/n/g$f;

.field public static final enum d:Ld/n/g$f;

.field public static final enum e:Ld/n/g$f;

.field public static final enum f:Ld/n/g$f;

.field private static final synthetic g:[Ld/n/g$f;


# instance fields
.field private final b:B


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Ld/n/g$f;

    const-string v1, "V0"

    const/4 v2, 0x0

    const/4 v3, -0x1

    invoke-direct {v0, v1, v2, v3}, Ld/n/g$f;-><init>(Ljava/lang/String;II)V

    sput-object v0, Ld/n/g$f;->c:Ld/n/g$f;

    new-instance v1, Ld/n/g$f;

    const-string v3, "V1"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4, v2}, Ld/n/g$f;-><init>(Ljava/lang/String;II)V

    sput-object v1, Ld/n/g$f;->d:Ld/n/g$f;

    new-instance v3, Ld/n/g$f;

    const-string v5, "V2"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6, v4}, Ld/n/g$f;-><init>(Ljava/lang/String;II)V

    sput-object v3, Ld/n/g$f;->e:Ld/n/g$f;

    new-instance v5, Ld/n/g$f;

    const-string v7, "V3"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8, v8}, Ld/n/g$f;-><init>(Ljava/lang/String;II)V

    sput-object v5, Ld/n/g$f;->f:Ld/n/g$f;

    const/4 v7, 0x4

    new-array v7, v7, [Ld/n/g$f;

    aput-object v0, v7, v2

    aput-object v1, v7, v4

    aput-object v3, v7, v6

    aput-object v5, v7, v8

    sput-object v7, Ld/n/g$f;->g:[Ld/n/g$f;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    int-to-byte p1, p3

    iput-byte p1, p0, Ld/n/g$f;->b:B

    return-void
.end method

.method static synthetic a(Ld/n/g$f;)B
    .locals 0

    iget-byte p0, p0, Ld/n/g$f;->b:B

    return p0
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/g$f;
    .locals 1

    const-class v0, Ld/n/g$f;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/g$f;

    return-object p0
.end method

.method public static values()[Ld/n/g$f;
    .locals 4

    sget-object v0, Ld/n/g$f;->g:[Ld/n/g$f;

    array-length v1, v0

    new-array v2, v1, [Ld/n/g$f;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
