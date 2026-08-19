.class final Ld/r/g/g$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/r/g/e$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/g/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Ld/r/g/g;


# direct methods
.method private constructor <init>(Ld/r/g/g;)V
    .locals 0

    iput-object p1, p0, Ld/r/g/g$a;->a:Ld/r/g/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/r/g/g;Ld/r/g/g$a;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/r/g/g$a;-><init>(Ld/r/g/g;)V

    return-void
.end method


# virtual methods
.method public a([BILd/p/b;)V
    .locals 1

    iget-object v0, p0, Ld/r/g/g$a;->a:Ld/r/g/g;

    invoke-static {v0, p1, p2, p3}, Ld/r/g/g;->r1(Ld/r/g/g;[BILd/p/b;)Z

    return-void
.end method
