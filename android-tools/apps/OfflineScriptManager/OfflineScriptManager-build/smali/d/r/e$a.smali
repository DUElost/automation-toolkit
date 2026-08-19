.class Ld/r/e$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field private a:Ld/p/b;

.field private b:Z


# direct methods
.method public constructor <init>(Ld/r/e;Ld/p/b;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Ld/r/e$a;->a:Ld/p/b;

    iput-boolean p3, p0, Ld/r/e$a;->b:Z

    return-void
.end method

.method static synthetic a(Ld/r/e$a;)Ld/p/b;
    .locals 0

    iget-object p0, p0, Ld/r/e$a;->a:Ld/p/b;

    return-object p0
.end method

.method static synthetic b(Ld/r/e$a;Z)V
    .locals 0

    iput-boolean p1, p0, Ld/r/e$a;->b:Z

    return-void
.end method
