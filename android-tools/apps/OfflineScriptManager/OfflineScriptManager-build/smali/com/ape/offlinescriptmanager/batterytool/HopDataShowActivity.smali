.class public Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;
.super Landroid/app/ListActivity;
.source ""


# instance fields
.field b:Landroid/database/Cursor;

.field c:Landroid/content/CursorLoader;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/ListActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 7

    invoke-super {p0, p1}, Landroid/app/ListActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0c004f

    invoke-virtual {p0, p1}, Landroid/app/ListActivity;->setContentView(I)V

    new-instance p1, Landroid/content/CursorLoader;

    sget-object v2, Lcom/ape/offlinescriptmanager/database/b;->a:Landroid/net/Uri;

    sget-object v3, Lcom/ape/offlinescriptmanager/database/b;->b:[Ljava/lang/String;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-string v6, "_id ASC"

    move-object v0, p1

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Landroid/content/CursorLoader;-><init>(Landroid/content/Context;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;->c:Landroid/content/CursorLoader;

    invoke-virtual {p1}, Landroid/content/CursorLoader;->loadInBackground()Landroid/database/Cursor;

    move-result-object p1

    iput-object p1, p0, Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;->b:Landroid/database/Cursor;

    new-instance p1, Landroid/widget/SimpleCursorAdapter;

    iget-object v3, p0, Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;->b:Landroid/database/Cursor;

    const-string v0, "hop_range"

    const-string v1, "hop_time"

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v4

    const/4 v0, 0x2

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    const v2, 0x1090004

    move-object v0, p1

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Landroid/widget/SimpleCursorAdapter;-><init>(Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V

    invoke-virtual {p0, p1}, Landroid/app/ListActivity;->setListAdapter(Landroid/widget/ListAdapter;)V

    return-void

    :array_0
    .array-data 4
        0x1020014
        0x1020015
    .end array-data
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Landroid/app/ListActivity;->onDestroy()V

    iget-object v0, p0, Lcom/ape/offlinescriptmanager/batterytool/HopDataShowActivity;->b:Landroid/database/Cursor;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 0

    invoke-super {p0}, Landroid/app/ListActivity;->onResume()V

    return-void
.end method
