.class Lb/f/a/g/a$b;
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
.field final synthetic b:I

.field final synthetic c:Lb/f/a/g/a;


# direct methods
.method constructor <init>(Lb/f/a/g/a;I)V
    .locals 0

    iput-object p1, p0, Lb/f/a/g/a$b;->c:Lb/f/a/g/a;

    iput p2, p0, Lb/f/a/g/a$b;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lb/f/a/g/a$b;->c:Lb/f/a/g/a;

    iget-object p1, p1, Lb/f/a/g/a;->e:Lb/f/a/g/a$d;

    iget v0, p0, Lb/f/a/g/a$b;->b:I

    invoke-interface {p1, v0}, Lb/f/a/g/a$d;->a(I)V

    return-void
.end method
