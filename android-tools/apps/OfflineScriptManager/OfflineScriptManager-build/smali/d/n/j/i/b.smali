.class public Ld/n/j/i/b;
.super Ld/n/j/h/d;
.source ""


# direct methods
.method public constructor <init>(Ld/n/d;Ld/j;Ld/f;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Ld/n/j/h/d;-><init>(Ld/n/d;Ld/j;Ld/f;)V

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "TODO implement tipc"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
