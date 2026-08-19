.class public final Ld/q/b$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/q/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "a"
.end annotation


# instance fields
.field private final a:Ljava/nio/channels/SelectableChannel;

.field private final b:Ld/q/a;

.field private c:I

.field private d:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Ld/q/b;

    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SelectableChannel;Ld/q/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    iput-object p2, p0, Ld/q/b$a;->b:Ld/q/a;

    return-void
.end method

.method static synthetic a(Ld/q/b$a;Z)V
    .locals 0

    iput-boolean p1, p0, Ld/q/b$a;->d:Z

    return-void
.end method

.method static synthetic b(Ld/q/b$a;)I
    .locals 0

    iget p0, p0, Ld/q/b$a;->c:I

    return p0
.end method

.method static synthetic c(Ld/q/b$a;I)V
    .locals 0

    iput p1, p0, Ld/q/b$a;->c:I

    return-void
.end method

.method static synthetic d(Ld/q/b$a;)Ljava/nio/channels/SelectableChannel;
    .locals 0

    iget-object p0, p0, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    return-object p0
.end method

.method static synthetic e(Ld/q/b$a;)Z
    .locals 0

    iget-boolean p0, p0, Ld/q/b$a;->d:Z

    return p0
.end method

.method static synthetic f(Ld/q/b$a;)Ld/q/a;
    .locals 0

    iget-object p0, p0, Ld/q/b$a;->b:Ld/q/a;

    return-object p0
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
    instance-of v2, p1, Ld/q/b$a;

    if-nez v2, :cond_2

    return v1

    :cond_2
    check-cast p1, Ld/q/b$a;

    iget-object v2, p0, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    iget-object v3, p1, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Ld/q/b$a;->b:Ld/q/a;

    iget-object p1, p1, Ld/q/b$a;->b:Ld/q/a;

    invoke-virtual {v2, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    return v0

    :cond_3
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    const/16 v1, 0x1f

    add-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-object v1, p0, Ld/q/b$a;->b:Ld/q/a;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Handle-"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ld/q/b$a;->a:Ljava/nio/channels/SelectableChannel;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
