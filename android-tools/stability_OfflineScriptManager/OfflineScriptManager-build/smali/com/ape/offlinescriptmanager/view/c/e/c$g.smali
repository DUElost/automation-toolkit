.class Lcom/ape/offlinescriptmanager/view/c/e/c$g;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/view/c/e/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "g"
.end annotation


# instance fields
.field final synthetic b:Lcom/ape/offlinescriptmanager/view/c/e/c;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Lcom/ape/offlinescriptmanager/view/c/e/c$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/view/c/e/c$g;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-virtual {v0}, Lb/h/a/a/c/a$a;->g()Lb/h/a/a/d/a;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->q(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    goto :goto_0

    :pswitch_2
    invoke-virtual {v0}, Lb/h/a/a/d/a;->p()Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Lb/h/a/a/d/a;->j()V

    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Lb/h/a/a/d/a;->r(Z)V

    goto :goto_0

    :pswitch_3
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->v(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->t(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->w(Lcom/ape/offlinescriptmanager/view/c/e/c;)Landroid/content/Context;

    move-result-object p1

    const v0, 0x7f0f02c1

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    :pswitch_4
    invoke-static {}, Lcom/ape/offlinescriptmanager/view/c/e/c;->r()Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/view/c/e/c;->t(Lcom/ape/offlinescriptmanager/view/c/e/c;)V

    return-void

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$g;->b:Lcom/ape/offlinescriptmanager/view/c/e/c;

    const v0, 0x7f0f02c0

    const v1, 0x7f0f02ae

    new-instance v2, Lcom/ape/offlinescriptmanager/view/c/e/c$g$a;

    invoke-direct {v2, p0}, Lcom/ape/offlinescriptmanager/view/c/e/c$g$a;-><init>(Lcom/ape/offlinescriptmanager/view/c/e/c$g;)V

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lcom/ape/offlinescriptmanager/view/c/e/c;->u(Lcom/ape/offlinescriptmanager/view/c/e/c;IILandroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V

    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f090043
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
