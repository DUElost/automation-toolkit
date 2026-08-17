.class public Ld/o/b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/o/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)Ld/e;
    .locals 1

    new-instance v0, Ld/e;

    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-direct {v0, p1}, Ld/e;-><init>(Ljava/nio/ByteBuffer;)V

    return-object v0
.end method
