.class public abstract Lb/e/a/c;
.super Lb/e/a/a;
.source ""

# interfaces
.implements Lb/c/a/i/b;


# static fields
.field private static final synthetic k:Lc/b/a/a/a$a;

.field private static final synthetic l:Lc/b/a/a/a$a;


# instance fields
.field private i:I

.field private j:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    invoke-static {}, Lb/e/a/c;->k()V

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lb/e/a/a;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method private static synthetic k()V
    .locals 10

    new-instance v8, Lc/b/a/b/b/b;

    const-class v0, Lb/e/a/c;

    const-string v1, "AbstractFullBox.java"

    invoke-direct {v8, v1, v0}, Lc/b/a/b/b/b;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    const-string v1, "1"

    const-string v2, "setVersion"

    const-string v3, "com.googlecode.mp4parser.AbstractFullBox"

    const-string v4, "int"

    const-string v5, "version"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const-string v9, "method-execution"

    const/16 v1, 0x33

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/c;->k:Lc/b/a/a/a$a;

    const-string v1, "1"

    const-string v2, "setFlags"

    const-string v3, "com.googlecode.mp4parser.AbstractFullBox"

    const-string v4, "int"

    const-string v5, "flags"

    const-string v6, ""

    const-string v7, "void"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const/16 v1, 0x40

    invoke-virtual {v8, v9, v0, v1}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/e/a/c;->l:Lc/b/a/a/a$a;

    return-void
.end method


# virtual methods
.method public l()I
    .locals 1

    iget-boolean v0, p0, Lb/e/a/a;->e:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lb/e/a/a;->j()V

    :cond_0
    iget v0, p0, Lb/e/a/c;->j:I

    return v0
.end method

.method public n()I
    .locals 1

    iget-boolean v0, p0, Lb/e/a/a;->e:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lb/e/a/a;->j()V

    :cond_0
    iget v0, p0, Lb/e/a/c;->i:I

    return v0
.end method

.method protected final o(Ljava/nio/ByteBuffer;)J
    .locals 2

    invoke-static {p1}, Lb/c/a/e;->n(Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lb/e/a/c;->i:I

    invoke-static {p1}, Lb/c/a/e;->j(Ljava/nio/ByteBuffer;)I

    move-result p1

    iput p1, p0, Lb/e/a/c;->j:I

    const-wide/16 v0, 0x4

    return-wide v0
.end method

.method public p(I)V
    .locals 2

    sget-object v0, Lb/e/a/c;->l:Lc/b/a/a/a$a;

    invoke-static {p1}, Lc/b/a/b/a/a;->d(I)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, p0, v1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput p1, p0, Lb/e/a/c;->j:I

    return-void
.end method

.method public q(I)V
    .locals 2

    sget-object v0, Lb/e/a/c;->k:Lc/b/a/a/a$a;

    invoke-static {p1}, Lc/b/a/b/a/a;->d(I)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, p0, v1}, Lc/b/a/b/b/b;->d(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    iput p1, p0, Lb/e/a/c;->i:I

    return-void
.end method

.method protected final r(Ljava/nio/ByteBuffer;)V
    .locals 1

    iget v0, p0, Lb/e/a/c;->i:I

    invoke-static {p1, v0}, Lb/c/a/f;->j(Ljava/nio/ByteBuffer;I)V

    iget v0, p0, Lb/e/a/c;->j:I

    invoke-static {p1, v0}, Lb/c/a/f;->f(Ljava/nio/ByteBuffer;I)V

    return-void
.end method
