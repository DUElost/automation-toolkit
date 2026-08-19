.class Lcom/ape/offlinescriptmanager/view/c/e/c$e;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lb/a/a/f$m;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ape/offlinescriptmanager/view/c/e/c;->H(Lb/h/a/a/c/a;Lb/b/a/a/c/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/EditText;

.field final synthetic b:Lb/b/a/a/c/b;

.field final synthetic c:Lb/h/a/a/c/a;


# direct methods
.method constructor <init>(Lcom/ape/offlinescriptmanager/view/c/e/c;Landroid/widget/EditText;Lb/b/a/a/c/b;Lb/h/a/a/c/a;)V
    .locals 0

    iput-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->a:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->b:Lb/b/a/a/c/b;

    iput-object p4, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->c:Lb/h/a/a/c/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lb/a/a/f;Lb/a/a/b;)V
    .locals 3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->a:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->b:Lb/b/a/a/c/b;

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Lb/b/a/a/c/b;->b(I)V

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/view/c/e/c$e;->c:Lb/h/a/a/c/a;

    invoke-virtual {p2}, Lb/h/a/a/c/a;->j()Lb/h/a/a/c/a$a;

    move-result-object p2

    check-cast p2, Lcom/ape/offlinescriptmanager/view/c/e/d;

    invoke-interface {p2}, Lcom/ape/offlinescriptmanager/view/c/e/d;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    aput-object v0, v2, v1

    const/4 v0, 0x1

    aput-object p1, v2, v0

    const-string p1, "%s * %s"

    invoke-static {p1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p1}, Lcom/ape/offlinescriptmanager/view/c/e/d;->b(Ljava/lang/String;)V

    return-void
.end method
