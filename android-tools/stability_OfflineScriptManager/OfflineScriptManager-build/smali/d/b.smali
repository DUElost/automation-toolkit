.class public final enum Ld/b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Ld/b;

.field public static final enum d:Ld/b;

.field public static final enum e:Ld/b;

.field public static final enum f:Ld/b;

.field public static final enum g:Ld/b;

.field public static final enum h:Ld/b;

.field public static final enum i:Ld/b;

.field public static final enum j:Ld/b;

.field public static final enum k:Ld/b;

.field public static final enum l:Ld/b;

.field public static final enum m:Ld/b;

.field public static final enum n:Ld/b;

.field private static final synthetic o:[Ld/b;


# instance fields
.field private final b:I


# direct methods
.method static constructor <clinit>()V
    .locals 16

    new-instance v0, Ld/b;

    const-string v1, "MESSAGE_PIPE_GRANULARITY"

    const/4 v2, 0x0

    const/16 v3, 0x100

    invoke-direct {v0, v1, v2, v3}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v0, Ld/b;->c:Ld/b;

    new-instance v1, Ld/b;

    const-string v4, "COMMAND_PIPE_GRANULARITY"

    const/4 v5, 0x1

    const/16 v6, 0x10

    invoke-direct {v1, v4, v5, v6}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v1, Ld/b;->d:Ld/b;

    new-instance v4, Ld/b;

    const-string v6, "INBOUND_POLL_RATE"

    const/4 v7, 0x2

    const/16 v8, 0x64

    invoke-direct {v4, v6, v7, v8}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v4, Ld/b;->e:Ld/b;

    new-instance v6, Ld/b;

    const-string v8, "IN_BATCH_SIZE"

    const/4 v9, 0x3

    const/16 v10, 0x2000

    invoke-direct {v6, v8, v9, v10}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v6, Ld/b;->f:Ld/b;

    new-instance v8, Ld/b;

    const-string v11, "OUT_BATCH_SIZE"

    const/4 v12, 0x4

    invoke-direct {v8, v11, v12, v10}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v8, Ld/b;->g:Ld/b;

    new-instance v10, Ld/b;

    const-string v11, "MAX_WM_DELTA"

    const/4 v13, 0x5

    const/16 v14, 0x400

    invoke-direct {v10, v11, v13, v14}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v10, Ld/b;->h:Ld/b;

    new-instance v11, Ld/b;

    const-string v14, "MAX_IO_EVENTS"

    const/4 v15, 0x6

    invoke-direct {v11, v14, v15, v3}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v11, Ld/b;->i:Ld/b;

    new-instance v3, Ld/b;

    const-string v14, "MAX_COMMAND_DELAY"

    const/4 v15, 0x7

    const v13, 0x2dc6c0

    invoke-direct {v3, v14, v15, v13}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v3, Ld/b;->j:Ld/b;

    new-instance v13, Ld/b;

    const-string v14, "CLOCK_PRECISION"

    const/16 v15, 0x8

    const v12, 0xf4240

    invoke-direct {v13, v14, v15, v12}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v13, Ld/b;->k:Ld/b;

    new-instance v12, Ld/b;

    const-string v14, "PGM_MAX_TPDU"

    const/16 v15, 0x9

    const/16 v9, 0x5dc

    invoke-direct {v12, v14, v15, v9}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v12, Ld/b;->l:Ld/b;

    new-instance v9, Ld/b;

    const-string v14, "SIGNALER_PORT"

    const/16 v15, 0xa

    invoke-direct {v9, v14, v15, v2}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v9, Ld/b;->m:Ld/b;

    new-instance v14, Ld/b;

    const-string v15, "MSG_ALLOCATION_HEAP_THRESHOLD"

    const/16 v7, 0xb

    const/high16 v5, 0x100000

    invoke-direct {v14, v15, v7, v5}, Ld/b;-><init>(Ljava/lang/String;II)V

    sput-object v14, Ld/b;->n:Ld/b;

    const/16 v5, 0xc

    new-array v5, v5, [Ld/b;

    aput-object v0, v5, v2

    const/4 v0, 0x1

    aput-object v1, v5, v0

    const/4 v0, 0x2

    aput-object v4, v5, v0

    const/4 v0, 0x3

    aput-object v6, v5, v0

    const/4 v0, 0x4

    aput-object v8, v5, v0

    const/4 v0, 0x5

    aput-object v10, v5, v0

    const/4 v0, 0x6

    aput-object v11, v5, v0

    const/4 v0, 0x7

    aput-object v3, v5, v0

    const/16 v0, 0x8

    aput-object v13, v5, v0

    const/16 v0, 0x9

    aput-object v12, v5, v0

    const/16 v0, 0xa

    aput-object v9, v5, v0

    aput-object v14, v5, v7

    sput-object v5, Ld/b;->o:[Ld/b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Ld/b;->b:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/b;
    .locals 1

    const-class v0, Ld/b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/b;

    return-object p0
.end method

.method public static values()[Ld/b;
    .locals 4

    sget-object v0, Ld/b;->o:[Ld/b;

    array-length v1, v0

    new-array v2, v1, [Ld/b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Ld/b;->b:I

    return v0
.end method
