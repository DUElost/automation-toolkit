.class public Lcom/ape/offlinescriptmanager/utils/l/g;
.super Lcom/ape/offlinescriptmanager/utils/l/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/utils/l/g$b;
    }
.end annotation


# static fields
.field private static final r:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final d:Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Collection<",
            "Lb/b/a/a/b/b;",
            ">;"
        }
    .end annotation
.end field

.field private e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

.field private f:Lcom/ape/offlinescriptmanager/utils/l/g$b;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/StringBuilder;

.field private i:Z

.field private j:Z

.field private k:Z

.field private l:Z

.field private m:I

.field private n:I

.field private o:Z

.field private p:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private q:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/ape/offlinescriptmanager/utils/l/g;->r:Ljava/util/Set;

    const-string v1, "test"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "class"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "stack"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "numtests"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "Error"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "shortMsg"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "stream"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "id"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    const-string v1, "current"

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public constructor <init>(Lb/b/a/a/b/b;)V
    .locals 0

    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;-><init>(Ljava/util/Collection;)V

    return-void
.end method

.method public constructor <init>(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lb/b/a/a/b/b;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/b;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->f:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->j:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->k:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->l:Z

    iput v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->m:I

    iput v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->n:I

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->p:Ljava/util/Map;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->q:Ljava/util/Map;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    return-void
.end method

.method private e()V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->f:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    return-void
.end method

.method private f()Lcom/ape/offlinescriptmanager/utils/l/g$b;
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    if-nez v0, :cond_0

    new-instance v0, Lcom/ape/offlinescriptmanager/utils/l/g$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;-><init>(Lcom/ape/offlinescriptmanager/utils/l/g$a;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->e:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    return-object v0
.end method

.method private g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/String;
    .locals 2

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->e(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->e(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/Object;

    const/4 v0, 0x0

    const-string v1, "UiautomatorResultParser"

    aput-object v1, p1, v0

    const/4 v0, 0x1

    const-string v1, "Could not find stack trace for failed test "

    aput-object v1, p1, v0

    const-string v0, "%s %s"

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/utils/b;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance p1, Ljava/lang/Throwable;

    const-string v0, "Unknown failure"

    invoke-direct {p1, v0}, Ljava/lang/Throwable;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private h()V
    .locals 4

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->j:Z

    if-nez v0, :cond_0

    const-string v0, "No test results"

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->n:I

    iget v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->m:I

    if-le v0, v1, :cond_1

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "Test run failed to complete"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v1, v2

    const/4 v0, 0x2

    iget v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->m:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v0

    const-string v0, "%1$s. Expected %2$d tests, received %3$d"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lcom/ape/offlinescriptmanager/utils/l/g;->i(Ljava/lang/String;)V

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/b/b;

    iget-boolean v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    if-nez v2, :cond_2

    invoke-interface {v1}, Lb/b/a/a/b/b;->b()V

    :cond_2
    invoke-interface {v1}, Lb/b/a/a/b/b;->c()V

    goto :goto_1

    :cond_3
    :goto_2
    return-void
.end method

.method private j(Ljava/lang/String;)V
    .locals 4

    const-string v0, "INSTRUMENTATION_STATUS_CODE: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->q()V

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;->l(Ljava/lang/String;)V

    goto/16 :goto_2

    :cond_0
    const-string v0, "INSTRUMENTATION_STATUS: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/16 v2, 0x18

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->q()V

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    :goto_0
    invoke-direct {p0, p1, v2}, Lcom/ape/offlinescriptmanager/utils/l/g;->k(Ljava/lang/String;I)V

    goto :goto_2

    :cond_1
    const-string v0, "INSTRUMENTATION_RESULT: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v3, 0x1

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->q()V

    iput-boolean v3, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    goto :goto_0

    :cond_2
    const-string v0, "INSTRUMENTATION_FAILED: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    const-string v0, "INSTRUMENTATION_CODE: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_1

    :cond_3
    const-string v0, "Time: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;->m(Ljava/lang/String;)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_5

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    :cond_5
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "UiautomatorResultParser"

    aput-object v2, v0, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unrecognized line "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v0, v3

    const-string p1, "%s %s"

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    :cond_6
    :goto_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->q()V

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    iput-boolean v3, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->j:Z

    :cond_7
    :goto_2
    return-void
.end method

.method private k(Ljava/lang/String;I)V
    .locals 2

    const/16 v0, 0x3d

    invoke-virtual {p1, v0, p2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    invoke-virtual {p1, p2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    add-int/lit8 v0, v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/l/g;->n(Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method private l(Ljava/lang/String;)V
    .locals 2

    const/16 v0, 0x1d

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->f()Lcom/ape/offlinescriptmanager/utils/l/g$b;

    move-result-object v0

    const/4 v1, -0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->h(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;

    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->h(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->h(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;

    :goto_0
    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    const/4 v1, 0x2

    if-eq p1, v1, :cond_0

    invoke-direct {p0, v0}, Lcom/ape/offlinescriptmanager/utils/l/g;->o(Lcom/ape/offlinescriptmanager/utils/l/g$b;)V

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->e()V

    :cond_0
    return-void
.end method

.method private m(Ljava/lang/String;)V
    .locals 8

    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, "Time: "

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "%s\\s*([\\d\\.]+)"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    const-string v4, "Unexpected time format %1$s"

    const-string v5, "UiautomatorResultParser"

    const/4 v6, 0x2

    const-string v7, "%s %s"

    if-eqz v2, :cond_0

    invoke-virtual {v1, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    :try_start_0
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-array v1, v6, [Ljava/lang/Object;

    aput-object v5, v1, v3

    new-array v2, v0, [Ljava/lang/Object;

    aput-object p1, v2, v3

    invoke-static {v4, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, v0

    invoke-static {v7, v1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    new-array v1, v6, [Ljava/lang/Object;

    aput-object v5, v1, v3

    new-array v2, v0, [Ljava/lang/Object;

    aput-object p1, v2, v3

    invoke-static {v4, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, v0

    invoke-static {v7, v1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method private n(Ljava/lang/String;I)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    invoke-virtual {p1, p2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    return-void
.end method

.method private o(Lcom/ape/offlinescriptmanager/utils/l/g$b;)V
    .locals 4

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->i()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;->p(Lcom/ape/offlinescriptmanager/utils/l/g$b;)V

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v1, -0x2

    const/4 v2, 0x1

    if-eq v0, v1, :cond_3

    const/4 v1, -0x1

    if-eq v0, v1, :cond_3

    if-eqz v0, :cond_2

    if-eq v0, v2, :cond_1

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    const-string v3, "UiautomatorResultParser"

    aput-object v3, v0, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown status code received: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v0, v2

    const-string p1, "%s %s"

    invoke-static {p1, v0}, Lcom/ape/offlinescriptmanager/utils/b;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-interface {v0}, Lb/b/a/a/b/b;->b()V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/b/b;

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/g;->g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v1}, Lb/b/a/a/b/b;->c()V

    goto :goto_3

    :cond_4
    iget p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->m:I

    add-int/2addr p1, v2

    iput p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->m:I

    :cond_5
    return-void
.end method

.method private p(Lcom/ape/offlinescriptmanager/utils/l/g$b;)V
    .locals 2

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    if-nez v0, :cond_1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/b/b;

    invoke-interface {v1}, Lb/b/a/a/b/b;->b()V

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->c(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->n:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    :cond_1
    return-void
.end method

.method private q()V
    .locals 6

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->o:Z

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_1

    sget-object v1, Lcom/ape/offlinescriptmanager/utils/l/g;->r:Ljava/util/Set;

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    invoke-interface {v1, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->p:Ljava/util/Map;

    :goto_0
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_2

    :cond_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v4, "shortMsg"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    new-array v1, v3, [Ljava/lang/Object;

    aput-object v0, v1, v2

    const-string v0, "Instrumentation run failed due to \'%1$s\'"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p0, v0}, Lcom/ape/offlinescriptmanager/utils/l/g;->i(Ljava/lang/String;)V

    goto/16 :goto_2

    :cond_1
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->f()Lcom/ape/offlinescriptmanager/utils/l/g$b;

    move-result-object v1

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v5, "class"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->a(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;

    goto/16 :goto_2

    :cond_2
    iget-object v4, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v5, "test"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->b(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_2

    :cond_3
    iget-object v4, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v5, "numtests"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->d(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/Integer;)Ljava/lang/Integer;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const-string v4, "UiautomatorResultParser"

    aput-object v4, v1, v2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unexpected integer number of tests, received "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v1, v3

    const-string v0, "%s %s"

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    :cond_4
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v3, "Error"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    goto :goto_1

    :cond_5
    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    const-string v3, "stack"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-static {v1, v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->f(Lcom/ape/offlinescriptmanager/utils/l/g$b;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_2

    :cond_6
    sget-object v1, Lcom/ape/offlinescriptmanager/utils/l/g;->r:Ljava/util/Set;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->q:Ljava/util/Map;

    goto/16 :goto_0

    :cond_7
    :goto_2
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->g:Ljava/lang/String;

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->h:Ljava/lang/StringBuilder;

    :cond_8
    return-void
.end method


# virtual methods
.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->l:Z

    return v0
.end method

.method public c()V
    .locals 1

    invoke-super {p0}, Lcom/ape/offlinescriptmanager/utils/l/b;->c()V

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->k:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/g;->h()V

    :cond_0
    return-void
.end method

.method public d([Ljava/lang/String;)V
    .locals 3

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/l/g;->j(Ljava/lang/String;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 6

    if-nez p1, :cond_0

    const-string p1, "Unknown error"

    :cond_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->f:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->i()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->f:Lcom/ape/offlinescriptmanager/utils/l/g$b;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/l/g$b;->g(Lcom/ape/offlinescriptmanager/utils/l/g$b;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v1, v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/b/b;

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "Test failed to run to completion"

    aput-object v5, v3, v4

    aput-object p1, v3, v1

    const/4 v4, 0x2

    const-string v5, "Check device logcat for details"

    aput-object v5, v3, v4

    const-string v4, "%1$s. Reason: \'%2$s\'. %3$s"

    invoke-static {v4, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v2}, Lb/b/a/a/b/b;->c()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->d:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/b/b;

    iget-boolean v3, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    if-nez v3, :cond_2

    invoke-interface {v2}, Lb/b/a/a/b/b;->b()V

    :cond_2
    invoke-interface {v2, p1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v2}, Lb/b/a/a/b/b;->c()V

    goto :goto_1

    :cond_3
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->i:Z

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/g;->k:Z

    return-void
.end method
