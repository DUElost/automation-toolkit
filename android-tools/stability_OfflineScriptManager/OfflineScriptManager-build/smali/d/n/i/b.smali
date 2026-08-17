.class public abstract enum Ld/n/i/b;
.super Ljava/lang/Enum;
.source ""


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ld/n/i/b;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Ld/n/i/b;

.field public static final enum c:Ld/n/i/b;

.field public static final enum d:Ld/n/i/b;

.field public static final enum e:Ld/n/i/b;

.field private static final synthetic f:[Ld/n/i/b;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Ld/n/i/b$a;

    const-string v1, "NULL"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ld/n/i/b$a;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ld/n/i/b;->b:Ld/n/i/b;

    new-instance v1, Ld/n/i/b$b;

    const-string v3, "PLAIN"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Ld/n/i/b$b;-><init>(Ljava/lang/String;I)V

    sput-object v1, Ld/n/i/b;->c:Ld/n/i/b;

    new-instance v3, Ld/n/i/b$c;

    const-string v5, "CURVE"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Ld/n/i/b$c;-><init>(Ljava/lang/String;I)V

    sput-object v3, Ld/n/i/b;->d:Ld/n/i/b;

    new-instance v5, Ld/n/i/b$d;

    const-string v7, "GSSAPI"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Ld/n/i/b$d;-><init>(Ljava/lang/String;I)V

    sput-object v5, Ld/n/i/b;->e:Ld/n/i/b;

    const/4 v7, 0x4

    new-array v7, v7, [Ld/n/i/b;

    aput-object v0, v7, v2

    aput-object v1, v7, v4

    aput-object v3, v7, v6

    aput-object v5, v7, v8

    sput-object v7, Ld/n/i/b;->f:[Ld/n/i/b;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;ILd/n/i/b;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Ld/n/i/b;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ld/n/i/b;
    .locals 1

    const-class v0, Ld/n/i/b;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ld/n/i/b;

    return-object p0
.end method

.method public static values()[Ld/n/i/b;
    .locals 4

    sget-object v0, Ld/n/i/b;->f:[Ld/n/i/b;

    array-length v1, v0

    new-array v2, v1, [Ld/n/i/b;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public abstract a(Ld/n/f;Ld/n/j/a;Ld/f;)Ld/n/i/a;
.end method

.method public b(Ljava/nio/ByteBuffer;)Z
    .locals 3

    const/16 v0, 0x14

    new-array v1, v0, [B

    const/4 v2, 0x0

    invoke-virtual {p1, v1, v2, v0}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    invoke-virtual {p0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object p1

    sget-object v2, Ld/l;->c:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    invoke-static {p1, v0}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object p1

    invoke-static {v1, p1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p1

    return p1
.end method
