.class public Lc/c/a/m/a;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final b:Ljava/util/regex/Pattern;

.field public static final c:Ljava/util/regex/Pattern;

.field public static final d:Ljava/util/regex/Pattern;

.field public static final e:Ljava/util/regex/Pattern;

.field public static final f:Ljava/util/regex/Pattern;

.field public static final g:Ljava/util/regex/Pattern;

.field public static final h:Ljava/util/regex/Pattern;

.field public static final i:Ljava/util/regex/Pattern;

.field public static final j:Ljava/util/regex/Pattern;


# instance fields
.field protected a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Character;",
            "Ljava/util/List<",
            "Lc/c/a/m/b;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "^(?:yes|Yes|YES|no|No|NO|true|True|TRUE|false|False|FALSE|on|On|ON|off|Off|OFF)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->b:Ljava/util/regex/Pattern;

    const-string v0, "^([-+]?(\\.[0-9]+|[0-9_]+(\\.[0-9_]*)?)([eE][-+]?[0-9]+)?|[-+]?[0-9][0-9_]*(?::[0-5]?[0-9])+\\.[0-9_]*|[-+]?\\.(?:inf|Inf|INF)|\\.(?:nan|NaN|NAN))$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->c:Ljava/util/regex/Pattern;

    const-string v0, "^(?:[-+]?0b[0-1_]+|[-+]?0[0-7_]+|[-+]?(?:0|[1-9][0-9_]*)|[-+]?0x[0-9a-fA-F_]+|[-+]?[1-9][0-9_]*(?::[0-5]?[0-9])+)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->d:Ljava/util/regex/Pattern;

    const-string v0, "^(?:<<)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->e:Ljava/util/regex/Pattern;

    const-string v0, "^(?:~|null|Null|NULL| )$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->f:Ljava/util/regex/Pattern;

    const-string v0, "^$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->g:Ljava/util/regex/Pattern;

    const-string v0, "^(?:[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9][0-9][0-9]-[0-9][0-9]?-[0-9][0-9]?(?:[Tt]|[ \t]+)[0-9][0-9]?:[0-9][0-9]:[0-9][0-9](?:\\.[0-9]*)?(?:[ \t]*(?:Z|[-+][0-9][0-9]?(?::[0-9][0-9])?))?)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->h:Ljava/util/regex/Pattern;

    const-string v0, "^(?:=)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->i:Ljava/util/regex/Pattern;

    const-string v0, "^(?:!|&|\\*)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/m/a;->j:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lc/c/a/m/a;-><init>(Z)V

    return-void
.end method

.method public constructor <init>(Z)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lc/c/a/m/a;->b()V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V
    .locals 6

    const/4 v0, 0x0

    if-nez p3, :cond_1

    iget-object p3, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/util/List;

    if-nez p3, :cond_0

    new-instance p3, Ljava/util/ArrayList;

    invoke-direct {p3}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-interface {v1, v0, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    new-instance v0, Lc/c/a/m/b;

    invoke-direct {v0, p1, p2}, Lc/c/a/m/b;-><init>(Lc/c/a/k/i;Ljava/util/regex/Pattern;)V

    invoke-interface {p3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    invoke-virtual {p3}, Ljava/lang/String;->toCharArray()[C

    move-result-object p3

    const/4 v1, 0x0

    array-length v2, p3

    :goto_0
    if-ge v1, v2, :cond_4

    new-instance v3, Ljava/lang/Character;

    aget-char v4, p3, v1

    invoke-direct {v3, v4}, Ljava/lang/Character;-><init>(C)V

    invoke-virtual {v3}, Ljava/lang/Character;->charValue()C

    move-result v4

    if-nez v4, :cond_2

    move-object v3, v0

    :cond_2
    iget-object v4, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-interface {v4, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/List;

    if-nez v4, :cond_3

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    iget-object v5, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-interface {v5, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    new-instance v3, Lc/c/a/m/b;

    invoke-direct {v3, p1, p2}, Lc/c/a/m/b;-><init>(Lc/c/a/k/i;Ljava/util/regex/Pattern;)V

    invoke-interface {v4, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    :goto_1
    return-void
.end method

.method protected b()V
    .locals 3

    sget-object v0, Lc/c/a/k/i;->m:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->b:Ljava/util/regex/Pattern;

    const-string v2, "yYnNtTfFoO"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->j:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->d:Ljava/util/regex/Pattern;

    const-string v2, "-+0123456789"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->k:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->c:Ljava/util/regex/Pattern;

    const-string v2, "-+0123456789."

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->e:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->e:Ljava/util/regex/Pattern;

    const-string v2, "<"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->n:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->f:Ljava/util/regex/Pattern;

    const-string v2, "~nN\u0000"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v1, Lc/c/a/m/a;->g:Ljava/util/regex/Pattern;

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->l:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->h:Ljava/util/regex/Pattern;

    const-string v2, "0123456789"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->d:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->i:Ljava/util/regex/Pattern;

    const-string v2, "="

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    sget-object v0, Lc/c/a/k/i;->c:Lc/c/a/k/i;

    sget-object v1, Lc/c/a/m/a;->j:Ljava/util/regex/Pattern;

    const-string v2, "!&*"

    invoke-virtual {p0, v0, v1, v2}, Lc/c/a/m/a;->a(Lc/c/a/k/i;Ljava/util/regex/Pattern;Ljava/lang/String;)V

    return-void
.end method

.method public c(Lc/c/a/k/e;Ljava/lang/String;Z)Lc/c/a/k/i;
    .locals 2

    sget-object v0, Lc/c/a/k/e;->b:Lc/c/a/k/e;

    if-ne p1, v0, :cond_4

    if-eqz p3, :cond_4

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p3

    const/4 v0, 0x0

    if-nez p3, :cond_0

    iget-object p3, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    goto :goto_0

    :cond_0
    iget-object p3, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    :goto_0
    invoke-static {v0}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/util/List;

    if-eqz p3, :cond_2

    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_1
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/m/b;

    invoke-virtual {v0}, Lc/c/a/m/b;->b()Lc/c/a/k/i;

    move-result-object v1

    invoke-virtual {v0}, Lc/c/a/m/b;->a()Ljava/util/regex/Pattern;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_1

    return-object v1

    :cond_2
    iget-object p3, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    const/4 v0, 0x0

    invoke-interface {p3, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_4

    iget-object p3, p0, Lc/c/a/m/a;->a:Ljava/util/Map;

    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/util/List;

    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_3
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/m/b;

    invoke-virtual {v0}, Lc/c/a/m/b;->b()Lc/c/a/k/i;

    move-result-object v1

    invoke-virtual {v0}, Lc/c/a/m/b;->a()Ljava/util/regex/Pattern;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_3

    return-object v1

    :cond_4
    sget-object p2, Lc/c/a/m/a$a;->a:[I

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, p2, p1

    const/4 p2, 0x1

    if-eq p1, p2, :cond_6

    const/4 p2, 0x2

    if-eq p1, p2, :cond_5

    sget-object p1, Lc/c/a/k/i;->q:Lc/c/a/k/i;

    return-object p1

    :cond_5
    sget-object p1, Lc/c/a/k/i;->p:Lc/c/a/k/i;

    return-object p1

    :cond_6
    sget-object p1, Lc/c/a/k/i;->o:Lc/c/a/k/i;

    return-object p1
.end method
