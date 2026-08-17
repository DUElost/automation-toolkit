.class public Lcom/ape/offlinescriptmanager/utils/m/h;
.super Lcom/ape/offlinescriptmanager/utils/m/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/utils/m/h$b;
    }
.end annotation


# instance fields
.field private a:Lb/b/a/a/a/a;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/m/a;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/h;->a:Lb/b/a/a/a/a;

    return-void
.end method

.method static synthetic d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/m/h;->a:Lb/b/a/a/a/a;

    return-object p0
.end method

.method static synthetic e(Lcom/ape/offlinescriptmanager/utils/m/h;Lb/b/a/a/a/a;)Lb/b/a/a/a/a;
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h;->a:Lb/b/a/a/a/a;

    return-object p1
.end method


# virtual methods
.method public a()Lorg/xml/sax/helpers/DefaultHandler;
    .locals 2

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/m/h$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/ape/offlinescriptmanager/utils/m/h$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/h;Lcom/ape/offlinescriptmanager/utils/m/h$a;)V

    return-object v0
.end method

.method public f()Lb/b/a/a/a/a;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/h;->a:Lb/b/a/a/a/a;

    return-object v0
.end method
