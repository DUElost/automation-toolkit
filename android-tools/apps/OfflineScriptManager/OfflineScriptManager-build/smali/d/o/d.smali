.class public Ld/o/d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/o/a;


# static fields
.field private static final b:Ld/o/a;

.field private static final c:Ld/o/a;


# instance fields
.field public final a:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ld/o/b;

    invoke-direct {v0}, Ld/o/b;-><init>()V

    sput-object v0, Ld/o/d;->b:Ld/o/a;

    new-instance v0, Ld/o/c;

    invoke-direct {v0}, Ld/o/c;-><init>()V

    sput-object v0, Ld/o/d;->c:Ld/o/a;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ld/o/d;->a:I

    return-void
.end method


# virtual methods
.method public a(I)Ld/e;
    .locals 1

    iget v0, p0, Ld/o/d;->a:I

    if-lez v0, :cond_0

    if-le p1, v0, :cond_0

    sget-object v0, Ld/o/d;->b:Ld/o/a;

    :goto_0
    invoke-interface {v0, p1}, Ld/o/a;->a(I)Ld/e;

    move-result-object p1

    return-object p1

    :cond_0
    sget-object v0, Ld/o/d;->c:Ld/o/a;

    goto :goto_0
.end method
