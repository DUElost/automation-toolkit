.class Ld/r/h/d$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/r/h/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field private a:Ld/p/b;

.field private b:Z


# direct methods
.method public constructor <init>(Ld/r/h/d;Ld/p/b;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Ld/r/h/d$a;->a:Ld/p/b;

    iput-boolean p3, p0, Ld/r/h/d$a;->b:Z

    return-void
.end method

.method static synthetic a(Ld/r/h/d$a;)Ld/p/b;
    .locals 0

    iget-object p0, p0, Ld/r/h/d$a;->a:Ld/p/b;

    return-object p0
.end method

.method static synthetic b(Ld/r/h/d$a;Z)V
    .locals 0

    iput-boolean p1, p0, Ld/r/h/d$a;->b:Z

    return-void
.end method
