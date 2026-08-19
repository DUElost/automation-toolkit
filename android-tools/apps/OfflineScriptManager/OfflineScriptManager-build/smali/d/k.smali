.class public Ld/k;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ld/k$a;,
        Ld/k$b;,
        Ld/k$c;
    }
.end annotation


# direct methods
.method public static a(Ljava/io/IOException;)I
    .locals 1

    instance-of v0, p0, Ljava/net/SocketException;

    if-eqz v0, :cond_0

    const p0, 0x9523e32

    return p0

    :cond_0
    instance-of p0, p0, Ljava/nio/channels/ClosedChannelException;

    if-eqz p0, :cond_1

    const/16 p0, 0x39

    return p0

    :cond_1
    const p0, 0x9523e31

    return p0
.end method

.method public static b(I)Ljava/lang/String;
    .locals 1

    const/16 v0, 0x30

    if-eq p0, v0, :cond_0

    packed-switch p0, :pswitch_data_0

    const-string p0, ""

    return-object p0

    :pswitch_0
    const-string p0, "No thread available"

    return-object p0

    :pswitch_1
    const-string p0, "Context was terminated"

    return-object p0

    :pswitch_2
    const-string p0, "The protocol is not compatible with the socket type"

    return-object p0

    :pswitch_3
    const-string p0, "Operation cannot be accomplished in current state"

    return-object p0

    :cond_0
    const-string p0, "Address already in use"

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x9523dfb
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
