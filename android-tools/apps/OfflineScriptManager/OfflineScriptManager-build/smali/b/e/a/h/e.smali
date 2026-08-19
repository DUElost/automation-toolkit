.class public Lb/e/a/h/e;
.super Lb/e/a/h/a;
.source ""


# instance fields
.field e:Lb/c/a/i/f0;

.field f:[Lb/c/a/d;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation
.end field

.field private h:Lb/c/a/i/u;

.field private i:[J

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/c/a/i/d$a;",
            ">;"
        }
    .end annotation
.end field

.field private k:[J

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lb/c/a/i/t$a;",
            ">;"
        }
    .end annotation
.end field

.field private m:Lb/e/a/h/h;

.field private n:Ljava/lang/String;

.field private o:Lb/c/a/i/b0;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lb/e/a/h/e;

    return-void
.end method

.method public varargs constructor <init>(Ljava/lang/String;Lb/c/a/i/f0;[Lb/c/a/d;)V
    .locals 30

    move-object/from16 v7, p0

    move-object/from16 v8, p2

    move-object/from16 v0, p3

    const-class v9, Lb/e/a/i/d/d/e;

    invoke-direct/range {p0 .. p1}, Lb/e/a/h/a;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x0

    iput-object v1, v7, Lb/e/a/h/e;->k:[J

    new-instance v2, Lb/e/a/h/h;

    invoke-direct {v2}, Lb/e/a/h/h;-><init>()V

    iput-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    iput-object v1, v7, Lb/e/a/h/e;->o:Lb/c/a/i/b0;

    iput-object v8, v7, Lb/e/a/h/e;->e:Lb/c/a/i/f0;

    invoke-virtual/range {p2 .. p2}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/g0;->A()J

    move-result-wide v10

    new-instance v1, Lb/c/a/i/j0/a;

    invoke-direct {v1, v8, v0}, Lb/c/a/i/j0/a;-><init>(Lb/c/a/i/f0;[Lb/c/a/d;)V

    iput-object v1, v7, Lb/e/a/h/e;->g:Ljava/util/List;

    invoke-virtual/range {p2 .. p2}, Lb/c/a/i/f0;->G()Lb/c/a/i/n;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/n;->I()Lb/c/a/i/p;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/p;->G()Lb/c/a/i/w;

    move-result-object v12

    invoke-virtual/range {p2 .. p2}, Lb/c/a/i/f0;->G()Lb/c/a/i/n;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/n;->G()Lb/c/a/i/l;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/l;->s()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v7, Lb/e/a/h/e;->n:Ljava/lang/String;

    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v7, Lb/e/a/h/e;->l:Ljava/util/List;

    invoke-virtual {v12}, Lb/c/a/i/w;->M()Lb/c/a/i/e0;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/e0;->u()Ljava/util/List;

    move-result-object v1

    invoke-interface {v13, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    invoke-virtual {v12}, Lb/c/a/i/w;->H()Lb/c/a/i/d;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    invoke-virtual {v12}, Lb/c/a/i/w;->H()Lb/c/a/i/d;

    move-result-object v2

    invoke-virtual {v2}, Lb/c/a/i/d;->u()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    invoke-virtual {v12}, Lb/c/a/i/w;->I()Lb/c/a/i/t;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, v7, Lb/e/a/h/e;->l:Ljava/util/List;

    invoke-virtual {v12}, Lb/c/a/i/w;->I()Lb/c/a/i/t;

    move-result-object v2

    invoke-virtual {v2}, Lb/c/a/i/t;->s()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_1
    invoke-virtual {v12}, Lb/c/a/i/w;->L()Lb/c/a/i/d0;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v12}, Lb/c/a/i/w;->L()Lb/c/a/i/d0;

    move-result-object v1

    invoke-virtual {v1}, Lb/c/a/i/d0;->s()[J

    move-result-object v1

    iput-object v1, v7, Lb/e/a/h/e;->k:[J

    :cond_2
    const-string v14, "subs"

    invoke-static {v12, v14}, Lb/e/a/j/j;->a(Lb/e/a/b;Ljava/lang/String;)Lb/c/a/i/b;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b0;

    iput-object v1, v7, Lb/e/a/h/e;->o:Lb/c/a/i/b0;

    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual/range {p2 .. p2}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v1

    check-cast v1, Lb/c/a/i/b;

    invoke-interface {v1}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v1

    const-class v2, Lb/c/a/i/i0/b;

    invoke-interface {v1, v2}, Lb/c/a/i/e;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v15, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    array-length v1, v0

    const/4 v5, 0x0

    move v2, v5

    :goto_0
    if-lt v2, v1, :cond_1d

    invoke-virtual {v12}, Lb/c/a/i/w;->x()Lb/c/a/i/u;

    move-result-object v0

    iput-object v0, v7, Lb/e/a/h/e;->h:Lb/c/a/i/u;

    invoke-virtual/range {p2 .. p2}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    const-class v1, Lb/c/a/i/i0/a;

    invoke-interface {v0, v1}, Lb/c/a/i/e;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1a

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v16

    :goto_1
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_3

    goto/16 :goto_11

    :cond_3
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lb/c/a/i/i0/a;

    const-class v1, Lb/c/a/i/i0/d;

    invoke-virtual {v0, v1}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v17

    :cond_4
    :goto_2
    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_5

    goto :goto_1

    :cond_5
    invoke-interface/range {v17 .. v17}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v18, v0

    check-cast v18, Lb/c/a/i/i0/d;

    invoke-virtual/range {v18 .. v18}, Lb/c/a/i/i0/d;->w()J

    move-result-wide v0

    cmp-long v0, v0, v10

    if-nez v0, :cond_4

    invoke-virtual/range {p2 .. p2}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    check-cast v0, Lb/c/a/i/b;

    invoke-interface {v0}, Lb/c/a/i/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    const-string v1, "/moof/traf/subs"

    invoke-static {v0, v1}, Lb/e/a/j/j;->d(Lb/c/a/i/e;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_6

    new-instance v0, Lb/c/a/i/b0;

    invoke-direct {v0}, Lb/c/a/i/b0;-><init>()V

    iput-object v0, v7, Lb/e/a/h/e;->o:Lb/c/a/i/b0;

    :cond_6
    invoke-interface {v15}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v19

    const-wide/16 v3, 0x1

    move-wide v0, v3

    :goto_3
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_7

    goto :goto_2

    :cond_7
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/c/a/i/i0/b;

    const-class v6, Lb/c/a/i/i0/e;

    invoke-virtual {v2, v6}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v20

    move-wide/from16 v21, v0

    :cond_8
    :goto_4
    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_9

    move-wide/from16 v0, v21

    goto :goto_3

    :cond_9
    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lb/c/a/i/i0/e;

    invoke-virtual {v6}, Lb/c/a/i/i0/e;->G()Lb/c/a/i/i0/f;

    move-result-object v0

    invoke-virtual {v0}, Lb/c/a/i/i0/f;->y()J

    move-result-wide v0

    cmp-long v0, v0, v10

    if-nez v0, :cond_8

    invoke-virtual {v12, v9}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v1

    const-string v0, "sgpd"

    invoke-static {v6, v0}, Lb/e/a/j/j;->d(Lb/c/a/i/e;Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    const-string v0, "sbgp"

    invoke-static {v6, v0}, Lb/e/a/j/j;->d(Lb/c/a/i/e;Ljava/lang/String;)Ljava/util/List;

    move-result-object v23

    iget-object v0, v7, Lb/e/a/h/a;->d:Ljava/util/Map;

    sub-long v24, v21, v3

    move-object/from16 p1, v0

    move-object/from16 v0, p0

    move-wide/from16 v26, v10

    move-wide v10, v3

    move-object/from16 v3, v23

    move-object/from16 v4, p1

    move v10, v5

    move-object v11, v6

    move-wide/from16 v5, v24

    invoke-direct/range {v0 .. v6}, Lb/e/a/h/e;->a(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/Map;J)Ljava/util/Map;

    move-object/from16 v0, p1

    iput-object v0, v7, Lb/e/a/h/a;->d:Ljava/util/Map;

    invoke-static {v11, v14}, Lb/e/a/j/j;->a(Lb/e/a/b;Ljava/lang/String;)Lb/c/a/i/b;

    move-result-object v0

    check-cast v0, Lb/c/a/i/b0;

    if-eqz v0, :cond_c

    int-to-long v1, v10

    sub-long v1, v21, v1

    const-wide/16 v3, 0x1

    sub-long/2addr v1, v3

    invoke-virtual {v0}, Lb/c/a/i/b0;->s()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_5
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_a

    goto :goto_7

    :cond_a
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/b0$a;

    new-instance v4, Lb/c/a/i/b0$a;

    invoke-direct {v4}, Lb/c/a/i/b0$a;-><init>()V

    invoke-virtual {v4}, Lb/c/a/i/b0$a;->c()Ljava/util/List;

    move-result-object v5

    invoke-virtual {v3}, Lb/c/a/i/b0$a;->c()Ljava/util/List;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    const-wide/16 v5, 0x0

    cmp-long v23, v1, v5

    if-eqz v23, :cond_b

    invoke-virtual {v3}, Lb/c/a/i/b0$a;->a()J

    move-result-wide v23

    add-long v1, v1, v23

    invoke-virtual {v4, v1, v2}, Lb/c/a/i/b0$a;->d(J)V

    move-wide v1, v5

    goto :goto_6

    :cond_b
    invoke-virtual {v3}, Lb/c/a/i/b0$a;->a()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Lb/c/a/i/b0$a;->d(J)V

    :goto_6
    iget-object v3, v7, Lb/e/a/h/e;->o:Lb/c/a/i/b0;

    invoke-virtual {v3}, Lb/c/a/i/b0;->s()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_5

    :cond_c
    :goto_7
    const-class v0, Lb/c/a/i/i0/g;

    invoke-virtual {v11, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_8
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_d

    move v5, v10

    move-wide/from16 v10, v26

    const-wide/16 v3, 0x1

    goto/16 :goto_4

    :cond_d
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lb/c/a/i/i0/g;

    invoke-virtual {v1}, Lb/e/a/a;->getParent()Lb/c/a/i/e;

    move-result-object v2

    check-cast v2, Lb/c/a/i/i0/e;

    invoke-virtual {v2}, Lb/c/a/i/i0/e;->G()Lb/c/a/i/i0/f;

    move-result-object v2

    invoke-virtual {v1}, Lb/c/a/i/i0/g;->u()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v5, 0x1

    move v4, v5

    :goto_9
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_e

    goto :goto_8

    :cond_e
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/c/a/i/i0/g$a;

    invoke-virtual {v1}, Lb/c/a/i/i0/g;->A()Z

    move-result v11

    if-eqz v11, :cond_11

    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v11

    if-eqz v11, :cond_10

    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v11

    sub-int/2addr v11, v5

    invoke-interface {v13, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lb/c/a/i/e0$a;

    invoke-virtual {v11}, Lb/c/a/i/e0$a;->b()J

    move-result-wide v23

    invoke-virtual {v6}, Lb/c/a/i/i0/g$a;->j()J

    move-result-wide v28

    cmp-long v11, v23, v28

    if-eqz v11, :cond_f

    goto :goto_a

    :cond_f
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v11

    sub-int/2addr v11, v5

    invoke-interface {v13, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lb/c/a/i/e0$a;

    invoke-virtual {v11}, Lb/c/a/i/e0$a;->a()J

    move-result-wide v23

    move-object/from16 p3, v6

    move-object/from16 v25, v14

    move-object/from16 v28, v15

    const-wide/16 v5, 0x1

    add-long v14, v23, v5

    invoke-virtual {v11, v14, v15}, Lb/c/a/i/e0$a;->c(J)V

    goto :goto_c

    :cond_10
    :goto_a
    move-object/from16 p3, v6

    move-object/from16 v25, v14

    move-object/from16 v28, v15

    const-wide/16 v5, 0x1

    new-instance v11, Lb/c/a/i/e0$a;

    invoke-virtual/range {p3 .. p3}, Lb/c/a/i/i0/g$a;->j()J

    move-result-wide v14

    invoke-direct {v11, v5, v6, v14, v15}, Lb/c/a/i/e0$a;-><init>(JJ)V

    goto :goto_b

    :cond_11
    move-object/from16 p3, v6

    move-object/from16 v25, v14

    move-object/from16 v28, v15

    const-wide/16 v5, 0x1

    invoke-virtual {v2}, Lb/c/a/i/i0/f;->A()Z

    move-result v11

    if-eqz v11, :cond_12

    new-instance v11, Lb/c/a/i/e0$a;

    invoke-virtual {v2}, Lb/c/a/i/i0/f;->u()J

    move-result-wide v14

    invoke-direct {v11, v5, v6, v14, v15}, Lb/c/a/i/e0$a;-><init>(JJ)V

    goto :goto_b

    :cond_12
    new-instance v11, Lb/c/a/i/e0$a;

    invoke-virtual/range {v18 .. v18}, Lb/c/a/i/i0/d;->s()J

    move-result-wide v14

    invoke-direct {v11, v5, v6, v14, v15}, Lb/c/a/i/e0$a;-><init>(JJ)V

    :goto_b
    invoke-interface {v13, v11}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_c
    invoke-virtual {v1}, Lb/c/a/i/i0/g;->z()Z

    move-result v5

    if-eqz v5, :cond_15

    iget-object v5, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-eqz v5, :cond_14

    iget-object v5, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v6

    const/4 v11, 0x1

    sub-int/2addr v6, v11

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/c/a/i/d$a;

    invoke-virtual {v5}, Lb/c/a/i/d$a;->b()I

    move-result v5

    int-to-long v5, v5

    invoke-virtual/range {p3 .. p3}, Lb/c/a/i/i0/g$a;->i()J

    move-result-wide v14

    cmp-long v5, v5, v14

    if-eqz v5, :cond_13

    goto :goto_d

    :cond_13
    iget-object v5, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v6

    sub-int/2addr v6, v11

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lb/c/a/i/d$a;

    invoke-virtual {v5}, Lb/c/a/i/d$a;->a()I

    move-result v6

    add-int/2addr v6, v11

    invoke-virtual {v5, v6}, Lb/c/a/i/d$a;->c(I)V

    goto :goto_e

    :cond_14
    const/4 v11, 0x1

    :goto_d
    iget-object v5, v7, Lb/e/a/h/e;->j:Ljava/util/List;

    new-instance v6, Lb/c/a/i/d$a;

    invoke-virtual/range {p3 .. p3}, Lb/c/a/i/i0/g$a;->i()J

    move-result-wide v14

    invoke-static {v14, v15}, Lb/e/a/j/b;->a(J)I

    move-result v14

    invoke-direct {v6, v11, v14}, Lb/c/a/i/d$a;-><init>(II)V

    invoke-interface {v5, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_15
    :goto_e
    invoke-virtual {v1}, Lb/c/a/i/i0/g;->B()Z

    move-result v5

    if-eqz v5, :cond_16

    invoke-virtual/range {p3 .. p3}, Lb/c/a/i/i0/g$a;->k()Lb/c/a/i/i0/c;

    move-result-object v4

    goto :goto_f

    :cond_16
    if-eqz v4, :cond_17

    invoke-virtual {v1}, Lb/c/a/i/i0/g;->y()Z

    move-result v4

    if-eqz v4, :cond_17

    invoke-virtual {v1}, Lb/c/a/i/i0/g;->v()Lb/c/a/i/i0/c;

    move-result-object v4

    goto :goto_f

    :cond_17
    invoke-virtual {v2}, Lb/c/a/i/i0/f;->B()Z

    move-result v4

    if-eqz v4, :cond_18

    invoke-virtual {v2}, Lb/c/a/i/i0/f;->v()Lb/c/a/i/i0/c;

    move-result-object v4

    goto :goto_f

    :cond_18
    invoke-virtual/range {v18 .. v18}, Lb/c/a/i/i0/d;->u()Lb/c/a/i/i0/c;

    move-result-object v4

    :goto_f
    if-eqz v4, :cond_19

    invoke-virtual {v4}, Lb/c/a/i/i0/c;->b()Z

    move-result v4

    if-nez v4, :cond_19

    iget-object v4, v7, Lb/e/a/h/e;->k:[J

    const/4 v5, 0x1

    new-array v6, v5, [J

    aput-wide v21, v6, v10

    invoke-static {v4, v6}, Lb/e/a/j/i;->a([J[J)[J

    move-result-object v4

    iput-object v4, v7, Lb/e/a/h/e;->k:[J

    goto :goto_10

    :cond_19
    const/4 v5, 0x1

    :goto_10
    const-wide/16 v14, 0x1

    add-long v21, v21, v14

    move v4, v10

    move-object/from16 v14, v25

    move-object/from16 v15, v28

    goto/16 :goto_9

    :cond_1a
    invoke-virtual {v12, v9}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    const-class v0, Lb/e/a/i/d/d/f;

    invoke-virtual {v12, v0}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    iget-object v9, v7, Lb/e/a/h/a;->d:Ljava/util/Map;

    const-wide/16 v5, 0x0

    move-object/from16 v0, p0

    move-object v4, v9

    invoke-direct/range {v0 .. v6}, Lb/e/a/h/e;->a(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/Map;J)Ljava/util/Map;

    iput-object v9, v7, Lb/e/a/h/a;->d:Ljava/util/Map;

    :goto_11
    invoke-static {v13}, Lb/c/a/i/e0;->s(Ljava/util/List;)[J

    move-result-object v0

    iput-object v0, v7, Lb/e/a/h/e;->i:[J

    invoke-virtual/range {p2 .. p2}, Lb/c/a/i/f0;->G()Lb/c/a/i/n;

    move-result-object v0

    invoke-virtual {v0}, Lb/c/a/i/n;->H()Lb/c/a/i/o;

    move-result-object v0

    invoke-virtual/range {p2 .. p2}, Lb/c/a/i/f0;->I()Lb/c/a/i/g0;

    move-result-object v1

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->A()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lb/e/a/h/h;->r(J)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v0}, Lb/c/a/i/o;->s()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v2, v3}, Lb/e/a/h/h;->k(Ljava/util/Date;)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v0}, Lb/c/a/i/o;->v()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lb/e/a/h/h;->m(Ljava/lang/String;)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v0}, Lb/c/a/i/o;->w()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v2, v3}, Lb/e/a/h/h;->p(Ljava/util/Date;)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v0}, Lb/c/a/i/o;->x()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lb/e/a/h/h;->q(J)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->w()D

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lb/e/a/h/h;->l(D)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->C()D

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lb/e/a/h/h;->t(D)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->x()I

    move-result v3

    invoke-virtual {v2, v3}, Lb/e/a/h/h;->n(I)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->y()Lb/e/a/j/h;

    move-result-object v3

    invoke-virtual {v2, v3}, Lb/e/a/h/h;->o(Lb/e/a/j/h;)V

    iget-object v2, v7, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    invoke-virtual {v1}, Lb/c/a/i/g0;->B()F

    move-result v1

    invoke-virtual {v2, v1}, Lb/e/a/h/h;->s(F)V

    const-string v1, "edts/elst"

    invoke-static {v8, v1}, Lb/e/a/j/j;->a(Lb/e/a/b;Ljava/lang/String;)Lb/c/a/i/b;

    move-result-object v1

    check-cast v1, Lb/c/a/i/j;

    const-string v2, "../mvhd"

    invoke-static {v8, v2}, Lb/e/a/j/j;->a(Lb/e/a/b;Ljava/lang/String;)Lb/c/a/i/b;

    move-result-object v2

    check-cast v2, Lb/c/a/i/r;

    if-eqz v1, :cond_1c

    invoke-virtual {v1}, Lb/c/a/i/j;->s()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_12
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_1b

    goto :goto_13

    :cond_1b
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lb/c/a/i/j$a;

    iget-object v4, v7, Lb/e/a/h/a;->c:Ljava/util/List;

    new-instance v5, Lb/e/a/h/c;

    invoke-virtual {v3}, Lb/c/a/i/j$a;->c()J

    move-result-wide v9

    invoke-virtual {v0}, Lb/c/a/i/o;->x()J

    move-result-wide v11

    invoke-virtual {v3}, Lb/c/a/i/j$a;->b()D

    move-result-wide v13

    move-object/from16 p1, v0

    move-object/from16 p2, v1

    invoke-virtual {v3}, Lb/c/a/i/j$a;->d()J

    move-result-wide v0

    long-to-double v0, v0

    invoke-virtual {v2}, Lb/c/a/i/r;->z()J

    move-result-wide v6

    long-to-double v6, v6

    div-double v15, v0, v6

    move-object v8, v5

    invoke-direct/range {v8 .. v16}, Lb/e/a/h/c;-><init>(JJDD)V

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v7, p0

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    goto :goto_12

    :cond_1c
    :goto_13
    return-void

    :cond_1d
    move-wide/from16 v26, v10

    move-object/from16 v25, v14

    move-object/from16 v28, v15

    move v10, v5

    aget-object v3, v0, v2

    const-class v4, Lb/c/a/i/i0/b;

    invoke-virtual {v3, v4}, Lb/e/a/d;->q(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v3

    move-object/from16 v4, v28

    invoke-interface {v4, v3}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    add-int/lit8 v2, v2, 0x1

    move-object/from16 v7, p0

    move-object v15, v4

    move-wide/from16 v10, v26

    goto/16 :goto_0
.end method

.method private a(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/Map;J)Ljava/util/Map;
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lb/e/a/i/d/d/e;",
            ">;",
            "Ljava/util/List<",
            "Lb/e/a/i/d/d/e;",
            ">;",
            "Ljava/util/List<",
            "Lb/e/a/i/d/d/f;",
            ">;",
            "Ljava/util/Map<",
            "Lb/e/a/i/d/d/b;",
            "[J>;J)",
            "Ljava/util/Map<",
            "Lb/e/a/i/d/d/b;",
            "[J>;"
        }
    .end annotation

    move-object/from16 v0, p4

    invoke-interface/range {p3 .. p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_0

    return-object v0

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lb/e/a/i/d/d/f;

    invoke-virtual {v2}, Lb/e/a/i/d/d/f;->s()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v4, 0x0

    move v5, v4

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-nez v6, :cond_1

    goto :goto_0

    :cond_1
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lb/e/a/i/d/d/f$a;

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->a()I

    move-result v7

    if-lez v7, :cond_9

    const/4 v7, 0x0

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->a()I

    move-result v8

    const v9, 0xffff

    if-le v8, v9, :cond_4

    invoke-interface/range {p2 .. p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_2
    :goto_2
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-nez v10, :cond_3

    goto :goto_4

    :cond_3
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lb/e/a/i/d/d/e;

    invoke-virtual {v10}, Lb/e/a/i/d/d/e;->u()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v2}, Lb/e/a/i/d/d/f;->u()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_2

    invoke-virtual {v10}, Lb/e/a/i/d/d/e;->s()Ljava/util/List;

    move-result-object v7

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->a()I

    move-result v10

    add-int/lit8 v10, v10, -0x1

    and-int/2addr v10, v9

    invoke-interface {v7, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lb/e/a/i/d/d/b;

    goto :goto_2

    :cond_4
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_5
    :goto_3
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-nez v9, :cond_8

    :goto_4
    move-object v9, v7

    invoke-interface {v0, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [J

    if-nez v7, :cond_6

    new-array v7, v4, [J

    :cond_6
    move-object v10, v7

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->b()J

    move-result-wide v7

    invoke-static {v7, v8}, Lb/e/a/j/b;->a(J)I

    move-result v7

    array-length v8, v10

    add-int/2addr v7, v8

    new-array v11, v7, [J

    array-length v7, v10

    invoke-static {v10, v4, v11, v4, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move v7, v4

    :goto_5
    int-to-long v12, v7

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->b()J

    move-result-wide v14

    cmp-long v8, v12, v14

    if-ltz v8, :cond_7

    invoke-interface {v0, v9, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    :cond_7
    array-length v8, v10

    add-int/2addr v8, v7

    int-to-long v14, v5

    add-long v14, p5, v14

    add-long/2addr v14, v12

    aput-wide v14, v11, v8

    add-int/lit8 v7, v7, 0x1

    goto :goto_5

    :cond_8
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lb/e/a/i/d/d/e;

    invoke-virtual {v9}, Lb/e/a/i/d/d/e;->u()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v2}, Lb/e/a/i/d/d/f;->u()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    invoke-virtual {v9}, Lb/e/a/i/d/d/e;->s()Ljava/util/List;

    move-result-object v7

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->a()I

    move-result v9

    add-int/lit8 v9, v9, -0x1

    invoke-interface {v7, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lb/e/a/i/d/d/b;

    goto :goto_3

    :cond_9
    :goto_6
    int-to-long v7, v5

    invoke-virtual {v6}, Lb/e/a/i/d/d/f$a;->b()J

    move-result-wide v5

    add-long/2addr v7, v5

    long-to-int v5, v7

    goto/16 :goto_1
.end method


# virtual methods
.method public A()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/c/a/i/t$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/e;->l:Ljava/util/List;

    return-object v0
.end method

.method public close()V
    .locals 4

    iget-object v0, p0, Lb/e/a/h/e;->e:Lb/c/a/i/f0;

    invoke-virtual {v0}, Lb/e/a/b;->getParent()Lb/c/a/i/e;

    move-result-object v0

    instance-of v1, v0, Lb/e/a/d;

    if-eqz v1, :cond_0

    check-cast v0, Lb/e/a/d;

    invoke-virtual {v0}, Lb/e/a/d;->close()V

    :cond_0
    iget-object v0, p0, Lb/e/a/h/e;->f:[Lb/c/a/d;

    if-eqz v0, :cond_2

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-lt v2, v1, :cond_1

    goto :goto_1

    :cond_1
    aget-object v3, v0, v2

    invoke-virtual {v3}, Lb/c/a/d;->close()V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method

.method public d()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/c/a/i/d$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/e;->j:Ljava/util/List;

    return-object v0
.end method

.method public f()[J
    .locals 2

    iget-object v0, p0, Lb/e/a/h/e;->k:[J

    if-eqz v0, :cond_1

    array-length v0, v0

    iget-object v1, p0, Lb/e/a/h/e;->g:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lb/e/a/h/e;->k:[J

    return-object v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public g()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lb/e/a/h/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lb/e/a/h/e;->g:Ljava/util/List;

    return-object v0
.end method

.method public i()Lb/c/a/i/b0;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/e;->o:Lb/c/a/i/b0;

    return-object v0
.end method

.method public r()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/e;->n:Ljava/lang/String;

    return-object v0
.end method

.method public declared-synchronized w()[J
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lb/e/a/h/e;->i:[J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public x()Lb/c/a/i/u;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/e;->h:Lb/c/a/i/u;

    return-object v0
.end method

.method public z()Lb/e/a/h/h;
    .locals 1

    iget-object v0, p0, Lb/e/a/h/e;->m:Lb/e/a/h/h;

    return-object v0
.end method
