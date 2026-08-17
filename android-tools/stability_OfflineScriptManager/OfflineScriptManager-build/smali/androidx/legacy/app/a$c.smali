.class Landroidx/legacy/app/a$c;
.super Landroidx/legacy/app/a$b;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/legacy/app/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "c"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroidx/legacy/app/a$b;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Fragment;Z)V
    .locals 0

    invoke-virtual {p1, p2}, Landroid/app/Fragment;->setUserVisibleHint(Z)V

    return-void
.end method
