.class public Lcom/ape/offlinescriptmanager/view/testcase/a$b;
.super Lcom/jude/easyrecyclerview/d/a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/view/testcase/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/jude/easyrecyclerview/d/a<",
        "Lb/b/a/a/d/b;",
        ">;"
    }
.end annotation


# instance fields
.field private final u:Landroid/widget/EditText;

.field private final v:Landroid/widget/EditText;

.field private final w:Landroid/widget/ImageButton;

.field final synthetic x:Lcom/ape/offlinescriptmanager/view/testcase/a;


# direct methods
.method public constructor <init>(Lcom/ape/offlinescriptmanager/view/testcase/a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->x:Lcom/ape/offlinescriptmanager/view/testcase/a;

    invoke-direct {p0, p2}, Lcom/jude/easyrecyclerview/d/a;-><init>(Landroid/view/View;)V

    const p1, 0x7f09002b

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->u:Landroid/widget/EditText;

    const p1, 0x7f09002c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->v:Landroid/widget/EditText;

    const p1, 0x7f090029

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageButton;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->w:Landroid/widget/ImageButton;

    return-void
.end method

.method static synthetic O(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/ImageButton;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->w:Landroid/widget/ImageButton;

    return-object p0
.end method

.method static synthetic P(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->u:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic Q(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->v:Landroid/widget/EditText;

    return-object p0
.end method


# virtual methods
.method public bridge synthetic N(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lb/b/a/a/d/b;

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->R(Lb/b/a/a/d/b;)V

    return-void
.end method

.method public R(Lb/b/a/a/d/b;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/jude/easyrecyclerview/d/a;->N(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->u:Landroid/widget/EditText;

    iget-object v1, p1, Lb/b/a/a/d/b;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->v:Landroid/widget/EditText;

    iget-object p1, p1, Lb/b/a/a/d/b;->c:Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->u:Landroid/widget/EditText;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;

    invoke-direct {v0, p0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/a$b;Lcom/ape/offlinescriptmanager/view/testcase/a$b;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->u:Landroid/widget/EditText;

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$c0;->o()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->v:Landroid/widget/EditText;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;

    invoke-direct {v0, p0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/a$b$b;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/a$b;Lcom/ape/offlinescriptmanager/view/testcase/a$b;)V

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->v:Landroid/widget/EditText;

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$c0;->o()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->w:Landroid/widget/ImageButton;

    invoke-virtual {p0}, Landroidx/recyclerview/widget/RecyclerView$c0;->o()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/view/testcase/a$b;->w:Landroid/widget/ImageButton;

    new-instance v0, Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;

    invoke-direct {v0, p0}, Lcom/ape/offlinescriptmanager/view/testcase/a$b$a;-><init>(Lcom/ape/offlinescriptmanager/view/testcase/a$b;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
