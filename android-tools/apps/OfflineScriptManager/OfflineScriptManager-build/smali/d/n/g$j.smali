.class final Ld/n/g$j;
.super Ld/n/g$e$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "j"
.end annotation


# instance fields
.field final synthetic a:Ld/n/g;


# direct methods
.method private constructor <init>(Ld/n/g;)V
    .locals 0

    iput-object p1, p0, Ld/n/g$j;->a:Ld/n/g;

    invoke-direct {p0}, Ld/n/g$e$a;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/g;Ld/n/g$j;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g$j;-><init>(Ld/n/g;)V

    return-void
.end method


# virtual methods
.method public a(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/n/g$j;->a:Ld/n/g;

    invoke-static {v0, p1}, Ld/n/g;->t(Ld/n/g;Ld/e;)Z

    move-result p1

    return p1
.end method
