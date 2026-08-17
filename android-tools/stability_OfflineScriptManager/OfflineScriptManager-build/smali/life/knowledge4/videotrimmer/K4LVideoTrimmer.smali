.class public Llife/knowledge4/videotrimmer/K4LVideoTrimmer;
.super Landroid/widget/FrameLayout;
.source ""

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;
.implements Landroid/media/MediaPlayer$OnPreparedListener;
.implements Landroid/media/MediaPlayer$OnCompletionListener;
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;
.implements Llife/knowledge4/videotrimmer/g/b;
.implements Llife/knowledge4/videotrimmer/g/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;
    }
.end annotation


# static fields
.field private static final z:Ljava/lang/String;


# instance fields
.field private b:Landroid/widget/SeekBar;

.field private c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

.field private d:Landroid/widget/RelativeLayout;

.field private e:Landroid/widget/VideoView;

.field private f:Landroid/widget/ImageView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Llife/knowledge4/videotrimmer/view/TimeLineView;

.field private k:Landroid/net/Uri;

.field private l:Ljava/lang/String;

.field private m:I

.field private n:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Llife/knowledge4/videotrimmer/g/a;",
            ">;"
        }
    .end annotation
.end field

.field private o:Llife/knowledge4/videotrimmer/g/c;

.field private p:I

.field private q:I

.field private r:I

.field private s:I

.field private t:J

.field private u:Z

.field private final v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

.field private w:Landroid/view/GestureDetector;

.field private final x:Landroid/view/GestureDetector$SimpleOnGestureListener;

.field private final y:Landroid/view/View$OnTouchListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->z:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    iput p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    iput p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->q:I

    iput p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    iput p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    const/4 p2, 0x1

    iput-boolean p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->u:Z

    new-instance p2, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    invoke-direct {p2, p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V

    iput-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    new-instance p2, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;

    invoke-direct {p2, p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$a;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V

    iput-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->x:Landroid/view/GestureDetector$SimpleOnGestureListener;

    new-instance p2, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$b;

    invoke-direct {p2, p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$b;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V

    iput-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->y:Landroid/view/View$OnTouchListener;

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->w(Landroid/content/Context;)V

    return-void
.end method

.method private A(Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V
    .locals 12

    new-instance v11, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;

    const-string v2, ""

    const-wide/16 v3, 0x0

    const-string v5, ""

    move-object v0, v11

    move-object v1, p0

    move-object v6, p1

    move-object v7, p2

    move v8, p3

    move/from16 v9, p4

    move-object/from16 v10, p5

    invoke-direct/range {v0 .. v10}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Ljava/lang/String;JLjava/lang/String;Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V

    invoke-static {v11}, Llife/knowledge4/videotrimmer/h/a;->e(Llife/knowledge4/videotrimmer/h/a$a;)V

    return-void
.end method

.method private B(I)Ljava/lang/String;
    .locals 7

    div-int/lit16 p1, p1, 0x3e8

    rem-int/lit8 v0, p1, 0x3c

    div-int/lit8 v1, p1, 0x3c

    rem-int/lit8 v1, v1, 0x3c

    div-int/lit16 p1, p1, 0xe10

    new-instance v2, Ljava/util/Formatter;

    invoke-direct {v2}, Ljava/util/Formatter;-><init>()V

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x2

    if-lez p1, :cond_0

    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v6, v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v6, v3

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v6, v5

    const-string p1, "%d:%02d:%02d"

    invoke-virtual {v2, p1, v6}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object p1

    :goto_0
    invoke-virtual {p1}, Ljava/util/Formatter;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    new-array p1, v5, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, p1, v4

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, p1, v3

    const-string v0, "%02d:%02d"

    invoke-virtual {v2, v0, p1}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object p1

    goto :goto_0
.end method

.method private C(Z)V
    .locals 4

    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {v0}, Landroid/widget/VideoView;->getCurrentPosition()I

    move-result v0

    if-eqz p1, :cond_1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->n:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Llife/knowledge4/videotrimmer/g/a;

    iget v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    mul-int/lit8 v3, v0, 0x64

    div-int/2addr v3, v2

    int-to-float v3, v3

    invoke-interface {v1, v0, v2, v3}, Llife/knowledge4/videotrimmer/g/a;->c(IIF)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->n:Ljava/util/List;

    const/4 v1, 0x1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/g/a;

    iget v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    mul-int/lit8 v2, v0, 0x64

    div-int/2addr v2, v1

    int-to-float v2, v2

    invoke-interface {p1, v0, v1, v2}, Llife/knowledge4/videotrimmer/g/a;->c(IIF)V

    :cond_2
    return-void
.end method

.method static synthetic f(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/VideoView;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    return-object p0
.end method

.method static synthetic g(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    return-object p0
.end method

.method private getSizeFile()V
    .locals 9

    iget-wide v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->t:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_1

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k:Landroid/net/Uri;

    invoke-virtual {v1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    iput-wide v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->t:J

    const-wide/16 v2, 0x400

    div-long/2addr v0, v2

    const-wide/16 v4, 0x3e8

    cmp-long v4, v0, v4

    const/4 v5, 0x1

    const/4 v6, 0x0

    const/4 v7, 0x2

    const-string v8, "%s %s"

    if-lez v4, :cond_0

    div-long/2addr v0, v2

    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g:Landroid/widget/TextView;

    new-array v3, v7, [Ljava/lang/Object;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    aput-object v0, v3, v6

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/f;->megabyte:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v5

    invoke-static {v8, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g:Landroid/widget/TextView;

    new-array v3, v7, [Ljava/lang/Object;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    aput-object v0, v3, v6

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/f;->kilobyte:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v5

    invoke-static {v8, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    return-void
.end method

.method static synthetic h(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I
    .locals 0

    iget p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->q:I

    return p0
.end method

.method static synthetic i(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic j(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->A(Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V

    return-void
.end method

.method static synthetic k(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Z)V
    .locals 0

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->C(Z)V

    return-void
.end method

.method static synthetic l(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    return-object p0
.end method

.method static synthetic m(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Z
    .locals 0

    iget-boolean p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->u:Z

    return p0
.end method

.method static synthetic n(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Z)Z
    .locals 0

    iput-boolean p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->u:Z

    return p1
.end method

.method static synthetic o(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I
    .locals 0

    iget p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    return p0
.end method

.method static synthetic p(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;I)I
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    return p1
.end method

.method static synthetic q(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/view/GestureDetector;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->w:Landroid/view/GestureDetector;

    return-object p0
.end method

.method static synthetic r(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Llife/knowledge4/videotrimmer/g/c;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o:Llife/knowledge4/videotrimmer/g/c;

    return-object p0
.end method

.method static synthetic s(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I
    .locals 0

    iget p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    return p0
.end method

.method private setProgressBarPosition(I)V
    .locals 5

    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    if-lez v0, :cond_0

    const-wide/16 v1, 0x3e8

    int-to-long v3, p1

    mul-long/2addr v3, v1

    int-to-long v0, v0

    div-long/2addr v3, v0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    long-to-int v0, v3

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    :cond_0
    return-void
.end method

.method private setTimeVideo(I)V
    .locals 4

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/f;->short_seconds:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->i:Landroid/widget/TextView;

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->B(I)Ljava/lang/String;

    move-result-object p1

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 p1, 0x1

    aput-object v0, v2, p1

    const-string p1, "%s %s"

    invoke-static {p1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method static synthetic t(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;I)I
    .locals 0

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    return p1
.end method

.method static synthetic u(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)I
    .locals 0

    iget p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    return p0
.end method

.method static synthetic v(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)Landroid/net/Uri;
    .locals 0

    iget-object p0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k:Landroid/net/Uri;

    return-object p0
.end method

.method private w(Landroid/content/Context;)V
    .locals 4

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    sget v0, Llife/knowledge4/videotrimmer/e;->view_time_line:I

    const/4 v1, 0x1

    invoke-virtual {p1, v0, p0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    sget p1, Llife/knowledge4/videotrimmer/d;->handlerTop:I

    invoke-virtual {p0, p1}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/SeekBar;

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    sget p1, Llife/knowledge4/videotrimmer/d;->timeVideoView:I

    invoke-virtual {p0, p1}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Llife/knowledge4/videotrimmer/view/ProgressBarView;

    sget v0, Llife/knowledge4/videotrimmer/d;->timeLineBar:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    sget v0, Llife/knowledge4/videotrimmer/d;->layout_surface_view:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->d:Landroid/widget/RelativeLayout;

    sget v0, Llife/knowledge4/videotrimmer/d;->video_loader:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/VideoView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    sget v0, Llife/knowledge4/videotrimmer/d;->icon_video_play:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    sget v0, Llife/knowledge4/videotrimmer/d;->textSize:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->g:Landroid/widget/TextView;

    sget v0, Llife/knowledge4/videotrimmer/d;->textTimeSelection:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h:Landroid/widget/TextView;

    sget v0, Llife/knowledge4/videotrimmer/d;->textTime:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->i:Landroid/widget/TextView;

    sget v0, Llife/knowledge4/videotrimmer/d;->timeLineView:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/TimeLineView;

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->j:Llife/knowledge4/videotrimmer/view/TimeLineView;

    sget v0, Llife/knowledge4/videotrimmer/d;->btCancel:I

    invoke-virtual {p0, v0}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/d;->btSave:I

    invoke-virtual {p0, v1}, Landroid/widget/FrameLayout;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v0, :cond_0

    new-instance v2, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$c;

    invoke-direct {v2, p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$c;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    if-eqz v1, :cond_1

    new-instance v0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;

    invoke-direct {v0, p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$d;-><init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->n:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->n:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    const/16 v1, 0x3e8

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setMax(I)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setSecondaryProgress(I)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    invoke-virtual {v0, p0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->a(Llife/knowledge4/videotrimmer/g/b;)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    invoke-virtual {v0, p1}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->a(Llife/knowledge4/videotrimmer/g/b;)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->getThumbs()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Llife/knowledge4/videotrimmer/view/a;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/a;->h()I

    move-result v0

    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    invoke-virtual {v2}, Landroid/widget/SeekBar;->getThumb()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->getMinimumWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    iget-object v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    invoke-virtual {v3}, Landroid/widget/SeekBar;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/widget/RelativeLayout$LayoutParams;

    sub-int v2, v0, v2

    invoke-virtual {v3, v2, v1, v2, v1}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    invoke-virtual {v2, v3}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->j:Llife/knowledge4/videotrimmer/view/TimeLineView;

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {v2, v0, v1, v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    iget-object v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->j:Llife/knowledge4/videotrimmer/view/TimeLineView;

    invoke-virtual {v3, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {v2, v0, v1, v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    invoke-virtual {p1, p0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1, p0}, Landroid/widget/VideoView;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1, p0}, Landroid/widget/VideoView;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1, p0}, Landroid/widget/VideoView;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    new-instance p1, Landroid/view/GestureDetector;

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->x:Landroid/view/GestureDetector$SimpleOnGestureListener;

    invoke-direct {p1, v0, v1}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->w:Landroid/view/GestureDetector;

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->y:Landroid/view/View$OnTouchListener;

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->x()V

    return-void
.end method

.method private x()V
    .locals 3

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l:Ljava/lang/String;

    sget-object v0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->z:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Setting default path "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private y()V
    .locals 5

    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    iget v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->m:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    div-int/lit8 v3, v0, 0x2

    div-int/lit8 v4, v1, 0x2

    sub-int/2addr v3, v4

    iput v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    div-int/lit8 v4, v0, 0x2

    div-int/lit8 v1, v1, 0x2

    add-int/2addr v4, v1

    iput v4, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    mul-int/lit8 v3, v3, 0x64

    div-int/2addr v3, v0

    int-to-float v0, v3

    invoke-virtual {v1, v2, v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->r(IF)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    const/4 v1, 0x1

    iget v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    mul-int/lit8 v2, v2, 0x64

    iget v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    div-int/2addr v2, v3

    int-to-float v2, v2

    invoke-virtual {v0, v1, v2}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->r(IF)V

    goto :goto_0

    :cond_0
    iput v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    iput v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    :goto_0
    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    invoke-direct {p0, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setProgressBarPosition(I)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    iget v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    invoke-virtual {v0, v1}, Landroid/widget/VideoView;->seekTo(I)V

    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    iput v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->q:I

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->c:Llife/knowledge4/videotrimmer/view/RangeSeekBarView;

    invoke-virtual {v0}, Llife/knowledge4/videotrimmer/view/RangeSeekBarView;->j()V

    return-void
.end method

.method private z()V
    .locals 5

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    sget v1, Llife/knowledge4/videotrimmer/f;->short_seconds:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->h:Landroid/widget/TextView;

    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/Object;

    iget v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    invoke-direct {p0, v3}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->B(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const/4 v3, 0x1

    aput-object v0, v2, v3

    iget v3, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    invoke-direct {p0, v3}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->B(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    aput-object v3, v2, v4

    const/4 v3, 0x3

    aput-object v0, v2, v3

    const-string v0, "%s %s - %s %s"

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method


# virtual methods
.method public a(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 1

    const/high16 p1, 0x42c80000    # 100.0f

    if-eqz p2, :cond_1

    const/4 v0, 0x1

    if-eq p2, v0, :cond_0

    goto :goto_0

    :cond_0
    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    int-to-float p2, p2

    mul-float/2addr p2, p3

    div-float/2addr p2, p1

    float-to-int p1, p2

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    goto :goto_0

    :cond_1
    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    int-to-float p2, p2

    mul-float/2addr p2, p3

    div-float/2addr p2, p1

    float-to-int p1, p2

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    iget-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p2, p1}, Landroid/widget/VideoView;->seekTo(I)V

    :goto_0
    iget p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setProgressBarPosition(I)V

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->z()V

    iget p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    sub-int/2addr p1, p2

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->q:I

    return-void
.end method

.method public b(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    return-void
.end method

.method public c(IIF)V
    .locals 0

    iget-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    if-nez p2, :cond_0

    return-void

    :cond_0
    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    if-lt p1, p2, :cond_1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    const/4 p2, 0x2

    invoke-virtual {p1, p2}, Landroid/os/Handler;->removeMessages(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->pause()V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setVisibility(I)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->u:Z

    return-void

    :cond_1
    iget-object p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->b:Landroid/widget/SeekBar;

    if-eqz p2, :cond_2

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setProgressBarPosition(I)V

    :cond_2
    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setTimeVideo(I)V

    return-void
.end method

.method public d(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    const/4 p2, 0x2

    invoke-virtual {p1, p2}, Landroid/os/Handler;->removeMessages(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->pause()V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void
.end method

.method public e(Llife/knowledge4/videotrimmer/view/RangeSeekBarView;IF)V
    .locals 0

    return-void
.end method

.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->seekTo(I)V

    return-void
.end method

.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 6

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getVideoWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getVideoHeight()I

    move-result p1

    int-to-float v0, v0

    int-to-float p1, p1

    div-float/2addr v0, p1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->d:Landroid/widget/RelativeLayout;

    invoke-virtual {p1}, Landroid/widget/RelativeLayout;->getWidth()I

    move-result p1

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->d:Landroid/widget/RelativeLayout;

    invoke-virtual {v1}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v1

    int-to-float v2, p1

    int-to-float v3, v1

    div-float v4, v2, v3

    iget-object v5, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {v5}, Landroid/widget/VideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    cmpl-float v4, v0, v4

    if-lez v4, :cond_0

    iput p1, v5, Landroid/view/ViewGroup$LayoutParams;->width:I

    div-float/2addr v2, v0

    float-to-int p1, v2

    iput p1, v5, Landroid/view/ViewGroup$LayoutParams;->height:I

    goto :goto_0

    :cond_0
    mul-float/2addr v0, v3

    float-to-int p1, v0

    iput p1, v5, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v1, v5, Landroid/view/ViewGroup$LayoutParams;->height:I

    :goto_0
    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1, v5}, Landroid/widget/VideoView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->getDuration()I

    move-result p1

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->y()V

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->z()V

    invoke-direct {p0, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setTimeVideo(I)V

    return-void
.end method

.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 2

    iget p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    mul-int/2addr p1, p2

    int-to-long p1, p1

    const-wide/16 v0, 0x3e8

    div-long/2addr p1, v0

    long-to-int p1, p1

    if-eqz p3, :cond_2

    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    if-ge p1, p2, :cond_0

    invoke-direct {p0, p2}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setProgressBarPosition(I)V

    iget p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->r:I

    goto :goto_0

    :cond_0
    iget p2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    if-le p1, p2, :cond_1

    invoke-direct {p0, p2}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setProgressBarPosition(I)V

    iget p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->s:I

    :cond_1
    :goto_0
    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setTimeVideo(I)V

    :cond_2
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeMessages(I)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->pause()V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-direct {p0, v0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->C(Z)V

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 6

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->v:Llife/knowledge4/videotrimmer/K4LVideoTrimmer$f;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {v0}, Landroid/widget/VideoView;->pause()V

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->f:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->p:I

    invoke-virtual {p1}, Landroid/widget/SeekBar;->getProgress()I

    move-result p1

    mul-int/2addr v0, p1

    int-to-long v2, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v2, v4

    long-to-int p1, v2

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {v0, p1}, Landroid/widget/VideoView;->seekTo(I)V

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->setTimeVideo(I)V

    invoke-direct {p0, v1}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->C(Z)V

    return-void
.end method

.method public setDestinationPath(Ljava/lang/String;)V
    .locals 2

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l:Ljava/lang/String;

    sget-object p1, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->z:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Setting custom path "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public setMaxDuration(I)V
    .locals 0

    mul-int/lit16 p1, p1, 0x3e8

    iput p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->m:I

    return-void
.end method

.method public setOnTrimVideoListener(Llife/knowledge4/videotrimmer/g/c;)V
    .locals 0

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->o:Llife/knowledge4/videotrimmer/g/c;

    return-void
.end method

.method public setVideoURI(Landroid/net/Uri;)V
    .locals 1

    iput-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k:Landroid/net/Uri;

    invoke-direct {p0}, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->getSizeFile()V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k:Landroid/net/Uri;

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setVideoURI(Landroid/net/Uri;)V

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->e:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->requestFocus()Z

    iget-object p1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->j:Llife/knowledge4/videotrimmer/view/TimeLineView;

    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->k:Landroid/net/Uri;

    invoke-virtual {p1, v0}, Llife/knowledge4/videotrimmer/view/TimeLineView;->setVideo(Landroid/net/Uri;)V

    return-void
.end method
