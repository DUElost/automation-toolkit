.class public final enum Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

.field public static final enum c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

.field private static final synthetic d:[Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    const-string v1, "Internal"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->b:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    const-string v3, "External"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->c:Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    const/4 v3, 0x2

    new-array v3, v3, [Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    aput-object v0, v3, v2

    aput-object v1, v3, v4

    sput-object v3, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->d:[Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

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

.method public static valueOf(Ljava/lang/String;)Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;
    .locals 1

    const-class v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    return-object p0
.end method

.method public static values()[Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;
    .locals 1

    sget-object v0, Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->d:[Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    invoke-virtual {v0}, [Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/ape/offlinescriptmanager/screenrecorder/folderpicker/c$a;

    return-object v0
.end method
