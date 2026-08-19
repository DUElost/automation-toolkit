.class public final enum Ld/n/i/a$b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/i/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/i/a$b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/i/a$b;

.field public static final enum c:Ld/n/i/a$b;

.field public static final enum d:Ld/n/i/a$b;

.field private static final synthetic e:[Ld/n/i/a$b;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Ld/n/i/a$b;

    const-string v1, "HANDSHAKING"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/i/a$b;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/i/a$b;->b:Ld/n/i/a$b;

    new-instance v1, Ld/n/i/a$b;

    const-string v3, "READY"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/i/a$b;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    new-instance v3, Ld/n/i/a$b;

    const-string v5, "ERROR"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/n/i/a$b;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    const/4 v5, 0x3

    new-array v5, v5, [Ld/n/i/a$b;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Ld/n/i/a$b;->e:[Ld/n/i/a$b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/i/a$b;
    .locals 1

    const-class v0, Ld/n/i/a$b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/i/a$b;

    return-object p0
.end method

.method public static values()[Ld/n/i/a$b;
    .locals 4

    sget-object v0, Ld/n/i/a$b;->e:[Ld/n/i/a$b;

    array-length v1, v0

    new-array v2, v1, [Ld/n/i/a$b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
