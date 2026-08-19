.class public Ld/n/g;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/b;
.implements Ld/q/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/n/g$a;,
        Ld/n/g$b;,
        Ld/n/g$c;,
        Ld/n/g$d;,
        Ld/n/g$e;,
        Ld/n/g$f;,
        Ld/n/g$g;,
        Ld/n/g$h;,
        Ld/n/g$i;,
        Ld/n/g$j;,
        Ld/n/g$k;
    }
.end annotation


# instance fields
.field private A:Z

.field private B:Z

.field private C:Ld/j;

.field private D:Ld/n/j/a;

.field private final E:Ld/s/c;

.field private final F:Ld/n/g$e;

.field private final G:Ld/n/g$e;

.field private final H:Ld/n/g$e;

.field private final I:Ld/n/g$e;

.field private final J:Ld/n/g$e;

.field private final K:Ld/n/g$e;

.field private final L:Ld/n/g$e;

.field private final M:Ld/n/g$e;

.field private final N:Ld/n/g$e;

.field private final O:Ld/n/g$e;

.field private b:Ld/n/c;

.field private c:Ljava/nio/channels/SocketChannel;

.field private d:Ld/q/b$a;

.field private e:Ljava/nio/ByteBuffer;

.field private f:I

.field private g:Ld/n/h/e;

.field private final h:Ld/s/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ld/s/f<",
            "Ljava/nio/ByteBuffer;",
            ">;"
        }
    .end annotation
.end field

.field private i:I

.field private j:Ld/n/h/f;

.field private k:Ld/n/e;

.field private l:Z

.field private m:I

.field private final n:Ljava/nio/ByteBuffer;

.field private final o:Ljava/nio/ByteBuffer;

.field private p:Ld/n/g$f;

.field private q:Ld/n/f;

.field private r:Ld/f;

.field private s:Ljava/lang/String;

.field private t:Z

.field private u:Ld/n/g$e;

.field private v:Ld/n/g$e;

.field private w:Z

.field private x:Z

.field private y:Ld/n/i/a;

.field private z:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SocketChannel;Ld/f;Ljava/lang/String;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ld/n/g$d;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Ld/n/g$d;-><init>(Ld/n/g;Ld/n/g$d;)V

    iput-object v0, p0, Ld/n/g;->F:Ld/n/g$e;

    new-instance v2, Ld/n/g$c;

    invoke-direct {v2, p0, v1}, Ld/n/g$c;-><init>(Ld/n/g;Ld/n/g$c;)V

    iput-object v2, p0, Ld/n/g;->G:Ld/n/g$e;

    iput-object v2, p0, Ld/n/g;->H:Ld/n/g$e;

    new-instance v2, Ld/n/g$h;

    invoke-direct {v2, p0, v1}, Ld/n/g$h;-><init>(Ld/n/g;Ld/n/g$h;)V

    iput-object v2, p0, Ld/n/g;->I:Ld/n/g$e;

    iput-object v2, p0, Ld/n/g;->J:Ld/n/g$e;

    new-instance v2, Ld/n/g$j;

    invoke-direct {v2, p0, v1}, Ld/n/g$j;-><init>(Ld/n/g;Ld/n/g$j;)V

    iput-object v2, p0, Ld/n/g;->K:Ld/n/g$e;

    new-instance v2, Ld/n/g$k;

    invoke-direct {v2, p0, v1}, Ld/n/g$k;-><init>(Ld/n/g;Ld/n/g$k;)V

    iput-object v2, p0, Ld/n/g;->L:Ld/n/g$e;

    new-instance v2, Ld/n/g$g;

    invoke-direct {v2, p0, v1}, Ld/n/g$g;-><init>(Ld/n/g;Ld/n/g$g;)V

    iput-object v2, p0, Ld/n/g;->M:Ld/n/g$e;

    new-instance v2, Ld/n/g$a;

    invoke-direct {v2, p0, v1}, Ld/n/g$a;-><init>(Ld/n/g;Ld/n/g$a;)V

    iput-object v2, p0, Ld/n/g;->N:Ld/n/g$e;

    new-instance v2, Ld/n/g$i;

    invoke-direct {v2, p0, v1}, Ld/n/g$i;-><init>(Ld/n/g;Ld/n/g$i;)V

    iput-object v2, p0, Ld/n/g;->O:Ld/n/g$e;

    iget-object v1, p2, Ld/f;->P:Ld/s/c;

    iput-object v1, p0, Ld/n/g;->E:Ld/s/c;

    iput-object p1, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    const/4 v1, 0x1

    iput-boolean v1, p0, Ld/n/g;->l:Z

    const/16 v2, 0xc

    iput v2, p0, Ld/n/g;->m:I

    iput-object p2, p0, Ld/n/g;->r:Ld/f;

    iput-object p3, p0, Ld/n/g;->s:Ljava/lang/String;

    iput-object v0, p0, Ld/n/g;->u:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->v:Ld/n/g$e;

    new-instance p2, Ld/s/f;

    invoke-direct {p2}, Ld/s/f;-><init>()V

    iput-object p2, p0, Ld/n/g;->h:Ld/s/f;

    const/16 p2, 0x40

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p3

    iput-object p3, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    iput-object p2, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    :try_start_0
    new-array p2, v1, [Ljava/nio/channels/SelectableChannel;

    const/4 p3, 0x0

    iget-object v0, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    aput-object v0, p2, p3

    invoke-static {p2}, Ld/s/e;->f([Ljava/nio/channels/SelectableChannel;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-static {p1}, Ld/s/e;->a(Ljava/nio/channels/SocketChannel;)Ld/n/j/a;

    move-result-object p1

    iput-object p1, p0, Ld/n/g;->D:Ld/n/j/a;

    return-void

    :catch_0
    move-exception p1

    new-instance p2, Ld/k$b;

    invoke-direct {p2, p1}, Ld/k$b;-><init>(Ljava/io/IOException;)V

    throw p2
.end method

.method private A(Ld/n/g$b;)V
    .locals 3

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-boolean v0, v0, Ld/f;->u:Z

    if-eqz v0, :cond_0

    new-instance v0, Ld/e;

    invoke-direct {v0}, Ld/e;-><init>()V

    iget-object v1, p0, Ld/n/g;->v:Ld/n/g$e;

    invoke-interface {v1, v0}, Ld/n/g$e;->a(Ld/e;)Z

    :cond_0
    iget-object v0, p0, Ld/n/g;->C:Ld/j;

    iget-object v1, p0, Ld/n/g;->s:Ljava/lang/String;

    iget-object v2, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, v1, v2}, Ld/j;->Z0(Ljava/lang/String;Ljava/nio/channels/SelectableChannel;)V

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0, p1}, Ld/n/f;->L0(Ld/n/g$b;)V

    invoke-direct {p0}, Ld/n/g;->N()V

    invoke-virtual {p0}, Ld/n/g;->z()V

    return-void
.end method

.method private B()Z
    .locals 15

    :goto_0
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    iget v1, p0, Ld/n/g;->m:I

    const/16 v2, 0xc

    const/16 v3, 0x40

    const/16 v4, 0x9

    const/16 v5, 0xff

    const/16 v6, 0xa

    const/4 v7, 0x1

    const/4 v8, 0x0

    if-lt v0, v1, :cond_0

    goto :goto_2

    :cond_0
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-direct {p0, v0}, Ld/n/g;->L(Ljava/nio/ByteBuffer;)I

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Ld/n/g$b;->c:Ld/n/g$b;

    :goto_1
    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    return v8

    :cond_1
    const/4 v1, -0x1

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ld/s/c;->b(I)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Ld/n/g$b;->c:Ld/n/g$b;

    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    :cond_2
    return v8

    :cond_3
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/2addr v0, v5

    if-eq v0, v5, :cond_4

    goto :goto_2

    :cond_4
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    if-ge v0, v6, :cond_5

    goto :goto_0

    :cond_5
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/2addr v0, v7

    if-eq v0, v7, :cond_14

    :goto_2
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/2addr v0, v5

    if-ne v0, v5, :cond_d

    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/2addr v0, v7

    if-nez v0, :cond_6

    goto/16 :goto_5

    :cond_6
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    sget-object v1, Ld/n/g$f;->d:Ld/n/g$f;

    invoke-static {v1}, Ld/n/g$f;->a(Ld/n/g$f;)B

    move-result v4

    if-ne v0, v4, :cond_9

    iput-object v1, p0, Ld/n/g;->p:Ld/n/g$f;

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->W0()Z

    move-result v0

    if-eqz v0, :cond_8

    :cond_7
    :goto_3
    sget-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    goto :goto_1

    :cond_8
    new-instance v0, Ld/n/h/h/b;

    iget-object v1, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v2, Ld/b;->g:Ld/b;

    invoke-virtual {v2}, Ld/b;->a()I

    move-result v2

    invoke-direct {v0, v1, v2}, Ld/n/h/h/b;-><init>(Ld/s/c;I)V

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    new-instance v0, Ld/n/h/h/a;

    iget-object v10, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v1, Ld/b;->f:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v11

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-wide v12, v1, Ld/f;->o:J

    iget-object v14, v1, Ld/f;->O:Ld/o/a;

    move-object v9, v0

    invoke-direct/range {v9 .. v14}, Ld/n/h/h/a;-><init>(Ld/s/c;IJLd/o/a;)V

    :goto_4
    iput-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    goto/16 :goto_8

    :cond_9
    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    sget-object v1, Ld/n/g$f;->e:Ld/n/g$f;

    invoke-static {v1}, Ld/n/g$f;->a(Ld/n/g$f;)B

    move-result v4

    if-ne v0, v4, :cond_b

    iput-object v1, p0, Ld/n/g;->p:Ld/n/g$f;

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->W0()Z

    move-result v0

    if-eqz v0, :cond_a

    goto :goto_3

    :cond_a
    new-instance v0, Ld/n/h/i/b;

    iget-object v1, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v2, Ld/b;->g:Ld/b;

    invoke-virtual {v2}, Ld/b;->a()I

    move-result v2

    invoke-direct {v0, v1, v2}, Ld/n/h/i/b;-><init>(Ld/s/c;I)V

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    new-instance v0, Ld/n/h/i/a;

    iget-object v10, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v1, Ld/b;->f:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v11

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-wide v12, v1, Ld/f;->o:J

    iget-object v14, v1, Ld/f;->O:Ld/o/a;

    move-object v9, v0

    invoke-direct/range {v9 .. v14}, Ld/n/h/i/a;-><init>(Ld/s/c;IJLd/o/a;)V

    goto :goto_4

    :cond_b
    sget-object v0, Ld/n/g$f;->f:Ld/n/g$f;

    iput-object v0, p0, Ld/n/g;->p:Ld/n/g$f;

    new-instance v0, Ld/n/h/i/b;

    iget-object v1, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v4, Ld/b;->g:Ld/b;

    invoke-virtual {v4}, Ld/b;->a()I

    move-result v4

    invoke-direct {v0, v1, v4}, Ld/n/h/i/b;-><init>(Ld/s/c;I)V

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    new-instance v0, Ld/n/h/i/a;

    iget-object v10, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v1, Ld/b;->f:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v11

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-wide v12, v1, Ld/f;->o:J

    iget-object v14, v1, Ld/f;->O:Ld/o/a;

    move-object v9, v0

    invoke-direct/range {v9 .. v14}, Ld/n/h/i/a;-><init>(Ld/s/c;IJLd/o/a;)V

    iput-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-object v0, v0, Ld/f;->B:Ld/n/i/b;

    if-nez v0, :cond_c

    goto/16 :goto_3

    :cond_c
    iget-object v1, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ld/n/i/b;->b(Ljava/nio/ByteBuffer;)Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-object v1, v0, Ld/f;->B:Ld/n/i/b;

    iget-object v2, p0, Ld/n/g;->q:Ld/n/f;

    iget-object v4, p0, Ld/n/g;->D:Ld/n/j/a;

    invoke-virtual {v1, v2, v4, v0}, Ld/n/i/b;->a(Ld/n/f;Ld/n/j/a;Ld/f;)Ld/n/i/a;

    move-result-object v0

    iput-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    iget-object v0, p0, Ld/n/g;->H:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->u:Ld/n/g$e;

    iget-object v0, p0, Ld/n/g;->G:Ld/n/g$e;

    goto/16 :goto_7

    :cond_d
    :goto_5
    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->W0()Z

    move-result v0

    if-eqz v0, :cond_e

    goto/16 :goto_3

    :cond_e
    sget-object v0, Ld/n/g$f;->c:Ld/n/g$f;

    iput-object v0, p0, Ld/n/g;->p:Ld/n/g$f;

    new-instance v0, Ld/n/h/h/b;

    iget-object v1, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v2, Ld/b;->g:Ld/b;

    invoke-virtual {v2}, Ld/b;->a()I

    move-result v2

    invoke-direct {v0, v1, v2}, Ld/n/h/h/b;-><init>(Ld/s/c;I)V

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    new-instance v0, Ld/n/h/h/a;

    iget-object v10, p0, Ld/n/g;->E:Ld/s/c;

    sget-object v1, Ld/b;->f:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v11

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-wide v12, v1, Ld/f;->o:J

    iget-object v14, v1, Ld/f;->O:Ld/o/a;

    move-object v9, v0

    invoke-direct/range {v9 .. v14}, Ld/n/h/h/a;-><init>(Ld/s/c;IJLd/o/a;)V

    iput-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-byte v0, v0, Ld/f;->d:B

    add-int/2addr v0, v7

    if-lt v0, v5, :cond_f

    goto :goto_6

    :cond_f
    const/4 v6, 0x2

    :goto_6
    invoke-static {v6}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    new-instance v1, Ld/e;

    iget-object v2, p0, Ld/n/g;->r:Ld/f;

    iget-byte v2, v2, Ld/f;->d:B

    invoke-direct {v1, v2}, Ld/e;-><init>(I)V

    iget-object v2, p0, Ld/n/g;->r:Ld/f;

    iget-object v5, v2, Ld/f;->e:[B

    iget-byte v2, v2, Ld/f;->d:B

    invoke-virtual {v1, v5, v8, v2}, Ld/e;->v([BII)Ld/e;

    iget-object v2, p0, Ld/n/g;->j:Ld/n/h/f;

    invoke-interface {v2, v1}, Ld/n/h/f;->c(Ld/e;)V

    new-instance v1, Ld/s/f;

    invoke-direct {v1, v0}, Ld/s/f;-><init>(Ljava/lang/Object;)V

    iget-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    invoke-interface {v0, v1, v6}, Ld/n/h/f;->b(Ld/s/f;I)I

    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    iget-object v0, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    iput-object v0, p0, Ld/n/g;->e:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v0

    iput v0, p0, Ld/n/g;->f:I

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget v0, v0, Ld/f;->j:I

    if-eq v0, v7, :cond_10

    if-ne v0, v4, :cond_11

    :cond_10
    iput-boolean v7, p0, Ld/n/g;->x:Z

    :cond_11
    iget-object v0, p0, Ld/n/g;->J:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->u:Ld/n/g$e;

    iget-object v0, p0, Ld/n/g;->F:Ld/n/g$e;

    :goto_7
    iput-object v0, p0, Ld/n/g;->v:Ld/n/g$e;

    :goto_8
    iget v0, p0, Ld/n/g;->i:I

    if-nez v0, :cond_12

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->n(Ld/q/b$a;)V

    :cond_12
    iput-boolean v8, p0, Ld/n/g;->l:Z

    iget-boolean v0, p0, Ld/n/g;->B:Z

    if-eqz v0, :cond_13

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    invoke-virtual {v0, v3}, Ld/n/c;->d(I)V

    iput-boolean v8, p0, Ld/n/g;->B:Z

    :cond_13
    iget-object v0, p0, Ld/n/g;->C:Ld/j;

    iget-object v1, p0, Ld/n/g;->s:Ljava/lang/String;

    iget-object v2, p0, Ld/n/g;->p:Ld/n/g$f;

    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Ld/j;->a1(Ljava/lang/String;I)V

    return v7

    :cond_14
    iget-object v0, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    const/16 v4, 0xb

    if-ne v1, v6, :cond_16

    iget v1, p0, Ld/n/g;->i:I

    if-nez v1, :cond_15

    iget-object v1, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v5, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v1, v5}, Ld/n/c;->n(Ld/q/b$a;)V

    :cond_15
    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    sget-object v5, Ld/n/g$f;->f:Ld/n/g$f;

    invoke-static {v5}, Ld/n/g$f;->a(Ld/n/g$f;)B

    move-result v5

    invoke-virtual {v1, v6, v5}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v7

    iput v1, p0, Ld/n/g;->i:I

    :cond_16
    iget-object v1, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    if-le v1, v6, :cond_1a

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    if-ne v1, v4, :cond_1a

    iget v1, p0, Ld/n/g;->i:I

    if-nez v1, :cond_17

    iget-object v1, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v5, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v1, v5}, Ld/n/c;->n(Ld/q/b$a;)V

    :cond_17
    iget-object v1, p0, Ld/n/g;->n:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    sget-object v5, Ld/n/g$f;->d:Ld/n/g$f;

    invoke-static {v5}, Ld/n/g$f;->a(Ld/n/g$f;)B

    move-result v5

    if-eq v1, v5, :cond_19

    sget-object v5, Ld/n/g$f;->e:Ld/n/g$f;

    invoke-static {v5}, Ld/n/g$f;->a(Ld/n/g$f;)B

    move-result v5

    if-ne v1, v5, :cond_18

    goto :goto_9

    :cond_18
    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v8}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v7

    iput v1, p0, Ld/n/g;->i:I

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->mark()Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    const/16 v2, 0x14

    new-array v4, v2, [B

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->reset()Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    iget-object v4, p0, Ld/n/g;->r:Ld/f;

    iget-object v4, v4, Ld/f;->B:Ld/n/i/b;

    invoke-virtual {v4}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->reset()Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->position()I

    move-result v4

    add-int/2addr v4, v2

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v2

    iput v1, p0, Ld/n/g;->i:I

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    const/16 v2, 0x20

    new-array v4, v2, [B

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v2

    iput v1, p0, Ld/n/g;->i:I

    iput v3, p0, Ld/n/g;->m:I

    goto :goto_a

    :cond_19
    :goto_9
    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    iget-object v2, p0, Ld/n/g;->r:Ld/f;

    iget v2, v2, Ld/f;->j:I

    int-to-byte v2, v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v7

    iput v1, p0, Ld/n/g;->i:I

    :cond_1a
    :goto_a
    iget-object v1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    goto/16 :goto_0
.end method

.method private C()Ld/e;
    .locals 4

    new-instance v0, Ld/e;

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-byte v1, v1, Ld/f;->d:B

    invoke-direct {v0, v1}, Ld/e;-><init>(I)V

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-byte v2, v1, Ld/f;->d:B

    if-lez v2, :cond_0

    iget-object v1, v1, Ld/f;->e:[B

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ld/e;->v([BII)Ld/e;

    :cond_0
    iget-object v1, p0, Ld/n/g;->J:Ld/n/g$e;

    iput-object v1, p0, Ld/n/g;->u:Ld/n/g$e;

    return-object v0
.end method

.method private D(Ljava/lang/Class;IJ)Ljava/lang/Object;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;IJ)",
            "Ljava/lang/Object;"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x2

    :try_start_0
    new-array v2, v1, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const/4 v5, 0x1

    aput-object v3, v2, v5

    invoke-virtual {p1, v2}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object p1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, v1, v4

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    aput-object p2, v1, v5

    invoke-virtual {p1, v1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-object v0
.end method

.method private E()V
    .locals 3

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-boolean v0, v0, Ld/f;->t:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0}, Ld/n/i/a;->p()Ld/e;

    move-result-object v0

    iget-object v1, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v1, v0}, Ld/n/f;->P0(Ld/e;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ld/s/c;->b(I)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    :cond_1
    iget-object v0, p0, Ld/n/g;->M:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->u:Ld/n/g$e;

    iget-object v0, p0, Ld/n/g;->L:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->v:Ld/n/g$e;

    new-instance v0, Ld/n/e;

    invoke-direct {v0}, Ld/n/e;-><init>()V

    iput-object v0, p0, Ld/n/g;->k:Ld/n/e;

    iget-object v0, p0, Ld/n/g;->D:Ld/n/j/a;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ld/n/j/a;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    iget-object v1, p0, Ld/n/g;->D:Ld/n/j/a;

    invoke-virtual {v1}, Ld/n/j/a;->a()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Peer-Address"

    invoke-virtual {v0, v2, v1}, Ld/n/e;->d(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    iget-object v1, p0, Ld/n/g;->y:Ld/n/i/a;

    iget-object v1, v1, Ld/n/i/a;->d:Ld/n/e;

    invoke-virtual {v0, v1}, Ld/n/e;->e(Ld/n/e;)V

    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    iget-object v1, p0, Ld/n/g;->y:Ld/n/i/a;

    iget-object v1, v1, Ld/n/i/a;->e:Ld/n/e;

    invoke-virtual {v0, v1}, Ld/n/e;->e(Ld/n/e;)V

    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    invoke-virtual {v0}, Ld/n/e;->b()Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/g;->k:Ld/n/e;

    :cond_3
    return-void
.end method

.method private F()Ld/e;
    .locals 3

    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0}, Ld/n/i/a;->y()Ld/n/i/a$b;

    move-result-object v0

    sget-object v1, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    if-ne v0, v1, :cond_0

    invoke-direct {p0}, Ld/n/g;->E()V

    iget-object v0, p0, Ld/n/g;->M:Ld/n/g$e;

    invoke-interface {v0}, Ld/n/g$e;->b()Ld/e;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0}, Ld/n/i/a;->y()Ld/n/i/a$b;

    move-result-object v0

    sget-object v1, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    const v1, 0x9523e34

    :goto_0
    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V

    return-object v2

    :cond_1
    new-instance v0, Ld/e$a;

    invoke-direct {v0}, Ld/e$a;-><init>()V

    iget-object v1, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v1, v0}, Ld/n/i/a;->m(Ld/e;)I

    move-result v1

    if-nez v1, :cond_2

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ld/e$a;->y(I)V

    invoke-virtual {v0}, Ld/e$a;->D()Ld/e;

    move-result-object v0

    return-object v0

    :cond_2
    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    goto :goto_0
.end method

.method private G(Ld/e;)Z
    .locals 3

    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0, p1}, Ld/n/i/a;->q(Ld/e;)I

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_2

    iget-object v1, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v1}, Ld/n/i/a;->y()Ld/n/i/a$b;

    move-result-object v1

    sget-object v2, Ld/n/i/a$b;->c:Ld/n/i/a$b;

    if-ne v1, v2, :cond_0

    invoke-direct {p0}, Ld/n/g;->E()V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v1}, Ld/n/i/a;->y()Ld/n/i/a$b;

    move-result-object v1

    sget-object v2, Ld/n/i/a$b;->d:Ld/n/i/a$b;

    if-ne v1, v2, :cond_1

    iget-object p1, p0, Ld/n/g;->E:Ld/s/c;

    const v1, 0x9523e34

    invoke-virtual {p1, v1}, Ld/s/c;->c(I)V

    return v0

    :cond_1
    :goto_0
    iget-boolean v1, p0, Ld/n/g;->A:Z

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Ld/n/g;->f()V

    goto :goto_1

    :cond_2
    iget-object v1, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v1, p1}, Ld/s/c;->c(I)V

    :cond_3
    :goto_1
    if-nez p1, :cond_4

    const/4 p1, 0x1

    return p1

    :cond_4
    return v0
.end method

.method private H(Ld/e;)Z
    .locals 2

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-boolean v0, v0, Ld/f;->t:Z

    if-eqz v0, :cond_0

    const/16 v0, 0x40

    invoke-virtual {p1, v0}, Ld/e;->y(I)V

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0, p1}, Ld/n/f;->P0(Ld/e;)Z

    :cond_0
    iget-boolean p1, p0, Ld/n/g;->x:Z

    const/4 v0, 0x1

    if-eqz p1, :cond_1

    new-instance p1, Ld/e;

    invoke-direct {p1, v0}, Ld/e;-><init>(I)V

    invoke-virtual {p1, v0}, Ld/e;->p(B)Ld/e;

    iget-object v1, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v1, p1}, Ld/n/f;->P0(Ld/e;)Z

    :cond_1
    iget-object p1, p0, Ld/n/g;->I:Ld/n/g$e;

    iput-object p1, p0, Ld/n/g;->v:Ld/n/g$e;

    return v0
.end method

.method private I()Ld/e;
    .locals 1

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->O0()Ld/e;

    move-result-object v0

    return-object v0
.end method

.method private J(Ld/e;)Z
    .locals 1

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0, p1}, Ld/n/f;->P0(Ld/e;)Z

    move-result p1

    return p1
.end method

.method private K(Ld/e;)Z
    .locals 2

    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ld/e;->h()Ld/n/e;

    move-result-object v1

    invoke-virtual {v0, v1}, Ld/n/e;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/g;->k:Ld/n/e;

    invoke-virtual {p1, v0}, Ld/e;->z(Ld/n/e;)Ld/e;

    :cond_0
    invoke-direct {p0, p1}, Ld/n/g;->J(Ld/e;)Z

    move-result p1

    return p1
.end method

.method private L(Ljava/nio/ByteBuffer;)I
    .locals 3

    const/16 v0, 0x39

    const/4 v1, -0x1

    :try_start_0
    iget-object v2, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v2, p1}, Ljava/nio/channels/SocketChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result p1

    if-ne p1, v1, :cond_0

    iget-object v2, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v2, v0}, Ld/s/c;->c(I)V

    goto :goto_0

    :cond_0
    if-nez p1, :cond_1

    iget-object v2, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v2}, Ljava/nio/channels/SocketChannel;->isBlocking()Z

    move-result v2

    if-nez v2, :cond_1

    iget-object p1, p0, Ld/n/g;->E:Ld/s/c;

    const/16 v2, 0x23

    invoke-virtual {p1, v2}, Ld/s/c;->c(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_1
    :goto_0
    move v1, p1

    goto :goto_1

    :catch_0
    iget-object p1, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    :goto_1
    return v1
.end method

.method private M()V
    .locals 4

    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-boolean v1, v0, Ld/f;->u:Z

    if-nez v1, :cond_0

    iget v0, v0, Ld/f;->L:I

    if-lez v0, :cond_0

    iget-object v1, p0, Ld/n/g;->b:Ld/n/c;

    int-to-long v2, v0

    const/16 v0, 0x40

    invoke-virtual {v1, v2, v3, v0}, Ld/n/c;->c(JI)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/g;->B:Z

    :cond_0
    return-void
.end method

.method private N()V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/g;->t:Z

    iget-boolean v1, p0, Ld/n/g;->B:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Ld/n/g;->b:Ld/n/c;

    const/16 v2, 0x40

    invoke-virtual {v1, v2}, Ld/n/c;->d(I)V

    iput-boolean v0, p0, Ld/n/g;->B:Z

    :cond_0
    iget-boolean v0, p0, Ld/n/g;->w:Z

    const/4 v1, 0x0

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v2, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v2}, Ld/n/c;->g(Ld/q/b$a;)V

    iput-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    :cond_1
    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    invoke-virtual {v0}, Ld/n/c;->o()V

    iput-object v1, p0, Ld/n/g;->q:Ld/n/f;

    return-void
.end method

.method private O(Ljava/nio/ByteBuffer;)I
    .locals 2

    :try_start_0
    iget-object v0, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    invoke-virtual {v0, p1}, Ljava/nio/channels/SocketChannel;->write(Ljava/nio/ByteBuffer;)I

    move-result p1

    if-nez p1, :cond_0

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    const/16 v1, 0x23

    invoke-virtual {v0, v1}, Ld/s/c;->c(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object p1, p0, Ld/n/g;->E:Ld/s/c;

    const/16 v0, 0x39

    invoke-virtual {p1, v0}, Ld/s/c;->c(I)V

    const/4 p1, -0x1

    :cond_0
    :goto_0
    return p1
.end method

.method private P(Ld/e;)Z
    .locals 4

    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0}, Ld/n/i/a;->l()Ld/s/a;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ld/s/a;->e()I

    move-result v1

    if-lez v1, :cond_0

    new-instance v1, Ld/e;

    invoke-virtual {v0}, Ld/s/a;->e()I

    move-result v2

    invoke-direct {v1, v2}, Ld/e;-><init>(I)V

    invoke-virtual {v0}, Ld/s/a;->d()[B

    move-result-object v2

    invoke-virtual {v0}, Ld/s/a;->e()I

    move-result v0

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3, v0}, Ld/e;->v([BII)Ld/e;

    const/16 v0, 0x20

    invoke-virtual {v1, v0}, Ld/e;->y(I)V

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0, v1}, Ld/n/f;->P0(Ld/e;)Z

    move-result v0

    if-nez v0, :cond_0

    return v3

    :cond_0
    iget-object v0, p0, Ld/n/g;->N:Ld/n/g$e;

    iput-object v0, p0, Ld/n/g;->v:Ld/n/g$e;

    invoke-interface {v0, p1}, Ld/n/g$e;->a(Ld/e;)Z

    move-result p1

    return p1
.end method

.method static synthetic i(Ld/n/g;)Ld/e;
    .locals 0

    invoke-direct {p0}, Ld/n/g;->F()Ld/e;

    move-result-object p0

    return-object p0
.end method

.method static synthetic j(Ld/n/g;Ld/e;)Z
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g;->G(Ld/e;)Z

    move-result p0

    return p0
.end method

.method static synthetic k(Ld/n/g;)Ld/n/g$e;
    .locals 0

    iget-object p0, p0, Ld/n/g;->O:Ld/n/g$e;

    return-object p0
.end method

.method static synthetic l(Ld/n/g;Ld/n/g$e;)V
    .locals 0

    iput-object p1, p0, Ld/n/g;->v:Ld/n/g$e;

    return-void
.end method

.method static synthetic m(Ld/n/g;)Ld/n/g$e;
    .locals 0

    iget-object p0, p0, Ld/n/g;->N:Ld/n/g$e;

    return-object p0
.end method

.method static synthetic n(Ld/n/g;)Ld/e;
    .locals 0

    invoke-direct {p0}, Ld/n/g;->C()Ld/e;

    move-result-object p0

    return-object p0
.end method

.method static synthetic o(Ld/n/g;Ld/e;)Z
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g;->H(Ld/e;)Z

    move-result p0

    return p0
.end method

.method static synthetic p(Ld/n/g;)Ld/e;
    .locals 0

    invoke-direct {p0}, Ld/n/g;->I()Ld/e;

    move-result-object p0

    return-object p0
.end method

.method static synthetic r(Ld/n/g;Ld/e;)Z
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g;->J(Ld/e;)Z

    move-result p0

    return p0
.end method

.method static synthetic t(Ld/n/g;Ld/e;)Z
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g;->K(Ld/e;)Z

    move-result p0

    return p0
.end method

.method static synthetic u(Ld/n/g;Ld/e;)Z
    .locals 0

    invoke-direct {p0, p1}, Ld/n/g;->P(Ld/e;)Z

    move-result p0

    return p0
.end method

.method static synthetic v(Ld/n/g;)Ld/n/i/a;
    .locals 0

    iget-object p0, p0, Ld/n/g;->y:Ld/n/i/a;

    return-object p0
.end method

.method static synthetic w(Ld/n/g;)Ld/n/e;
    .locals 0

    iget-object p0, p0, Ld/n/g;->k:Ld/n/e;

    return-object p0
.end method

.method static synthetic x(Ld/n/g;)Ld/n/f;
    .locals 0

    iget-object p0, p0, Ld/n/g;->q:Ld/n/f;

    return-object p0
.end method

.method static synthetic y(Ld/n/g;)Ld/s/c;
    .locals 0

    iget-object p0, p0, Ld/n/g;->E:Ld/s/c;

    return-object p0
.end method


# virtual methods
.method public a()V
    .locals 6

    iget-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    invoke-interface {v0}, Ld/n/h/e;->b()Ld/e;

    move-result-object v0

    iget-object v1, p0, Ld/n/g;->v:Ld/n/g$e;

    invoke-interface {v1, v0}, Ld/n/g$e;->a(Ld/e;)Z

    move-result v0

    const/16 v1, 0x23

    if-nez v0, :cond_1

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v0, v1}, Ld/s/c;->b(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    goto :goto_0

    :cond_0
    sget-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    :goto_0
    return-void

    :cond_1
    iget v2, p0, Ld/n/g;->f:I

    const/4 v3, 0x0

    if-gtz v2, :cond_2

    goto :goto_1

    :cond_2
    new-instance v0, Ld/s/f;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-direct {v0, v2}, Ld/s/f;-><init>(Ljava/lang/Object;)V

    iget-object v2, p0, Ld/n/g;->g:Ld/n/h/e;

    iget-object v4, p0, Ld/n/g;->e:Ljava/nio/ByteBuffer;

    iget v5, p0, Ld/n/g;->f:I

    invoke-interface {v2, v4, v5, v0}, Ld/n/h/e;->c(Ljava/nio/ByteBuffer;ILd/s/f;)Ld/n/h/e$a$a;

    move-result-object v2

    iget v4, p0, Ld/n/g;->f:I

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    sub-int/2addr v4, v0

    iput v4, p0, Ld/n/g;->f:I

    sget-object v0, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    if-ne v2, v0, :cond_3

    const/4 v0, 0x1

    goto :goto_1

    :cond_3
    sget-object v0, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-ne v2, v0, :cond_4

    move v0, v3

    goto :goto_1

    :cond_4
    iget-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    invoke-interface {v0}, Ld/n/h/e;->b()Ld/e;

    move-result-object v0

    iget-object v2, p0, Ld/n/g;->v:Ld/n/g$e;

    invoke-interface {v2, v0}, Ld/n/g$e;->a(Ld/e;)Z

    move-result v0

    if-nez v0, :cond_1

    :goto_1
    if-nez v0, :cond_5

    iget-object v2, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v2, v1}, Ld/s/c;->b(I)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    goto :goto_3

    :cond_5
    iget-boolean v1, p0, Ld/n/g;->w:Z

    if-eqz v1, :cond_6

    sget-object v0, Ld/n/g$b;->c:Ld/n/g$b;

    :goto_2
    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    goto :goto_3

    :cond_6
    if-nez v0, :cond_7

    sget-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    goto :goto_2

    :cond_7
    iput-boolean v3, p0, Ld/n/g;->z:Z

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->m(Ld/q/b$a;)V

    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    invoke-virtual {p0}, Ld/n/g;->e()V

    :goto_3
    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public c(Ld/n/d;Ld/n/f;)V
    .locals 5

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/g;->t:Z

    iput-object p2, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {p2}, Ld/n/f;->N0()Ld/j;

    move-result-object v1

    iput-object v1, p0, Ld/n/g;->C:Ld/j;

    new-instance v1, Ld/n/c;

    invoke-direct {v1, p1, p0}, Ld/n/c;-><init>(Ld/n/d;Ld/q/a;)V

    iput-object v1, p0, Ld/n/g;->b:Ld/n/c;

    invoke-virtual {v1}, Ld/n/c;->f()V

    iget-object p1, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    invoke-virtual {p1, v1}, Ld/n/c;->a(Ljava/nio/channels/SelectableChannel;)Ld/q/b$a;

    move-result-object p1

    iput-object p1, p0, Ld/n/g;->d:Ld/q/b$a;

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/n/g;->w:Z

    iget-object v1, p0, Ld/n/g;->r:Ld/f;

    iget-boolean v2, v1, Ld/f;->u:Z

    if-eqz v2, :cond_3

    iget-object v0, v1, Ld/f;->M:Ljava/lang/Class;

    sget-object v1, Ld/b;->f:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v2

    iget-object v3, p0, Ld/n/g;->r:Ld/f;

    iget-wide v3, v3, Ld/f;->o:J

    invoke-direct {p0, v0, v2, v3, v4}, Ld/n/g;->D(Ljava/lang/Class;IJ)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/n/h/e;

    iput-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    if-nez v0, :cond_0

    new-instance v0, Ld/n/h/g/a;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    invoke-direct {v0, v1}, Ld/n/h/g/a;-><init>(I)V

    iput-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    :cond_0
    iget-object v0, p0, Ld/n/g;->r:Ld/f;

    iget-object v0, v0, Ld/f;->N:Ljava/lang/Class;

    sget-object v1, Ld/b;->g:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v2

    iget-object v3, p0, Ld/n/g;->r:Ld/f;

    iget-wide v3, v3, Ld/f;->o:J

    invoke-direct {p0, v0, v2, v3, v4}, Ld/n/g;->D(Ljava/lang/Class;IJ)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ld/n/h/f;

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    if-nez v0, :cond_1

    new-instance v0, Ld/n/h/g/b;

    iget-object v2, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    invoke-direct {v0, v2, v1}, Ld/n/h/g/b;-><init>(Ld/s/c;I)V

    iput-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    :cond_1
    iput-boolean p1, p0, Ld/n/g;->l:Z

    iget-object p1, p0, Ld/n/g;->J:Ld/n/g$e;

    iput-object p1, p0, Ld/n/g;->u:Ld/n/g$e;

    iget-object p1, p0, Ld/n/g;->K:Ld/n/g$e;

    iput-object p1, p0, Ld/n/g;->v:Ld/n/g$e;

    iget-object p1, p0, Ld/n/g;->D:Ld/n/j/a;

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ld/n/j/a;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_2

    new-instance p1, Ld/n/e;

    invoke-direct {p1}, Ld/n/e;-><init>()V

    iput-object p1, p0, Ld/n/g;->k:Ld/n/e;

    iget-object v0, p0, Ld/n/g;->D:Ld/n/j/a;

    invoke-virtual {v0}, Ld/n/j/a;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Peer-Address"

    invoke-virtual {p1, v1, v0}, Ld/n/e;->d(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    new-instance p1, Ld/e;

    invoke-direct {p1}, Ld/e;-><init>()V

    invoke-direct {p0, p1}, Ld/n/g;->K(Ld/e;)Z

    invoke-virtual {p2}, Ld/n/f;->M0()V

    goto :goto_0

    :cond_3
    invoke-direct {p0}, Ld/n/g;->M()V

    iget-object p1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    const/4 p2, -0x1

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    iget-object p2, p0, Ld/n/g;->r:Ld/f;

    iget-byte p2, p2, Ld/f;->d:B

    add-int/2addr p2, v0

    int-to-long v0, p2

    invoke-static {p1, v0, v1}, Ld/s/g;->f(Ljava/nio/ByteBuffer;J)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    const/16 p2, 0x7f

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    iget-object p1, p0, Ld/n/g;->h:Ld/s/f;

    iget-object p2, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-object p1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result p1

    iput p1, p0, Ld/n/g;->i:I

    iget-object p1, p0, Ld/n/g;->o:Ljava/nio/ByteBuffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    :goto_0
    iget-object p1, p0, Ld/n/g;->b:Ld/n/c;

    iget-object p2, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {p1, p2}, Ld/n/c;->m(Ld/q/b$a;)V

    iget-object p1, p0, Ld/n/g;->b:Ld/n/c;

    iget-object p2, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {p1, p2}, Ld/n/c;->n(Ld/q/b$a;)V

    invoke-virtual {p0}, Ld/n/g;->e()V

    return-void
.end method

.method public d()V
    .locals 0

    invoke-direct {p0}, Ld/n/g;->N()V

    invoke-virtual {p0}, Ld/n/g;->z()V

    return-void
.end method

.method public e()V
    .locals 7

    iget-boolean v0, p0, Ld/n/g;->l:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Ld/n/g;->B()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-boolean v0, p0, Ld/n/g;->z:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v2, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v2}, Ld/n/c;->g(Ld/q/b$a;)V

    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/g;->d:Ld/q/b$a;

    iput-boolean v1, p0, Ld/n/g;->w:Z

    return-void

    :cond_1
    iget v0, p0, Ld/n/g;->f:I

    const/16 v2, 0x23

    if-nez v0, :cond_5

    iget-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    invoke-interface {v0}, Ld/n/h/e;->d()Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Ld/n/g;->e:Ljava/nio/ByteBuffer;

    invoke-direct {p0, v0}, Ld/n/g;->L(Ljava/nio/ByteBuffer;)I

    move-result v0

    if-nez v0, :cond_2

    sget-object v3, Ld/n/g$b;->c:Ld/n/g$b;

    invoke-direct {p0, v3}, Ld/n/g;->A(Ld/n/g$b;)V

    :cond_2
    const/4 v3, -0x1

    if-ne v0, v3, :cond_4

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v0, v2}, Ld/s/c;->b(I)Z

    move-result v0

    if-nez v0, :cond_3

    sget-object v0, Ld/n/g$b;->c:Ld/n/g$b;

    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    :cond_3
    return-void

    :cond_4
    iget-object v3, p0, Ld/n/g;->e:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    iput v0, p0, Ld/n/g;->f:I

    :cond_5
    new-instance v0, Ld/s/f;

    const/4 v3, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v0, v4}, Ld/s/f;-><init>(Ljava/lang/Object;)V

    move v4, v3

    :cond_6
    iget v5, p0, Ld/n/g;->f:I

    if-gtz v5, :cond_7

    :goto_0
    move v3, v4

    goto :goto_1

    :cond_7
    iget-object v4, p0, Ld/n/g;->g:Ld/n/h/e;

    iget-object v6, p0, Ld/n/g;->e:Ljava/nio/ByteBuffer;

    invoke-interface {v4, v6, v5, v0}, Ld/n/h/e;->c(Ljava/nio/ByteBuffer;ILd/s/f;)Ld/n/h/e$a$a;

    move-result-object v4

    iget v5, p0, Ld/n/g;->f:I

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    sub-int/2addr v5, v6

    iput v5, p0, Ld/n/g;->f:I

    sget-object v5, Ld/n/h/e$a$a;->b:Ld/n/h/e$a$a;

    if-ne v4, v5, :cond_8

    move v3, v1

    goto :goto_1

    :cond_8
    sget-object v5, Ld/n/h/e$a$a;->d:Ld/n/h/e$a$a;

    if-ne v4, v5, :cond_9

    goto :goto_1

    :cond_9
    iget-object v4, p0, Ld/n/g;->g:Ld/n/h/e;

    invoke-interface {v4}, Ld/n/h/e;->b()Ld/e;

    move-result-object v4

    iget-object v5, p0, Ld/n/g;->v:Ld/n/g$e;

    invoke-interface {v5, v4}, Ld/n/g$e;->a(Ld/e;)Z

    move-result v4

    if-nez v4, :cond_6

    goto :goto_0

    :goto_1
    if-nez v3, :cond_b

    iget-object v0, p0, Ld/n/g;->E:Ld/s/c;

    invoke-virtual {v0, v2}, Ld/s/c;->b(I)Z

    move-result v0

    if-nez v0, :cond_a

    sget-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    return-void

    :cond_a
    iput-boolean v1, p0, Ld/n/g;->z:Z

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->i(Ld/q/b$a;)V

    :cond_b
    iget-object v0, p0, Ld/n/g;->q:Ld/n/f;

    invoke-virtual {v0}, Ld/n/f;->M0()V

    return-void
.end method

.method public f()V
    .locals 2

    iget-boolean v0, p0, Ld/n/g;->w:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-boolean v0, p0, Ld/n/g;->A:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->n(Ld/q/b$a;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Ld/n/g;->A:Z

    :cond_1
    invoke-virtual {p0}, Ld/n/g;->s()V

    return-void
.end method

.method public g()V
    .locals 2

    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    invoke-virtual {v0}, Ld/n/i/a;->z()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    sget-object v0, Ld/n/g$b;->b:Ld/n/g$b;

    invoke-direct {p0, v0}, Ld/n/g;->A(Ld/n/g$b;)V

    return-void

    :cond_0
    iget-boolean v0, p0, Ld/n/g;->z:Z

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ld/n/g;->a()V

    :cond_1
    iget-boolean v0, p0, Ld/n/g;->A:Z

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Ld/n/g;->f()V

    :cond_2
    return-void
.end method

.method public h(I)V
    .locals 0

    const/4 p1, 0x0

    iput-boolean p1, p0, Ld/n/g;->B:Z

    sget-object p1, Ld/n/g$b;->d:Ld/n/g$b;

    invoke-direct {p0, p1}, Ld/n/g;->A(Ld/n/g$b;)V

    return-void
.end method

.method public q()V
    .locals 1

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public s()V
    .locals 4

    iget v0, p0, Ld/n/g;->i:I

    if-nez v0, :cond_4

    iget-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Ld/n/g;->h:Ld/s/f;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ld/s/f;->b(Ljava/lang/Object;)V

    iget-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    iget-object v1, p0, Ld/n/g;->h:Ld/s/f;

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Ld/n/h/f;->b(Ld/s/f;I)I

    move-result v0

    iput v0, p0, Ld/n/g;->i:I

    :goto_0
    iget v0, p0, Ld/n/g;->i:I

    sget-object v1, Ld/b;->g:Ld/b;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v2

    if-lt v0, v2, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Ld/n/g;->u:Ld/n/g$e;

    invoke-interface {v0}, Ld/n/g$e;->b()Ld/e;

    move-result-object v0

    if-nez v0, :cond_3

    :goto_1
    iget v0, p0, Ld/n/g;->i:I

    if-nez v0, :cond_2

    const/4 v0, 0x1

    iput-boolean v0, p0, Ld/n/g;->A:Z

    :goto_2
    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->j(Ld/q/b$a;)V

    return-void

    :cond_2
    iget-object v0, p0, Ld/n/g;->h:Ld/s/f;

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    iget v2, p0, Ld/n/g;->i:I

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    if-gt v2, v1, :cond_4

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    goto :goto_3

    :cond_3
    iget-object v2, p0, Ld/n/g;->j:Ld/n/h/f;

    invoke-interface {v2, v0}, Ld/n/h/f;->c(Ld/e;)V

    iget-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    iget-object v2, p0, Ld/n/g;->h:Ld/s/f;

    invoke-virtual {v1}, Ld/b;->a()I

    move-result v1

    iget v3, p0, Ld/n/g;->i:I

    sub-int/2addr v1, v3

    invoke-interface {v0, v2, v1}, Ld/n/h/f;->b(Ld/s/f;I)I

    move-result v0

    iget v1, p0, Ld/n/g;->i:I

    add-int/2addr v1, v0

    iput v1, p0, Ld/n/g;->i:I

    goto :goto_0

    :cond_4
    :goto_3
    iget-object v0, p0, Ld/n/g;->h:Ld/s/f;

    invoke-virtual {v0}, Ld/s/f;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    invoke-direct {p0, v0}, Ld/n/g;->O(Ljava/nio/ByteBuffer;)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_5

    goto :goto_2

    :cond_5
    iget v1, p0, Ld/n/g;->i:I

    sub-int/2addr v1, v0

    iput v1, p0, Ld/n/g;->i:I

    iget-boolean v0, p0, Ld/n/g;->l:Z

    if-eqz v0, :cond_6

    if-nez v1, :cond_6

    iget-object v0, p0, Ld/n/g;->b:Ld/n/c;

    iget-object v1, p0, Ld/n/g;->d:Ld/q/b$a;

    invoke-virtual {v0, v1}, Ld/n/c;->j(Ld/q/b$a;)V

    :cond_6
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-class v1, Ld/n/g;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Ld/n/g;->C:Ld/j;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Ld/n/g;->p:Ld/n/g$f;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public z()V
    .locals 1

    iget-object v0, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    if-eqz v0, :cond_0

    :try_start_0
    invoke-virtual {v0}, Ljava/nio/channels/SocketChannel;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x0

    iput-object v0, p0, Ld/n/g;->c:Ljava/nio/channels/SocketChannel;

    :cond_0
    iget-object v0, p0, Ld/n/g;->j:Ld/n/h/f;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ld/n/h/f;->a()V

    :cond_1
    iget-object v0, p0, Ld/n/g;->g:Ld/n/h/e;

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ld/n/h/e;->a()V

    :cond_2
    iget-object v0, p0, Ld/n/g;->y:Ld/n/i/a;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ld/n/i/a;->j()V

    :cond_3
    return-void
.end method
