.class public Ld/n/j/i/a;
.super Ld/n/j/h/c;
.source ""


# direct methods
.method public constructor <init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Ld/n/j/h/c;-><init>(Ld/n/d;Ld/n/f;Ld/f;Ld/n/j/a;Z)V

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "TODO implement Tipc"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
