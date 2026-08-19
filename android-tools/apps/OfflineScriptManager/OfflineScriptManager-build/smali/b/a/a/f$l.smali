.class final enum Lb/a/a/f$l;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lb/a/a/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "l"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lb/a/a/f$l;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lb/a/a/f$l;

.field public static final enum c:Lb/a/a/f$l;

.field public static final enum d:Lb/a/a/f$l;

.field private static final synthetic e:[Lb/a/a/f$l;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lb/a/a/f$l;

    const-string v1, "REGULAR"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lb/a/a/f$l;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lb/a/a/f$l;->b:Lb/a/a/f$l;

    new-instance v1, Lb/a/a/f$l;

    const-string v3, "SINGLE"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lb/a/a/f$l;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lb/a/a/f$l;->c:Lb/a/a/f$l;

    new-instance v3, Lb/a/a/f$l;

    const-string v5, "MULTI"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lb/a/a/f$l;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lb/a/a/f$l;->d:Lb/a/a/f$l;

    const/4 v5, 0x3

    new-array v5, v5, [Lb/a/a/f$l;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lb/a/a/f$l;->e:[Lb/a/a/f$l;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static a(Lb/a/a/f$l;)I
    .locals 1

    sget-object v0, Lb/a/a/f$c;->b:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result p0

    aget p0, v0, p0

    const/4 v0, 0x1

    if-eq p0, v0, :cond_2

    const/4 v0, 0x2

    if-eq p0, v0, :cond_1

    const/4 v0, 0x3

    if-ne p0, v0, :cond_0

    sget p0, Lb/a/a/l;->md_listitem_multichoice:I

    return p0

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Not a valid list type"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    sget p0, Lb/a/a/l;->md_listitem_singlechoice:I

    return p0

    :cond_2
    sget p0, Lb/a/a/l;->md_listitem:I

    return p0
.end method

.method public static valueOf(Ljava/lang/String;)Lb/a/a/f$l;
    .locals 1

    const-class v0, Lb/a/a/f$l;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lb/a/a/f$l;

    return-object p0
.end method

.method public static values()[Lb/a/a/f$l;
    .locals 1

    sget-object v0, Lb/a/a/f$l;->e:[Lb/a/a/f$l;

    invoke-virtual {v0}, [Lb/a/a/f$l;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb/a/a/f$l;

    return-object v0
.end method
