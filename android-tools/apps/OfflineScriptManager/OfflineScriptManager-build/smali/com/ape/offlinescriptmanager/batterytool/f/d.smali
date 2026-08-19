.class public Lcom/ape/offlinescriptmanager/batterytool/f/d;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:D


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;D)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->b:Ljava/lang/String;

    iput-wide p3, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->c:D

    return-void
.end method


# virtual methods
.method public a()D
    .locals 2

    iget-wide v0, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->c:D

    return-wide v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->a:Ljava/lang/String;

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/f/d;->b:Ljava/lang/String;

    return-object v0
.end method
