.class Lb/f/a/g/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/f/a/g/a;->w(Lb/f/a/g/a$e;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic b:Ljava/io/File;

.field final synthetic c:Lb/f/a/g/a$e;

.field final synthetic d:I

.field final synthetic e:Lb/f/a/g/a;


# direct methods
.method constructor <init>(Lb/f/a/g/a;Ljava/io/File;Lb/f/a/g/a$e;I)V
    .locals 0

    iput-object p1, p0, Lb/f/a/g/a$a;->e:Lb/f/a/g/a;

    iput-object p2, p0, Lb/f/a/g/a$a;->b:Ljava/io/File;

    iput-object p3, p0, Lb/f/a/g/a$a;->c:Lb/f/a/g/a$e;

    iput p4, p0, Lb/f/a/g/a$a;->d:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lb/f/a/g/a$a;->b:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->isFile()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lb/f/a/g/a$a;->c:Lb/f/a/g/a$e;

    invoke-static {p1}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object p1

    iget-object v0, p0, Lb/f/a/g/a$a;->c:Lb/f/a/g/a$e;

    invoke-static {v0}, Lb/f/a/g/a$e;->P(Lb/f/a/g/a$e;)Landroid/widget/CheckBox;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_0
    iget-object p1, p0, Lb/f/a/g/a$a;->e:Lb/f/a/g/a;

    iget-object p1, p1, Lb/f/a/g/a;->e:Lb/f/a/g/a$d;

    iget v0, p0, Lb/f/a/g/a$a;->d:I

    invoke-interface {p1, v0}, Lb/f/a/g/a$d;->a(I)V

    return-void
.end method
