.class Lcom/ape/offlinescriptmanager/utils/l/g$b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/l/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/Integer;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/Integer;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->a:Ljava/lang/Integer;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->b:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->d:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->e:Ljava/lang/Integer;

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/l/g$a;)V
    .locals 0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;-><init>()V

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic b(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->b:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic c(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->e:Ljava/lang/Integer;

    return-object p0
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->e:Ljava/lang/Integer;

    return-object p1
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->d:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic f(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->d:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->a:Ljava/lang/Integer;

    return-object p0
.end method

.method static synthetic h(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->a:Ljava/lang/Integer;

    return-object p1
.end method


# virtual methods
.method i()Z
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->a:Ljava/lang/Integer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c:Ljava/lang/String;

    if-eqz v1, :cond_0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g$b;->b:Ljava/lang/String;

    if-eqz v1, :cond_1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-lez v1, :cond_2

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_2
    const-string v0, "unknown result"

    return-object v0
.end method
