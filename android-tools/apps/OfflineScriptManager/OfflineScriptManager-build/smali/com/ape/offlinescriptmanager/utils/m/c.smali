.class public Lcom/ape/offlinescriptmanager/utils/m/c;
.super Lcom/ape/offlinescriptmanager/utils/m/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/utils/m/c$b;
    }
.end annotation


# instance fields
.field private a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private f:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/m/a;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->a:Ljava/util/Map;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->d:Ljava/util/List;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->e:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->f:I

    return-void
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/utils/m/c;)I
    .locals 0

    iget p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->f:I

    return p0
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/utils/m/c;)I
    .locals 2

    iget v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->f:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->f:I

    return v0
.end method

.method static synthetic f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->b:Ljava/util/Map;

    return-object p0
.end method

.method static synthetic g(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->b:Ljava/util/Map;

    return-object p1
.end method

.method static synthetic h(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->e:Ljava/util/List;

    return-object p0
.end method

.method static synthetic i(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->e:Ljava/util/List;

    return-object p1
.end method

.method static synthetic j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->c:Ljava/util/Map;

    return-object p0
.end method

.method static synthetic k(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->c:Ljava/util/Map;

    return-object p1
.end method

.method static synthetic l(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->a:Ljava/util/Map;

    return-object p0
.end method

.method static synthetic m(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->d:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public a()Lorg/xml/sax/helpers/DefaultHandler;
    .locals 2

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/c$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/utils/m/c$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/c;Lcom/ape/offlinescriptmanager/utils/m/c$a;)V

    return-object v0
.end method

.method public n()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->a:Ljava/util/Map;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->d:Ljava/util/List;

    const-string v2, "test_points"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "test_result_map is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->a:Ljava/util/Map;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c;->a:Ljava/util/Map;

    return-object v0
.end method
