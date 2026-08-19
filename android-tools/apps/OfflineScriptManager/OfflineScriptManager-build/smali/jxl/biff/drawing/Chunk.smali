.class Ljxl/biff/drawing/Chunk;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private data:[B

.field private length:I

.field private pos:I

.field private type:Ljxl/biff/drawing/ChunkType;


# direct methods
.method public constructor <init>(IILjxl/biff/drawing/ChunkType;[B)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Ljxl/biff/drawing/Chunk;->pos:I

    iput p2, p0, Ljxl/biff/drawing/Chunk;->length:I

    iput-object p3, p0, Ljxl/biff/drawing/Chunk;->type:Ljxl/biff/drawing/ChunkType;

    new-array p3, p2, [B

    iput-object p3, p0, Ljxl/biff/drawing/Chunk;->data:[B

    const/4 v0, 0x0

    invoke-static {p4, p1, p3, v0, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Ljxl/biff/drawing/Chunk;->data:[B

    return-object v0
.end method
