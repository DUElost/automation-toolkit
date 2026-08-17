.class public final Lxcrash/j;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lxcrash/j$a;
    }
.end annotation


# static fields
.field private static a:Z = false

.field private static b:Ljava/lang/String;

.field private static c:Lxcrash/f;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lxcrash/b;

    invoke-direct {v0}, Lxcrash/b;-><init>()V

    sput-object v0, Lxcrash/j;->c:Lxcrash/f;

    return-void
.end method

.method static a()Lxcrash/f;
    .locals 1

    sget-object v0, Lxcrash/j;->c:Lxcrash/f;

    return-object v0
.end method

.method public static b(Landroid/content/Context;)I
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lxcrash/j;->c(Landroid/content/Context;Lxcrash/j$a;)I

    move-result p0

    return p0
.end method

.method public static declared-synchronized c(Landroid/content/Context;Lxcrash/j$a;)I
    .locals 29

    const-class v1, Lxcrash/j;

    monitor-enter v1

    :try_start_0
    sget-boolean v0, Lxcrash/j;->a:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    monitor-exit v1

    return v2

    :cond_0
    const/4 v0, 0x1

    :try_start_1
    sput-boolean v0, Lxcrash/j;->a:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez p0, :cond_1

    const/4 v0, -0x1

    monitor-exit v1

    return v0

    :cond_1
    :try_start_2
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    if-eqz v3, :cond_2

    goto :goto_0

    :cond_2
    move-object/from16 v3, p0

    :goto_0
    if-nez p1, :cond_3

    new-instance v4, Lxcrash/j$a;

    invoke-direct {v4}, Lxcrash/j$a;-><init>()V

    move-object v15, v4

    goto :goto_1

    :cond_3
    move-object/from16 v15, p1

    :goto_1
    iget-object v4, v15, Lxcrash/j$a;->d:Lxcrash/f;

    if-eqz v4, :cond_4

    sput-object v4, Lxcrash/j;->c:Lxcrash/f;

    :cond_4
    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    sput-object v4, Lxcrash/j;->b:Ljava/lang/String;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_5

    const-string v5, "unknown"

    sput-object v5, Lxcrash/j;->b:Ljava/lang/String;

    :cond_5
    iget-object v5, v15, Lxcrash/j$a;->a:Ljava/lang/String;

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-static {v3}, Lxcrash/i;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v15, Lxcrash/j$a;->a:Ljava/lang/String;

    :cond_6
    iget-object v5, v15, Lxcrash/j$a;->a:Ljava/lang/String;

    iget-object v5, v15, Lxcrash/j$a;->b:Ljava/lang/String;

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_7

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v6, "/tombstones"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iput-object v5, v15, Lxcrash/j$a;->b:Ljava/lang/String;

    :cond_7
    iget-object v5, v15, Lxcrash/j$a;->b:Ljava/lang/String;

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v14

    const/4 v5, 0x0

    iget-boolean v6, v15, Lxcrash/j$a;->h:Z

    if-nez v6, :cond_9

    iget-boolean v6, v15, Lxcrash/j$a;->F:Z

    if-eqz v6, :cond_8

    goto :goto_3

    :cond_8
    :goto_2
    move-object/from16 v20, v5

    goto :goto_4

    :cond_9
    :goto_3
    invoke-static {v3, v14}, Lxcrash/i;->l(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v5

    iget-boolean v6, v15, Lxcrash/j$a;->F:Z

    if-eqz v6, :cond_8

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_a

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_8

    :cond_a
    iput-boolean v2, v15, Lxcrash/j$a;->F:Z

    goto :goto_2

    :goto_4
    invoke-static {}, Lxcrash/c;->l()Lxcrash/c;

    move-result-object v4

    iget-object v5, v15, Lxcrash/j$a;->b:Ljava/lang/String;

    iget v6, v15, Lxcrash/j$a;->j:I

    iget v7, v15, Lxcrash/j$a;->u:I

    iget v8, v15, Lxcrash/j$a;->H:I

    iget v9, v15, Lxcrash/j$a;->f:I

    iget v10, v15, Lxcrash/j$a;->g:I

    iget v11, v15, Lxcrash/j$a;->c:I

    invoke-virtual/range {v4 .. v11}, Lxcrash/c;->n(Ljava/lang/String;IIIIII)V

    iget-boolean v4, v15, Lxcrash/j$a;->h:Z

    if-eqz v4, :cond_b

    invoke-static {}, Lxcrash/g;->b()Lxcrash/g;

    move-result-object v4

    sget-object v8, Lxcrash/j;->b:Ljava/lang/String;

    iget-object v9, v15, Lxcrash/j$a;->a:Ljava/lang/String;

    iget-object v10, v15, Lxcrash/j$a;->b:Ljava/lang/String;

    iget-boolean v11, v15, Lxcrash/j$a;->i:Z

    iget v12, v15, Lxcrash/j$a;->k:I

    iget v13, v15, Lxcrash/j$a;->l:I

    iget v7, v15, Lxcrash/j$a;->m:I

    iget-boolean v6, v15, Lxcrash/j$a;->n:Z

    iget-boolean v5, v15, Lxcrash/j$a;->o:Z

    iget v0, v15, Lxcrash/j$a;->p:I

    iget-object v2, v15, Lxcrash/j$a;->q:[Ljava/lang/String;

    move-object/from16 v18, v2

    iget-object v2, v15, Lxcrash/j$a;->r:Lxcrash/d;

    move/from16 v16, v5

    move-object v5, v3

    move/from16 v17, v6

    move v6, v14

    move/from16 v19, v7

    move-object/from16 v7, v20

    move/from16 v23, v14

    move/from16 v14, v19

    move-object/from16 p0, v3

    move-object v3, v15

    move/from16 v15, v17

    move/from16 v17, v0

    move-object/from16 v19, v2

    invoke-virtual/range {v4 .. v19}, Lxcrash/g;->e(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZIIIZZI[Ljava/lang/String;Lxcrash/d;)V

    goto :goto_5

    :cond_b
    move-object/from16 p0, v3

    move/from16 v23, v14

    move-object v3, v15

    :goto_5
    iget-boolean v0, v3, Lxcrash/j$a;->F:Z

    const/16 v2, 0x15

    if-eqz v0, :cond_c

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v0, v2, :cond_c

    invoke-static {}, Lxcrash/a;->c()Lxcrash/a;

    move-result-object v4

    sget-object v8, Lxcrash/j;->b:Ljava/lang/String;

    iget-object v9, v3, Lxcrash/j$a;->a:Ljava/lang/String;

    iget-object v10, v3, Lxcrash/j$a;->b:Ljava/lang/String;

    iget v11, v3, Lxcrash/j$a;->I:I

    iget v12, v3, Lxcrash/j$a;->J:I

    iget v13, v3, Lxcrash/j$a;->K:I

    iget-boolean v14, v3, Lxcrash/j$a;->L:Z

    iget-object v15, v3, Lxcrash/j$a;->M:Lxcrash/d;

    move-object/from16 v5, p0

    move/from16 v6, v23

    move-object/from16 v7, v20

    invoke-virtual/range {v4 .. v15}, Lxcrash/a;->f(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIIZLxcrash/d;)V

    :cond_c
    iget-boolean v0, v3, Lxcrash/j$a;->s:Z

    if-nez v0, :cond_e

    iget-boolean v0, v3, Lxcrash/j$a;->F:Z

    if-eqz v0, :cond_d

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_d

    goto :goto_6

    :cond_d
    const/4 v2, 0x0

    goto/16 :goto_8

    :cond_e
    :goto_6
    invoke-static {}, Lxcrash/NativeHandler;->a()Lxcrash/NativeHandler;

    move-result-object v4

    iget-object v6, v3, Lxcrash/j$a;->e:Lxcrash/e;

    sget-object v7, Lxcrash/j;->b:Ljava/lang/String;

    iget-object v8, v3, Lxcrash/j$a;->a:Ljava/lang/String;

    iget-object v9, v3, Lxcrash/j$a;->b:Ljava/lang/String;

    iget-boolean v10, v3, Lxcrash/j$a;->s:Z

    iget-boolean v11, v3, Lxcrash/j$a;->t:Z

    iget v12, v3, Lxcrash/j$a;->v:I

    iget v13, v3, Lxcrash/j$a;->w:I

    iget v14, v3, Lxcrash/j$a;->x:I

    iget-boolean v15, v3, Lxcrash/j$a;->y:Z

    iget-boolean v0, v3, Lxcrash/j$a;->z:Z

    iget-boolean v5, v3, Lxcrash/j$a;->A:Z

    iget-boolean v2, v3, Lxcrash/j$a;->B:Z

    move/from16 v18, v2

    iget v2, v3, Lxcrash/j$a;->C:I

    move/from16 v19, v2

    iget-object v2, v3, Lxcrash/j$a;->D:[Ljava/lang/String;

    move-object/from16 v20, v2

    iget-object v2, v3, Lxcrash/j$a;->E:Lxcrash/d;

    move/from16 v16, v5

    iget-boolean v5, v3, Lxcrash/j$a;->F:Z

    if-eqz v5, :cond_f

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    move-object/from16 v23, v2

    const/16 v2, 0x15

    if-lt v5, v2, :cond_10

    const/16 v22, 0x1

    goto :goto_7

    :cond_f
    move-object/from16 v23, v2

    :cond_10
    const/16 v22, 0x0

    :goto_7
    iget-boolean v2, v3, Lxcrash/j$a;->G:Z

    iget v5, v3, Lxcrash/j$a;->I:I

    move/from16 v24, v2

    iget v2, v3, Lxcrash/j$a;->J:I

    move/from16 v25, v2

    iget v2, v3, Lxcrash/j$a;->K:I

    move/from16 v26, v2

    iget-boolean v2, v3, Lxcrash/j$a;->L:Z

    iget-object v3, v3, Lxcrash/j$a;->M:Lxcrash/d;

    move/from16 v27, v5

    move/from16 v17, v16

    move-object/from16 v5, p0

    move/from16 v16, v0

    move-object/from16 v21, v23

    move/from16 v23, v24

    move/from16 v24, v27

    move/from16 v27, v2

    move-object/from16 v28, v3

    invoke-virtual/range {v4 .. v28}, Lxcrash/NativeHandler;->c(Landroid/content/Context;Lxcrash/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZIIIZZZZI[Ljava/lang/String;Lxcrash/d;ZZIIIZLxcrash/d;)I

    move-result v2

    :goto_8
    invoke-static {}, Lxcrash/c;->l()Lxcrash/c;

    move-result-object v0

    invoke-virtual {v0}, Lxcrash/c;->o()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit v1

    return v2

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method
