.class public abstract enum Ld/r/d;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/r/d;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum c:Ld/r/d;

.field public static final enum d:Ld/r/d;

.field public static final enum e:Ld/r/d;

.field public static final enum f:Ld/r/d;

.field public static final enum g:Ld/r/d;

.field public static final enum h:Ld/r/d;

.field public static final enum i:Ld/r/d;

.field public static final enum j:Ld/r/d;

.field public static final enum k:Ld/r/d;

.field public static final enum l:Ld/r/d;

.field public static final enum m:Ld/r/d;

.field public static final enum n:Ld/r/d;

.field private static final synthetic o:[Ld/r/d;


# instance fields
.field private final b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 16

    new-instance v0, Ld/r/d$d;

    const-string v1, "PAIR"

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v2}, Ld/r/d$d;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v0, Ld/r/d;->c:Ld/r/d;

    new-instance v1, Ld/r/d$e;

    const-string v2, "SUB"

    const-string v4, "XSUB"

    filled-new-array {v2, v4}, [Ljava/lang/String;

    move-result-object v5

    const-string v6, "PUB"

    const/4 v7, 0x1

    invoke-direct {v1, v6, v7, v5}, Ld/r/d$e;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v1, Ld/r/d;->d:Ld/r/d;

    new-instance v5, Ld/r/d$f;

    const-string v8, "XPUB"

    filled-new-array {v6, v8}, [Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x2

    invoke-direct {v5, v2, v10, v9}, Ld/r/d$f;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v5, Ld/r/d;->e:Ld/r/d;

    new-instance v9, Ld/r/d$g;

    const-string v11, "REP"

    const-string v12, "ROUTER"

    filled-new-array {v11, v12}, [Ljava/lang/String;

    move-result-object v13

    const-string v14, "REQ"

    const/4 v15, 0x3

    invoke-direct {v9, v14, v15, v13}, Ld/r/d$g;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v9, Ld/r/d;->f:Ld/r/d;

    new-instance v13, Ld/r/d$h;

    const-string v15, "DEALER"

    filled-new-array {v14, v15}, [Ljava/lang/String;

    move-result-object v10

    const/4 v7, 0x4

    invoke-direct {v13, v11, v7, v10}, Ld/r/d$h;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v13, Ld/r/d;->g:Ld/r/d;

    new-instance v10, Ld/r/d$i;

    filled-new-array {v11, v15, v12}, [Ljava/lang/String;

    move-result-object v11

    const/4 v7, 0x5

    invoke-direct {v10, v15, v7, v11}, Ld/r/d$i;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v10, Ld/r/d;->h:Ld/r/d;

    new-instance v11, Ld/r/d$j;

    filled-new-array {v14, v15, v12}, [Ljava/lang/String;

    move-result-object v14

    const/4 v15, 0x6

    invoke-direct {v11, v12, v15, v14}, Ld/r/d$j;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v11, Ld/r/d;->i:Ld/r/d;

    new-instance v12, Ld/r/d$k;

    const-string v14, "PUSH"

    filled-new-array {v14}, [Ljava/lang/String;

    move-result-object v15

    const-string v7, "PULL"

    const/4 v3, 0x7

    invoke-direct {v12, v7, v3, v15}, Ld/r/d$k;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v12, Ld/r/d;->j:Ld/r/d;

    new-instance v15, Ld/r/d$l;

    filled-new-array {v7}, [Ljava/lang/String;

    move-result-object v7

    const/16 v3, 0x8

    invoke-direct {v15, v14, v3, v7}, Ld/r/d$l;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v15, Ld/r/d;->k:Ld/r/d;

    new-instance v7, Ld/r/d$a;

    filled-new-array {v2, v4}, [Ljava/lang/String;

    move-result-object v2

    const/16 v14, 0x9

    invoke-direct {v7, v8, v14, v2}, Ld/r/d$a;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v7, Ld/r/d;->l:Ld/r/d;

    new-instance v2, Ld/r/d$b;

    filled-new-array {v6, v8}, [Ljava/lang/String;

    move-result-object v6

    const/16 v8, 0xa

    invoke-direct {v2, v4, v8, v6}, Ld/r/d$b;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v2, Ld/r/d;->m:Ld/r/d;

    new-instance v4, Ld/r/d$c;

    const/4 v6, 0x0

    new-array v8, v6, [Ljava/lang/String;

    const-string v14, "STREAM"

    const/16 v3, 0xb

    invoke-direct {v4, v14, v3, v8}, Ld/r/d$c;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    sput-object v4, Ld/r/d;->n:Ld/r/d;

    const/16 v3, 0xc

    new-array v3, v3, [Ld/r/d;

    aput-object v0, v3, v6

    const/4 v0, 0x1

    aput-object v1, v3, v0

    const/4 v0, 0x2

    aput-object v5, v3, v0

    const/4 v0, 0x3

    aput-object v9, v3, v0

    const/4 v0, 0x4

    aput-object v13, v3, v0

    const/4 v0, 0x5

    aput-object v10, v3, v0

    const/4 v0, 0x6

    aput-object v11, v3, v0

    const/4 v0, 0x7

    aput-object v12, v3, v0

    const/16 v0, 0x8

    aput-object v15, v3, v0

    const/16 v0, 0x9

    aput-object v7, v3, v0

    const/16 v0, 0xa

    aput-object v2, v3, v0

    const/16 v0, 0xb

    aput-object v4, v3, v0

    sput-object v3, Ld/r/d;->o:[Ld/r/d;

    return-void
.end method

.method private varargs constructor <init>(Ljava/lang/String;I[Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Ld/r/d;->b:Ljava/util/List;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;I[Ljava/lang/String;Ld/r/d;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/r/d;-><init>(Ljava/lang/String;I[Ljava/lang/String;)V

    return-void
.end method

.method public static a(ILjava/lang/String;)Z
    .locals 1

    invoke-static {}, Ld/r/d;->values()[Ld/r/d;

    move-result-object v0

    aget-object p0, v0, p0

    iget-object p0, p0, Ld/r/d;->b:Ljava/util/List;

    invoke-interface {p0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static b(ILd/c;II)Ld/j;
    .locals 1

    invoke-static {}, Ld/r/d;->values()[Ld/r/d;

    move-result-object v0

    aget-object p0, v0, p0

    invoke-virtual {p0, p1, p2, p3}, Ld/r/d;->c(Ld/c;II)Ld/j;

    move-result-object p0

    return-object p0
.end method

.method public static e(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;
    .locals 8

    invoke-static {}, Ld/r/d;->values()[Ld/r/d;

    move-result-object v0

    iget v1, p3, Ld/f;->j:I

    aget-object v2, v0, v1

    move-object v3, p0

    move v4, p1

    move-object v5, p2

    move-object v6, p3

    move-object v7, p4

    invoke-virtual/range {v2 .. v7}, Ld/r/d;->d(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;

    move-result-object p0

    return-object p0
.end method

.method public static f(I)Ld/r/d;
    .locals 1

    invoke-static {}, Ld/r/d;->values()[Ld/r/d;

    move-result-object v0

    aget-object p0, v0, p0

    return-object p0
.end method

.method public static g(I)Ljava/lang/String;
    .locals 1

    invoke-static {}, Ld/r/d;->values()[Ld/r/d;

    move-result-object v0

    aget-object p0, v0, p0

    invoke-virtual {p0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Ld/r/d;
    .locals 1

    const-class v0, Ld/r/d;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/r/d;

    return-object p0
.end method

.method public static values()[Ld/r/d;
    .locals 4

    sget-object v0, Ld/r/d;->o:[Ld/r/d;

    array-length v1, v0

    new-array v2, v1, [Ld/r/d;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method abstract c(Ld/c;II)Ld/j;
.end method

.method public d(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)Ld/n/f;
    .locals 7

    new-instance v6, Ld/n/f;

    move-object v0, v6

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Ld/n/f;-><init>(Ld/n/d;ZLd/j;Ld/f;Ld/n/j/a;)V

    return-object v6
.end method
