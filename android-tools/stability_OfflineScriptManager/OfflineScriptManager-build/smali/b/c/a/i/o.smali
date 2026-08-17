.class public Lb/c/a/i/o;
.super Lb/e/a/c;
.source ""


# static fields
.field private static final synthetic A:Lc/b/a/a/a$a;

.field private static final synthetic B:Lc/b/a/a/a$a;

.field private static r:Lb/e/a/j/f;

.field private static final synthetic s:Lc/b/a/a/a$a;

.field private static final synthetic t:Lc/b/a/a/a$a;

.field private static final synthetic u:Lc/b/a/a/a$a;

.field private static final synthetic v:Lc/b/a/a/a$a;

.field private static final synthetic w:Lc/b/a/a/a$a;

.field private static final synthetic x:Lc/b/a/a/a$a;

.field private static final synthetic y:Lc/b/a/a/a$a;

.field private static final synthetic z:Lc/b/a/a/a$a;


# instance fields
.field private m:Ljava/util/Date;

.field private n:Ljava/util/Date;

.field private o:J

.field private p:J

.field private q:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lb/c/a/i/o;->k()V

    const-class v0, Lb/c/a/i/o;

    invoke-static {v0}, Lb/e/a/j/f;->a(Ljava/lang/Class;)Lb/e/a/j/f;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->r:Lb/e/a/j/f;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const-string v0, "mdhd"

    invoke-direct {p0, v0}, Lb/e/a/c;-><init>(Ljava/lang/String;)V

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    iput-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    iput-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    const-string v0, "eng"

    iput-object v0, p0, Lb/c/a/i/o;->q:Ljava/lang/String;

    return-void
.end method

.method private static synthetic k()V
    .locals 10

    new-instance v8, Lc/b/a/b/b/b;

    const-class v0, Lb/c/a/i/o;

    const-string v1, "MediaHeaderBox.java"

    invoke-direct {v8, v1, v0}, Lc/b/a/b/b/b;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    const-string v1, "1"

    const-string v2, "getCreationTime"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.util.Date"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const-string v9, "method-execution"

    const/16 v1, 0x30

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->s:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getModificationTime"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.util.Date"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x34

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->t:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "toString"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.lang.String"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->B:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getTimescale"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "long"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x38

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->u:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getDuration"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "long"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x3c

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->v:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getLanguage"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.lang.String"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x40

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->w:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setCreationTime"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, "java.util.Date"

    const-string v5, "creationTime"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x51

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->x:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setModificationTime"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, "java.util.Date"

    const-string v5, "modificationTime"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x55

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setTimescale"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, "long"

    const-string v5, "timescale"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x59

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->y:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setDuration"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, "long"

    const-string v5, "duration"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x5d

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->z:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setLanguage"

    const-string v3, "com.coremedia.iso.boxes.MediaHeaderBox"

    const-string v4, "java.lang.String"

    const-string v5, "language"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x61

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/o;->A:Lc/b/a/a/a$a;

    return-void
.end method


# virtual methods
.method public A(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lb/c/a/i/o;->A:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0, p1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput-object p1, p0, Lb/c/a/i/o;->q:Ljava/lang/String;

    return-void
.end method

.method public B(J)V
    .locals 2

    sget-object v0, Lb/c/a/i/o;->y:Lc/b/a/a/a$a;

    invoke-static {p1, p2}, Lc/b/a/b/a/a;->e(J)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, p0, v1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput-wide p1, p0, Lb/c/a/i/o;->o:J

    return-void
.end method

.method public c(Ljava/nio/ByteBuffer;)V
    .locals 4

    invoke-virtual {p0, p1}, Lb/e/a/c;->o(Ljava/nio/ByteBuffer;)J

    invoke-virtual {p0}, Lb/e/a/c;->n()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-static {p1}, Lb/c/a/e;->m(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/c;->b(J)Ljava/util/Date;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    invoke-static {p1}, Lb/c/a/e;->m(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/c;->b(J)Ljava/util/Date;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/o;->o:J

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/c;->b(J)Ljava/util/Date;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    invoke-static {v0, v1}, Lb/e/a/j/c;->b(J)Ljava/util/Date;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/o;->o:J

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    int-to-long v0, v0

    :goto_0
    iput-wide v0, p0, Lb/c/a/i/o;->p:J

    iget-wide v0, p0, Lb/c/a/i/o;->p:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    sget-object v0, Lb/c/a/i/o;->r:Lb/e/a/j/f;

    const-string v1, "mdhd duration is not in expected range"

    invoke-virtual {v0, v1}, Lb/e/a/j/f;->d(Ljava/lang/String;)V

    :cond_1
    invoke-static {p1}, Lb/c/a/e;->f(Ljava/nio/ByteBuffer;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/o;->q:Ljava/lang/String;

    invoke-static {p1}, Lb/c/a/e;->i(Ljava/nio/ByteBuffer;)I

    return-void
.end method

.method protected d(Ljava/nio/ByteBuffer;)V
    .locals 2

    invoke-virtual {p0, p1}, Lb/e/a/c;->r(Ljava/nio/ByteBuffer;)V

    invoke-virtual {p0}, Lb/e/a/c;->n()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    invoke-static {v0}, Lb/e/a/j/c;->a(Ljava/util/Date;)J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->i(Ljava/nio/ByteBuffer;J)V

    iget-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    invoke-static {v0}, Lb/e/a/j/c;->a(Ljava/util/Date;)J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->i(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/o;->o:J

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/o;->p:J

    invoke-virtual {p1, v0, v1}, Ljava/nio/ByteBuffer;->putLong(J)Ljava/nio/ByteBuffer;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    invoke-static {v0}, Lb/e/a/j/c;->a(Ljava/util/Date;)J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    invoke-static {v0}, Lb/e/a/j/c;->a(Ljava/util/Date;)J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/o;->o:J

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-wide v0, p0, Lb/c/a/i/o;->p:J

    long-to-int v0, v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    :goto_0
    iget-object v0, p0, Lb/c/a/i/o;->q:Ljava/lang/String;

    invoke-static {p1, v0}, Lb/c/a/f;->d(Ljava/nio/ByteBuffer;Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lb/c/a/f;->e(Ljava/nio/ByteBuffer;I)V

    return-void
.end method

.method protected e()J
    .locals 4

    invoke-virtual {p0}, Lb/e/a/c;->n()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const-wide/16 v0, 0x20

    goto :goto_0

    :cond_0
    const-wide/16 v0, 0x14

    :goto_0
    const-wide/16 v2, 0x2

    add-long/2addr v0, v2

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public s()Ljava/util/Date;
    .locals 2

    sget-object v0, Lb/c/a/i/o;->s:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-object v0, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    sget-object v0, Lb/c/a/i/o;->B:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MediaHeaderBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "creationTime="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/o;->s()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "modificationTime="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/o;->w()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "timescale="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/o;->x()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "duration="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/o;->u()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "language="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/o;->v()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public u()J
    .locals 2

    sget-object v0, Lb/c/a/i/o;->v:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-wide v0, p0, Lb/c/a/i/o;->p:J

    return-wide v0
.end method

.method public v()Ljava/lang/String;
    .locals 2

    sget-object v0, Lb/c/a/i/o;->w:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-object v0, p0, Lb/c/a/i/o;->q:Ljava/lang/String;

    return-object v0
.end method

.method public w()Ljava/util/Date;
    .locals 2

    sget-object v0, Lb/c/a/i/o;->t:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-object v0, p0, Lb/c/a/i/o;->n:Ljava/util/Date;

    return-object v0
.end method

.method public x()J
    .locals 2

    sget-object v0, Lb/c/a/i/o;->u:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-wide v0, p0, Lb/c/a/i/o;->o:J

    return-wide v0
.end method

.method public y(Ljava/util/Date;)V
    .locals 2

    sget-object v0, Lb/c/a/i/o;->x:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0, p1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput-object p1, p0, Lb/c/a/i/o;->m:Ljava/util/Date;

    return-void
.end method

.method public z(J)V
    .locals 2

    sget-object v0, Lb/c/a/i/o;->z:Lc/b/a/a/a$a;

    invoke-static {p1, p2}, Lc/b/a/b/a/a;->e(J)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, p0, v1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput-wide p1, p0, Lb/c/a/i/o;->p:J

    return-void
.end method
