.class Lcom/ape/offlinescriptmanager/utils/m/h$b;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ape/offlinescriptmanager/utils/m/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic b:Lcom/ape/offlinescriptmanager/utils/m/h;


# direct methods
.method private constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/h;)V
    .locals 0

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    new-instance p1, Ljava/util/Stack;

    invoke-direct {p1}, Ljava/util/Stack;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->a:Ljava/util/Stack;

    return-void
.end method

.method synthetic constructor <init>(Lcom/ape/offlinescriptmanager/utils/m/h;Lcom/ape/offlinescriptmanager/utils/m/h$a;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/ape/offlinescriptmanager/utils/m/h$b;-><init>(Lcom/ape/offlinescriptmanager/utils/m/h;)V

    return-void
.end method


# virtual methods
.method public endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    const-string p1, "TestSuite"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    const-string p1, "TestCase"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    :cond_0
    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->a:Ljava/util/Stack;

    invoke-virtual {p1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    :cond_1
    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 6

    const-string p1, "TestPackage"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_1

    const-string p1, "jarPath"

    invoke-interface {p4, p1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    if-nez p1, :cond_0

    const-string p1, "apkPath"

    invoke-interface {p4, p1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "appPackageName"

    invoke-interface {p4, p2}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "testType"

    invoke-interface {p4, p3}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_0
    move-object p3, p2

    :goto_0
    iget-object p4, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    new-instance v0, Lb/b/a/a/a/a;

    invoke-direct {v0}, Lb/b/a/a/a/a;-><init>()V

    invoke-static {p4, v0}, Lcom/ape/offlinescriptmanager/utils/m/h;->e(Lcom/ape/offlinescriptmanager/utils/m/h;Lb/b/a/a/a/a;)Lb/b/a/a/a/a;

    iget-object p4, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-static {p4}, Lcom/ape/offlinescriptmanager/utils/m/h;->d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;

    move-result-object p4

    iput-object p1, p4, Lb/b/a/a/a/a;->c:Ljava/lang/String;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/h;->d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;

    move-result-object p1

    iput-object p2, p1, Lb/b/a/a/a/a;->e:Ljava/lang/String;

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/h;->d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;

    move-result-object p1

    iput-object p3, p1, Lb/b/a/a/a/a;->a:Ljava/lang/String;

    new-instance p1, Ljava/util/Stack;

    invoke-direct {p1}, Ljava/util/Stack;-><init>()V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->a:Ljava/util/Stack;

    goto/16 :goto_4

    :cond_1
    const-string p3, "TestSuite"

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v1, "Invalid XML: missing \'name\' attribute for \'%s\'"

    const-string v2, "name"

    const/4 v3, 0x0

    const/4 v4, 0x1

    const-string v5, "UiAutomatorXmlLoader"

    if-eqz v0, :cond_3

    invoke-interface {p4, v2}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    :goto_1
    iget-object p2, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->a:Ljava/util/Stack;

    invoke-virtual {p2, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_4

    :cond_2
    new-array p1, v4, [Ljava/lang/Object;

    aput-object p3, p1, v3

    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_3
    const-string p3, "TestCase"

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p4, v2}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_4

    goto :goto_1

    :cond_4
    new-array p1, v4, [Ljava/lang/Object;

    aput-object p3, p1, v3

    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_5
    const-string p3, "Test"

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_a

    invoke-interface {p4, v2}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iget-object p4, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-static {p4}, Lcom/ape/offlinescriptmanager/utils/m/h;->d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;

    move-result-object p4

    if-nez p4, :cond_6

    const/4 p2, 0x2

    new-array p2, p2, [Ljava/lang/Object;

    aput-object p3, p2, v3

    aput-object p1, p2, v4

    const-string p1, "Invalid XML: encountered a \'%s\' tag not enclosed within a \'%s\' tag"

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    :goto_2
    invoke-static {v5, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4

    :cond_6
    if-nez p2, :cond_7

    new-array p1, v4, [Ljava/lang/Object;

    aput-object p3, p1, v3

    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_7
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->a:Ljava/util/Stack;

    invoke-virtual {p3}, Ljava/util/Stack;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_8
    :goto_3
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_9

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/lang/String;

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_8

    const-string p4, "."

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    :cond_9
    new-instance p3, Lb/b/a/a/a/b;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p3, p1, p2}, Lb/b/a/a/a/b;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/ape/offlinescriptmanager/utils/m/h$b;->b:Lcom/ape/offlinescriptmanager/utils/m/h;

    invoke-static {p1}, Lcom/ape/offlinescriptmanager/utils/m/h;->d(Lcom/ape/offlinescriptmanager/utils/m/h;)Lb/b/a/a/a/a;

    move-result-object p1

    iget-object p1, p1, Lb/b/a/a/a/a;->g:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_a
    :goto_4
    return-void
.end method
