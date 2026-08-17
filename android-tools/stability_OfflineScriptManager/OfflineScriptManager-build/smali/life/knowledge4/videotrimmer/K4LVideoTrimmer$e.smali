.class Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;
.super Llife/knowledge4/videotrimmer/h/a$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Llife/knowledge4/videotrimmer/K4LVideoTrimmer;->A(Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic i:Ljava/io/File;

.field final synthetic j:Ljava/lang/String;

.field final synthetic k:I

.field final synthetic l:I

.field final synthetic m:Llife/knowledge4/videotrimmer/g/c;


# direct methods
.method constructor <init>(Llife/knowledge4/videotrimmer/K4LVideoTrimmer;Ljava/lang/String;JLjava/lang/String;Ljava/io/File;Ljava/lang/String;IILlife/knowledge4/videotrimmer/g/c;)V
    .locals 0

    iput-object p6, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->i:Ljava/io/File;

    iput-object p7, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->j:Ljava/lang/String;

    iput p8, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->k:I

    iput p9, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->l:I

    iput-object p10, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->m:Llife/knowledge4/videotrimmer/g/c;

    invoke-direct {p0, p2, p3, p4, p5}, Llife/knowledge4/videotrimmer/h/a$a;-><init>(Ljava/lang/String;JLjava/lang/String;)V

    return-void
.end method


# virtual methods
.method public h()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->i:Ljava/io/File;

    iget-object v1, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->j:Ljava/lang/String;

    iget v2, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->k:I

    int-to-long v2, v2

    iget v4, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->l:I

    int-to-long v4, v4

    iget-object v6, p0, Llife/knowledge4/videotrimmer/K4LVideoTrimmer$e;->m:Llife/knowledge4/videotrimmer/g/c;

    invoke-static/range {v0 .. v6}, Llife/knowledge4/videotrimmer/h/b;->c(Ljava/io/File;Ljava/lang/String;JJLlife/knowledge4/videotrimmer/g/c;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-static {}, Ljava/lang/Thread;->getDefaultUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object v1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method
