.class final Llife/knowledge4/videotrimmer/h/c$b;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Llife/knowledge4/videotrimmer/h/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "b"
.end annotation


# instance fields
.field a:I

.field final b:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Llife/knowledge4/videotrimmer/h/c$b;->a:I

    iput-object p1, p0, Llife/knowledge4/videotrimmer/h/c$b;->b:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Llife/knowledge4/videotrimmer/h/c$a;)V
    .locals 0

    invoke-direct {p0, p1}, Llife/knowledge4/videotrimmer/h/c$b;-><init>(Ljava/lang/String;)V

    return-void
.end method
