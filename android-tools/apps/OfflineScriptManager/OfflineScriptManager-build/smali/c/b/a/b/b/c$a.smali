.class Lc/b/a/b/b/c$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Lc/b/a/a/a$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lc/b/a/b/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "a"
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field b:Lc/b/a/a/c;


# direct methods
.method public constructor <init>(ILjava/lang/String;Lc/b/a/a/c;Lc/b/a/a/d/b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lc/b/a/b/b/c$a;->a:Ljava/lang/String;

    iput-object p3, p0, Lc/b/a/b/b/c$a;->b:Lc/b/a/a/c;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lc/b/a/b/b/c$a;->a:Ljava/lang/String;

    return-object v0
.end method

.method public b()Lc/b/a/a/c;
    .locals 1

    iget-object v0, p0, Lc/b/a/b/b/c$a;->b:Lc/b/a/a/c;

    return-object v0
.end method

.method c(Lc/b/a/b/b/h;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {p0}, Lc/b/a/b/b/c$a;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Lc/b/a/b/b/h;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {p0}, Lc/b/a/b/b/c$a;->b()Lc/b/a/a/c;

    move-result-object v1

    check-cast v1, Lc/b/a/b/b/f;

    invoke-virtual {v1, p1}, Lc/b/a/b/b/f;->k(Lc/b/a/b/b/h;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    const-string p1, ")"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    sget-object v0, Lc/b/a/b/b/h;->h:Lc/b/a/b/b/h;

    invoke-virtual {p0, v0}, Lc/b/a/b/b/c$a;->c(Lc/b/a/b/b/h;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
