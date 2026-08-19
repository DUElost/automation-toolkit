.class public Lcom/ape/offlinescriptmanager/screenrecorder/e/b;
.super Landroidx/recyclerview/widget/RecyclerView$g;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;,
        Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$g<",
        "Landroidx/recyclerview/widget/RecyclerView$c0;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Lcom/ape/offlinescriptmanager/screenrecorder/d;

.field private d:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/screenrecorder/e/a;",
            ">;"
        }
    .end annotation
.end field

.field private e:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/ArrayList;Lcom/ape/offlinescriptmanager/screenrecorder/d;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/ArrayList<",
            "Lcom/ape/offlinescriptmanager/screenrecorder/e/a;",
            ">;",
            "Lcom/ape/offlinescriptmanager/screenrecorder/d;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$g;-><init>()V

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/d;

    return-void
.end method

.method private A(I)V
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "delete position clicked: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Videos List"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    const/4 v1, 0x0

    const-string v2, "File deleted successfully"

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-virtual {p0, p1}, Landroidx/recyclerview/widget/RecyclerView$g;->j(I)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Landroidx/recyclerview/widget/RecyclerView$g;->i(II)V

    :cond_0
    return-void
.end method

.method private B(Ljava/util/Date;)Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    invoke-direct {p0, v0, v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->E(J)Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    invoke-direct {p0, v1, v2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->E(J)Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {v0}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v2

    invoke-virtual {v1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v4

    sub-long/2addr v4, v2

    const-wide/32 v2, 0x5265c00

    div-long/2addr v4, v2

    invoke-static {v4, v5}, Ljava/lang/Math;->abs(J)J

    move-result-wide v2

    long-to-int v2, v2

    const/4 v3, 0x1

    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v0

    invoke-virtual {v1, v3}, Ljava/util/Calendar;->get(I)I

    move-result v1

    sub-int/2addr v0, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "yeardiff: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v4, "ScreenRecorder"

    invoke-static {v4, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v0, :cond_2

    if-eqz v2, :cond_1

    if-eq v2, v3, :cond_0

    new-instance v0, Ljava/text/SimpleDateFormat;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    const-string v2, "EEEE, dd MMM"

    invoke-direct {v0, v2, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    :goto_0
    invoke-virtual {v0, p1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const-string p1, "Yesterday"

    return-object p1

    :cond_1
    const-string p1, "Today"

    return-object p1

    :cond_2
    new-instance v0, Ljava/text/SimpleDateFormat;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    const-string v2, "EEEE, dd MMM YYYY"

    invoke-direct {v0, v2, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    goto :goto_0
.end method

.method private D(I)V
    .locals 4

    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->b()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "share position clicked: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "Videos List"

    invoke-static {v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance p1, Landroid/content/Intent;

    const-string v1, "android.intent.action.SEND"

    invoke-direct {p1, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "video/*"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".fileprovider"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v0}, Landroidx/core/content/FileProvider;->e(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {v1, v2, v0, v3}, Landroid/content/Context;->grantUriPermission(Ljava/lang/String;Landroid/net/Uri;I)V

    const-string v1, "android.intent.extra.STREAM"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    const v1, 0x7f0f0295

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private E(J)Ljava/util/Calendar;
    .locals 1

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/16 p1, 0xb

    const/4 p2, 0x0

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xc

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xd

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    const/16 p1, 0xe

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->set(II)V

    return-object v0
.end method

.method static synthetic v(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->e:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic w(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->D(I)V

    return-void
.end method

.method static synthetic x(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;I)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->A(I)V

    return-void
.end method

.method static synthetic y(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic z(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;)Lcom/ape/offlinescriptmanager/screenrecorder/d;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->c:Lcom/ape/offlinescriptmanager/screenrecorder/d;

    return-object p0
.end method


# virtual methods
.method public C(I)Z
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->f()Z

    move-result p1

    return p1
.end method

.method public c()I
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public e(I)I
    .locals 0

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->C(I)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    return p1
.end method

.method public l(Landroidx/recyclerview/widget/RecyclerView$c0;I)V
    .locals 2

    invoke-virtual {p1}, Landroidx/recyclerview/widget/RecyclerView$c0;->l()I

    move-result v0

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    goto/16 :goto_1

    :cond_0
    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;->M(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v0}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->e()Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;->N(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)Landroid/widget/ImageView;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {v1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->e()Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    goto :goto_0

    :cond_1
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;->N(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)Landroid/widget/ImageView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    const-string v0, "SCREENRECORDER"

    const-string v1, "thumbnail error"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;->O(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)Landroid/widget/ImageButton;

    move-result-object v0

    new-instance v1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;

    invoke-direct {v1, p0, p1, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$a;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;I)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;->P(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)Landroid/widget/RelativeLayout;

    move-result-object p2

    new-instance v0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;

    invoke-direct {v0, p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$b;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;)V

    invoke-virtual {p2, v0}, Landroid/widget/RelativeLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_1

    :cond_2
    check-cast p1, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;->M(Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->d:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;

    invoke-virtual {p2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/a;->d()Ljava/util/Date;

    move-result-object p2

    invoke-direct {p0, p2}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b;->B(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_1
    return-void
.end method

.method public n(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$c0;
    .locals 3

    const/4 v0, 0x0

    if-eqz p2, :cond_1

    const/4 v1, 0x1

    const v2, 0x7f0c0030

    if-eq p2, v1, :cond_0

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v2, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-direct {p2, p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Landroid/view/View;)V

    return-object p2

    :cond_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v2, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;

    invoke-direct {p2, p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$c;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Landroid/view/View;)V

    return-object p2

    :cond_1
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v1, 0x7f0c0031

    invoke-virtual {p2, v1, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    new-instance p2, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;

    invoke-direct {p2, p0, p1}, Lcom/ape/offlinescriptmanager/screenrecorder/e/b$d;-><init>(Lcom/ape/offlinescriptmanager/screenrecorder/e/b;Landroid/view/View;)V

    return-object p2
.end method
