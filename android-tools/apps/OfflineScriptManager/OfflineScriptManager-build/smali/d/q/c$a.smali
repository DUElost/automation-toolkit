.class final Ld/q/c$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/q/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "a"
.end annotation


# instance fields
.field private final a:Ld/q/a;

.field private final b:I

.field private c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/q/c;

    return-void
.end method

.method public constructor <init>(Ld/q/a;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ld/q/c$a;->a:Ld/q/a;

    iput p2, p0, Ld/q/c$a;->b:I

    return-void
.end method

.method static synthetic a(Ld/q/c$a;Z)V
    .locals 0

    iput-boolean p1, p0, Ld/q/c$a;->c:Z

    return-void
.end method

.method static synthetic b(Ld/q/c$a;)Z
    .locals 0

    iget-boolean p0, p0, Ld/q/c$a;->c:Z

    return p0
.end method

.method static synthetic c(Ld/q/c$a;)Ld/q/a;
    .locals 0

    iget-object p0, p0, Ld/q/c$a;->a:Ld/q/a;

    return-object p0
.end method

.method static synthetic d(Ld/q/c$a;)I
    .locals 0

    iget p0, p0, Ld/q/c$a;->b:I

    return p0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    :cond_1
    instance-of v2, p1, Ld/q/c$a;

    if-nez v2, :cond_2

    return v1

    :cond_2
    check-cast p1, Ld/q/c$a;

    iget v2, p0, Ld/q/c$a;->b:I

    iget v3, p1, Ld/q/c$a;->b:I

    if-ne v2, v3, :cond_3

    iget-object v2, p0, Ld/q/c$a;->a:Ld/q/a;

    iget-object p1, p1, Ld/q/c$a;->a:Ld/q/a;

    invoke-virtual {v2, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    return v0

    :cond_3
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget v0, p0, Ld/q/c$a;->b:I

    const/16 v1, 0x1f

    add-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v1, p0, Ld/q/c$a;->a:Ld/q/a;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "TimerInfo [id="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Ld/q/c$a;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", sink="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/q/c$a;->a:Ld/q/a;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
