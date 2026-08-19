.class Lc/c/a/f/b$k;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/c/a/f/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/c/a/f/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "k"
.end annotation


# instance fields
.field final synthetic a:Lc/c/a/f/b;


# direct methods
.method private constructor <init>(Lc/c/a/f/b;)V
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b$k;->a:Lc/c/a/f/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b$k;-><init>(Lc/c/a/f/b;)V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    new-instance v0, Lc/c/a/f/b$h;

    iget-object v1, p0, Lc/c/a/f/b$k;->a:Lc/c/a/f/b;

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lc/c/a/f/b$h;-><init>(Lc/c/a/f/b;Z)V

    invoke-virtual {v0}, Lc/c/a/f/b$h;->a()V

    return-void
.end method
