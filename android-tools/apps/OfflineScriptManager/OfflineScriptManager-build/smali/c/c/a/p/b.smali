.class public abstract Lc/c/a/p/b;
.super Ljava/lang/Object;
.source ""


# static fields
.field private static final a:Lc/c/a/i/b/a/a/a/a/a/a;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const-string v0, "UTF-8"

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->newDecoder()Ljava/nio/charset/CharsetDecoder;

    move-result-object v0

    sget-object v1, Ljava/nio/charset/CodingErrorAction;->REPORT:Ljava/nio/charset/CodingErrorAction;

    invoke-virtual {v0, v1}, Ljava/nio/charset/CharsetDecoder;->onMalformedInput(Ljava/nio/charset/CodingErrorAction;)Ljava/nio/charset/CharsetDecoder;

    new-instance v0, Lc/c/a/i/b/a/a/a/a/a/b;

    const-string v1, "-_.!~*\'()@:$&,;=[]/"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lc/c/a/i/b/a/a/a/a/a/b;-><init>(Ljava/lang/String;Z)V

    sput-object v0, Lc/c/a/p/b;->a:Lc/c/a/i/b/a/a/a/a/a/a;

    return-void
.end method

.method public static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lc/c/a/p/b;->a:Lc/c/a/i/b/a/a/a/a/a/a;

    invoke-interface {v0, p0}, Lc/c/a/i/b/a/a/a/a/a/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
