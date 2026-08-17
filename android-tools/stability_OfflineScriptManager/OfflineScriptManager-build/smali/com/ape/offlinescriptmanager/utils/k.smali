.class public Lcom/ape/offlinescriptmanager/utils/k;
.super Ljava/lang/Object;
.source ""


# instance fields
.field private a:Landroid/content/Context;

.field private b:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "2099-12-31 23:59:59"

    iput-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    return-void
.end method

.method static synthetic a(Lcom/ape/offlinescriptmanager/utils/k;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    return-object p0
.end method


# virtual methods
.method public b()V
    .locals 2

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    const-string v1, "deadline"

    invoke-virtual {p0, v1, v0}, Lcom/ape/offlinescriptmanager/utils/k;->f(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/ape/offlinescriptmanager/utils/g;->M(J)Ljava/lang/String;

    move-result-object v0

    const-string v1, "latest"

    invoke-virtual {p0, v1, v0}, Lcom/ape/offlinescriptmanager/utils/k;->f(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->h()V

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->e()V

    return-void
.end method

.method public c()Z
    .locals 7

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isPreferenceNull :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    const-string v3, "timetips"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    const-string v6, "deadline"

    invoke-interface {v2, v6, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "TimeTips"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    invoke-virtual {v1, v3, v4}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-interface {v1, v6, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public d()Z
    .locals 8

    const-string v0, "TimeTips"

    const-string v1, "timetips"

    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    invoke-virtual {v3, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    const-string v4, "deadline"

    iget-object v5, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ",deadline:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v4, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    invoke-virtual {v4, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v4, "latest"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/ape/offlinescriptmanager/utils/g;->N(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ",latest:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v0

    invoke-static {v3}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v4

    cmp-long v0, v0, v4

    const/4 v1, 0x1

    if-lez v0, :cond_0

    return v1

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v3}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v0, v4, v6

    if-lez v0, :cond_1

    move v2, v1

    :cond_1
    return v2

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    return v2
.end method

.method public e()V
    .locals 5

    const-string v0, "TimeTips"

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->d()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->g()V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->c()Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_0
    iget-object v1, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    const-string v2, "timetips"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "latest"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/ape/offlinescriptmanager/utils/g;->N(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ",mDefaultime:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ",latest:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v0

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-static {v2}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->g()V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/ape/offlinescriptmanager/utils/g;->h(Ljava/lang/String;)J

    move-result-wide v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-gez v0, :cond_2

    invoke-virtual {p0}, Lcom/ape/offlinescriptmanager/utils/k;->g()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    const-string v1, "timetips"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public g()V
    .locals 5

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    new-instance v1, Lcom/ape/offlinescriptmanager/utils/k$a;

    invoke-direct {v1, p0}, Lcom/ape/offlinescriptmanager/utils/k$a;-><init>(Lcom/ape/offlinescriptmanager/utils/k;)V

    const-string v2, "\u66f4\u65b0"

    const-string v3, "\u8be5app\u5df2\u7ecf\u8fc7\u671f,\u8bf7\u5230ITMS\u4e0b\u8f7d\u66f4\u65b0\u7248\u672c!"

    const/4 v4, 0x0

    invoke-static {v0, v2, v3, v1, v4}, Lcom/ape/offlinescriptmanager/utils/g;->J(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;Landroid/content/DialogInterface$OnClickListener;)V

    return-void
.end method

.method public h()V
    .locals 3

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/utils/k;->a:Landroid/content/Context;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "App \u4f7f\u7528\u6709\u6548\u671f\u81f3:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/ape/offlinescriptmanager/utils/k;->b:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method
