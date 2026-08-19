.class Lc/c/a/l/d;
.super Lc/c/a/l/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lc/c/a/l/d$d;,
        Lc/c/a/l/d$f;,
        Lc/c/a/l/d$e;,
        Lc/c/a/l/d$l;,
        Lc/c/a/l/d$i;,
        Lc/c/a/l/d$b;,
        Lc/c/a/l/d$a;,
        Lc/c/a/l/d$g;,
        Lc/c/a/l/d$h;,
        Lc/c/a/l/d$k;,
        Lc/c/a/l/d$c;,
        Lc/c/a/l/d$m;,
        Lc/c/a/l/d$j;
    }
.end annotation


# static fields
.field public static k:Ljava/util/regex/Pattern;


# instance fields
.field protected j:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "+",
            "Ljava/lang/Object;",
            ">;",
            "Lc/c/a/k/i;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F]"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/l/d;->k:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lc/c/a/l/a;-><init>()V

    new-instance v0, Lc/c/a/l/d$j;

    invoke-direct {v0, p0}, Lc/c/a/l/d$j;-><init>(Lc/c/a/l/d;)V

    iput-object v0, p0, Lc/c/a/l/a;->b:Lc/c/a/l/b;

    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    const-class v1, Ljava/lang/String;

    new-instance v2, Lc/c/a/l/d$m;

    invoke-direct {v2, p0}, Lc/c/a/l/d$m;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    const-class v1, Ljava/lang/Boolean;

    new-instance v2, Lc/c/a/l/d$c;

    invoke-direct {v2, p0}, Lc/c/a/l/d$c;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    const-class v1, Ljava/lang/Character;

    new-instance v2, Lc/c/a/l/d$m;

    invoke-direct {v2, p0}, Lc/c/a/l/d$m;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->a:Ljava/util/Map;

    const-class v1, [B

    new-instance v2, Lc/c/a/l/d$d;

    invoke-direct {v2, p0}, Lc/c/a/l/d$d;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/lang/Number;

    new-instance v2, Lc/c/a/l/d$k;

    invoke-direct {v2, p0}, Lc/c/a/l/d$k;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/List;

    new-instance v2, Lc/c/a/l/d$h;

    invoke-direct {v2, p0}, Lc/c/a/l/d$h;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/Map;

    new-instance v2, Lc/c/a/l/d$i;

    invoke-direct {v2, p0}, Lc/c/a/l/d$i;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/Set;

    new-instance v2, Lc/c/a/l/d$l;

    invoke-direct {v2, p0}, Lc/c/a/l/d$l;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/Iterator;

    new-instance v2, Lc/c/a/l/d$g;

    invoke-direct {v2, p0}, Lc/c/a/l/d$g;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    new-instance v2, Lc/c/a/l/d$b;

    invoke-direct {v2, p0}, Lc/c/a/l/d$b;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/Date;

    new-instance v2, Lc/c/a/l/d$e;

    invoke-direct {v2, p0}, Lc/c/a/l/d$e;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/lang/Enum;

    new-instance v2, Lc/c/a/l/d$f;

    invoke-direct {v2, p0}, Lc/c/a/l/d$f;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lc/c/a/l/a;->c:Ljava/util/Map;

    const-class v1, Ljava/util/Calendar;

    new-instance v2, Lc/c/a/l/d$e;

    invoke-direct {v2, p0}, Lc/c/a/l/d$e;-><init>(Lc/c/a/l/d;)V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lc/c/a/l/d;->j:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method protected l(Ljava/lang/Class;Lc/c/a/k/i;)Lc/c/a/k/i;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lc/c/a/k/i;",
            ")",
            "Lc/c/a/k/i;"
        }
    .end annotation

    iget-object v0, p0, Lc/c/a/l/d;->j:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p2, p0, Lc/c/a/l/d;->j:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lc/c/a/k/i;

    return-object p1

    :cond_0
    return-object p2
.end method
