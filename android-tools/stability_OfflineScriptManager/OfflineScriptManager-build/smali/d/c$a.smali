.class public Ld/c$a;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public final a:Ld/j;

.field public final b:Ld/f;


# direct methods
.method public constructor <init>(Ld/j;Ld/f;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ld/c$a;->a:Ld/j;

    iput-object p2, p0, Ld/c$a;->b:Ld/f;

    return-void
.end method
