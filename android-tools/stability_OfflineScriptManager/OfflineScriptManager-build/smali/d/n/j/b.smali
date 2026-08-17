.class public final enum Ld/n/j/b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/j/b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum d:Ld/n/j/b;

.field public static final enum e:Ld/n/j/b;

.field public static final enum f:Ld/n/j/b;

.field public static final enum g:Ld/n/j/b;

.field public static final enum h:Ld/n/j/b;

.field public static final enum i:Ld/n/j/b;

.field public static final enum j:Ld/n/j/b;

.field private static final synthetic k:[Ld/n/j/b;


# instance fields
.field public final b:Z

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ld/r/d;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 16

    new-instance v0, Ld/n/j/b;

    const/4 v1, 0x0

    new-array v2, v1, [Ld/r/d;

    const-string v3, "inproc"

    const/4 v4, 0x1

    invoke-direct {v0, v3, v1, v4, v2}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v0, Ld/n/j/b;->d:Ld/n/j/b;

    new-instance v2, Ld/n/j/b;

    new-array v3, v1, [Ld/r/d;

    const-string v5, "ipc"

    invoke-direct {v2, v5, v4, v4, v3}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v2, Ld/n/j/b;->e:Ld/n/j/b;

    new-instance v3, Ld/n/j/b;

    new-array v5, v1, [Ld/r/d;

    const-string v6, "tcp"

    const/4 v7, 0x2

    invoke-direct {v3, v6, v7, v4, v5}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v3, Ld/n/j/b;->f:Ld/n/j/b;

    new-instance v5, Ld/n/j/b;

    const/4 v6, 0x4

    new-array v8, v6, [Ld/r/d;

    sget-object v9, Ld/r/d;->d:Ld/r/d;

    aput-object v9, v8, v1

    sget-object v10, Ld/r/d;->e:Ld/r/d;

    aput-object v10, v8, v4

    sget-object v11, Ld/r/d;->l:Ld/r/d;

    aput-object v11, v8, v7

    const/4 v12, 0x3

    aput-object v11, v8, v12

    const-string v13, "pgm"

    invoke-direct {v5, v13, v12, v1, v8}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v5, Ld/n/j/b;->g:Ld/n/j/b;

    new-instance v8, Ld/n/j/b;

    new-array v13, v6, [Ld/r/d;

    aput-object v9, v13, v1

    aput-object v10, v13, v4

    aput-object v11, v13, v7

    aput-object v11, v13, v12

    const-string v9, "epgm"

    invoke-direct {v8, v9, v6, v1, v13}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v8, Ld/n/j/b;->h:Ld/n/j/b;

    new-instance v9, Ld/n/j/b;

    new-array v10, v1, [Ld/r/d;

    const-string v11, "tipc"

    const/4 v13, 0x5

    invoke-direct {v9, v11, v13, v1, v10}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v9, Ld/n/j/b;->i:Ld/n/j/b;

    new-instance v10, Ld/n/j/b;

    new-array v11, v1, [Ld/r/d;

    const-string v14, "norm"

    const/4 v15, 0x6

    invoke-direct {v10, v14, v15, v1, v11}, Ld/n/j/b;-><init>(Ljava/lang/String;IZ[Ld/r/d;)V

    sput-object v10, Ld/n/j/b;->j:Ld/n/j/b;

    const/4 v11, 0x7

    new-array v11, v11, [Ld/n/j/b;

    aput-object v0, v11, v1

    aput-object v2, v11, v4

    aput-object v3, v11, v7

    aput-object v5, v11, v12

    aput-object v8, v11, v6

    aput-object v9, v11, v13

    aput-object v10, v11, v15

    sput-object v11, Ld/n/j/b;->k:[Ld/n/j/b;

    return-void
.end method

.method private varargs constructor <init>(Ljava/lang/String;IZ[Ld/r/d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-boolean p3, p0, Ld/n/j/b;->b:Z

    invoke-static {p4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Ld/n/j/b;->c:Ljava/util/List;

    return-void
.end method

.method public static b(Ljava/lang/String;)Ld/n/j/b;
    .locals 5

    invoke-static {}, Ld/n/j/b;->values()[Ld/n/j/b;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-lt v2, v1, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    return-object v3

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/j/b;
    .locals 1

    const-class v0, Ld/n/j/b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/j/b;

    return-object p0
.end method

.method public static values()[Ld/n/j/b;
    .locals 4

    sget-object v0, Ld/n/j/b;->k:[Ld/n/j/b;

    array-length v1, v0

    new-array v2, v1, [Ld/n/j/b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public final a(I)Z
    .locals 1

    iget-object v0, p0, Ld/n/j/b;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Ld/n/j/b;->c:Ljava/util/List;

    invoke-static {p1}, Ld/r/d;->f(I)Ld/r/d;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method
