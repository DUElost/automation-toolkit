.class public abstract Ld/n/h/c;
.super Ld/n/h/d;
.source ""


# instance fields
.field protected final h:Ljava/lang/Runnable;

.field protected final i:Ljava/lang/Runnable;


# direct methods
.method protected constructor <init>(Ld/s/c;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/h/d;-><init>(Ld/s/c;I)V

    new-instance p1, Ld/n/h/c$a;

    invoke-direct {p1, p0}, Ld/n/h/c$a;-><init>(Ld/n/h/c;)V

    iput-object p1, p0, Ld/n/h/c;->h:Ljava/lang/Runnable;

    new-instance p1, Ld/n/h/c$b;

    invoke-direct {p1, p0}, Ld/n/h/c$b;-><init>(Ld/n/h/c;)V

    iput-object p1, p0, Ld/n/h/c;->i:Ljava/lang/Runnable;

    return-void
.end method


# virtual methods
.method protected abstract h()V
.end method

.method protected abstract i()V
.end method
