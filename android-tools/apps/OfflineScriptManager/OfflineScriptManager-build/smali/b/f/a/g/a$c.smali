.class Lb/f/a/g/a$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lb/f/a/g/a;->w(Lb/f/a/g/a$e;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lb/f/a/g/a;


# direct methods
.method constructor <init>(Lb/f/a/g/a;I)V
    .locals 0

    iput-object p1, p0, Lb/f/a/g/a$c;->b:Lb/f/a/g/a;

    iput p2, p0, Lb/f/a/g/a$c;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 1

    iget-object p1, p0, Lb/f/a/g/a$c;->b:Lb/f/a/g/a;

    invoke-static {p1}, Lb/f/a/g/a;->v(Lb/f/a/g/a;)[Z

    move-result-object p1

    iget v0, p0, Lb/f/a/g/a$c;->a:I

    aput-boolean p2, p1, v0

    return-void
.end method
