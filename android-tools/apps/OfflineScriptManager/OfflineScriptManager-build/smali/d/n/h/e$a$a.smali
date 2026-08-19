.class public final enum Ld/n/h/e$a$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/h/e$a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/h/e$a$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/h/e$a$a;

.field public static final enum c:Ld/n/h/e$a$a;

.field public static final enum d:Ld/n/h/e$a$a;

.field private static final synthetic e:[Ld/n/h/e$a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Ld/n/h/e$a$a;

    const-string v1, "MORE_DATA"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Ld/n/h/e$a$a;-><init>(Ljava/lang/String;II)V

    sput-object v0, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    new-instance v1, Ld/n/h/e$a$a;

    const-string v3, "DECODED"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4, v4}, Ld/n/h/e$a$a;-><init>(Ljava/lang/String;II)V

    sput-object v1, Ld/n/h/e$a$a;->c:Ld/n/h/e$a$a;

    new-instance v3, Ld/n/h/e$a$a;

    const-string v5, "ERROR"

    const/4 v6, 0x2

    const/4 v7, -0x1

    invoke-direct {v3, v5, v6, v7}, Ld/n/h/e$a$a;-><init>(Ljava/lang/String;II)V

    sput-object v3, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    const/4 v5, 0x3

    new-array v5, v5, [Ld/n/h/e$a$a;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Ld/n/h/e$a$a;->e:[Ld/n/h/e$a$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/h/e$a$a;
    .locals 1

    const-class v0, Ld/n/h/e$a$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/h/e$a$a;

    return-object p0
.end method

.method public static values()[Ld/n/h/e$a$a;
    .locals 4

    sget-object v0, Ld/n/h/e$a$a;->e:[Ld/n/h/e$a$a;

    array-length v1, v0

    new-array v2, v1, [Ld/n/h/e$a$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
