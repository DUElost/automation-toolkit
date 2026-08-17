.class public Landroidx/legacy/app/a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/legacy/app/a$c;,
        Landroidx/legacy/app/a$b;,
        Landroidx/legacy/app/a$a;,
        Landroidx/legacy/app/a$d;,
        Landroidx/legacy/app/a$e;
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field static final a:Landroidx/legacy/app/a$e;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    new-instance v0, Landroidx/legacy/app/a$c;

    invoke-direct {v0}, Landroidx/legacy/app/a$c;-><init>()V

    :goto_0
    sput-object v0, Landroidx/legacy/app/a;->a:Landroidx/legacy/app/a$e;

    goto :goto_1

    :cond_0
    const/16 v1, 0x17

    if-lt v0, v1, :cond_1

    new-instance v0, Landroidx/legacy/app/a$b;

    invoke-direct {v0}, Landroidx/legacy/app/a$b;-><init>()V

    goto :goto_0

    :cond_1
    const/16 v1, 0xf

    if-lt v0, v1, :cond_2

    new-instance v0, Landroidx/legacy/app/a$a;

    invoke-direct {v0}, Landroidx/legacy/app/a$a;-><init>()V

    goto :goto_0

    :cond_2
    new-instance v0, Landroidx/legacy/app/a$d;

    invoke-direct {v0}, Landroidx/legacy/app/a$d;-><init>()V

    goto :goto_0

    :goto_1
    return-void
.end method

.method public static a(Landroid/app/Fragment;Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-virtual {p0, p1}, Landroid/app/Fragment;->setMenuVisibility(Z)V

    return-void
.end method

.method public static b(Landroid/app/Fragment;Z)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object v0, Landroidx/legacy/app/a;->a:Landroidx/legacy/app/a$e;

    invoke-interface {v0, p0, p1}, Landroidx/legacy/app/a$e;->a(Landroid/app/Fragment;Z)V

    return-void
.end method
