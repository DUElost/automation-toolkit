.class Ld/c$b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# instance fields
.field private final a:Ld/c$a;

.field private final b:Ld/p/b;

.field private final c:Ld/p/b;


# direct methods
.method public constructor <init>(Ld/c$a;Ld/p/b;Ld/p/b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ld/c$b;->a:Ld/c$a;

    iput-object p2, p0, Ld/c$b;->b:Ld/p/b;

    iput-object p3, p0, Ld/c$b;->c:Ld/p/b;

    return-void
.end method

.method static synthetic a(Ld/c$b;)Ld/p/b;
    .locals 0

    iget-object p0, p0, Ld/c$b;->c:Ld/p/b;

    return-object p0
.end method

.method static synthetic b(Ld/c$b;)Ld/c$a;
    .locals 0

    iget-object p0, p0, Ld/c$b;->a:Ld/c$a;

    return-object p0
.end method

.method static synthetic c(Ld/c$b;)Ld/p/b;
    .locals 0

    iget-object p0, p0, Ld/c$b;->b:Ld/p/b;

    return-object p0
.end method
