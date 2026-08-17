.class public final enum Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "h"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

.field public static final enum c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

.field public static final enum d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

.field private static final synthetic e:[Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    new-instance v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    const-string v1, "SHOW_WHEN_ACTIVE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->b:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    new-instance v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    const-string v3, "ALWAYS_SHOW"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->c:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    new-instance v3, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    const-string v5, "ALWAYS_HIDE"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->d:Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    const/4 v5, 0x3

    new-array v5, v5, [Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->e:[Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

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

.method public static valueOf(Ljava/lang/String;)Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;
    .locals 1

    const-class v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    return-object p0
.end method

.method public static values()[Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;
    .locals 1

    sget-object v0, Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->e:[Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    invoke-virtual {v0}, [Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/aurelhubert/ahbottomnavigation/AHBottomNavigation$h;

    return-object v0
.end method
