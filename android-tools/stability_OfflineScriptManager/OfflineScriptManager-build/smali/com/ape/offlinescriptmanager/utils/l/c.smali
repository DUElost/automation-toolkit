.class public Lcom/ape/offlinescriptmanager/utils/l/c;
.super Lcom/ape/offlinescriptmanager/utils/l/b;
.source ""


# instance fields
.field private d:Z

.field private e:Z

.field private f:Z

.field private g:Z

.field private h:Ljava/lang/StringBuilder;

.field private final i:Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Collection<",
            "Lb/b/a/a/b/b;",
            ">;"
        }
    .end annotation
.end field

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lb/b/a/a/b/b;)V
    .locals 0

    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;-><init>(Ljava/util/Collection;)V

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

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->d:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->e:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->f:Z

    iput-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    return-void
.end method

.method private e(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    :goto_0
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    return-void
.end method

.method private f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "No trace info...\nPlease check if the testcase run is exist.\n\u8bf7\u68c0\u67e5\u7528\u4f8b\u662f\u5426\u5b58\u5728\u4e8e\u811a\u672c\u4e2d\u3002"

    return-object v0
.end method

.method private h(Ljava/lang/String;)V
    .locals 8

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->e:Z

    const/4 v1, 0x1

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/b/b;

    invoke-interface {v2}, Lb/b/a/a/b/b;->b()V

    goto :goto_0

    :cond_0
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->e:Z

    :cond_1
    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->f:Z

    const-string v2, "shortMsg="

    const-string v3, "INSTRUMENTATION_RESULT: "

    const-string v4, "INSTRUMENTATION_FAILED: "

    const/4 v5, 0x0

    const/4 v6, -0x1

    const-string v7, ":"

    if-nez v0, :cond_3

    invoke-virtual {p1, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-eq v0, v6, :cond_2

    invoke-virtual {p1, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->f:Z

    :cond_2
    invoke-virtual {p1, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-eq v0, v6, :cond_13

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-eq v0, v6, :cond_13

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    :goto_1
    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->e(Ljava/lang/String;)V

    goto/16 :goto_c

    :cond_3
    const-string v0, "Failure in"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    invoke-virtual {p1, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_13

    const/16 v0, 0xa

    :goto_2
    invoke-virtual {p1, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    goto/16 :goto_c

    :cond_4
    const-string v0, "Error in"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    invoke-virtual {p1, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_13

    const/16 v0, 0x8

    goto :goto_2

    :cond_5
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->j:Ljava/util/List;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_3
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    const-string v1, "\n\u811a\u672c\u4e2d\u65e0\u5bf9\u5e94\u7528\u4f8b\uff0c\u8bf7\u91cd\u65b0\u786e\u8ba4"

    invoke-interface {v0, v1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_3

    :cond_6
    const-string v0, "INSTRUMENTATION_STATUS: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    const/16 v0, 0x18

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/l/c;->i(Ljava/lang/String;I)V

    goto/16 :goto_c

    :cond_7
    const-string v0, "INSTRUMENTATION_STATUS_CODE: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->j(Ljava/lang/String;)I

    move-result p1

    if-ne p1, v6, :cond_13

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_4
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_4

    :cond_8
    const-string v0, "Test results for InstrumentationTestRunner"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    iput-boolean v5, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    const-string v0, "="

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    add-int/2addr v0, v1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_5
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_13

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/b/a/a/b/b;

    const-string v2, ".F"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    :goto_6
    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/c;->f()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    goto :goto_7

    :cond_9
    const-string v2, ".E"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    goto :goto_6

    :cond_a
    :goto_7
    invoke-interface {v1}, Lb/b/a/a/b/b;->c()V

    goto :goto_5

    :cond_b
    const-string v0, "FAILURES!"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_8
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_8

    :cond_c
    const-string v0, "OK "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_d

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_9
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_9

    :cond_d
    invoke-virtual {p1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_f

    invoke-virtual {p1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_e

    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    :cond_e
    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    if-eqz v0, :cond_13

    :goto_a
    goto/16 :goto_1

    :cond_f
    const-string v0, "INSTRUMENTATION_CODE: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->h:Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->length()I

    move-result p1

    if-lez p1, :cond_11

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_b
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/b/a/a/b/b;

    invoke-direct {p0}, Lcom/ape/offlinescriptmanager/utils/l/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v0}, Lb/b/a/a/b/b;->c()V

    goto :goto_b

    :cond_10
    const-string v0, "Time: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_12

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->k(Ljava/lang/String;)V

    :cond_11
    iput-boolean v5, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    goto :goto_c

    :cond_12
    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->g:Z

    if-eqz v0, :cond_13

    goto :goto_a

    :cond_13
    :goto_c
    return-void
.end method

.method private i(Ljava/lang/String;I)V
    .locals 2

    const-string v0, "="

    invoke-virtual {p1, v0, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    invoke-virtual {p1, p2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p2

    add-int/lit8 v0, v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/ape/offlinescriptmanager/utils/l/c;->l(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p1

    const-string v0, "Error"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/l/c;->e(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private j(Ljava/lang/String;)I
    .locals 1

    const/16 v0, 0x1d

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 p1, -0x1

    :goto_0
    return p1
.end method

.method private k(Ljava/lang/String;)V
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

    const-string v5, "RobotiumResultParser"

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

.method private l(Ljava/lang/String;I)Ljava/lang/String;
    .locals 0

    invoke-virtual {p1, p2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->d:Z

    return v0
.end method

.method public d([Ljava/lang/String;)V
    .locals 5

    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->j:Ljava/util/List;

    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    invoke-direct {p0, v2}, Lcom/ape/offlinescriptmanager/utils/l/c;->h(Ljava/lang/String;)V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "processNewLines: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "RobotiumResultParser"

    invoke-static {v3, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 4

    if-nez p1, :cond_0

    const-string p1, "Unknown error"

    :cond_0
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "RobotiumResultParser"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const/4 v1, 0x1

    new-array v3, v1, [Ljava/lang/Object;

    aput-object p1, v3, v2

    const-string v2, "test run failed: \'%1$s\'"

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    const-string v2, "%s %s"

    invoke-static {v2, v0}, Lcom/ape/offlinescriptmanager/utils/b;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->i:Ljava/util/Collection;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/b/a/a/b/b;

    iget-boolean v3, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->e:Z

    if-nez v3, :cond_1

    invoke-interface {v2}, Lb/b/a/a/b/b;->b()V

    :cond_1
    invoke-interface {v2, p1}, Lb/b/a/a/b/b;->d(Ljava/lang/String;)V

    invoke-interface {v2}, Lb/b/a/a/b/b;->c()V

    goto :goto_0

    :cond_2
    iput-boolean v1, p0, Lcom/ape/offlinescriptmanager/utils/l/c;->e:Z

    return-void
.end method
