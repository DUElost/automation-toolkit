.class Lcom/ape/offlinescriptmanager/utils/m/c$b;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/m/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/StringBuilder;

.field final synthetic c:Lcom/ape/offlinescriptmanager/utils/m/c;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/c;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/c;Lcom/ape/offlinescriptmanager/utils/m/c$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/c$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/c;)V

    return-void
.end method

.method private a(Lorg/xml/sax/Attributes;)V
    .locals 3

    if-eqz p1, :cond_0

    const-string v0, "taskname"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->l(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v0

    const-string v1, "task_name"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RunTestResultXmlLoader getTaskName is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private b(Lorg/xml/sax/Attributes;)V
    .locals 5

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->k(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;

    const-string v0, "type"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "serialnumber"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "serial_number"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "command"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "cmd_script"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "classname"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "class_name"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "method_name"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "starttime"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "start_time"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "endtime"

    invoke-interface {p1, v1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v2

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    const-string v4, "end_time"

    invoke-interface {v2, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    sub-long/2addr v1, v3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v0

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "elapsed_time"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "package"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    const-string v0, "package_name"

    const-string v1, ""

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    const-string v0, "test_status"

    const-string v2, "pass"

    invoke-interface {p1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    const-string v0, "trace"

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    const-string v0, "failure_type"

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->h(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->h(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->h(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;

    move-result-object v0

    const-string v1, "case_results"

    invoke-interface {p1, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    return-void
.end method

.method private c(Lorg/xml/sax/Attributes;)V
    .locals 5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->g(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->i(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/List;)Ljava/util/List;

    if-eqz p1, :cond_0

    const-string v0, "name"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    const-string v2, "testpoint_name"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/c$b;->d(Lorg/xml/sax/Attributes;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "testpoint_status"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "tests"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "starttime"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "testpoint_start_time"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "endtime"

    invoke-interface {p1, v1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "testpoint_end_time"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    sub-long/2addr v1, v3

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "testpoint_elapsed_time"

    invoke-interface {p1, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->d(Lcom/ape/offlinescriptmanager/utils/m/c;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "key"

    invoke-interface {p1, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->m(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->m(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/List;

    move-result-object p1

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/m/c;->f(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    return-void
.end method


# virtual methods
.method public characters([CII)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lorg/xml/sax/helpers/DefaultHandler;->characters([CII)V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a:Ljava/lang/String;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->b:Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a:Ljava/lang/String;

    const-string p2, "failure"

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->b:Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "trace"

    invoke-interface {p1, v0, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->j(Lcom/ape/offlinescriptmanager/utils/m/c;)Ljava/util/Map;

    move-result-object p1

    const-string p3, "test_status"

    invoke-interface {p1, p3, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->b:Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public d(Lorg/xml/sax/Attributes;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_0

    const-string v0, "failures"

    invoke-interface {p1, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    if-nez p1, :cond_0

    const-string p1, "pass"

    goto :goto_0

    :cond_0
    const-string p1, "failure"

    :goto_0
    return-object p1
.end method

.method public endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a:Ljava/lang/String;

    const-string p3, "testpoint"

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_0

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p2, p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->g(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p2, p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->i(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/List;)Ljava/util/List;

    goto :goto_0

    :cond_0
    const-string p3, "testcase"

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p2, p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->k(Lcom/ape/offlinescriptmanager/utils/m/c;Ljava/util/Map;)Ljava/util/Map;

    :cond_1
    :goto_0
    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 0

    const-string p1, "testpoints"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_0
    const-string p1, "testpoint"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c:Lcom/ape/offlinescriptmanager/utils/m/c;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/c;->e(Lcom/ape/offlinescriptmanager/utils/m/c;)I

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/c$b;->c(Lorg/xml/sax/Attributes;)V

    goto :goto_0

    :cond_1
    const-string p1, "testcase"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0, p4}, Lcom/ape/offlinescriptmanager/utils/m/c$b;->b(Lorg/xml/sax/Attributes;)V

    :cond_2
    :goto_0
    iput-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->a:Ljava/lang/String;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/c$b;->b:Ljava/lang/StringBuilder;

    return-void
.end method
