.class public final Lc/c/a/k/i;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lc/c/a/k/i;",
        ">;"
    }
.end annotation


# static fields
.field public static final c:Lc/c/a/k/i;

.field public static final d:Lc/c/a/k/i;

.field public static final e:Lc/c/a/k/i;

.field public static final f:Lc/c/a/k/i;

.field public static final g:Lc/c/a/k/i;

.field public static final h:Lc/c/a/k/i;

.field public static final i:Lc/c/a/k/i;

.field public static final j:Lc/c/a/k/i;

.field public static final k:Lc/c/a/k/i;

.field public static final l:Lc/c/a/k/i;

.field public static final m:Lc/c/a/k/i;

.field public static final n:Lc/c/a/k/i;

.field public static final o:Lc/c/a/k/i;

.field public static final p:Lc/c/a/k/i;

.field public static final q:Lc/c/a/k/i;

.field public static final r:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lc/c/a/k/i;",
            "Ljava/util/Set<",
            "Ljava/lang/Class<",
            "*>;>;>;"
        }
    .end annotation
.end field


# instance fields
.field private final b:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:yaml"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->c:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:value"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->d:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:merge"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->e:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:set"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->f:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:pairs"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->g:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:omap"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->h:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:binary"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->i:Lc/c/a/k/i;

    new-instance v0, Lc/c/a/k/i;

    const-string v1, "tag:yaml.org,2002:int"

    invoke-direct {v0, v1}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/k/i;->j:Lc/c/a/k/i;

    new-instance v1, Lc/c/a/k/i;

    const-string v2, "tag:yaml.org,2002:float"

    invoke-direct {v1, v2}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v1, Lc/c/a/k/i;->k:Lc/c/a/k/i;

    new-instance v2, Lc/c/a/k/i;

    const-string v3, "tag:yaml.org,2002:timestamp"

    invoke-direct {v2, v3}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v2, Lc/c/a/k/i;->l:Lc/c/a/k/i;

    new-instance v3, Lc/c/a/k/i;

    const-string v4, "tag:yaml.org,2002:bool"

    invoke-direct {v3, v4}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v3, Lc/c/a/k/i;->m:Lc/c/a/k/i;

    new-instance v3, Lc/c/a/k/i;

    const-string v4, "tag:yaml.org,2002:null"

    invoke-direct {v3, v4}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v3, Lc/c/a/k/i;->n:Lc/c/a/k/i;

    new-instance v3, Lc/c/a/k/i;

    const-string v4, "tag:yaml.org,2002:str"

    invoke-direct {v3, v4}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v3, Lc/c/a/k/i;->o:Lc/c/a/k/i;

    new-instance v3, Lc/c/a/k/i;

    const-string v4, "tag:yaml.org,2002:seq"

    invoke-direct {v3, v4}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v3, Lc/c/a/k/i;->p:Lc/c/a/k/i;

    new-instance v3, Lc/c/a/k/i;

    const-string v4, "tag:yaml.org,2002:map"

    invoke-direct {v3, v4}, Lc/c/a/k/i;-><init>(Ljava/lang/String;)V

    sput-object v3, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v3, Lc/c/a/k/i;->r:Ljava/util/Map;

    new-instance v4, Ljava/util/HashSet;

    invoke-direct {v4}, Ljava/util/HashSet;-><init>()V

    const-class v5, Ljava/lang/Double;

    invoke-interface {v4, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v5, Ljava/lang/Float;

    invoke-interface {v4, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v5, Ljava/math/BigDecimal;

    invoke-interface {v4, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-interface {v3, v1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-class v4, Ljava/lang/Integer;

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v4, Ljava/lang/Long;

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v4, Ljava/math/BigInteger;

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-interface {v3, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    const-class v1, Ljava/util/Date;

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v1, Ljava/sql/Date;

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-class v1, Ljava/sql/Timestamp;

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    invoke-interface {v3, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "Class for tag must be provided."

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "tag:yaml.org,2002:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lc/c/a/p/b;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "Tag must be provided."

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-ne v0, v1, :cond_0

    invoke-static {p1}, Lc/c/a/p/b;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    return-void

    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Tag must not contain leading or trailing spaces."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Tag must not be empty."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public a(Lc/c/a/k/i;)I
    .locals 1

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    invoke-virtual {p1}, Lc/c/a/k/i;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/Class;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;)Z"
        }
    .end annotation

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "tag:yaml.org,2002:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lc/c/a/k/i;

    invoke-virtual {p0, p1}, Lc/c/a/k/i;->a(Lc/c/a/k/i;)I

    move-result p1

    return p1
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lc/c/a/k/i;

    if-eqz v1, :cond_1

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    check-cast p1, Lc/c/a/k/i;

    invoke-virtual {p1}, Lc/c/a/k/i;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_1
    instance-of v1, p1, Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    sget-object p1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string v0, "Comparing Tag and String is deprecated."

    invoke-virtual {p1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    const/4 p1, 0x1

    return p1

    :cond_2
    return v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/c/a/k/i;->b:Ljava/lang/String;

    return-object v0
.end method
