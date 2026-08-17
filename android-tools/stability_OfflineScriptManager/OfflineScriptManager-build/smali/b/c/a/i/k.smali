.class public Lb/c/a/i/k;
.super Lb/e/a/a;
.source ""


# static fields
.field private static final synthetic l:Lc/b/a/a/a$a;

.field private static final synthetic m:Lc/b/a/a/a$a;


# instance fields
.field private i:Ljava/lang/String;

.field private j:J

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    invoke-static {}, Lb/c/a/i/k;->k()V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const-string v0, "ftyp"

    invoke-direct {p0, v0}, Lb/e/a/a;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;JLjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "ftyp"

    invoke-direct {p0, v0}, Lb/e/a/a;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    iput-object p1, p0, Lb/c/a/i/k;->i:Ljava/lang/String;

    iput-wide p2, p0, Lb/c/a/i/k;->j:J

    iput-object p4, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    return-void
.end method

.method private static synthetic k()V
    .locals 10

    new-instance v8, Lc/b/a/b/b/b;

    const-class v0, Lb/c/a/i/k;

    const-string v1, "FileTypeBox.java"

    invoke-direct {v8, v1, v0}, Lc/b/a/b/b/b;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    const-string v1, "1"

    const-string v2, "getMajorBrand"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.lang.String"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const-string v9, "method-execution"

    const/16 v1, 0x55

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/k;->l:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setMajorBrand"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, "java.lang.String"

    const-string v5, "majorBrand"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x5e

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setMinorVersion"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, "long"

    const-string v5, "minorVersion"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x67

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getMinorVersion"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "long"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x71

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/k;->m:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "getCompatibleBrands"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.util.List"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x7a

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setCompatibleBrands"

    const-string v3, "com.coremedia.iso.boxes.FileTypeBox"

    const-string v4, "java.util.List"

    const-string v5, "compatibleBrands"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x7e

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    return-void
.end method


# virtual methods
.method public c(Ljava/nio/ByteBuffer;)V
    .locals 4

    invoke-static {p1}, Lb/c/a/e;->b(Ljava/nio/ByteBuffer;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lb/c/a/i/k;->i:Ljava/lang/String;

    invoke-static {p1}, Lb/c/a/e;->k(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p0, Lb/c/a/i/k;->j:J

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    div-int/lit8 v0, v0, 0x4

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    const/4 v1, 0x0

    :goto_0
    if-lt v1, v0, :cond_0

    return-void

    :cond_0
    iget-object v2, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    invoke-static {p1}, Lb/c/a/e;->b(Ljava/nio/ByteBuffer;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method protected d(Ljava/nio/ByteBuffer;)V
    .locals 2

    iget-object v0, p0, Lb/c/a/i/k;->i:Ljava/lang/String;

    invoke-static {v0}, Lb/c/a/d;->F(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    iget-wide v0, p0, Lb/c/a/i/k;->j:J

    invoke-static {p1, v0, v1}, Lb/c/a/f;->g(Ljava/nio/ByteBuffer;J)V

    iget-object v0, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lb/c/a/d;->F(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    goto :goto_0
.end method

.method protected e()J
    .locals 2

    iget-object v0, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    mul-int/lit8 v0, v0, 0x4

    add-int/lit8 v0, v0, 0x8

    int-to-long v0, v0

    return-wide v0
.end method

.method public l()Ljava/lang/String;
    .locals 2

    sget-object v0, Lb/c/a/i/k;->l:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-object v0, p0, Lb/c/a/i/k;->i:Ljava/lang/String;

    return-object v0
.end method

.method public n()J
    .locals 2

    sget-object v0, Lb/c/a/i/k;->m:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iget-wide v0, p0, Lb/c/a/i/k;->j:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FileTypeBox["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "majorBrand="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/k;->l()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "minorVersion="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lb/c/a/i/k;->n()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lb/c/a/i/k;->k:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-nez v3, :cond_0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "compatibleBrand="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method
