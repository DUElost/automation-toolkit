.class Ld/p/f$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/p/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field final a:[Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[TT;"
        }
    .end annotation
.end field

.field final b:[I

.field c:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field

.field d:Ld/p/f$a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/p/f$a<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(II)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-array v0, p1, [Ljava/lang/Object;

    iput-object v0, p0, Ld/p/f$a;->a:[Ljava/lang/Object;

    new-array p1, p1, [I

    iput-object p1, p0, Ld/p/f$a;->b:[I

    const/4 p1, 0x0

    :goto_0
    iget-object v0, p0, Ld/p/f$a;->a:[Ljava/lang/Object;

    array-length v0, v0

    if-ne p1, v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/p/f$a;->b:[I

    aput p2, v0, p1

    add-int/lit8 p2, p2, 0x1

    add-int/lit8 p1, p1, 0x1

    goto :goto_0
.end method
