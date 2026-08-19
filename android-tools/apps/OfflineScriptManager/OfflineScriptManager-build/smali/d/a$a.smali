.class public final enum Ld/a$a;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/a$a;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/a$a;

.field public static final enum c:Ld/a$a;

.field public static final enum d:Ld/a$a;

.field public static final enum e:Ld/a$a;

.field public static final enum f:Ld/a$a;

.field public static final enum g:Ld/a$a;

.field public static final enum h:Ld/a$a;

.field public static final enum i:Ld/a$a;

.field public static final enum j:Ld/a$a;

.field public static final enum k:Ld/a$a;

.field public static final enum l:Ld/a$a;

.field public static final enum m:Ld/a$a;

.field public static final enum n:Ld/a$a;

.field public static final enum o:Ld/a$a;

.field public static final enum p:Ld/a$a;

.field public static final enum q:Ld/a$a;

.field public static final enum r:Ld/a$a;

.field private static final synthetic s:[Ld/a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 20

    new-instance v0, Ld/a$a;

    const-string v1, "STOP"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/a$a;->b:Ld/a$a;

    new-instance v1, Ld/a$a;

    const-string v3, "PLUG"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/a$a;->c:Ld/a$a;

    new-instance v3, Ld/a$a;

    const-string v5, "OWN"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/a$a;->d:Ld/a$a;

    new-instance v5, Ld/a$a;

    const-string v7, "ATTACH"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v5, Ld/a$a;->e:Ld/a$a;

    new-instance v7, Ld/a$a;

    const-string v9, "BIND"

    const/4 v10, 0x4

    invoke-direct {v7, v9, v10}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v7, Ld/a$a;->f:Ld/a$a;

    new-instance v9, Ld/a$a;

    const-string v11, "ACTIVATE_READ"

    const/4 v12, 0x5

    invoke-direct {v9, v11, v12}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v9, Ld/a$a;->g:Ld/a$a;

    new-instance v11, Ld/a$a;

    const-string v13, "ACTIVATE_WRITE"

    const/4 v14, 0x6

    invoke-direct {v11, v13, v14}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v11, Ld/a$a;->h:Ld/a$a;

    new-instance v13, Ld/a$a;

    const-string v15, "HICCUP"

    const/4 v14, 0x7

    invoke-direct {v13, v15, v14}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v13, Ld/a$a;->i:Ld/a$a;

    new-instance v15, Ld/a$a;

    const-string v14, "PIPE_TERM"

    const/16 v12, 0x8

    invoke-direct {v15, v14, v12}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v15, Ld/a$a;->j:Ld/a$a;

    new-instance v14, Ld/a$a;

    const-string v12, "PIPE_TERM_ACK"

    const/16 v10, 0x9

    invoke-direct {v14, v12, v10}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v14, Ld/a$a;->k:Ld/a$a;

    new-instance v12, Ld/a$a;

    const-string v10, "TERM_REQ"

    const/16 v8, 0xa

    invoke-direct {v12, v10, v8}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v12, Ld/a$a;->l:Ld/a$a;

    new-instance v10, Ld/a$a;

    const-string v8, "TERM"

    const/16 v6, 0xb

    invoke-direct {v10, v8, v6}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v10, Ld/a$a;->m:Ld/a$a;

    new-instance v8, Ld/a$a;

    const-string v6, "TERM_ACK"

    const/16 v4, 0xc

    invoke-direct {v8, v6, v4}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v8, Ld/a$a;->n:Ld/a$a;

    new-instance v6, Ld/a$a;

    const-string v4, "REAP"

    const/16 v2, 0xd

    invoke-direct {v6, v4, v2}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v6, Ld/a$a;->o:Ld/a$a;

    new-instance v4, Ld/a$a;

    const-string v2, "REAPED"

    move-object/from16 v17, v6

    const/16 v6, 0xe

    invoke-direct {v4, v2, v6}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v4, Ld/a$a;->p:Ld/a$a;

    new-instance v2, Ld/a$a;

    const-string v6, "INPROC_CONNECTED"

    move-object/from16 v18, v4

    const/16 v4, 0xf

    invoke-direct {v2, v6, v4}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v2, Ld/a$a;->q:Ld/a$a;

    new-instance v6, Ld/a$a;

    const-string v4, "DONE"

    move-object/from16 v19, v2

    const/16 v2, 0x10

    invoke-direct {v6, v4, v2}, Ld/a$a;-><init>(Ljava/lang/String;I)V

    sput-object v6, Ld/a$a;->r:Ld/a$a;

    const/16 v4, 0x11

    new-array v4, v4, [Ld/a$a;

    const/16 v16, 0x0

    aput-object v0, v4, v16

    const/4 v0, 0x1

    aput-object v1, v4, v0

    const/4 v0, 0x2

    aput-object v3, v4, v0

    const/4 v0, 0x3

    aput-object v5, v4, v0

    const/4 v0, 0x4

    aput-object v7, v4, v0

    const/4 v0, 0x5

    aput-object v9, v4, v0

    const/4 v0, 0x6

    aput-object v11, v4, v0

    const/4 v0, 0x7

    aput-object v13, v4, v0

    const/16 v0, 0x8

    aput-object v15, v4, v0

    const/16 v0, 0x9

    aput-object v14, v4, v0

    const/16 v0, 0xa

    aput-object v12, v4, v0

    const/16 v0, 0xb

    aput-object v10, v4, v0

    const/16 v0, 0xc

    aput-object v8, v4, v0

    const/16 v0, 0xd

    aput-object v17, v4, v0

    const/16 v0, 0xe

    aput-object v18, v4, v0

    const/16 v0, 0xf

    aput-object v19, v4, v0

    aput-object v6, v4, v2

    sput-object v4, Ld/a$a;->s:[Ld/a$a;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/a$a;
    .locals 1

    const-class v0, Ld/a$a;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/a$a;

    return-object p0
.end method

.method public static values()[Ld/a$a;
    .locals 4

    sget-object v0, Ld/a$a;->s:[Ld/a$a;

    array-length v1, v0

    new-array v2, v1, [Ld/a$a;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
