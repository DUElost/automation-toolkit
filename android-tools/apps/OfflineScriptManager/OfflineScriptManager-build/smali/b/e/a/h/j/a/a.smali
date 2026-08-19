.class public Lb/e/a/h/j/a/a;
.super Ljava/lang/Object;
.source ""


# direct methods
.method public static a(Lb/e/a/e;)Lb/e/a/h/d;
    .locals 11

    new-instance v0, Lb/c/a/d;

    invoke-direct {v0, p0}, Lb/c/a/d;-><init>(Lb/e/a/e;)V

    new-instance v1, Lb/e/a/h/d;

    invoke-direct {v1}, Lb/e/a/h/d;-><init>()V

    invoke-virtual {v0}, Lb/c/a/d;->G()Lb/c/a/i/q;

    move-result-object v2

    const-class v3, Lb/c/a/i/f0;

    invoke-virtual {v2, v3}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v0}, Lb/c/a/d;->G()Lb/c/a/i/q;

    move-result-object p0

    invoke-virtual {p0}, Lb/c/a/i/q;->G()Lb/c/a/i/r;

    move-result-object p0

    invoke-virtual {p0}, Lb/c/a/i/r;->v()Lb/e/a/j/h;

    move-result-object p0

    invoke-virtual {v1, p0}, Lb/e/a/h/d;->h(Lb/e/a/j/h;)V

    return-object v1

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/f0;

    const-string v4, "mdia[0]/minf[0]/stbl[0]/stsd[0]/enc.[0]/sinf[0]/schm[0]"

    invoke-static {v3, v4}, Lb/e/a/j/j;->a(Lb/e/a/b;Ljava/lang/String;)Lb/c/a/i/b;

    move-result-object v4

    check-cast v4, Lb/c/a/i/y;

    const/4 v5, 0x0

    const-string v6, "]"

    const-string v7, "["

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lb/c/a/i/y;->s()Ljava/lang/String;

    move-result-object v8

    const-string v9, "cenc"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_1

    invoke-virtual {v4}, Lb/c/a/i/y;->s()Ljava/lang/String;

    move-result-object v4

    const-string v8, "cbc1"

    invoke-virtual {v4, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_1
    new-instance v4, Lb/e/a/h/b;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object v7

    invoke-virtual {v7}, Lb/c/a/i/g0;->A()J

    move-result-wide v9

    invoke-virtual {v8, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v5, v5, [Lb/c/a/d;

    invoke-direct {v4, v6, v3, v5}, Lb/e/a/h/b;-><init>(Ljava/lang/String;Lb/c/a/i/f0;[Lb/c/a/d;)V

    goto :goto_1

    :cond_2
    new-instance v4, Lb/e/a/h/e;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object v7

    invoke-virtual {v7}, Lb/c/a/i/g0;->A()J

    move-result-wide v9

    invoke-virtual {v8, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v5, v5, [Lb/c/a/d;

    invoke-direct {v4, v6, v3, v5}, Lb/e/a/h/e;-><init>(Ljava/lang/String;Lb/c/a/i/f0;[Lb/c/a/d;)V

    :goto_1
    invoke-virtual {v1, v4}, Lb/e/a/h/d;->a(Lb/e/a/h/g;)V

    goto/16 :goto_0
.end method
