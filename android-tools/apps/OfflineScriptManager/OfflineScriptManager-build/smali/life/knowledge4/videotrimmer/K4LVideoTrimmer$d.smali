.class Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->w(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 8

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    if-gtz p1, :cond_0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->u(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v0

    if-lt p1, v0, :cond_0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/g/c;

    move-result-object p1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/net/Uri;

    move-result-object v0

    invoke-interface {p1, v0}, Llife/knowledge4/videotrimmer/g/c;->m(Landroid/net/Uri;)V

    goto/16 :goto_1

    :cond_0
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/ImageView;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/VideoView;->pause()V

    new-instance p1, Landroid/media/MediaMetadataRetriever;

    invoke-direct {p1}, Landroid/media/MediaMetadataRetriever;-><init>()V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/media/MediaMetadataRetriever;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    const/16 v0, 0x9

    invoke-virtual {p1, v0}, Landroid/media/MediaMetadataRetriever;->extractMetadata(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    new-instance v3, Ljava/io/File;

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v3, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    const/16 v2, 0x3e8

    if-ge p1, v2, :cond_2

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    int-to-long v4, p1

    sub-long/2addr v0, v4

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    rsub-int p1, p1, 0x3e8

    int-to-long v4, p1

    cmp-long p1, v0, v4

    if-lez p1, :cond_1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v1

    sub-int/2addr v2, v1

    add-int/2addr v0, v2

    invoke-static {p1, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->t(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;I)I

    goto :goto_0

    :cond_1
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result p1

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v0

    rsub-int v0, v0, 0x3e8

    if-le p1, v0, :cond_2

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v1

    sub-int/2addr v2, v1

    sub-int/2addr v0, v2

    invoke-static {p1, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;I)I

    :cond_2
    :goto_0
    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {v2}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->i(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Ljava/lang/String;

    move-result-object v4

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v5

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I

    move-result v6

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;->b:Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-static {p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/g/c;

    move-result-object v7

    invoke-static/range {v2 .. v7}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->j(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V

    :goto_1
    return-void
.end method
