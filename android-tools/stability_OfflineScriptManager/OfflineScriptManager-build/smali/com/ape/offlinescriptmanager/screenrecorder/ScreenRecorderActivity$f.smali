.class Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;
.super Landroidx/legacy/app/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "f"
.end annotation


# instance fields
.field private final g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/app/Fragment;",
            ">;"
        }
    .end annotation
.end field

.field private final h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity;Landroid/app/FragmentManager;)V
    .locals 0

    invoke-direct {p0, p2}, Landroidx/legacy/app/b;-><init>(Landroid/app/FragmentManager;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->g:Ljava/util/List;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->h:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public c()I
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public d(Ljava/lang/Object;)I
    .locals 0

    invoke-super {p0, p1}, Landroidx/viewpager/widget/a;->d(Ljava/lang/Object;)I

    move-result p1

    return p1
.end method

.method public e(I)Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->h:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/CharSequence;

    return-object p1
.end method

.method public p(I)Landroid/app/Fragment;
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/Fragment;

    return-object p1
.end method

.method q(Landroid/app/Fragment;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/screenrecorder/ScreenRecorderActivity$f;->h:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method
