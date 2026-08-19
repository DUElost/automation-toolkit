.class public final enum Lorg/achartengine/h/d$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/achartengine/h/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/achartengine/h/d$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Lorg/achartengine/h/d$a;

.field public static final enum d:Lorg/achartengine/h/d$a;

.field private static final synthetic e:[Lorg/achartengine/h/d$a;


# instance fields
.field private b:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    new-instance v0, Lorg/achartengine/h/d$a;

    const-string v1, "HORIZONTAL"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lorg/achartengine/h/d$a;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/achartengine/h/d$a;->c:Lorg/achartengine/h/d$a;

    new-instance v1, Lorg/achartengine/h/d$a;

    const-string v3, "VERTICAL"

    const/4 v4, 0x1

    const/16 v5, 0x5a

    invoke-direct {v1, v3, v4, v5}, Lorg/achartengine/h/d$a;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lorg/achartengine/h/d$a;->d:Lorg/achartengine/h/d$a;

    const/4 v3, 0x2

    new-array v3, v3, [Lorg/achartengine/h/d$a;

    aput-object v0, v3, v2

    aput-object v1, v3, v4

    sput-object v3, Lorg/achartengine/h/d$a;->e:[Lorg/achartengine/h/d$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    const/4 p1, 0x0

    iput p1, p0, Lorg/achartengine/h/d$a;->b:I

    iput p3, p0, Lorg/achartengine/h/d$a;->b:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/achartengine/h/d$a;
    .locals 1

    const-class v0, Lorg/achartengine/h/d$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/achartengine/h/d$a;

    return-object p0
.end method

.method public static values()[Lorg/achartengine/h/d$a;
    .locals 4

    sget-object v0, Lorg/achartengine/h/d$a;->e:[Lorg/achartengine/h/d$a;

    array-length v1, v0

    new-array v2, v1, [Lorg/achartengine/h/d$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lorg/achartengine/h/d$a;->b:I

    return v0
.end method
