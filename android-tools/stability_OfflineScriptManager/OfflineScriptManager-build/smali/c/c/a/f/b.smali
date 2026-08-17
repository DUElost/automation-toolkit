.class public final Lc/c/a/f/b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/c/a/f/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lc/c/a/f/b$d;,
        Lc/c/a/f/b$c;,
        Lc/c/a/f/b$b;,
        Lc/c/a/f/b$i;,
        Lc/c/a/f/b$e;,
        Lc/c/a/f/b$j;,
        Lc/c/a/f/b$p;,
        Lc/c/a/f/b$o;,
        Lc/c/a/f/b$n;,
        Lc/c/a/f/b$l;,
        Lc/c/a/f/b$q;,
        Lc/c/a/f/b$m;,
        Lc/c/a/f/b$g;,
        Lc/c/a/f/b$f;,
        Lc/c/a/f/b$h;,
        Lc/c/a/f/b$k;,
        Lc/c/a/f/b$r;,
        Lc/c/a/f/b$s;
    }
.end annotation


# static fields
.field private static final B:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Character;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static final C:[C

.field private static final D:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final E:Ljava/util/regex/Pattern;

.field private static final F:Ljava/util/regex/Pattern;


# instance fields
.field private A:Lc/c/a/a;

.field private final a:Ljava/io/Writer;

.field private final b:Lc/c/a/p/a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lc/c/a/p/a<",
            "Lc/c/a/f/d;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lc/c/a/f/d;

.field private final d:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lc/c/a/h/f;",
            ">;"
        }
    .end annotation
.end field

.field private e:Lc/c/a/h/f;

.field private final f:Lc/c/a/p/a;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lc/c/a/p/a<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/lang/Integer;

.field private h:I

.field private i:Z

.field private j:Z

.field private k:Z

.field private l:I

.field private m:Z

.field private n:Z

.field private o:Z

.field private p:Ljava/lang/Boolean;

.field private q:Ljava/lang/Boolean;

.field private r:Z

.field private s:I

.field private t:I

.field private u:[C

.field private v:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private w:Ljava/lang/String;

.field private x:Ljava/lang/String;

.field private y:Lc/c/a/f/e;

.field private z:Ljava/lang/Character;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lc/c/a/f/b;->B:Ljava/util/Map;

    const/4 v1, 0x1

    new-array v1, v1, [C

    const/16 v2, 0x20

    const/4 v3, 0x0

    aput-char v2, v1, v3

    sput-object v1, Lc/c/a/f/b;->C:[C

    new-instance v1, Ljava/lang/Character;

    invoke-direct {v1, v3}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "0"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/4 v2, 0x7

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "a"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x8

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "b"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x9

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "t"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0xa

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "n"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0xb

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "v"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0xc

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "f"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0xd

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "r"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x1b

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "e"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x22

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "\""

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x5c

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "\\"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x85

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "N"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0xa0

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "_"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x2028

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "L"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/Character;

    const/16 v2, 0x2029

    invoke-direct {v1, v2}, Ljava/lang/Character;-><init>(C)V

    const-string v2, "P"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Lc/c/a/f/b;->D:Ljava/util/Map;

    const-string v1, "!"

    invoke-interface {v0, v1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "tag:yaml.org,2002:"

    const-string v2, "!!"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "^![-_\\w]*!$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/f/b;->E:Ljava/util/regex/Pattern;

    const-string v0, "^[-_\\w]*$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lc/c/a/f/b;->F:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>(Ljava/io/Writer;Lc/c/a/a;)V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    new-instance p1, Lc/c/a/p/a;

    const/16 v0, 0x64

    invoke-direct {p1, v0}, Lc/c/a/p/a;-><init>(I)V

    iput-object p1, p0, Lc/c/a/f/b;->b:Lc/c/a/p/a;

    new-instance p1, Lc/c/a/f/b$s;

    const/4 v1, 0x0

    invoke-direct {p1, p0, v1}, Lc/c/a/f/b$s;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    iput-object p1, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    new-instance p1, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {p1, v0}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    iput-object p1, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    iput-object v1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    new-instance p1, Lc/c/a/p/a;

    const/16 v0, 0xa

    invoke-direct {p1, v0}, Lc/c/a/p/a;-><init>(I)V

    iput-object p1, p0, Lc/c/a/f/b;->f:Lc/c/a/p/a;

    iput-object v1, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    const/4 p1, 0x0

    iput p1, p0, Lc/c/a/f/b;->h:I

    iput-boolean p1, p0, Lc/c/a/f/b;->j:Z

    iput-boolean p1, p0, Lc/c/a/f/b;->k:Z

    iput p1, p0, Lc/c/a/f/b;->l:I

    const/4 v2, 0x1

    iput-boolean v2, p0, Lc/c/a/f/b;->m:Z

    iput-boolean v2, p0, Lc/c/a/f/b;->n:Z

    iput-boolean p1, p0, Lc/c/a/f/b;->o:Z

    invoke-virtual {p2}, Lc/c/a/a;->l()Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {p2}, Lc/c/a/a;->o()Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/f/b;->q:Ljava/lang/Boolean;

    invoke-virtual {p2}, Lc/c/a/a;->k()Z

    move-result p1

    iput-boolean p1, p0, Lc/c/a/f/b;->r:Z

    const/4 p1, 0x2

    iput p1, p0, Lc/c/a/f/b;->s:I

    invoke-virtual {p2}, Lc/c/a/a;->e()I

    move-result v3

    if-le v3, v2, :cond_0

    invoke-virtual {p2}, Lc/c/a/a;->e()I

    move-result v2

    if-ge v2, v0, :cond_0

    invoke-virtual {p2}, Lc/c/a/a;->e()I

    move-result v0

    iput v0, p0, Lc/c/a/f/b;->s:I

    :cond_0
    const/16 v0, 0x50

    iput v0, p0, Lc/c/a/f/b;->t:I

    invoke-virtual {p2}, Lc/c/a/a;->i()I

    move-result v0

    iget v2, p0, Lc/c/a/f/b;->s:I

    mul-int/2addr v2, p1

    if-le v0, v2, :cond_1

    invoke-virtual {p2}, Lc/c/a/a;->i()I

    move-result p1

    iput p1, p0, Lc/c/a/f/b;->t:I

    :cond_1
    invoke-virtual {p2}, Lc/c/a/a;->f()Lc/c/a/a$b;

    move-result-object p1

    invoke-virtual {p1}, Lc/c/a/a$b;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object p1

    iput-object p1, p0, Lc/c/a/f/b;->u:[C

    new-instance p1, Ljava/util/LinkedHashMap;

    invoke-direct {p1}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object p1, p0, Lc/c/a/f/b;->v:Ljava/util/Map;

    iput-object v1, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    iput-object v1, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    iput-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iput-object v1, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    iput-object p2, p0, Lc/c/a/f/b;->A:Lc/c/a/a;

    return-void
.end method

.method private A()Ljava/lang/Character;
    .locals 4

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast v0, Lc/c/a/h/k;

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lc/c/a/h/k;->f()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lc/c/a/f/b;->v(Ljava/lang/String;)Lc/c/a/f/e;

    move-result-object v1

    iput-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    :cond_0
    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    const/16 v2, 0x22

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Character;->charValue()C

    move-result v1

    if-eq v1, v2, :cond_2

    :cond_1
    iget-object v1, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    return-object v0

    :cond_3
    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    if-nez v1, :cond_7

    invoke-virtual {v0}, Lc/c/a/h/k;->c()Lc/c/a/h/g;

    move-result-object v1

    invoke-virtual {v1}, Lc/c/a/h/g;->b()Z

    move-result v1

    if-eqz v1, :cond_7

    iget-boolean v1, p0, Lc/c/a/f/b;->k:Z

    if-eqz v1, :cond_4

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v3, v1, Lc/c/a/f/e;->b:Z

    if-nez v3, :cond_7

    iget-boolean v1, v1, Lc/c/a/f/e;->c:Z

    if-nez v1, :cond_7

    :cond_4
    iget v1, p0, Lc/c/a/f/b;->h:I

    if-eqz v1, :cond_5

    iget-object v3, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v3, v3, Lc/c/a/f/e;->d:Z

    if-nez v3, :cond_6

    :cond_5
    if-nez v1, :cond_7

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v1, v1, Lc/c/a/f/e;->e:Z

    if-eqz v1, :cond_7

    :cond_6
    const/4 v0, 0x0

    return-object v0

    :cond_7
    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    if-eqz v1, :cond_9

    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Character;->charValue()C

    move-result v1

    const/16 v3, 0x7c

    if-eq v1, v3, :cond_8

    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Character;->charValue()C

    move-result v1

    const/16 v3, 0x3e

    if-ne v1, v3, :cond_9

    :cond_8
    iget v1, p0, Lc/c/a/f/b;->h:I

    if-nez v1, :cond_9

    iget-boolean v1, p0, Lc/c/a/f/b;->k:Z

    if-nez v1, :cond_9

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v1, v1, Lc/c/a/f/e;->g:Z

    if-eqz v1, :cond_9

    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v0

    return-object v0

    :cond_9
    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v1

    const/16 v3, 0x27

    if-eqz v1, :cond_a

    invoke-virtual {v0}, Lc/c/a/h/k;->d()Ljava/lang/Character;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Character;->charValue()C

    move-result v0

    if-ne v0, v3, :cond_c

    :cond_a
    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v1, v0, Lc/c/a/f/e;->f:Z

    if-eqz v1, :cond_c

    iget-boolean v1, p0, Lc/c/a/f/b;->k:Z

    if-eqz v1, :cond_b

    iget-boolean v0, v0, Lc/c/a/f/e;->c:Z

    if-nez v0, :cond_c

    :cond_b
    invoke-static {v3}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    return-object v0

    :cond_c
    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v0

    return-object v0
.end method

.method private B(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const-string v3, " "

    invoke-virtual {v1, v2, v3}, Lc/c/a/n/a;->b(CLjava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget v2, p0, Lc/c/a/f/b;->s:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v1, v2}, Lc/c/a/n/a;->c(C)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string p1, "-"

    :goto_0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-eq v2, v3, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x2

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result p1

    invoke-virtual {v1, p1}, Lc/c/a/n/a;->a(C)Z

    move-result p1

    if-eqz p1, :cond_3

    :cond_2
    const-string p1, "+"

    goto :goto_0

    :cond_3
    :goto_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private C()V
    .locals 2

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast v0, Lc/c/a/h/j;

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v0, "*"

    invoke-direct {p0, v0}, Lc/c/a/f/b;->S(Ljava/lang/String;)V

    iget-object v0, p0, Lc/c/a/f/b;->b:Lc/c/a/p/a;

    invoke-virtual {v0}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/f/d;

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void

    :cond_0
    new-instance v0, Lc/c/a/f/c;

    const-string v1, "anchor is not specified for alias"

    invoke-direct {v0, v1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private D()V
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Lc/c/a/f/b;->K(ZZ)V

    new-instance v0, Lc/c/a/f/b$i;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lc/c/a/f/b$i;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void
.end method

.method private E()V
    .locals 2

    iget-boolean v0, p0, Lc/c/a/f/b;->j:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lc/c/a/f/b;->n:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    invoke-direct {p0, v1, v0}, Lc/c/a/f/b;->K(ZZ)V

    new-instance v0, Lc/c/a/f/b$j;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lc/c/a/f/b$j;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void
.end method

.method private F()V
    .locals 3

    const-string v0, "{"

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v1, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget v0, p0, Lc/c/a/f/b;->h:I

    add-int/2addr v0, v1

    iput v0, p0, Lc/c/a/f/b;->h:I

    invoke-direct {p0, v1, v2}, Lc/c/a/f/b;->K(ZZ)V

    iget-object v0, p0, Lc/c/a/f/b;->q:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    :cond_0
    new-instance v0, Lc/c/a/f/b$l;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lc/c/a/f/b$l;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void
.end method

.method private G()V
    .locals 3

    const-string v0, "["

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v1, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iget v0, p0, Lc/c/a/f/b;->h:I

    add-int/2addr v0, v1

    iput v0, p0, Lc/c/a/f/b;->h:I

    invoke-direct {p0, v1, v2}, Lc/c/a/f/b;->K(ZZ)V

    iget-object v0, p0, Lc/c/a/f/b;->q:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    :cond_0
    new-instance v0, Lc/c/a/f/b$m;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lc/c/a/f/b$m;-><init>(Lc/c/a/f/b;Lc/c/a/f/b$a;)V

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void
.end method

.method private H(ZZZZ)V
    .locals 0

    iput-boolean p1, p0, Lc/c/a/f/b;->i:Z

    iput-boolean p3, p0, Lc/c/a/f/b;->j:Z

    iput-boolean p4, p0, Lc/c/a/f/b;->k:Z

    iget-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of p2, p1, Lc/c/a/h/a;

    if-eqz p2, :cond_0

    invoke-direct {p0}, Lc/c/a/f/b;->C()V

    goto/16 :goto_3

    :cond_0
    instance-of p2, p1, Lc/c/a/h/k;

    if-nez p2, :cond_2

    instance-of p1, p1, Lc/c/a/h/c;

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    new-instance p1, Lc/c/a/f/c;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "expected NodeEvent, but got "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    :goto_0
    const-string p1, "&"

    invoke-direct {p0, p1}, Lc/c/a/f/b;->S(Ljava/lang/String;)V

    invoke-direct {p0}, Lc/c/a/f/b;->U()V

    iget-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of p2, p1, Lc/c/a/h/k;

    if-eqz p2, :cond_3

    invoke-direct {p0}, Lc/c/a/f/b;->I()V

    goto :goto_3

    :cond_3
    instance-of p1, p1, Lc/c/a/h/m;

    if-eqz p1, :cond_6

    iget p1, p0, Lc/c/a/f/b;->h:I

    if-nez p1, :cond_5

    iget-object p1, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast p1, Lc/c/a/h/m;

    invoke-virtual {p1}, Lc/c/a/h/c;->c()Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_5

    invoke-direct {p0}, Lc/c/a/f/b;->y()Z

    move-result p1

    if-eqz p1, :cond_4

    goto :goto_1

    :cond_4
    invoke-direct {p0}, Lc/c/a/f/b;->E()V

    goto :goto_3

    :cond_5
    :goto_1
    invoke-direct {p0}, Lc/c/a/f/b;->G()V

    goto :goto_3

    :cond_6
    iget p1, p0, Lc/c/a/f/b;->h:I

    if-nez p1, :cond_8

    iget-object p1, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast p1, Lc/c/a/h/i;

    invoke-virtual {p1}, Lc/c/a/h/c;->c()Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_8

    invoke-direct {p0}, Lc/c/a/f/b;->x()Z

    move-result p1

    if-eqz p1, :cond_7

    goto :goto_2

    :cond_7
    invoke-direct {p0}, Lc/c/a/f/b;->D()V

    goto :goto_3

    :cond_8
    :goto_2
    invoke-direct {p0}, Lc/c/a/f/b;->F()V

    :goto_3
    return-void
.end method

.method private I()V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lc/c/a/f/b;->K(ZZ)V

    invoke-direct {p0}, Lc/c/a/f/b;->T()V

    iget-object v0, p0, Lc/c/a/f/b;->f:Lc/c/a/p/a;

    invoke-virtual {v0}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    iput-object v0, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    iget-object v0, p0, Lc/c/a/f/b;->b:Lc/c/a/p/a;

    invoke-virtual {v0}, Lc/c/a/p/a;->a()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/f/d;

    iput-object v0, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-void
.end method

.method private K(ZZ)V
    .locals 2

    iget-object v0, p0, Lc/c/a/f/b;->f:Lc/c/a/p/a;

    iget-object v1, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Lc/c/a/p/a;->b(Ljava/lang/Object;)V

    iget-object v0, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    if-nez v0, :cond_1

    if-eqz p1, :cond_0

    iget p1, p0, Lc/c/a/f/b;->s:I

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    :cond_1
    if-nez p2, :cond_2

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iget p2, p0, Lc/c/a/f/b;->s:I

    add-int/2addr p1, p2

    :goto_0
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    :cond_2
    return-void
.end method

.method private L(I)Z
    .locals 5

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    const/4 v1, 0x0

    move v2, v1

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lc/c/a/h/f;

    instance-of v4, v3, Lc/c/a/h/e;

    if-nez v4, :cond_4

    instance-of v4, v3, Lc/c/a/h/c;

    if-eqz v4, :cond_1

    goto :goto_1

    :cond_1
    instance-of v4, v3, Lc/c/a/h/d;

    if-nez v4, :cond_3

    instance-of v4, v3, Lc/c/a/h/b;

    if-eqz v4, :cond_2

    goto :goto_0

    :cond_2
    instance-of v3, v3, Lc/c/a/h/n;

    if-eqz v3, :cond_5

    const/4 v2, -0x1

    goto :goto_2

    :cond_3
    :goto_0
    add-int/lit8 v2, v2, -0x1

    goto :goto_2

    :cond_4
    :goto_1
    add-int/lit8 v2, v2, 0x1

    :cond_5
    :goto_2
    if-gez v2, :cond_0

    return v1

    :cond_6
    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->size()I

    move-result v0

    const/4 v2, 0x1

    add-int/2addr p1, v2

    if-ge v0, p1, :cond_7

    move v1, v2

    :cond_7
    return v1
.end method

.method private M()Z
    .locals 3

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->isEmpty()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->peek()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/h/f;

    instance-of v2, v0, Lc/c/a/h/e;

    if-eqz v2, :cond_1

    invoke-direct {p0, v1}, Lc/c/a/f/b;->L(I)Z

    move-result v0

    return v0

    :cond_1
    instance-of v1, v0, Lc/c/a/h/m;

    if-eqz v1, :cond_2

    const/4 v0, 0x2

    :goto_0
    invoke-direct {p0, v0}, Lc/c/a/f/b;->L(I)Z

    move-result v0

    return v0

    :cond_2
    instance-of v0, v0, Lc/c/a/h/i;

    if-eqz v0, :cond_3

    const/4 v0, 0x3

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    return v0
.end method

.method static N(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lc/c/a/f/b;->F:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    :cond_0
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "invalid character in the anchor: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    new-instance p0, Lc/c/a/f/c;

    const-string v0, "anchor must not be empty"

    invoke-direct {p0, v0}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private O(Ljava/lang/String;)Ljava/lang/String;
    .locals 6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_7

    const-string v0, "!"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object p1

    :cond_0
    const/4 v1, 0x0

    iget-object v2, p0, Lc/c/a/f/b;->v:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {p1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v4, v5, :cond_1

    :cond_2
    move-object v1, v3

    goto :goto_0

    :cond_3
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lc/c/a/f/b;->v:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    :cond_4
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    const/4 v2, 0x0

    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_5
    const-string p1, ""

    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    if-eqz v1, :cond_6

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_2
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_6
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!<"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ">"

    goto :goto_2

    :cond_7
    new-instance p1, Lc/c/a/f/c;

    const-string v0, "tag must not be empty"

    invoke-direct {p1, v0}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private P(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x21

    if-ne v0, v1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    if-ne v0, v1, :cond_2

    const-string v0, "!"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lc/c/a/f/b;->E:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "invalid character in the tag handle: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    :goto_0
    return-object p1

    :cond_2
    new-instance v0, Lc/c/a/f/c;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "tag handle must start and end with \'!\': "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_3
    new-instance p1, Lc/c/a/f/c;

    const-string v0, "tag handle must not be empty"

    invoke-direct {p1, v0}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private Q(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x21

    if-ne v2, v3, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_1

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    if-lez v2, :cond_2

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_3
    new-instance p1, Lc/c/a/f/c;

    const-string v0, "tag prefix must not be empty"

    invoke-direct {p1, v0}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private R([Ljava/lang/Integer;)Ljava/lang/String;
    .locals 6

    const/4 v0, 0x0

    aget-object v1, p1, v0

    const/4 v2, 0x1

    aget-object v3, p1, v2

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v4

    const-string v5, "."

    if-ne v4, v2, :cond_0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    new-instance v1, Lc/c/a/f/c;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unsupported YAML version: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v0, p1, v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object p1, p1, v2

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private S(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast v0, Lc/c/a/h/j;

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    iput-object v2, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    return-void

    :cond_0
    iget-object v1, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    if-nez v1, :cond_1

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lc/c/a/f/b;->N(Ljava/lang/String;)Ljava/lang/String;

    iput-object v0, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1, v1}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iput-object v2, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    return-void
.end method

.method private T()V
    .locals 3

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast v0, Lc/c/a/h/k;

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lc/c/a/h/k;->f()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lc/c/a/f/b;->v(Ljava/lang/String;)Lc/c/a/f/e;

    move-result-object v0

    iput-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    if-nez v0, :cond_1

    invoke-direct {p0}, Lc/c/a/f/b;->A()Ljava/lang/Character;

    move-result-object v0

    iput-object v0, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    :cond_1
    iget-object v0, p0, Lc/c/a/f/b;->A:Lc/c/a/a;

    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v2, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    invoke-static {v2}, Lc/c/a/a$c;->a(Ljava/lang/Character;)Lc/c/a/a$c;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lc/c/a/a;->a(Lc/c/a/f/e;Lc/c/a/a$c;)Lc/c/a/a$c;

    invoke-virtual {v2}, Lc/c/a/a$c;->b()Ljava/lang/Character;

    move-result-object v0

    iput-object v0, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    iget-boolean v1, p0, Lc/c/a/f/b;->k:Z

    xor-int/lit8 v1, v1, 0x1

    if-nez v0, :cond_2

    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v0, v0, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Lc/c/a/f/b;->b0(Ljava/lang/String;Z)V

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Ljava/lang/Character;->charValue()C

    move-result v0

    const/16 v2, 0x22

    if-eq v0, v2, :cond_6

    const/16 v2, 0x27

    if-eq v0, v2, :cond_5

    const/16 v1, 0x3e

    if-eq v0, v1, :cond_4

    const/16 v1, 0x7c

    if-eq v0, v1, :cond_3

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v0, v0, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lc/c/a/f/b;->a0(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v0, v0, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lc/c/a/f/b;->W(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v0, v0, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-direct {p0, v0, v1}, Lc/c/a/f/b;->c0(Ljava/lang/String;Z)V

    goto :goto_0

    :cond_6
    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v0, v0, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-direct {p0, v0, v1}, Lc/c/a/f/b;->V(Ljava/lang/String;Z)V

    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iput-object v0, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    return-void
.end method

.method private U()V
    .locals 4

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v1, v0, Lc/c/a/h/k;

    const/4 v2, 0x0

    if-eqz v1, :cond_5

    check-cast v0, Lc/c/a/h/k;

    invoke-virtual {v0}, Lc/c/a/h/k;->e()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    if-nez v3, :cond_0

    invoke-direct {p0}, Lc/c/a/f/b;->A()Ljava/lang/Character;

    move-result-object v3

    iput-object v3, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    :cond_0
    iget-object v3, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_1

    if-nez v1, :cond_4

    :cond_1
    iget-object v3, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    if-nez v3, :cond_2

    invoke-virtual {v0}, Lc/c/a/h/k;->c()Lc/c/a/h/g;

    move-result-object v3

    invoke-virtual {v3}, Lc/c/a/h/g;->b()Z

    move-result v3

    if-nez v3, :cond_3

    :cond_2
    iget-object v3, p0, Lc/c/a/f/b;->z:Ljava/lang/Character;

    if-eqz v3, :cond_4

    invoke-virtual {v0}, Lc/c/a/h/k;->c()Lc/c/a/h/g;

    move-result-object v3

    invoke-virtual {v3}, Lc/c/a/h/g;->a()Z

    move-result v3

    if-eqz v3, :cond_4

    :cond_3
    iput-object v2, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    return-void

    :cond_4
    invoke-virtual {v0}, Lc/c/a/h/k;->c()Lc/c/a/h/g;

    move-result-object v0

    invoke-virtual {v0}, Lc/c/a/h/g;->b()Z

    move-result v0

    if-eqz v0, :cond_7

    if-nez v1, :cond_7

    iput-object v2, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    const-string v1, "!"

    goto :goto_0

    :cond_5
    check-cast v0, Lc/c/a/h/c;

    invoke-virtual {v0}, Lc/c/a/h/c;->e()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_6

    if-nez v1, :cond_7

    :cond_6
    invoke-virtual {v0}, Lc/c/a/h/c;->d()Z

    move-result v0

    if-eqz v0, :cond_7

    iput-object v2, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    return-void

    :cond_7
    :goto_0
    if-eqz v1, :cond_9

    iget-object v0, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    if-nez v0, :cond_8

    invoke-direct {p0, v1}, Lc/c/a/f/b;->O(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    :cond_8
    iget-object v0, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    const/4 v1, 0x1

    const/4 v3, 0x0

    invoke-virtual {p0, v0, v1, v3, v3}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    iput-object v2, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    return-void

    :cond_9
    new-instance v0, Lc/c/a/f/c;

    const-string v1, "tag is not specified"

    invoke-direct {v0, v1}, Lc/c/a/f/c;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private V(Ljava/lang/String;Z)V
    .locals 11

    const-string v0, "\""

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    move v3, v2

    move v4, v3

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-gt v3, v5, :cond_b

    const/4 v5, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v3, v6, :cond_0

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v5

    :cond_0
    const/16 v6, 0x20

    const-string v7, "\\"

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v8

    const-string v9, "\"\\\u0085\u2028\u2029\ufeff"

    invoke-virtual {v9, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v8

    const/4 v9, -0x1

    if-ne v8, v9, :cond_1

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v8

    if-gt v6, v8, :cond_1

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v8

    const/16 v9, 0x7e

    if-le v8, v9, :cond_6

    :cond_1
    if-ge v4, v3, :cond_2

    sub-int v8, v3, v4

    iget v9, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v9, v8

    iput v9, p0, Lc/c/a/f/b;->l:I

    iget-object v9, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v9, p1, v4, v8}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    move v4, v3

    :cond_2
    if-eqz v5, :cond_6

    sget-object v4, Lc/c/a/f/b;->B:Ljava/util/Map;

    new-instance v8, Ljava/lang/Character;

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v9

    invoke-direct {v8, v9}, Ljava/lang/Character;-><init>(C)V

    invoke-interface {v4, v8}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v9, Ljava/lang/Character;

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v10

    invoke-direct {v9, v10}, Ljava/lang/Character;-><init>(C)V

    invoke-interface {v4, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    :goto_1
    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_3

    :cond_3
    iget-boolean v4, p0, Lc/c/a/f/b;->r:Z

    if-nez v4, :cond_5

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v4

    const/16 v8, 0xff

    const/16 v9, 0x10

    if-gt v4, v8, :cond_4

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "0"

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v8

    invoke-static {v8, v9}, Ljava/lang/Integer;->toString(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "\\x"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    add-int/lit8 v9, v9, -0x2

    goto :goto_2

    :cond_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "000"

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v8

    invoke-static {v8, v9}, Ljava/lang/Integer;->toString(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "\\u"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    add-int/lit8 v9, v9, -0x4

    :goto_2
    invoke-virtual {v4, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_5
    invoke-static {v5}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    :goto_3
    iget v8, p0, Lc/c/a/f/b;->l:I

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    add-int/2addr v8, v9

    iput v8, p0, Lc/c/a/f/b;->l:I

    iget-object v8, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v8, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    add-int/lit8 v4, v3, 0x1

    :cond_6
    if-lez v3, :cond_a

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    sub-int/2addr v8, v1

    if-ge v3, v8, :cond_a

    invoke-virtual {v5}, Ljava/lang/Character;->charValue()C

    move-result v5

    if-eq v5, v6, :cond_7

    if-lt v4, v3, :cond_a

    :cond_7
    iget v5, p0, Lc/c/a/f/b;->l:I

    sub-int v8, v3, v4

    add-int/2addr v5, v8

    iget v8, p0, Lc/c/a/f/b;->t:I

    if-le v5, v8, :cond_a

    if-eqz p2, :cond_a

    if-lt v4, v3, :cond_8

    move-object v5, v7

    goto :goto_4

    :cond_8
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :goto_4
    if-ge v4, v3, :cond_9

    move v4, v3

    :cond_9
    iget v8, p0, Lc/c/a/f/b;->l:I

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    add-int/2addr v8, v9

    iput v8, p0, Lc/c/a/f/b;->l:I

    iget-object v8, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v8, v5}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    iput-boolean v2, p0, Lc/c/a/f/b;->m:Z

    iput-boolean v2, p0, Lc/c/a/f/b;->n:Z

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v5, v6, :cond_a

    iget v5, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v5, v1

    iput v5, p0, Lc/c/a/f/b;->l:I

    iget-object v5, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v5, v7}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    :cond_a
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    :cond_b
    invoke-virtual {p0, v0, v2, v2, v2}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    return-void
.end method

.method private Z(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lc/c/a/f/b;->m:Z

    iput-boolean v0, p0, Lc/c/a/f/b;->n:Z

    const/4 v0, 0x0

    iput v0, p0, Lc/c/a/f/b;->l:I

    if-nez p1, :cond_0

    iget-object p1, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    iget-object v0, p0, Lc/c/a/f/b;->u:[C

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write([C)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v0, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method static synthetic b(Lc/c/a/f/b;)Lc/c/a/h/f;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    return-object p0
.end method

.method static synthetic c(Lc/c/a/f/b;)Ljava/lang/Boolean;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->p:Ljava/lang/Boolean;

    return-object p0
.end method

.method private c0(Ljava/lang/String;Z)V
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-string v2, "\'"

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v4, v4}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    move v5, v4

    move v6, v5

    move v7, v6

    move v8, v7

    :goto_0
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v9

    if-gt v5, v9, :cond_d

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v9

    if-ge v5, v9, :cond_0

    invoke-virtual {v1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v9

    goto :goto_1

    :cond_0
    move v9, v4

    :goto_1
    const/16 v10, 0x20

    if-eqz v6, :cond_2

    if-eqz v9, :cond_1

    if-eq v9, v10, :cond_9

    :cond_1
    add-int/lit8 v11, v8, 0x1

    if-ne v11, v5, :cond_8

    iget v11, v0, Lc/c/a/f/b;->l:I

    iget v12, v0, Lc/c/a/f/b;->t:I

    if-le v11, v12, :cond_8

    if-eqz p2, :cond_8

    if-eqz v8, :cond_8

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v11

    if-eq v5, v11, :cond_8

    goto :goto_4

    :cond_2
    if-eqz v7, :cond_7

    if-eqz v9, :cond_3

    sget-object v11, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v11, v9}, Lc/c/a/n/a;->c(C)Z

    move-result v11

    if-eqz v11, :cond_9

    :cond_3
    invoke-virtual {v1, v8}, Ljava/lang/String;->charAt(I)C

    move-result v11

    const/4 v12, 0x0

    const/16 v13, 0xa

    if-ne v11, v13, :cond_4

    invoke-direct {v0, v12}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_4
    invoke-virtual {v1, v8, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->toCharArray()[C

    move-result-object v8

    array-length v11, v8

    move v14, v4

    :goto_2
    if-ge v14, v11, :cond_6

    aget-char v15, v8, v14

    if-ne v15, v13, :cond_5

    invoke-direct {v0, v12}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    invoke-static {v15}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v15

    invoke-direct {v0, v15}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :goto_3
    add-int/lit8 v14, v14, 0x1

    goto :goto_2

    :cond_6
    :goto_4
    invoke-virtual/range {p0 .. p0}, Lc/c/a/f/b;->X()V

    goto :goto_5

    :cond_7
    sget-object v11, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    const-string v12, "\u0000 \'"

    invoke-virtual {v11, v9, v12}, Lc/c/a/n/a;->b(CLjava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_9

    if-ge v8, v5, :cond_9

    :cond_8
    sub-int v11, v5, v8

    iget v12, v0, Lc/c/a/f/b;->l:I

    add-int/2addr v12, v11

    iput v12, v0, Lc/c/a/f/b;->l:I

    iget-object v12, v0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v12, v1, v8, v11}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    :goto_5
    move v8, v5

    :cond_9
    const/16 v11, 0x27

    if-ne v9, v11, :cond_a

    iget v8, v0, Lc/c/a/f/b;->l:I

    add-int/lit8 v8, v8, 0x2

    iput v8, v0, Lc/c/a/f/b;->l:I

    iget-object v8, v0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    const-string v11, "\'\'"

    invoke-virtual {v8, v11}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    add-int/lit8 v8, v5, 0x1

    :cond_a
    if-eqz v9, :cond_c

    if-ne v9, v10, :cond_b

    move v6, v3

    goto :goto_6

    :cond_b
    move v6, v4

    :goto_6
    sget-object v7, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v7, v9}, Lc/c/a/n/a;->a(C)Z

    move-result v7

    :cond_c
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_0

    :cond_d
    invoke-virtual {v0, v2, v4, v4, v4}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    return-void
.end method

.method static synthetic d(Lc/c/a/f/b;)Z
    .locals 0

    invoke-direct {p0}, Lc/c/a/f/b;->w()Z

    move-result p0

    return p0
.end method

.method static synthetic e(Lc/c/a/f/b;)Lc/c/a/p/a;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->b:Lc/c/a/p/a;

    return-object p0
.end method

.method static synthetic f(Lc/c/a/f/b;ZZZZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lc/c/a/f/b;->H(ZZZZ)V

    return-void
.end method

.method static synthetic g(Lc/c/a/f/b;Ljava/lang/Integer;)Ljava/lang/Integer;
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    return-object p1
.end method

.method static synthetic h(Lc/c/a/f/b;)Lc/c/a/p/a;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->f:Lc/c/a/p/a;

    return-object p0
.end method

.method static synthetic i(Lc/c/a/f/b;)I
    .locals 2

    iget v0, p0, Lc/c/a/f/b;->h:I

    add-int/lit8 v1, v0, -0x1

    iput v1, p0, Lc/c/a/f/b;->h:I

    return v0
.end method

.method static synthetic j(Lc/c/a/f/b;Lc/c/a/f/d;)Lc/c/a/f/d;
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    return-object p1
.end method

.method static synthetic k(Lc/c/a/f/b;)I
    .locals 0

    iget p0, p0, Lc/c/a/f/b;->l:I

    return p0
.end method

.method static synthetic l(Lc/c/a/f/b;)I
    .locals 0

    iget p0, p0, Lc/c/a/f/b;->t:I

    return p0
.end method

.method static synthetic m(Lc/c/a/f/b;)Ljava/lang/Boolean;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->q:Ljava/lang/Boolean;

    return-object p0
.end method

.method static synthetic n(Lc/c/a/f/b;)Z
    .locals 0

    invoke-direct {p0}, Lc/c/a/f/b;->z()Z

    move-result p0

    return p0
.end method

.method static synthetic o(Lc/c/a/f/b;)Z
    .locals 0

    iget-boolean p0, p0, Lc/c/a/f/b;->o:Z

    return p0
.end method

.method static synthetic p(Lc/c/a/f/b;[Ljava/lang/Integer;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b;->R([Ljava/lang/Integer;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic q(Lc/c/a/f/b;)Ljava/util/Map;
    .locals 0

    iget-object p0, p0, Lc/c/a/f/b;->v:Ljava/util/Map;

    return-object p0
.end method

.method static synthetic r(Lc/c/a/f/b;Ljava/util/Map;)Ljava/util/Map;
    .locals 0

    iput-object p1, p0, Lc/c/a/f/b;->v:Ljava/util/Map;

    return-object p1
.end method

.method static synthetic s()Ljava/util/Map;
    .locals 1

    sget-object v0, Lc/c/a/f/b;->D:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic t(Lc/c/a/f/b;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b;->P(Ljava/lang/String;)Ljava/lang/String;

    return-object p1
.end method

.method static synthetic u(Lc/c/a/f/b;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lc/c/a/f/b;->Q(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private v(Ljava/lang/String;)Lc/c/a/f/e;
    .locals 20

    move-object/from16 v1, p1

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    new-instance v9, Lc/c/a/f/e;

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x1

    const/4 v6, 0x1

    const/4 v7, 0x1

    const/4 v8, 0x0

    move-object v0, v9

    move-object/from16 v1, p1

    invoke-direct/range {v0 .. v8}, Lc/c/a/f/e;-><init>(Ljava/lang/String;ZZZZZZZ)V

    return-object v9

    :cond_0
    const-string v0, "---"

    invoke-virtual {v1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v3, 0x1

    if-nez v0, :cond_2

    const-string v0, "..."

    invoke-virtual {v1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    const/4 v4, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    move v0, v3

    move v4, v0

    :goto_1
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v5

    if-eq v5, v3, :cond_4

    sget-object v5, Lc/c/a/n/a;->e:Lc/c/a/n/a;

    invoke-virtual {v1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-virtual {v5, v6}, Lc/c/a/n/a;->a(C)Z

    move-result v5

    if-eqz v5, :cond_3

    goto :goto_2

    :cond_3
    const/4 v5, 0x0

    goto :goto_3

    :cond_4
    :goto_2
    move v5, v3

    :goto_3
    move v14, v3

    move v6, v5

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    move v5, v4

    const/4 v4, 0x0

    :goto_4
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v7, v2, :cond_21

    invoke-virtual {v1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/4 v3, -0x1

    if-nez v7, :cond_9

    const-string v14, "#,[]{}&*!|>\'\"%@`"

    invoke-virtual {v14, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v14

    if-eq v14, v3, :cond_5

    const/4 v0, 0x1

    const/4 v5, 0x1

    :cond_5
    const/16 v3, 0x3f

    if-eq v2, v3, :cond_6

    const/16 v3, 0x3a

    if-ne v2, v3, :cond_8

    :cond_6
    if-eqz v6, :cond_7

    const/4 v0, 0x1

    :cond_7
    const/4 v5, 0x1

    :cond_8
    const/16 v3, 0x2d

    if-ne v2, v3, :cond_d

    if-eqz v6, :cond_d

    goto :goto_8

    :cond_9
    move/from16 v19, v0

    const-string v0, ",?[]{}"

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-eq v0, v3, :cond_a

    const/16 v0, 0x3a

    const/4 v5, 0x1

    goto :goto_5

    :cond_a
    const/16 v0, 0x3a

    :goto_5
    if-ne v2, v0, :cond_c

    if-eqz v6, :cond_b

    const/4 v0, 0x1

    goto :goto_6

    :cond_b
    move/from16 v0, v19

    :goto_6
    const/4 v5, 0x1

    goto :goto_7

    :cond_c
    move/from16 v0, v19

    :goto_7
    const/16 v3, 0x23

    if-ne v2, v3, :cond_d

    if-eqz v14, :cond_d

    :goto_8
    const/4 v0, 0x1

    const/4 v5, 0x1

    :cond_d
    sget-object v3, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v3, v2}, Lc/c/a/n/a;->a(C)Z

    move-result v3

    if-eqz v3, :cond_e

    const/4 v4, 0x1

    :cond_e
    const/16 v6, 0xa

    const/16 v14, 0x20

    if-eq v2, v6, :cond_13

    if-gt v14, v2, :cond_f

    const/16 v6, 0x7e

    if-le v2, v6, :cond_13

    :cond_f
    const/16 v6, 0x85

    if-eq v2, v6, :cond_11

    const/16 v6, 0xa0

    if-gt v6, v2, :cond_10

    const v6, 0xd7ff

    if-le v2, v6, :cond_11

    :cond_10
    const v6, 0xe000

    if-gt v6, v2, :cond_12

    const v6, 0xfffd

    if-gt v2, v6, :cond_12

    :cond_11
    const v6, 0xfeff

    if-eq v2, v6, :cond_12

    move-object/from16 v6, p0

    iget-boolean v14, v6, Lc/c/a/f/b;->r:Z

    if-nez v14, :cond_14

    goto :goto_9

    :cond_12
    move-object/from16 v6, p0

    :goto_9
    const/16 v14, 0x20

    const/4 v15, 0x1

    goto :goto_a

    :cond_13
    move-object/from16 v6, p0

    :cond_14
    const/16 v14, 0x20

    :goto_a
    if-ne v2, v14, :cond_18

    if-nez v7, :cond_15

    const/4 v8, 0x1

    :cond_15
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v14

    const/16 v16, 0x1

    add-int/lit8 v14, v14, -0x1

    if-ne v7, v14, :cond_16

    const/4 v10, 0x1

    :cond_16
    if-eqz v17, :cond_17

    const/4 v12, 0x1

    :cond_17
    const/16 v16, 0x1

    goto :goto_b

    :cond_18
    if-eqz v3, :cond_1c

    if-nez v7, :cond_19

    const/4 v9, 0x1

    :cond_19
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v14

    const/16 v17, 0x1

    add-int/lit8 v14, v14, -0x1

    if-ne v7, v14, :cond_1a

    const/4 v11, 0x1

    :cond_1a
    if-eqz v16, :cond_1b

    const/4 v13, 0x1

    :cond_1b
    const/16 v16, 0x0

    const/16 v17, 0x1

    goto :goto_c

    :cond_1c
    const/16 v16, 0x0

    :goto_b
    const/16 v17, 0x0

    :goto_c
    add-int/lit8 v7, v7, 0x1

    sget-object v14, Lc/c/a/n/a;->f:Lc/c/a/n/a;

    invoke-virtual {v14, v2}, Lc/c/a/n/a;->a(C)Z

    move-result v2

    if-nez v2, :cond_1e

    if-eqz v3, :cond_1d

    goto :goto_d

    :cond_1d
    const/4 v2, 0x0

    goto :goto_e

    :cond_1e
    :goto_d
    const/4 v2, 0x1

    :goto_e
    move/from16 v18, v0

    add-int/lit8 v0, v7, 0x1

    move/from16 v19, v2

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_20

    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-virtual {v14, v0}, Lc/c/a/n/a;->a(C)Z

    move-result v0

    if-nez v0, :cond_20

    if-eqz v3, :cond_1f

    goto :goto_f

    :cond_1f
    const/4 v0, 0x0

    goto :goto_10

    :cond_20
    :goto_f
    const/4 v0, 0x1

    :goto_10
    move v6, v0

    move/from16 v0, v18

    move/from16 v14, v19

    const/4 v3, 0x1

    goto/16 :goto_4

    :cond_21
    move-object/from16 v6, p0

    move/from16 v19, v0

    const/4 v7, 0x1

    if-nez v8, :cond_23

    if-nez v9, :cond_23

    if-nez v10, :cond_23

    if-eqz v11, :cond_22

    goto :goto_11

    :cond_22
    const/4 v0, 0x1

    const/16 v16, 0x1

    goto :goto_12

    :cond_23
    :goto_11
    const/4 v0, 0x0

    const/16 v16, 0x0

    :goto_12
    const/4 v2, 0x1

    xor-int/lit8 v3, v10, 0x1

    if-eqz v12, :cond_24

    const/4 v0, 0x0

    const/16 v16, 0x0

    :cond_24
    xor-int/2addr v2, v12

    if-nez v13, :cond_26

    if-eqz v15, :cond_25

    goto :goto_13

    :cond_25
    move v8, v2

    move v9, v3

    goto :goto_14

    :cond_26
    :goto_13
    const/4 v0, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/16 v16, 0x0

    :goto_14
    if-eqz v4, :cond_27

    const/4 v0, 0x0

    const/16 v16, 0x0

    :cond_27
    if-eqz v5, :cond_28

    const/16 v16, 0x0

    :cond_28
    if-eqz v19, :cond_29

    const/4 v5, 0x0

    goto :goto_15

    :cond_29
    move v5, v0

    :goto_15
    new-instance v10, Lc/c/a/f/e;

    const/4 v2, 0x0

    move-object v0, v10

    move-object/from16 v1, p1

    move v3, v4

    move/from16 v4, v16

    move v6, v8

    move v8, v9

    invoke-direct/range {v0 .. v8}, Lc/c/a/f/e;-><init>(Ljava/lang/String;ZZZZZZZ)V

    return-object v10
.end method

.method private w()Z
    .locals 3

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v0, v0, Lc/c/a/h/e;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->peek()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lc/c/a/h/f;

    instance-of v2, v0, Lc/c/a/h/k;

    if-eqz v2, :cond_1

    check-cast v0, Lc/c/a/h/k;

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_1

    invoke-virtual {v0}, Lc/c/a/h/k;->e()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_1

    invoke-virtual {v0}, Lc/c/a/h/k;->c()Lc/c/a/h/g;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Lc/c/a/h/k;->f()Ljava/lang/String;

    move-result-object v0

    const-string v2, ""

    if-ne v0, v2, :cond_1

    const/4 v1, 0x1

    :cond_1
    :goto_0
    return v1
.end method

.method private x()Z
    .locals 1

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v0, v0, Lc/c/a/h/i;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->peek()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/h;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private y()Z
    .locals 1

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v0, v0, Lc/c/a/h/m;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->peek()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Lc/c/a/h/l;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private z()Z
    .locals 5

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v1, v0, Lc/c/a/h/j;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    check-cast v0, Lc/c/a/h/j;

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    check-cast v0, Lc/c/a/h/j;

    invoke-virtual {v0}, Lc/c/a/h/j;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lc/c/a/f/b;->N(Ljava/lang/String;)Ljava/lang/String;

    iput-object v0, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lc/c/a/f/b;->w:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v2

    goto :goto_0

    :cond_1
    move v0, v2

    :goto_0
    const/4 v1, 0x0

    iget-object v3, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v4, v3, Lc/c/a/h/k;

    if-eqz v4, :cond_2

    check-cast v3, Lc/c/a/h/k;

    invoke-virtual {v3}, Lc/c/a/h/k;->e()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_2
    instance-of v4, v3, Lc/c/a/h/c;

    if-eqz v4, :cond_3

    check-cast v3, Lc/c/a/h/c;

    invoke-virtual {v3}, Lc/c/a/h/c;->e()Ljava/lang/String;

    move-result-object v1

    :cond_3
    :goto_1
    if-eqz v1, :cond_5

    iget-object v3, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    if-nez v3, :cond_4

    invoke-direct {p0, v1}, Lc/c/a/f/b;->O(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    :cond_4
    iget-object v1, p0, Lc/c/a/f/b;->x:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    :cond_5
    iget-object v1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v3, v1, Lc/c/a/h/k;

    if-eqz v3, :cond_7

    iget-object v3, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    if-nez v3, :cond_6

    check-cast v1, Lc/c/a/h/k;

    invoke-virtual {v1}, Lc/c/a/h/k;->f()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lc/c/a/f/b;->v(Ljava/lang/String;)Lc/c/a/f/e;

    move-result-object v1

    iput-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    :cond_6
    iget-object v1, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-object v1, v1, Lc/c/a/f/e;->a:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    :cond_7
    const/16 v1, 0x80

    if-ge v0, v1, :cond_a

    iget-object v0, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    instance-of v1, v0, Lc/c/a/h/a;

    if-nez v1, :cond_9

    instance-of v0, v0, Lc/c/a/h/k;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lc/c/a/f/b;->y:Lc/c/a/f/e;

    iget-boolean v1, v0, Lc/c/a/f/e;->b:Z

    if-nez v1, :cond_8

    iget-boolean v0, v0, Lc/c/a/f/e;->c:Z

    if-eqz v0, :cond_9

    :cond_8
    invoke-direct {p0}, Lc/c/a/f/b;->y()Z

    move-result v0

    if-nez v0, :cond_9

    invoke-direct {p0}, Lc/c/a/f/b;->x()Z

    move-result v0

    if-eqz v0, :cond_a

    :cond_9
    const/4 v2, 0x1

    :cond_a
    return v2
.end method


# virtual methods
.method J()V
    .locals 1

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v0}, Ljava/io/Writer;->flush()V

    return-void
.end method

.method W(Ljava/lang/String;)V
    .locals 14

    invoke-direct {p0, p1}, Lc/c/a/f/b;->B(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ">"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v2, v3, v3}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2b

    if-ne v0, v1, :cond_0

    iput-boolean v2, p0, Lc/c/a/f/b;->o:Z

    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    move v4, v2

    move v7, v4

    move v1, v3

    move v5, v1

    move v6, v5

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    if-gt v1, v8, :cond_e

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v8

    if-ge v1, v8, :cond_1

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v8

    goto :goto_1

    :cond_1
    move v8, v3

    :goto_1
    const/16 v9, 0x20

    if-eqz v4, :cond_7

    if-eqz v8, :cond_2

    sget-object v10, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v10, v8}, Lc/c/a/n/a;->c(C)Z

    move-result v10

    if-eqz v10, :cond_b

    :cond_2
    const/16 v10, 0xa

    if-nez v7, :cond_3

    if-eqz v8, :cond_3

    if-eq v8, v9, :cond_3

    invoke-virtual {p1, v6}, Ljava/lang/String;->charAt(I)C

    move-result v7

    if-ne v7, v10, :cond_3

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_3
    if-ne v8, v9, :cond_4

    move v7, v2

    goto :goto_2

    :cond_4
    move v7, v3

    :goto_2
    invoke-virtual {p1, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->toCharArray()[C

    move-result-object v6

    array-length v11, v6

    move v12, v3

    :goto_3
    if-ge v12, v11, :cond_6

    aget-char v13, v6, v12

    if-ne v13, v10, :cond_5

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    goto :goto_4

    :cond_5
    invoke-static {v13}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v13

    invoke-direct {p0, v13}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :goto_4
    add-int/lit8 v12, v12, 0x1

    goto :goto_3

    :cond_6
    if-eqz v8, :cond_a

    goto :goto_5

    :cond_7
    if-eqz v5, :cond_9

    if-eq v8, v9, :cond_b

    add-int/lit8 v10, v6, 0x1

    if-ne v10, v1, :cond_8

    iget v10, p0, Lc/c/a/f/b;->l:I

    iget v11, p0, Lc/c/a/f/b;->t:I

    if-le v10, v11, :cond_8

    :goto_5
    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    goto :goto_6

    :cond_8
    sub-int v10, v1, v6

    iget v11, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v11, v10

    iput v11, p0, Lc/c/a/f/b;->l:I

    iget-object v11, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v11, p1, v6, v10}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    goto :goto_6

    :cond_9
    sget-object v10, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    const-string v11, "\u0000 "

    invoke-virtual {v10, v8, v11}, Lc/c/a/n/a;->b(CLjava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_b

    sub-int v10, v1, v6

    iget v11, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v11, v10

    iput v11, p0, Lc/c/a/f/b;->l:I

    iget-object v11, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v11, p1, v6, v10}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    if-nez v8, :cond_a

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_a
    :goto_6
    move v6, v1

    :cond_b
    if-eqz v8, :cond_d

    sget-object v4, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v4, v8}, Lc/c/a/n/a;->a(C)Z

    move-result v4

    if-ne v8, v9, :cond_c

    move v5, v2

    goto :goto_7

    :cond_c
    move v5, v3

    :cond_d
    :goto_7
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    :cond_e
    return-void
.end method

.method X()V
    .locals 5

    iget-object v0, p0, Lc/c/a/f/b;->g:Ljava/lang/Integer;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    iget-boolean v2, p0, Lc/c/a/f/b;->n:Z

    if-eqz v2, :cond_1

    iget v2, p0, Lc/c/a/f/b;->l:I

    if-gt v2, v0, :cond_1

    if-ne v2, v0, :cond_2

    iget-boolean v2, p0, Lc/c/a/f/b;->m:Z

    if-nez v2, :cond_2

    :cond_1
    const/4 v2, 0x0

    invoke-direct {p0, v2}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_2
    iget v2, p0, Lc/c/a/f/b;->l:I

    if-ge v2, v0, :cond_4

    const/4 v3, 0x1

    iput-boolean v3, p0, Lc/c/a/f/b;->m:Z

    sub-int v2, v0, v2

    new-array v3, v2, [C

    :goto_1
    if-ge v1, v2, :cond_3

    const/16 v4, 0x20

    aput-char v4, v3, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_3
    iput v0, p0, Lc/c/a/f/b;->l:I

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v0, v3}, Ljava/io/Writer;->write([C)V

    :cond_4
    return-void
.end method

.method Y(Ljava/lang/String;ZZZ)V
    .locals 2

    iget-boolean v0, p0, Lc/c/a/f/b;->m:Z

    const/4 v1, 0x1

    if-nez v0, :cond_0

    if-eqz p2, :cond_0

    iget p2, p0, Lc/c/a/f/b;->l:I

    add-int/2addr p2, v1

    iput p2, p0, Lc/c/a/f/b;->l:I

    iget-object p2, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    sget-object v0, Lc/c/a/f/b;->C:[C

    invoke-virtual {p2, v0}, Ljava/io/Writer;->write([C)V

    :cond_0
    iput-boolean p3, p0, Lc/c/a/f/b;->m:Z

    iget-boolean p2, p0, Lc/c/a/f/b;->n:Z

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    if-eqz p4, :cond_1

    goto :goto_0

    :cond_1
    move v1, p3

    :goto_0
    iput-boolean v1, p0, Lc/c/a/f/b;->n:Z

    iget p2, p0, Lc/c/a/f/b;->l:I

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p4

    add-int/2addr p2, p4

    iput p2, p0, Lc/c/a/f/b;->l:I

    iput-boolean p3, p0, Lc/c/a/f/b;->o:Z

    iget-object p2, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {p2, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    return-void
.end method

.method public a(Lc/c/a/h/f;)V
    .locals 1

    iget-object v0, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {v0, p1}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    :goto_0
    invoke-direct {p0}, Lc/c/a/f/b;->M()Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lc/c/a/f/b;->d:Ljava/util/Queue;

    invoke-interface {p1}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lc/c/a/h/f;

    iput-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    iget-object p1, p0, Lc/c/a/f/b;->c:Lc/c/a/f/d;

    invoke-interface {p1}, Lc/c/a/f/d;->a()V

    const/4 p1, 0x0

    iput-object p1, p0, Lc/c/a/f/b;->e:Lc/c/a/h/f;

    goto :goto_0

    :cond_0
    return-void
.end method

.method a0(Ljava/lang/String;)V
    .locals 10

    invoke-direct {p0, p1}, Lc/c/a/f/b;->B(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "|"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v2, v3, v3}, Lc/c/a/f/b;->Y(Ljava/lang/String;ZZZ)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2b

    if-ne v0, v1, :cond_0

    iput-boolean v2, p0, Lc/c/a/f/b;->o:Z

    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    move v1, v3

    move v4, v1

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-gt v1, v5, :cond_a

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v1, v5, :cond_1

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    goto :goto_1

    :cond_1
    move v5, v3

    :goto_1
    if-eqz v2, :cond_5

    if-eqz v5, :cond_2

    sget-object v6, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v6, v5}, Lc/c/a/n/a;->c(C)Z

    move-result v6

    if-eqz v6, :cond_8

    :cond_2
    invoke-virtual {p1, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toCharArray()[C

    move-result-object v4

    array-length v6, v4

    move v7, v3

    :goto_2
    if-ge v7, v6, :cond_4

    aget-char v8, v4, v7

    const/16 v9, 0xa

    if-ne v8, v9, :cond_3

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    goto :goto_3

    :cond_3
    invoke-static {v8}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :goto_3
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    :cond_4
    if-eqz v5, :cond_7

    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    goto :goto_4

    :cond_5
    if-eqz v5, :cond_6

    sget-object v6, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v6, v5}, Lc/c/a/n/a;->a(C)Z

    move-result v6

    if-eqz v6, :cond_8

    :cond_6
    iget-object v6, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    sub-int v7, v1, v4

    invoke-virtual {v6, p1, v4, v7}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    if-nez v5, :cond_7

    invoke-direct {p0, v0}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_7
    :goto_4
    move v4, v1

    :cond_8
    if-eqz v5, :cond_9

    sget-object v2, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v2, v5}, Lc/c/a/n/a;->a(C)Z

    move-result v2

    :cond_9
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_a
    return-void
.end method

.method b0(Ljava/lang/String;Z)V
    .locals 13

    iget-boolean v0, p0, Lc/c/a/f/b;->i:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lc/c/a/f/b;->o:Z

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-boolean v0, p0, Lc/c/a/f/b;->m:Z

    if-nez v0, :cond_2

    iget v0, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v0, v1

    iput v0, p0, Lc/c/a/f/b;->l:I

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    sget-object v2, Lc/c/a/f/b;->C:[C

    invoke-virtual {v0, v2}, Ljava/io/Writer;->write([C)V

    :cond_2
    const/4 v0, 0x0

    iput-boolean v0, p0, Lc/c/a/f/b;->m:Z

    iput-boolean v0, p0, Lc/c/a/f/b;->n:Z

    move v2, v0

    move v3, v2

    move v4, v3

    move v5, v4

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    if-gt v2, v6, :cond_d

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v2, v6, :cond_3

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v6

    goto :goto_1

    :cond_3
    move v6, v0

    :goto_1
    const/16 v7, 0x20

    if-eqz v3, :cond_4

    if-eq v6, v7, :cond_a

    add-int/lit8 v8, v5, 0x1

    if-ne v8, v2, :cond_9

    iget v8, p0, Lc/c/a/f/b;->l:I

    iget v9, p0, Lc/c/a/f/b;->t:I

    if-le v8, v9, :cond_9

    if-eqz p2, :cond_9

    goto :goto_4

    :cond_4
    if-eqz v4, :cond_8

    sget-object v8, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v8, v6}, Lc/c/a/n/a;->c(C)Z

    move-result v8

    if-eqz v8, :cond_a

    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v8

    const/4 v9, 0x0

    const/16 v10, 0xa

    if-ne v8, v10, :cond_5

    invoke-direct {p0, v9}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :cond_5
    invoke-virtual {p1, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->toCharArray()[C

    move-result-object v5

    array-length v8, v5

    move v11, v0

    :goto_2
    if-ge v11, v8, :cond_7

    aget-char v12, v5, v11

    if-ne v12, v10, :cond_6

    invoke-direct {p0, v9}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    goto :goto_3

    :cond_6
    invoke-static {v12}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v12

    invoke-direct {p0, v12}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    :goto_3
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    :cond_7
    :goto_4
    invoke-virtual {p0}, Lc/c/a/f/b;->X()V

    iput-boolean v0, p0, Lc/c/a/f/b;->m:Z

    iput-boolean v0, p0, Lc/c/a/f/b;->n:Z

    goto :goto_5

    :cond_8
    if-eqz v6, :cond_9

    sget-object v8, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v8, v6}, Lc/c/a/n/a;->a(C)Z

    move-result v8

    if-eqz v8, :cond_a

    :cond_9
    sub-int v8, v2, v5

    iget v9, p0, Lc/c/a/f/b;->l:I

    add-int/2addr v9, v8

    iput v9, p0, Lc/c/a/f/b;->l:I

    iget-object v9, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v9, p1, v5, v8}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    :goto_5
    move v5, v2

    :cond_a
    if-eqz v6, :cond_c

    if-ne v6, v7, :cond_b

    move v3, v1

    goto :goto_6

    :cond_b
    move v3, v0

    :goto_6
    sget-object v4, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    invoke-virtual {v4, v6}, Lc/c/a/n/a;->a(C)Z

    move-result v4

    :cond_c
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    :cond_d
    return-void
.end method

.method d0()V
    .locals 0

    invoke-virtual {p0}, Lc/c/a/f/b;->J()V

    return-void
.end method

.method e0()V
    .locals 0

    return-void
.end method

.method f0(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    const-string v1, "%TAG "

    invoke-virtual {v0, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v0, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    iget-object p1, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    sget-object v0, Lc/c/a/f/b;->C:[C

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write([C)V

    iget-object p1, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {p1, p2}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    return-void
.end method

.method g0(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    const-string v1, "%YAML "

    invoke-virtual {v0, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    iget-object v0, p0, Lc/c/a/f/b;->a:Ljava/io/Writer;

    invoke-virtual {v0, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lc/c/a/f/b;->Z(Ljava/lang/String;)V

    return-void
.end method
