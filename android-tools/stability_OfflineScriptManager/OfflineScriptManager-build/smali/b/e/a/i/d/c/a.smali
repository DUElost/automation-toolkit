.class public Lb/e/a/i/d/c/a;
.super Lb/e/a/i/d/c/b;
.source ""


# annotations
.annotation runtime Lb/e/a/i/d/c/g;
    objectTypeIndication = 0x40
    tags = {
        0x5
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lb/e/a/i/d/c/a$a;,
        Lb/e/a/i/d/c/a$b;
    }
.end annotation


# static fields
.field public static X:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public static Y:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public A:I

.field public B:I

.field public C:Z

.field public D:Z

.field public E:Z

.field public F:I

.field public G:Z

.field public H:I

.field public I:I

.field public J:I

.field public K:I

.field public L:I

.field public M:I

.field public N:I

.field public O:I

.field public P:I

.field public Q:I

.field public R:I

.field public S:I

.field public T:I

.field public U:I

.field public V:Z

.field W:[B

.field public d:I

.field public e:I

.field public f:I

.field public g:I

.field public h:I

.field public i:I

.field public j:Z

.field public k:Z

.field public l:I

.field public m:I

.field public n:I

.field public o:I

.field public p:I

.field public q:I

.field public r:I

.field public s:I

.field public t:I

.field public u:I

.field public v:I

.field public w:I

.field public x:I

.field public y:I

.field public z:I


# direct methods
.method static constructor <clinit>()V
    .locals 13

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const v2, 0x17700

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const v2, 0x15888

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const v3, 0xfa00

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v3, 0x3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const v4, 0xbb80

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v4, 0x4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const v5, 0xac44

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v5, 0x5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/16 v6, 0x7d00

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v0, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v6, 0x6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/16 v7, 0x5dc0

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {v0, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/4 v7, 0x7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const/16 v8, 0x5622

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v0, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/16 v8, 0x8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    const/16 v9, 0x3e80

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v0, v8, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/16 v9, 0x9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    const/16 v10, 0x2ee0

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-interface {v0, v9, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/16 v10, 0xa

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    const/16 v11, 0x2b11

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-interface {v0, v10, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    const/16 v11, 0xb

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const/16 v12, 0x1f40

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    invoke-interface {v0, v11, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v12, "AAC main"

    invoke-interface {v0, v1, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "AAC LC"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "AAC SSR"

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "AAC LTP"

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "SBR"

    invoke-interface {v0, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "AAC Scalable"

    invoke-interface {v0, v6, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "TwinVQ"

    invoke-interface {v0, v7, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "CELP"

    invoke-interface {v0, v8, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "HVXC"

    invoke-interface {v0, v9, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const-string v1, "(reserved)"

    invoke-interface {v0, v10, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    invoke-interface {v0, v11, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0xc

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "TTSI"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0xd

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "Main synthetic"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0xe

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "Wavetable synthesis"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0xf

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "General MIDI"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0x10

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "Algorithmic Synthesis and Audio FX"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0x11

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "ER AAC LC"

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v2, 0x12

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x13

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER AAC LTP"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x14

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER AAC Scalable"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x15

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER TwinVQ"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x16

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER BSAC"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x17

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER AAC LD"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x18

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER CELP"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x19

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER HVXC"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1a

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER HILN"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1b

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER Parametric"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1c

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "SSC"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1d

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "PS"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1e

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "MPEG Surround"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x1f

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "(escape)"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x20

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "Layer-1"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x21

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "Layer-2"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x22

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "Layer-3"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x23

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "DST"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x24

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ALS"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x25

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "SLS"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x26

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "SLS non-core"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x27

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "ER AAC ELD"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x28

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "SMR Simple"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    const/16 v1, 0x29

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "SMR Main"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lb/e/a/i/d/c/b;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lb/e/a/i/d/c/a;->l:I

    iput v0, p0, Lb/e/a/i/d/c/a;->s:I

    iput v0, p0, Lb/e/a/i/d/c/a;->t:I

    iput v0, p0, Lb/e/a/i/d/c/a;->u:I

    const/4 v0, 0x5

    iput v0, p0, Lb/e/a/i/d/c/b;->a:I

    return-void
.end method

.method private g()I
    .locals 5

    iget v0, p0, Lb/e/a/i/d/c/a;->w:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/16 v0, 0x10

    goto :goto_0

    :cond_0
    const/4 v0, 0x2

    :goto_0
    add-int/2addr v0, v1

    iget v2, p0, Lb/e/a/i/d/c/a;->h:I

    if-eqz v2, :cond_8

    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    const/4 v3, 0x6

    const/16 v4, 0x14

    if-eq v2, v3, :cond_1

    if-ne v2, v4, :cond_2

    :cond_1
    add-int/lit8 v0, v0, 0x3

    :cond_2
    iget v3, p0, Lb/e/a/i/d/c/a;->y:I

    if-ne v3, v1, :cond_7

    const/16 v3, 0x16

    if-ne v2, v3, :cond_3

    add-int/lit8 v0, v0, 0x5

    add-int/lit8 v0, v0, 0xb

    :cond_3
    const/16 v3, 0x11

    if-eq v2, v3, :cond_4

    const/16 v3, 0x13

    if-eq v2, v3, :cond_4

    if-eq v2, v4, :cond_4

    const/16 v3, 0x17

    if-ne v2, v3, :cond_5

    :cond_4
    add-int/lit8 v0, v0, 0x1

    add-int/2addr v0, v1

    add-int/2addr v0, v1

    :cond_5
    add-int/2addr v0, v1

    iget v2, p0, Lb/e/a/i/d/c/a;->F:I

    if-eq v2, v1, :cond_6

    goto :goto_1

    :cond_6
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Not implemented"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_7
    :goto_1
    return v0

    :cond_8
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t parse program_config_element yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private h(Lb/e/a/i/d/c/c;)I
    .locals 2

    const/4 v0, 0x5

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    const/16 v1, 0x1f

    if-ne v0, v1, :cond_0

    const/4 v0, 0x6

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    add-int/lit8 v0, p1, 0x20

    :cond_0
    return v0
.end method

.method private i(IIILb/e/a/i/d/c/c;)V
    .locals 0

    const/4 p1, 0x1

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->K:I

    const/4 p2, 0x2

    invoke-virtual {p4, p2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->L:I

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->M:I

    if-ne p2, p1, :cond_0

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->N:I

    :cond_0
    return-void
.end method

.method private j(IIILb/e/a/i/d/c/c;)V
    .locals 1

    const/4 p1, 0x1

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->v:I

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->w:I

    if-ne v0, p1, :cond_0

    const/16 v0, 0xe

    invoke-virtual {p4, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->x:I

    :cond_0
    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->y:I

    if-eqz p2, :cond_8

    const/4 p2, 0x6

    const/16 v0, 0x14

    if-eq p3, p2, :cond_1

    if-ne p3, v0, :cond_2

    :cond_1
    const/4 p2, 0x3

    invoke-virtual {p4, p2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->z:I

    :cond_2
    iget p2, p0, Lb/e/a/i/d/c/a;->y:I

    if-ne p2, p1, :cond_7

    const/16 p2, 0x16

    if-ne p3, p2, :cond_3

    const/4 p2, 0x5

    invoke-virtual {p4, p2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->A:I

    const/16 p2, 0xb

    invoke-virtual {p4, p2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->B:I

    :cond_3
    const/16 p2, 0x11

    if-eq p3, p2, :cond_4

    const/16 p2, 0x13

    if-eq p3, p2, :cond_4

    if-eq p3, v0, :cond_4

    const/16 p2, 0x17

    if-ne p3, p2, :cond_5

    :cond_4
    invoke-virtual {p4}, Lb/e/a/i/d/c/c;->b()Z

    move-result p2

    iput-boolean p2, p0, Lb/e/a/i/d/c/a;->C:Z

    invoke-virtual {p4}, Lb/e/a/i/d/c/c;->b()Z

    move-result p2

    iput-boolean p2, p0, Lb/e/a/i/d/c/a;->D:Z

    invoke-virtual {p4}, Lb/e/a/i/d/c/c;->b()Z

    move-result p2

    iput-boolean p2, p0, Lb/e/a/i/d/c/a;->E:Z

    :cond_5
    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->F:I

    if-eq p2, p1, :cond_6

    goto :goto_0

    :cond_6
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "not yet implemented"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_7
    :goto_0
    iput-boolean p1, p0, Lb/e/a/i/d/c/a;->G:Z

    return-void

    :cond_8
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "can\'t parse program_config_element yet"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private k(IIILb/e/a/i/d/c/c;)V
    .locals 0

    const/4 p1, 0x1

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->O:I

    const/16 p1, 0x8

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->P:I

    const/4 p1, 0x4

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->Q:I

    const/16 p1, 0xc

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->R:I

    const/4 p1, 0x2

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->S:I

    return-void
.end method

.method private l(IIILb/e/a/i/d/c/c;)V
    .locals 0

    const/4 p1, 0x1

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p2

    iput p2, p0, Lb/e/a/i/d/c/a;->T:I

    if-ne p2, p1, :cond_0

    const/4 p1, 0x2

    invoke-virtual {p4, p1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->U:I

    :cond_0
    return-void
.end method

.method private m(IIILb/e/a/i/d/c/c;)V
    .locals 2

    const/4 v0, 0x2

    invoke-virtual {p4, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->I:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    invoke-direct {p0, p1, p2, p3, p4}, Lb/e/a/i/d/c/a;->i(IIILb/e/a/i/d/c/c;)V

    :cond_0
    iget v0, p0, Lb/e/a/i/d/c/a;->I:I

    if-eqz v0, :cond_1

    invoke-direct {p0, p1, p2, p3, p4}, Lb/e/a/i/d/c/a;->k(IIILb/e/a/i/d/c/c;)V

    :cond_1
    invoke-virtual {p4, v1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->J:I

    iput-boolean v1, p0, Lb/e/a/i/d/c/a;->V:Z

    return-void
.end method

.method private n(IIILb/e/a/i/d/c/c;)V
    .locals 2

    const/4 v0, 0x1

    invoke-virtual {p4, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->H:I

    if-ne v1, v0, :cond_0

    invoke-direct {p0, p1, p2, p3, p4}, Lb/e/a/i/d/c/a;->m(IIILb/e/a/i/d/c/c;)V

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1, p2, p3, p4}, Lb/e/a/i/d/c/a;->l(IIILb/e/a/i/d/c/c;)V

    :goto_0
    return-void
.end method

.method private p()Ljava/nio/ByteBuffer;
    .locals 10

    invoke-virtual {p0}, Lb/e/a/i/d/c/a;->a()I

    move-result v0

    new-array v0, v0, [B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    new-instance v1, Lb/e/a/i/d/c/d;

    invoke-direct {v1, v0}, Lb/e/a/i/d/c/d;-><init>(Ljava/nio/ByteBuffer;)V

    iget v2, p0, Lb/e/a/i/d/c/a;->e:I

    invoke-direct {p0, v2, v1}, Lb/e/a/i/d/c/a;->q(ILb/e/a/i/d/c/d;)V

    iget v2, p0, Lb/e/a/i/d/c/a;->f:I

    const/4 v3, 0x4

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->f:I

    const/16 v4, 0x18

    const/16 v5, 0xf

    if-ne v2, v5, :cond_0

    iget v2, p0, Lb/e/a/i/d/c/a;->g:I

    invoke-virtual {v1, v2, v4}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_0
    iget v2, p0, Lb/e/a/i/d/c/a;->h:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v6, 0x16

    const/16 v7, 0x1d

    const/4 v8, 0x1

    const/4 v9, 0x5

    if-eq v2, v9, :cond_1

    if-ne v2, v7, :cond_4

    :cond_1
    iput v9, p0, Lb/e/a/i/d/c/a;->i:I

    iput-boolean v8, p0, Lb/e/a/i/d/c/a;->j:Z

    if-ne v2, v7, :cond_2

    iput-boolean v8, p0, Lb/e/a/i/d/c/a;->k:Z

    :cond_2
    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v2, v5, :cond_3

    iget v2, p0, Lb/e/a/i/d/c/a;->m:I

    invoke-virtual {v1, v2, v4}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_3
    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    invoke-direct {p0, v2, v1}, Lb/e/a/i/d/c/a;->q(ILb/e/a/i/d/c/d;)V

    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    if-ne v2, v6, :cond_4

    iget v2, p0, Lb/e/a/i/d/c/a;->n:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_4
    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    packed-switch v2, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_0

    :pswitch_1
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t parse SymbolicMusicSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_2
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write ELDSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_3
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write SLSSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_4
    iget v0, p0, Lb/e/a/i/d/c/a;->p:I

    invoke-virtual {v1, v0, v9}, Lb/e/a/i/d/c/d;->a(II)V

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write ALSSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_5
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write DSTSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_6
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write MPEG_1_2_SpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_7
    iget v0, p0, Lb/e/a/i/d/c/a;->o:I

    invoke-virtual {v1, v0, v8}, Lb/e/a/i/d/c/d;->a(II)V

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write SpatialSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_8
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write SSCSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_9
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write parseParametricSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_a
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write ErrorResilientHvxcSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_b
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write ErrorResilientCelpSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_c
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write StructuredAudioSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_d
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write TTSSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_e
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write HvxcSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_f
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t write CelpSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_10
    invoke-direct {p0, v1}, Lb/e/a/i/d/c/a;->r(Lb/e/a/i/d/c/d;)V

    :goto_0
    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v7, 0x11

    if-eq v2, v7, :cond_5

    const/16 v7, 0x27

    if-eq v2, v7, :cond_5

    packed-switch v2, :pswitch_data_1

    goto :goto_1

    :cond_5
    :pswitch_11
    iget v2, p0, Lb/e/a/i/d/c/a;->q:I

    const/4 v7, 0x2

    invoke-virtual {v1, v2, v7}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->q:I

    if-eq v2, v7, :cond_c

    const/4 v7, 0x3

    if-eq v2, v7, :cond_c

    if-ne v2, v7, :cond_7

    iget v2, p0, Lb/e/a/i/d/c/a;->r:I

    invoke-virtual {v1, v2, v8}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->r:I

    if-eqz v2, :cond_6

    goto :goto_1

    :cond_6
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "not implemented"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_7
    :goto_1
    iget v2, p0, Lb/e/a/i/d/c/a;->u:I

    if-ltz v2, :cond_b

    const/16 v7, 0xb

    invoke-virtual {v1, v2, v7}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->u:I

    const/16 v8, 0x2b7

    if-ne v2, v8, :cond_b

    iget v2, p0, Lb/e/a/i/d/c/a;->i:I

    invoke-direct {p0, v2, v1}, Lb/e/a/i/d/c/a;->q(ILb/e/a/i/d/c/d;)V

    iget v2, p0, Lb/e/a/i/d/c/a;->i:I

    if-ne v2, v9, :cond_9

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->j:Z

    invoke-virtual {v1, v2}, Lb/e/a/i/d/c/d;->b(Z)V

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v2, :cond_9

    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v2, v5, :cond_8

    iget v2, p0, Lb/e/a/i/d/c/a;->m:I

    invoke-virtual {v1, v2, v4}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_8
    iget v2, p0, Lb/e/a/i/d/c/a;->t:I

    if-ltz v2, :cond_9

    invoke-virtual {v1, v2, v7}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->s:I

    const/16 v7, 0x548

    if-ne v2, v7, :cond_9

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->k:Z

    invoke-virtual {v1, v2}, Lb/e/a/i/d/c/d;->b(Z)V

    :cond_9
    iget v2, p0, Lb/e/a/i/d/c/a;->i:I

    if-ne v2, v6, :cond_b

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->j:Z

    invoke-virtual {v1, v2}, Lb/e/a/i/d/c/d;->b(Z)V

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v2, :cond_a

    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v2, v5, :cond_a

    iget v2, p0, Lb/e/a/i/d/c/a;->m:I

    invoke-virtual {v1, v2, v4}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_a
    iget v2, p0, Lb/e/a/i/d/c/a;->n:I

    invoke-virtual {v1, v2, v3}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_b
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    return-object v0

    :cond_c
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "can\'t parse ErrorProtectionSpecificConfig yet"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_0
        :pswitch_10
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_0
        :pswitch_0
        :pswitch_d
        :pswitch_c
        :pswitch_c
        :pswitch_c
        :pswitch_c
        :pswitch_10
        :pswitch_0
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_9
        :pswitch_8
        :pswitch_0
        :pswitch_7
        :pswitch_0
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x13
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
    .end packed-switch
.end method

.method private q(ILb/e/a/i/d/c/d;)V
    .locals 3

    const/4 v0, 0x5

    const/16 v1, 0x20

    if-lt p1, v1, :cond_0

    const/16 v2, 0x1f

    invoke-virtual {p2, v2, v0}, Lb/e/a/i/d/c/d;->a(II)V

    sub-int/2addr p1, v1

    const/4 v0, 0x6

    :cond_0
    invoke-virtual {p2, p1, v0}, Lb/e/a/i/d/c/d;->a(II)V

    return-void
.end method

.method private r(Lb/e/a/i/d/c/d;)V
    .locals 4

    iget v0, p0, Lb/e/a/i/d/c/a;->v:I

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Lb/e/a/i/d/c/d;->a(II)V

    iget v0, p0, Lb/e/a/i/d/c/a;->w:I

    invoke-virtual {p1, v0, v1}, Lb/e/a/i/d/c/d;->a(II)V

    iget v0, p0, Lb/e/a/i/d/c/a;->w:I

    if-ne v0, v1, :cond_0

    iget v0, p0, Lb/e/a/i/d/c/a;->x:I

    const/16 v2, 0xe

    invoke-virtual {p1, v0, v2}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_0
    iget v0, p0, Lb/e/a/i/d/c/a;->y:I

    invoke-virtual {p1, v0, v1}, Lb/e/a/i/d/c/d;->a(II)V

    iget v0, p0, Lb/e/a/i/d/c/a;->h:I

    if-eqz v0, :cond_8

    iget v0, p0, Lb/e/a/i/d/c/a;->d:I

    const/4 v2, 0x6

    const/16 v3, 0x14

    if-eq v0, v2, :cond_1

    if-ne v0, v3, :cond_2

    :cond_1
    iget v0, p0, Lb/e/a/i/d/c/a;->z:I

    const/4 v2, 0x3

    invoke-virtual {p1, v0, v2}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_2
    iget v0, p0, Lb/e/a/i/d/c/a;->y:I

    if-ne v0, v1, :cond_7

    iget v0, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v2, 0x16

    if-ne v0, v2, :cond_3

    iget v0, p0, Lb/e/a/i/d/c/a;->A:I

    const/4 v2, 0x5

    invoke-virtual {p1, v0, v2}, Lb/e/a/i/d/c/d;->a(II)V

    iget v0, p0, Lb/e/a/i/d/c/a;->B:I

    const/16 v2, 0xb

    invoke-virtual {p1, v0, v2}, Lb/e/a/i/d/c/d;->a(II)V

    :cond_3
    iget v0, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v2, 0x11

    if-eq v0, v2, :cond_4

    const/16 v2, 0x13

    if-eq v0, v2, :cond_4

    if-eq v0, v3, :cond_4

    const/16 v2, 0x17

    if-ne v0, v2, :cond_5

    :cond_4
    iget-boolean v0, p0, Lb/e/a/i/d/c/a;->C:Z

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/d;->b(Z)V

    iget-boolean v0, p0, Lb/e/a/i/d/c/a;->D:Z

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/d;->b(Z)V

    iget-boolean v0, p0, Lb/e/a/i/d/c/a;->E:Z

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/d;->b(Z)V

    :cond_5
    iget v0, p0, Lb/e/a/i/d/c/a;->F:I

    invoke-virtual {p1, v0, v1}, Lb/e/a/i/d/c/d;->a(II)V

    iget p1, p0, Lb/e/a/i/d/c/a;->F:I

    if-eq p1, v1, :cond_6

    goto :goto_0

    :cond_6
    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "not yet implemented"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_7
    :goto_0
    return-void

    :cond_8
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse program_config_element yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method a()I
    .locals 7

    iget v0, p0, Lb/e/a/i/d/c/a;->e:I

    const/16 v1, 0x1e

    const/4 v2, 0x5

    if-le v0, v1, :cond_0

    const/16 v0, 0xb

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    add-int/lit8 v0, v0, 0x4

    iget v3, p0, Lb/e/a/i/d/c/a;->f:I

    const/16 v4, 0xf

    if-ne v3, v4, :cond_1

    add-int/lit8 v0, v0, 0x18

    :cond_1
    add-int/lit8 v0, v0, 0x4

    iget v3, p0, Lb/e/a/i/d/c/a;->d:I

    if-eq v3, v2, :cond_2

    const/16 v5, 0x1d

    if-ne v3, v5, :cond_3

    :cond_2
    add-int/lit8 v0, v0, 0x4

    iget v5, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v5, v4, :cond_3

    add-int/lit8 v0, v0, 0x18

    :cond_3
    const/16 v5, 0x16

    if-ne v3, v5, :cond_4

    add-int/lit8 v0, v0, 0x4

    :cond_4
    iget-boolean v3, p0, Lb/e/a/i/d/c/a;->G:Z

    if-eqz v3, :cond_5

    invoke-direct {p0}, Lb/e/a/i/d/c/a;->g()I

    move-result v3

    add-int/2addr v0, v3

    :cond_5
    iget v3, p0, Lb/e/a/i/d/c/a;->u:I

    if-ltz v3, :cond_a

    add-int/lit8 v0, v0, 0xb

    const/16 v6, 0x2b7

    if-ne v3, v6, :cond_a

    add-int/lit8 v0, v0, 0x5

    iget v3, p0, Lb/e/a/i/d/c/a;->i:I

    if-le v3, v1, :cond_6

    add-int/lit8 v0, v0, 0x6

    :cond_6
    if-ne v3, v2, :cond_8

    add-int/lit8 v0, v0, 0x1

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v1, :cond_8

    add-int/lit8 v0, v0, 0x4

    iget v1, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v1, v4, :cond_7

    add-int/lit8 v0, v0, 0x18

    :cond_7
    iget v1, p0, Lb/e/a/i/d/c/a;->t:I

    if-ltz v1, :cond_8

    add-int/lit8 v0, v0, 0xb

    const/16 v2, 0x548

    if-ne v1, v2, :cond_8

    add-int/lit8 v0, v0, 0x1

    :cond_8
    if-ne v3, v5, :cond_a

    add-int/lit8 v0, v0, 0x1

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v1, :cond_9

    add-int/lit8 v0, v0, 0x4

    iget v1, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v1, v4, :cond_9

    add-int/lit8 v0, v0, 0x18

    :cond_9
    add-int/lit8 v0, v0, 0x4

    :cond_a
    int-to-double v0, v0

    const-wide/high16 v2, 0x4020000000000000L    # 8.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int v0, v0

    return v0
.end method

.method public e(Ljava/nio/ByteBuffer;)V
    .locals 9

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lb/e/a/i/d/c/b;->b:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    iget v2, p0, Lb/e/a/i/d/c/b;->b:I

    add-int/2addr v1, v2

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget p1, p0, Lb/e/a/i/d/c/b;->b:I

    new-array p1, p1, [B

    iput-object p1, p0, Lb/e/a/i/d/c/a;->W:[B

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    new-instance p1, Lb/e/a/i/d/c/c;

    invoke-direct {p1, v0}, Lb/e/a/i/d/c/c;-><init>(Ljava/nio/ByteBuffer;)V

    invoke-direct {p0, p1}, Lb/e/a/i/d/c/a;->h(Lb/e/a/i/d/c/c;)I

    move-result v0

    iput v0, p0, Lb/e/a/i/d/c/a;->d:I

    iput v0, p0, Lb/e/a/i/d/c/a;->e:I

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->f:I

    const/16 v2, 0x18

    const/16 v3, 0xf

    if-ne v1, v3, :cond_0

    invoke-virtual {p1, v2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->g:I

    :cond_0
    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->h:I

    iget v1, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v4, 0x16

    const/16 v5, 0x1d

    const/4 v6, 0x1

    const/4 v7, 0x5

    if-eq v1, v7, :cond_2

    if-ne v1, v5, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    iput v1, p0, Lb/e/a/i/d/c/a;->i:I

    goto :goto_1

    :cond_2
    :goto_0
    iput v7, p0, Lb/e/a/i/d/c/a;->i:I

    iput-boolean v6, p0, Lb/e/a/i/d/c/a;->j:Z

    if-ne v1, v5, :cond_3

    iput-boolean v6, p0, Lb/e/a/i/d/c/a;->k:Z

    :cond_3
    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v1, v3, :cond_4

    invoke-virtual {p1, v2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->m:I

    :cond_4
    invoke-direct {p0, p1}, Lb/e/a/i/d/c/a;->h(Lb/e/a/i/d/c/c;)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->d:I

    if-ne v1, v4, :cond_5

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->n:I

    :cond_5
    :goto_1
    iget v1, p0, Lb/e/a/i/d/c/a;->d:I

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_2

    :pswitch_1
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse SymbolicMusicSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_2
    new-instance v1, Lb/e/a/i/d/c/a$a;

    iget v5, p0, Lb/e/a/i/d/c/a;->h:I

    invoke-direct {v1, p0, v5, p1}, Lb/e/a/i/d/c/a$a;-><init>(Lb/e/a/i/d/c/a;ILb/e/a/i/d/c/c;)V

    goto/16 :goto_2

    :pswitch_3
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse SLSSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_4
    invoke-virtual {p1, v7}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->p:I

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse ALSSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_5
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse DSTSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_6
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse MPEG_1_2_SpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_7
    invoke-virtual {p1, v6}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->o:I

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse SpatialSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_8
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse SSCSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_9
    iget v5, p0, Lb/e/a/i/d/c/a;->f:I

    iget v8, p0, Lb/e/a/i/d/c/a;->h:I

    invoke-direct {p0, v5, v8, v1, p1}, Lb/e/a/i/d/c/a;->n(IIILb/e/a/i/d/c/c;)V

    goto :goto_2

    :pswitch_a
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse ErrorResilientHvxcSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_b
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse ErrorResilientCelpSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_c
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse StructuredAudioSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_d
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse TTSSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_e
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse HvxcSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_f
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse CelpSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_10
    iget v5, p0, Lb/e/a/i/d/c/a;->f:I

    iget v8, p0, Lb/e/a/i/d/c/a;->h:I

    invoke-direct {p0, v5, v8, v1, p1}, Lb/e/a/i/d/c/a;->j(IIILb/e/a/i/d/c/c;)V

    :goto_2
    iget v1, p0, Lb/e/a/i/d/c/a;->d:I

    const/16 v5, 0x11

    if-eq v1, v5, :cond_6

    const/16 v5, 0x27

    if-eq v1, v5, :cond_6

    packed-switch v1, :pswitch_data_1

    goto :goto_3

    :cond_6
    :pswitch_11
    const/4 v1, 0x2

    invoke-virtual {p1, v1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v5

    iput v5, p0, Lb/e/a/i/d/c/a;->q:I

    if-eq v5, v1, :cond_d

    const/4 v1, 0x3

    if-eq v5, v1, :cond_d

    if-ne v5, v1, :cond_8

    invoke-virtual {p1, v6}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->r:I

    if-eqz v1, :cond_7

    goto :goto_3

    :cond_7
    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "not implemented"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_8
    :goto_3
    iget v1, p0, Lb/e/a/i/d/c/a;->i:I

    if-eq v1, v7, :cond_c

    invoke-virtual {p1}, Lb/e/a/i/d/c/c;->c()I

    move-result v1

    const/16 v5, 0x10

    if-lt v1, v5, :cond_c

    const/16 v1, 0xb

    invoke-virtual {p1, v1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v5

    iput v5, p0, Lb/e/a/i/d/c/a;->s:I

    iput v5, p0, Lb/e/a/i/d/c/a;->u:I

    const/16 v6, 0x2b7

    if-ne v5, v6, :cond_c

    invoke-direct {p0, p1}, Lb/e/a/i/d/c/a;->h(Lb/e/a/i/d/c/c;)I

    move-result v5

    iput v5, p0, Lb/e/a/i/d/c/a;->i:I

    if-ne v5, v7, :cond_a

    invoke-virtual {p1}, Lb/e/a/i/d/c/c;->b()Z

    move-result v5

    iput-boolean v5, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v5, :cond_a

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v5

    iput v5, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v5, v3, :cond_9

    invoke-virtual {p1, v2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v5

    iput v5, p0, Lb/e/a/i/d/c/a;->m:I

    :cond_9
    invoke-virtual {p1}, Lb/e/a/i/d/c/c;->c()I

    move-result v5

    const/16 v6, 0xc

    if-lt v5, v6, :cond_a

    invoke-virtual {p1, v1}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->s:I

    iput v1, p0, Lb/e/a/i/d/c/a;->t:I

    const/16 v5, 0x548

    if-ne v1, v5, :cond_a

    invoke-virtual {p1}, Lb/e/a/i/d/c/c;->b()Z

    move-result v1

    iput-boolean v1, p0, Lb/e/a/i/d/c/a;->k:Z

    :cond_a
    iget v1, p0, Lb/e/a/i/d/c/a;->i:I

    if-ne v1, v4, :cond_c

    invoke-virtual {p1}, Lb/e/a/i/d/c/c;->b()Z

    move-result v1

    iput-boolean v1, p0, Lb/e/a/i/d/c/a;->j:Z

    if-eqz v1, :cond_b

    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->l:I

    if-ne v1, v3, :cond_b

    invoke-virtual {p1, v2}, Lb/e/a/i/d/c/c;->a(I)I

    move-result v1

    iput v1, p0, Lb/e/a/i/d/c/a;->m:I

    :cond_b
    invoke-virtual {p1, v0}, Lb/e/a/i/d/c/c;->a(I)I

    move-result p1

    iput p1, p0, Lb/e/a/i/d/c/a;->n:I

    :cond_c
    return-void

    :cond_d
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "can\'t parse ErrorProtectionSpecificConfig yet"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_0
        :pswitch_10
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_0
        :pswitch_0
        :pswitch_d
        :pswitch_c
        :pswitch_c
        :pswitch_c
        :pswitch_c
        :pswitch_10
        :pswitch_0
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_10
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_9
        :pswitch_8
        :pswitch_0
        :pswitch_7
        :pswitch_0
        :pswitch_6
        :pswitch_6
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x13
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
        :pswitch_11
    .end packed-switch
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_2d

    const-class v2, Lb/e/a/i/d/c/a;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto/16 :goto_0

    :cond_1
    check-cast p1, Lb/e/a/i/d/c/a;

    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->D:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->D:Z

    if-eq v2, v3, :cond_2

    return v1

    :cond_2
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->C:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->C:Z

    if-eq v2, v3, :cond_3

    return v1

    :cond_3
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->E:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->E:Z

    if-eq v2, v3, :cond_4

    return v1

    :cond_4
    iget v2, p0, Lb/e/a/i/d/c/a;->d:I

    iget v3, p1, Lb/e/a/i/d/c/a;->d:I

    if-eq v2, v3, :cond_5

    return v1

    :cond_5
    iget v2, p0, Lb/e/a/i/d/c/a;->h:I

    iget v3, p1, Lb/e/a/i/d/c/a;->h:I

    if-eq v2, v3, :cond_6

    return v1

    :cond_6
    iget v2, p0, Lb/e/a/i/d/c/a;->x:I

    iget v3, p1, Lb/e/a/i/d/c/a;->x:I

    if-eq v2, v3, :cond_7

    return v1

    :cond_7
    iget v2, p0, Lb/e/a/i/d/c/a;->w:I

    iget v3, p1, Lb/e/a/i/d/c/a;->w:I

    if-eq v2, v3, :cond_8

    return v1

    :cond_8
    iget v2, p0, Lb/e/a/i/d/c/a;->r:I

    iget v3, p1, Lb/e/a/i/d/c/a;->r:I

    if-eq v2, v3, :cond_9

    return v1

    :cond_9
    iget v2, p0, Lb/e/a/i/d/c/a;->q:I

    iget v3, p1, Lb/e/a/i/d/c/a;->q:I

    if-eq v2, v3, :cond_a

    return v1

    :cond_a
    iget v2, p0, Lb/e/a/i/d/c/a;->M:I

    iget v3, p1, Lb/e/a/i/d/c/a;->M:I

    if-eq v2, v3, :cond_b

    return v1

    :cond_b
    iget v2, p0, Lb/e/a/i/d/c/a;->i:I

    iget v3, p1, Lb/e/a/i/d/c/a;->i:I

    if-eq v2, v3, :cond_c

    return v1

    :cond_c
    iget v2, p0, Lb/e/a/i/d/c/a;->n:I

    iget v3, p1, Lb/e/a/i/d/c/a;->n:I

    if-eq v2, v3, :cond_d

    return v1

    :cond_d
    iget v2, p0, Lb/e/a/i/d/c/a;->y:I

    iget v3, p1, Lb/e/a/i/d/c/a;->y:I

    if-eq v2, v3, :cond_e

    return v1

    :cond_e
    iget v2, p0, Lb/e/a/i/d/c/a;->F:I

    iget v3, p1, Lb/e/a/i/d/c/a;->F:I

    if-eq v2, v3, :cond_f

    return v1

    :cond_f
    iget v2, p0, Lb/e/a/i/d/c/a;->m:I

    iget v3, p1, Lb/e/a/i/d/c/a;->m:I

    if-eq v2, v3, :cond_10

    return v1

    :cond_10
    iget v2, p0, Lb/e/a/i/d/c/a;->l:I

    iget v3, p1, Lb/e/a/i/d/c/a;->l:I

    if-eq v2, v3, :cond_11

    return v1

    :cond_11
    iget v2, p0, Lb/e/a/i/d/c/a;->p:I

    iget v3, p1, Lb/e/a/i/d/c/a;->p:I

    if-eq v2, v3, :cond_12

    return v1

    :cond_12
    iget v2, p0, Lb/e/a/i/d/c/a;->v:I

    iget v3, p1, Lb/e/a/i/d/c/a;->v:I

    if-eq v2, v3, :cond_13

    return v1

    :cond_13
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->G:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->G:Z

    if-eq v2, v3, :cond_14

    return v1

    :cond_14
    iget v2, p0, Lb/e/a/i/d/c/a;->S:I

    iget v3, p1, Lb/e/a/i/d/c/a;->S:I

    if-eq v2, v3, :cond_15

    return v1

    :cond_15
    iget v2, p0, Lb/e/a/i/d/c/a;->T:I

    iget v3, p1, Lb/e/a/i/d/c/a;->T:I

    if-eq v2, v3, :cond_16

    return v1

    :cond_16
    iget v2, p0, Lb/e/a/i/d/c/a;->U:I

    iget v3, p1, Lb/e/a/i/d/c/a;->U:I

    if-eq v2, v3, :cond_17

    return v1

    :cond_17
    iget v2, p0, Lb/e/a/i/d/c/a;->R:I

    iget v3, p1, Lb/e/a/i/d/c/a;->R:I

    if-eq v2, v3, :cond_18

    return v1

    :cond_18
    iget v2, p0, Lb/e/a/i/d/c/a;->P:I

    iget v3, p1, Lb/e/a/i/d/c/a;->P:I

    if-eq v2, v3, :cond_19

    return v1

    :cond_19
    iget v2, p0, Lb/e/a/i/d/c/a;->O:I

    iget v3, p1, Lb/e/a/i/d/c/a;->O:I

    if-eq v2, v3, :cond_1a

    return v1

    :cond_1a
    iget v2, p0, Lb/e/a/i/d/c/a;->Q:I

    iget v3, p1, Lb/e/a/i/d/c/a;->Q:I

    if-eq v2, v3, :cond_1b

    return v1

    :cond_1b
    iget v2, p0, Lb/e/a/i/d/c/a;->L:I

    iget v3, p1, Lb/e/a/i/d/c/a;->L:I

    if-eq v2, v3, :cond_1c

    return v1

    :cond_1c
    iget v2, p0, Lb/e/a/i/d/c/a;->K:I

    iget v3, p1, Lb/e/a/i/d/c/a;->K:I

    if-eq v2, v3, :cond_1d

    return v1

    :cond_1d
    iget v2, p0, Lb/e/a/i/d/c/a;->H:I

    iget v3, p1, Lb/e/a/i/d/c/a;->H:I

    if-eq v2, v3, :cond_1e

    return v1

    :cond_1e
    iget v2, p0, Lb/e/a/i/d/c/a;->z:I

    iget v3, p1, Lb/e/a/i/d/c/a;->z:I

    if-eq v2, v3, :cond_1f

    return v1

    :cond_1f
    iget v2, p0, Lb/e/a/i/d/c/a;->B:I

    iget v3, p1, Lb/e/a/i/d/c/a;->B:I

    if-eq v2, v3, :cond_20

    return v1

    :cond_20
    iget v2, p0, Lb/e/a/i/d/c/a;->A:I

    iget v3, p1, Lb/e/a/i/d/c/a;->A:I

    if-eq v2, v3, :cond_21

    return v1

    :cond_21
    iget v2, p0, Lb/e/a/i/d/c/a;->J:I

    iget v3, p1, Lb/e/a/i/d/c/a;->J:I

    if-eq v2, v3, :cond_22

    return v1

    :cond_22
    iget v2, p0, Lb/e/a/i/d/c/a;->I:I

    iget v3, p1, Lb/e/a/i/d/c/a;->I:I

    if-eq v2, v3, :cond_23

    return v1

    :cond_23
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->V:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->V:Z

    if-eq v2, v3, :cond_24

    return v1

    :cond_24
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->k:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->k:Z

    if-eq v2, v3, :cond_25

    return v1

    :cond_25
    iget v2, p0, Lb/e/a/i/d/c/a;->o:I

    iget v3, p1, Lb/e/a/i/d/c/a;->o:I

    if-eq v2, v3, :cond_26

    return v1

    :cond_26
    iget v2, p0, Lb/e/a/i/d/c/a;->g:I

    iget v3, p1, Lb/e/a/i/d/c/a;->g:I

    if-eq v2, v3, :cond_27

    return v1

    :cond_27
    iget v2, p0, Lb/e/a/i/d/c/a;->f:I

    iget v3, p1, Lb/e/a/i/d/c/a;->f:I

    if-eq v2, v3, :cond_28

    return v1

    :cond_28
    iget-boolean v2, p0, Lb/e/a/i/d/c/a;->j:Z

    iget-boolean v3, p1, Lb/e/a/i/d/c/a;->j:Z

    if-eq v2, v3, :cond_29

    return v1

    :cond_29
    iget v2, p0, Lb/e/a/i/d/c/a;->s:I

    iget v3, p1, Lb/e/a/i/d/c/a;->s:I

    if-eq v2, v3, :cond_2a

    return v1

    :cond_2a
    iget v2, p0, Lb/e/a/i/d/c/a;->N:I

    iget v3, p1, Lb/e/a/i/d/c/a;->N:I

    if-eq v2, v3, :cond_2b

    return v1

    :cond_2b
    iget-object v2, p0, Lb/e/a/i/d/c/a;->W:[B

    iget-object p1, p1, Lb/e/a/i/d/c/a;->W:[B

    invoke-static {v2, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p1

    if-nez p1, :cond_2c

    return v1

    :cond_2c
    return v0

    :cond_2d
    :goto_0
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Lb/e/a/i/d/c/a;->W:[B

    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/util/Arrays;->hashCode([B)I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->d:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->f:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->g:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->h:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->i:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->j:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->k:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->l:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->m:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->n:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->o:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->p:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->q:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->r:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->s:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->v:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->w:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->x:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->y:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->z:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->A:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->B:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->C:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->D:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->E:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->F:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->G:Z

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->H:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->I:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->J:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->K:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->L:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->M:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->N:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->O:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->P:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->Q:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->R:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->S:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->T:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lb/e/a/i/d/c/a;->U:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->V:Z

    add-int/2addr v0, v1

    return v0
.end method

.method public o()Ljava/nio/ByteBuffer;
    .locals 2

    invoke-virtual {p0}, Lb/e/a/i/d/c/b;->b()I

    move-result v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lb/e/a/i/d/c/b;->a:I

    invoke-static {v0, v1}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    invoke-virtual {p0}, Lb/e/a/i/d/c/a;->a()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lb/e/a/i/d/c/b;->f(Ljava/nio/ByteBuffer;I)V

    invoke-direct {p0}, Lb/e/a/i/d/c/a;->p()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AudioSpecificConfig"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "{configBytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lb/e/a/i/d/c/a;->W:[B

    invoke-static {v1}, Lb/c/a/c;->a([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", audioObjectType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    iget v3, p0, Lb/e/a/i/d/c/a;->d:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ")"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ", samplingFrequencyIndex="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->f:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    iget v4, p0, Lb/e/a/i/d/c/a;->f:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ", samplingFrequency="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->g:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ", channelConfiguration="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->h:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->i:I

    if-lez v3, :cond_0

    const-string v3, ", extensionAudioObjectType="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->i:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Lb/e/a/i/d/c/a;->Y:Ljava/util/Map;

    iget v4, p0, Lb/e/a/i/d/c/a;->i:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ", sbrPresentFlag="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lb/e/a/i/d/c/a;->j:Z

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v3, ", psPresentFlag="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v3, p0, Lb/e/a/i/d/c/a;->k:Z

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v3, ", extensionSamplingFrequencyIndex="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lb/e/a/i/d/c/a;->l:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lb/e/a/i/d/c/a;->X:Ljava/util/Map;

    iget v3, p0, Lb/e/a/i/d/c/a;->l:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", extensionSamplingFrequency="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->m:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", extensionChannelConfiguration="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->n:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    :cond_0
    const-string v1, ", syncExtensionType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->s:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->G:Z

    if-eqz v1, :cond_1

    const-string v1, ", frameLengthFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->v:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", dependsOnCoreCoder="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->w:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", coreCoderDelay="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->x:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", extensionFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->y:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", layerNr="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->z:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", numOfSubFrame="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->A:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", layer_length="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->B:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", aacSectionDataResilienceFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->C:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", aacScalefactorDataResilienceFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->D:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", aacSpectralDataResilienceFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->E:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ", extensionFlag3="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->F:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    :cond_1
    iget-boolean v1, p0, Lb/e/a/i/d/c/a;->V:Z

    if-eqz v1, :cond_2

    const-string v1, ", isBaseLayer="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->H:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", paraMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->I:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", paraExtensionFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->J:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hvxcVarMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->K:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hvxcRateMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->L:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", erHvxcExtensionFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->M:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", var_ScalableFlag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->N:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnQuantMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->O:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnMaxNumLine="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->P:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnSampleRateCode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->Q:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnFrameLength="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->R:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnContMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->S:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnEnhaLayer="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->T:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", hilnEnhaQuantMode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lb/e/a/i/d/c/a;->U:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    :cond_2
    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
