.class public Ld/f;
.super Ljava/lang/Object;
.source ""


# instance fields
.field public final A:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ld/n/j/h/b$a;",
            ">;"
        }
    .end annotation
.end field

.field public B:Ld/n/i/b;

.field public C:Z

.field public D:Ljava/lang/String;

.field public E:Ljava/lang/String;

.field public F:Ljava/lang/String;

.field public G:[B

.field public H:[B

.field public I:[B

.field public J:I

.field public K:Z

.field public L:I

.field public M:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "+",
            "Ld/n/h/e;",
            ">;"
        }
    .end annotation
.end field

.field public N:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "+",
            "Ld/n/h/f;",
            ">;"
        }
    .end annotation
.end field

.field public O:Ld/o/a;

.field public final P:Ld/s/c;

.field public a:I

.field public b:I

.field public c:J

.field public d:B

.field public e:[B

.field f:Ljava/lang/String;

.field public g:I

.field public h:I

.field public i:I

.field public j:I

.field public k:I

.field public l:I

.field public m:I

.field public n:I

.field public o:J

.field p:I

.field public q:Z

.field public r:Z

.field public s:Z

.field public t:Z

.field public u:Z

.field public v:Ljava/lang/String;

.field public w:I

.field public x:I

.field public y:I

.field public z:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Ld/f;->A:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-object v0, Ld/n/i/b;->b:Ld/n/i/b;

    iput-object v0, p0, Ld/f;->B:Ld/n/i/b;

    const-string v1, ""

    iput-object v1, p0, Ld/f;->D:Ljava/lang/String;

    new-instance v1, Ld/s/c;

    invoke-direct {v1}, Ld/s/c;-><init>()V

    iput-object v1, p0, Ld/f;->P:Ld/s/c;

    const/16 v1, 0x3e8

    iput v1, p0, Ld/f;->a:I

    iput v1, p0, Ld/f;->b:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Ld/f;->c:J

    const/4 v1, 0x0

    iput-byte v1, p0, Ld/f;->d:B

    iput v1, p0, Ld/f;->g:I

    iput v1, p0, Ld/f;->h:I

    iput v1, p0, Ld/f;->i:I

    const/4 v2, -0x1

    iput v2, p0, Ld/f;->j:I

    iput v2, p0, Ld/f;->k:I

    const/16 v3, 0x64

    iput v3, p0, Ld/f;->l:I

    iput v1, p0, Ld/f;->m:I

    iput v3, p0, Ld/f;->n:I

    const-wide/16 v3, -0x1

    iput-wide v3, p0, Ld/f;->o:J

    iput v2, p0, Ld/f;->p:I

    iput-boolean v1, p0, Ld/f;->q:Z

    const/4 v3, 0x1

    iput-boolean v3, p0, Ld/f;->r:Z

    iput-boolean v1, p0, Ld/f;->t:Z

    iput-boolean v1, p0, Ld/f;->u:Z

    iput v2, p0, Ld/f;->w:I

    iput v2, p0, Ld/f;->x:I

    iput v2, p0, Ld/f;->y:I

    iput v2, p0, Ld/f;->z:I

    iput-object v0, p0, Ld/f;->B:Ld/n/i/b;

    iput-boolean v1, p0, Ld/f;->C:Z

    iput v1, p0, Ld/f;->J:I

    iput-boolean v1, p0, Ld/f;->K:Z

    const/16 v0, 0x7530

    iput v0, p0, Ld/f;->L:I

    new-array v0, v1, [B

    iput-object v0, p0, Ld/f;->e:[B

    array-length v0, v0

    int-to-byte v0, v0

    iput-byte v0, p0, Ld/f;->d:B

    const/16 v0, 0x20

    new-array v1, v0, [B

    iput-object v1, p0, Ld/f;->G:[B

    new-array v1, v0, [B

    iput-object v1, p0, Ld/f;->H:[B

    new-array v0, v0, [B

    iput-object v0, p0, Ld/f;->I:[B

    new-instance v0, Ld/o/d;

    sget-object v1, Ld/b;->n:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    invoke-direct {v0, v1}, Ld/o/d;-><init>(I)V

    iput-object v0, p0, Ld/f;->O:Ld/o/a;

    return-void
.end method

.method private a(Ljava/lang/Class;)Ld/o/a;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ld/o/a;"
        }
    .end annotation

    :try_start_0
    const-class v0, Ld/o/a;

    invoke-virtual {p1, v0}, Ljava/lang/Class;->asSubclass(Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ld/o/a;
    :try_end_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw v0

    :catch_1
    move-exception p1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method private b(Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Class;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Ljava/lang/Class<",
            "+TT;>;"
        }
    .end annotation

    check-cast p1, Ljava/lang/Class;

    invoke-virtual {p1, p2}, Ljava/lang/Class;->asSubclass(Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object p1

    return-object p1
.end method

.method public static c(ILjava/lang/Object;)Z
    .locals 2

    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_0

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    return p0

    :cond_0
    instance-of v0, p1, Ljava/lang/Integer;

    if-eqz v0, :cond_2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p0

    if-eqz p0, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0

    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, " is neither an integer or a boolean for option "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static d(ILjava/lang/Object;)[B
    .locals 2

    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_0

    check-cast p1, Ljava/lang/String;

    sget-object p0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p1, p0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    return-object p0

    :cond_0
    instance-of v0, p1, [B

    if-eqz v0, :cond_1

    check-cast p1, [B

    return-object p1

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, " is neither a string or an array of bytes for option "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static e(ILjava/lang/Object;)Ljava/lang/String;
    .locals 2

    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_0

    check-cast p1, Ljava/lang/String;

    return-object p1

    :cond_0
    instance-of v0, p1, [B

    if-eqz v0, :cond_1

    new-instance p0, Ljava/lang/String;

    check-cast p1, [B

    sget-object v0, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-direct {p0, p1, v0}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    return-object p0

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string p1, " is neither a string or an array of bytes for option "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private f(ILjava/lang/Object;Ld/s/f;)[B
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/Object;",
            "Ld/s/f<",
            "Ljava/lang/Boolean;",
            ">;)[B"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p2, :cond_0

    sget-object p1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {p3, p1}, Ld/s/f;->b(Ljava/lang/Object;)V

    return-object v0

    :cond_0
    instance-of v1, p2, [B

    const/16 v2, 0x20

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    move-object v1, p2

    check-cast v1, [B

    array-length v4, v1

    if-ne v4, v2, :cond_1

    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p3, p1}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-object p1, p0, Ld/f;->P:Ld/s/c;

    invoke-virtual {p1, v3}, Ld/s/c;->c(I)V

    move-object v0, v1

    goto :goto_1

    :cond_1
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    const/16 v1, 0x28

    if-ne p2, v1, :cond_2

    invoke-static {p1}, Ld/s/h;->a(Ljava/lang/String;)[B

    move-result-object v0

    :goto_0
    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p3, p1}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-object p1, p0, Ld/f;->P:Ld/s/c;

    invoke-virtual {p1, v3}, Ld/s/c;->c(I)V

    goto :goto_1

    :cond_2
    if-ne p2, v2, :cond_3

    sget-object p2, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    goto :goto_0

    :cond_3
    sget-object p1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {p3, p1}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-object p1, p0, Ld/f;->P:Ld/s/c;

    const/16 p2, 0x16

    invoke-virtual {p1, p2}, Ld/s/c;->c(I)V

    :goto_1
    if-eqz v0, :cond_4

    sget-object p1, Ld/n/i/b;->d:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    :cond_4
    return-object v0
.end method


# virtual methods
.method public g(ILjava/lang/Object;)Z
    .locals 5

    new-instance v0, Ld/s/f;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-direct {v0, v1}, Ld/s/f;-><init>(Ljava/lang/Object;)V

    const/4 v1, 0x4

    const/4 v2, 0x1

    if-eq p1, v1, :cond_1e

    const/4 v1, 0x5

    const/16 v3, 0xff

    if-eq p1, v1, :cond_1c

    const/16 v1, 0x8

    if-eq p1, v1, :cond_1b

    const/16 v1, 0x9

    if-eq p1, v1, :cond_1a

    const/16 v1, 0xb

    if-eq p1, v1, :cond_19

    const/16 v1, 0xc

    if-eq p1, v1, :cond_18

    const/16 v1, 0x1b

    if-eq p1, v1, :cond_17

    const/16 v1, 0x1c

    if-eq p1, v1, :cond_16

    const/16 v1, 0x36

    if-eq p1, v1, :cond_15

    const/16 v1, 0x37

    if-eq p1, v1, :cond_13

    const/4 v1, -0x1

    packed-switch p1, :pswitch_data_0

    packed-switch p1, :pswitch_data_1

    const/4 v4, 0x0

    sparse-switch p1, :sswitch_data_0

    packed-switch p1, :pswitch_data_2

    packed-switch p1, :pswitch_data_3

    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Unknown Option "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    :pswitch_0
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ld/f;->v:Ljava/lang/String;

    return v2

    :pswitch_1
    move-object p1, p2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->L:I

    if-ltz p1, :cond_0

    return v2

    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "handshakeIvl only accept positive values "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_2
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    return v2

    :pswitch_3
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    sget-object p1, Ld/n/i/b;->e:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :pswitch_4
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    sget-object p1, Ld/n/i/b;->e:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :pswitch_5
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->C:Z

    sget-object p1, Ld/n/i/b;->e:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :pswitch_6
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    xor-int/2addr p1, v2

    iput-boolean p1, p0, Ld/f;->r:Z

    return v2

    :pswitch_7
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_1

    iget-object p1, p0, Ld/f;->A:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-gt v0, v3, :cond_2

    new-instance p2, Ld/n/j/h/b$a;

    iget-boolean v0, p0, Ld/f;->q:Z

    invoke-direct {p2, p1, v0}, Ld/n/j/h/b$a;-><init>(Ljava/lang/String;Z)V

    iget-object p1, p0, Ld/f;->A:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_0
    return v2

    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "tcp_accept_filter "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_8
    return v4

    :pswitch_9
    move-object p1, p2

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->w:I

    if-eq p1, v1, :cond_4

    if-eqz p1, :cond_4

    if-ne p1, v2, :cond_3

    goto :goto_1

    :cond_3
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "tcpKeepAlive only accepts one of -1,0,1 "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_4
    :goto_1
    return v2

    :sswitch_0
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->r:Z

    return v2

    :sswitch_1
    check-cast p2, Ljava/lang/Integer;

    new-instance p1, Ld/o/d;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    invoke-direct {p1, p2}, Ld/o/d;-><init>(I)V

    iput-object p1, p0, Ld/f;->O:Ld/o/a;

    return v2

    :sswitch_2
    instance-of p1, p2, Ljava/lang/String;

    if-eqz p1, :cond_5

    :try_start_0
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p1

    invoke-direct {p0, p1}, Ld/f;->a(Ljava/lang/Class;)Ld/o/a;

    move-result-object p1

    iput-object p1, p0, Ld/f;->O:Ld/o/a;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    move-exception p1

    new-instance p2, Ljava/lang/IllegalArgumentException;

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw p2

    :cond_5
    instance-of p1, p2, Ljava/lang/Class;

    if-eqz p1, :cond_6

    check-cast p2, Ljava/lang/Class;

    invoke-direct {p0, p2}, Ld/f;->a(Ljava/lang/Class;)Ld/o/a;

    move-result-object p1

    iput-object p1, p0, Ld/f;->O:Ld/o/a;

    return v2

    :cond_6
    instance-of p1, p2, Ld/o/a;

    if-eqz p1, :cond_7

    check-cast p2, Ld/o/a;

    iput-object p2, p0, Ld/f;->O:Ld/o/a;

    return v2

    :cond_7
    return v4

    :sswitch_3
    const-class p1, Ld/n/h/e;

    invoke-direct {p0, p2, p1}, Ld/f;->b(Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object p1

    iput-object p1, p0, Ld/f;->M:Ljava/lang/Class;

    if-nez p1, :cond_8

    return v4

    :cond_8
    iput-boolean v2, p0, Ld/f;->u:Z

    return v2

    :sswitch_4
    const-class p1, Ld/n/h/f;

    invoke-direct {p0, p2, p1}, Ld/f;->b(Ljava/lang/Object;Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object p1

    iput-object p1, p0, Ld/f;->N:Ljava/lang/Class;

    if-nez p1, :cond_9

    return v4

    :cond_9
    iput-boolean v2, p0, Ld/f;->u:Z

    return v2

    :sswitch_5
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->i:I

    return v2

    :sswitch_6
    invoke-direct {p0, p1, p2, v0}, Ld/f;->f(ILjava/lang/Object;Ld/s/f;)[B

    move-result-object p1

    iput-object p1, p0, Ld/f;->I:[B

    if-nez p1, :cond_a

    iput-boolean v4, p0, Ld/f;->C:Z

    :cond_a
    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :sswitch_7
    invoke-direct {p0, p1, p2, v0}, Ld/f;->f(ILjava/lang/Object;Ld/s/f;)[B

    move-result-object p1

    iput-object p1, p0, Ld/f;->H:[B

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :sswitch_8
    invoke-direct {p0, p1, p2, v0}, Ld/f;->f(ILjava/lang/Object;Ld/s/f;)[B

    move-result-object p1

    iput-object p1, p0, Ld/f;->G:[B

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1

    :sswitch_9
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->C:Z

    if-eqz p1, :cond_b

    sget-object p1, Ld/n/i/b;->d:Ld/n/i/b;

    goto :goto_2

    :cond_b
    sget-object p1, Ld/n/i/b;->b:Ld/n/i/b;

    :goto_2
    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :sswitch_a
    if-nez p2, :cond_c

    sget-object p1, Ld/n/i/b;->b:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    iput-boolean v4, p0, Ld/f;->C:Z

    return v2

    :cond_c
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ld/f;->F:Ljava/lang/String;

    iput-boolean v4, p0, Ld/f;->C:Z

    sget-object p1, Ld/n/i/b;->c:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :sswitch_b
    if-nez p2, :cond_d

    sget-object p1, Ld/n/i/b;->b:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    iput-boolean v4, p0, Ld/f;->C:Z

    return v2

    :cond_d
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Ld/f;->E:Ljava/lang/String;

    iput-boolean v4, p0, Ld/f;->C:Z

    sget-object p1, Ld/n/i/b;->c:Ld/n/i/b;

    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :sswitch_c
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->C:Z

    if-eqz p1, :cond_e

    sget-object p1, Ld/n/i/b;->c:Ld/n/i/b;

    goto :goto_3

    :cond_e
    sget-object p1, Ld/n/i/b;->b:Ld/n/i/b;

    :goto_3
    iput-object p1, p0, Ld/f;->B:Ld/n/i/b;

    return v2

    :sswitch_d
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->q:Z

    return v2

    :sswitch_e
    const/16 v0, 0x2a

    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    xor-int/2addr p1, v2

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Ld/f;->g(ILjava/lang/Object;)Z

    move-result p1

    return p1

    :pswitch_a
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    return v2

    :pswitch_b
    move-object p1, p2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->b:I

    if-ltz p1, :cond_f

    return v2

    :cond_f
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "recvHwm "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_c
    move-object p1, p2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->a:I

    if-ltz p1, :cond_10

    return v2

    :cond_10
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "sendHwm "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_d
    check-cast p2, Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide p1

    iput-wide p1, p0, Ld/f;->o:J

    return v2

    :pswitch_e
    move-object p1, p2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->m:I

    if-ltz p1, :cond_11

    return v2

    :cond_11
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "reconnectIvlMax "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_f
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->n:I

    return v2

    :pswitch_10
    move-object p1, p2

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->l:I

    if-lt p1, v1, :cond_12

    return v2

    :cond_12
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "reconnectIvl "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_11
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->k:I

    return v2

    :cond_13
    invoke-static {p1, p2}, Ld/f;->e(ILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_14

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x100

    if-ge v0, v1, :cond_14

    iput-object p1, p0, Ld/f;->D:Ljava/lang/String;

    return v2

    :cond_14
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "zap domain length shall be < 256 : "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_15
    invoke-static {p1, p2}, Ld/f;->c(ILjava/lang/Object;)Z

    move-result p1

    iput-boolean p1, p0, Ld/f;->K:Z

    return v2

    :cond_16
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->p:I

    return v2

    :cond_17
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    return v2

    :cond_18
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->h:I

    return v2

    :cond_19
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Ld/f;->g:I

    return v2

    :cond_1a
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    return v2

    :cond_1b
    check-cast p2, Ljava/lang/Integer;

    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    return v2

    :cond_1c
    invoke-static {p1, p2}, Ld/f;->d(ILjava/lang/Object;)[B

    move-result-object p1

    if-eqz p1, :cond_1d

    array-length v0, p1

    if-gt v0, v3, :cond_1d

    array-length p2, p1

    invoke-static {p1, p2}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object p1

    iput-object p1, p0, Ld/f;->e:[B

    array-length p1, p1

    int-to-byte p1, p1

    iput-byte p1, p0, Ld/f;->d:B

    return v2

    :cond_1d
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "identity must not be null or less than 255 "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1e
    check-cast p2, Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide p1

    iput-wide p1, p0, Ld/f;->c:J

    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x11
        :pswitch_11
        :pswitch_10
        :pswitch_f
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x15
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
    .end packed-switch

    :sswitch_data_0
    .sparse-switch
        0x1f -> :sswitch_e
        0x2a -> :sswitch_d
        0x2c -> :sswitch_c
        0x2d -> :sswitch_b
        0x2e -> :sswitch_a
        0x2f -> :sswitch_9
        0x30 -> :sswitch_8
        0x31 -> :sswitch_7
        0x32 -> :sswitch_6
        0x39 -> :sswitch_5
        0x3e9 -> :sswitch_4
        0x3ea -> :sswitch_3
        0x3eb -> :sswitch_2
        0x3ec -> :sswitch_1
        0x40f -> :sswitch_0
    .end sparse-switch

    :pswitch_data_2
    .packed-switch 0x22
        :pswitch_9
        :pswitch_8
        :pswitch_8
        :pswitch_8
        :pswitch_7
        :pswitch_6
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x3e
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
