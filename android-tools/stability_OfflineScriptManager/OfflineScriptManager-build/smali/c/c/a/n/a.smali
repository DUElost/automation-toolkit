.class public final Lc/c/a/n/a;
.super Ljava/lang/Object;
.source ""


# static fields
.field public static final d:Lc/c/a/n/a;

.field public static final e:Lc/c/a/n/a;

.field public static final f:Lc/c/a/n/a;


# instance fields
.field private a:Ljava/lang/String;

.field b:[Z

.field c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "\n\u0085\u2028\u2029"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/n/a;->d:Lc/c/a/n/a;

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "\r\n\u0085\u2028\u2029"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "\u0000\r\n\u0085\u2028\u2029"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    new-instance v0, Lc/c/a/n/a;

    const-string v1, " \u0000\r\n\u0085\u2028\u2029"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "\t \u0000\r\n\u0085\u2028\u2029"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/n/a;->e:Lc/c/a/n/a;

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "\u0000 \t"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    sput-object v0, Lc/c/a/n/a;->f:Lc/c/a/n/a;

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-_-;/?:@&=+$,_.!~*\'()[]%"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    new-instance v0, Lc/c/a/n/a;

    const-string v1, "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-_"

    invoke-direct {v0, v1}, Lc/c/a/n/a;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;)V
    .locals 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x80

    new-array v1, v0, [Z

    iput-object v1, p0, Lc/c/a/n/a;->b:[Z

    const/4 v2, 0x0

    iput-boolean v2, p0, Lc/c/a/n/a;->c:Z

    invoke-static {v1, v2}, Ljava/util/Arrays;->fill([ZZ)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x1

    if-ge v2, v3, :cond_1

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-ge v3, v0, :cond_0

    iget-object v5, p0, Lc/c/a/n/a;->b:[Z

    aput-boolean v4, v5, v3

    goto :goto_1

    :cond_0
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result p1

    if-lez p1, :cond_2

    iput-boolean v4, p0, Lc/c/a/n/a;->c:Z

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lc/c/a/n/a;->a:Ljava/lang/String;

    :cond_2
    return-void
.end method


# virtual methods
.method public a(C)Z
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0x80

    if-ge p1, v1, :cond_0

    iget-object v0, p0, Lc/c/a/n/a;->b:[Z

    aget-boolean v0, v0, p1

    goto :goto_0

    :cond_0
    iget-boolean v1, p0, Lc/c/a/n/a;->c:Z

    if-eqz v1, :cond_1

    iget-object v1, p0, Lc/c/a/n/a;->a:Ljava/lang/String;

    invoke-virtual {v1, p1, v0}, Ljava/lang/String;->indexOf(II)I

    move-result p1

    const/4 v1, -0x1

    if-eq p1, v1, :cond_1

    const/4 v0, 0x1

    :cond_1
    :goto_0
    return v0
.end method

.method public b(CLjava/lang/String;)Z
    .locals 2

    invoke-virtual {p0, p1}, Lc/c/a/n/a;->a(C)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p2, p1, v1}, Ljava/lang/String;->indexOf(II)I

    move-result p1

    const/4 p2, -0x1

    if-eq p1, p2, :cond_1

    :cond_0
    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public c(C)Z
    .locals 0

    invoke-virtual {p0, p1}, Lc/c/a/n/a;->a(C)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    return p1
.end method
