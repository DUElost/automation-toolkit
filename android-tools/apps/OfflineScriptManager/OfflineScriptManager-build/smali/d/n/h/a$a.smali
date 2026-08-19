.class final Ld/n/h/a$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ld/n/h/e$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ld/n/h/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Ld/n/h/a;


# direct methods
.method private constructor <init>(Ld/n/h/a;)V
    .locals 0

    iput-object p1, p0, Ld/n/h/a$a;->a:Ld/n/h/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Ld/n/h/a;Ld/n/h/a$a;)V
    .locals 0

    invoke-direct {p0, p1}, Ld/n/h/a$a;-><init>(Ld/n/h/a;)V

    return-void
.end method


# virtual methods
.method public a()Ld/n/h/e$a$a;
    .locals 1

    iget-object v0, p0, Ld/n/h/a$a;->a:Ld/n/h/a;

    invoke-virtual {v0}, Ld/n/h/a;->i()Ld/n/h/e$a$a;

    move-result-object v0

    return-object v0
.end method
