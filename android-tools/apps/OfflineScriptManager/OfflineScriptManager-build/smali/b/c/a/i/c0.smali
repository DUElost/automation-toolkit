.class public Lb/c/a/i/c0;
.super Lb/c/a/i/a;
.source ""


# static fields
.field private static final synthetic m:Lc/b/a/a/a$a;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    invoke-static {}, Lb/c/a/i/c0;->k()V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    const-string v0, "sthd"

    invoke-direct {p0, v0}, Lb/c/a/i/a;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method private static synthetic k()V
    .locals 9

    new-instance v8, Lc/b/a/b/b/b;

    const-class v0, Lb/c/a/i/c0;

    const-string v1, "SubtitleMediaHeaderBox.java"

    invoke-direct {v8, v1, v0}, Lc/b/a/b/b/b;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    const-string v1, "1"

    const-string v2, "toString"

    const-string v3, "com.coremedia.iso.boxes.SubtitleMediaHeaderBox"

    const-string v4, ""

    const-string v5, ""

    const-string v6, ""

    const-string v7, "java.lang.String"

    move-object v0, v8

    invoke-virtual/range {v0 .. v7}, Lc/b/a/b/b/b;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lc/b/a/a/d/a;

    move-result-object v0

    const-string v1, "method-execution"

    const/16 v2, 0x1e

    invoke-virtual {v8, v1, v0, v2}, Lc/b/a/b/b/b;->f(Ljava/lang/String;Lc/b/a/a/c;I)Lc/b/a/a/a$a;

    move-result-object v0

    sput-object v0, Lb/c/a/i/c0;->m:Lc/b/a/a/a$a;

    return-void
.end method


# virtual methods
.method public c(Ljava/nio/ByteBuffer;)V
    .locals 0

    invoke-virtual {p0, p1}, Lb/e/a/c;->o(Ljava/nio/ByteBuffer;)J

    return-void
.end method

.method protected d(Ljava/nio/ByteBuffer;)V
    .locals 0

    invoke-virtual {p0, p1}, Lb/e/a/c;->r(Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method protected e()J
    .locals 2

    const-wide/16 v0, 0x4

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    sget-object v0, Lb/c/a/i/c0;->m:Lc/b/a/a/a$a;

    invoke-static {v0, p0, p0}, Lc/b/a/b/b/b;->c(Lc/b/a/a/a$a;Ljava/lang/Object;Ljava/lang/Object;)Lc/b/a/a/a;

    move-result-object v0

    invoke-static {}, Lb/e/a/g;->b()Lb/e/a/g;

    move-result-object v1

    invoke-virtual {v1, v0}, Lb/e/a/g;->c(Lc/b/a/a/a;)V

    const-string v0, "SubtitleMediaHeaderBox"

    return-object v0
.end method
